-- ml4_13Lua.lua  -  4 Player, LastOne, 'Unsettled Earth' map. (Lua)
--
-- Converted by op2dll from ml4_13.dll ("4 Player, LastOne, 'Unsettled Earth' map."): its setup replayed. `on_init` makes the original's
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
  if n == 2 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 39, 22 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 106, 15 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 118, 90 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 40, 121 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 27, 33 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 18, 96 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[0]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[1]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[2]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[3]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[4]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[5]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[6]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[7]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[8]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[9]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[10]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[11]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[12]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[13]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[14]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[15]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[15]] } }
    R[16] = game.rand(4)
    R[17] = game.rand(2)
    R[18] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[18]][R[16]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[18]][R[16]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] })
    if R[18] == 5 or R[18] == 6 or R[18] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [6] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [7] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[18]][R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[18]][R[16]], ({ [5] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [6] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [7] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[18] == 5 or R[18] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [7] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[18]][R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[18] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[18] == 7 then
          if LEVEL_OF[players[1].difficulty] == 2 then
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[18]", R[18])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [7] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[18]][R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[18] == 5 then
        elseif R[18] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[18]", R[18])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[18]][R[16]], ({ [5] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[18] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[18]", R[18])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 }, [7] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 } })[R[18]][R[16]], ({ [5] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [6] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [7] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[18] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[18] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[18] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[18]", R[18])
      end
    elseif R[18] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[18] == 1 or R[18] == 2 or R[18] == 3 or R[18] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [3] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [4] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[18]][R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[18] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 9, [1] = 112, [2] = 105, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[18] == 1 or R[18] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[18]][R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[16]], ({ [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[18]][R[16]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[18]][R[16]], ({ [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 } })[R[18]][R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[18]][R[16]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[18]", R[18])
      end
      U[#U]:set_lights(true)
      if R[18] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[18]", R[18])
      end
      U[#U]:set_lights(true)
      if R[18] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[18]", R[18])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [3] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 } })[R[18]][R[16]], ({ [1] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [3] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [4] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[18]", R[18])
    end
    U[#U]:set_lights(true)
    if R[18] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[18] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[18] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[18]", R[18])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[18]], player = players[1], at = { ({ [0] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [3] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [5] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [6] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[18]][R[16]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [6] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[18]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [1] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [3] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [4] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [7] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 } })[R[18]][R[16]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [3] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [4] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [6] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[18] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[19] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[19]][R[16]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 18, [1] = 121, [2] = 114, [3] = 25 } })[R[19]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        for i = 1, game.initial_units() do
          R[20] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[20]][R[16]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[20]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[21]][R[16]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[21]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[22]][R[16]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[22]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] })
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[23]][R[16]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[23]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 } })[R[24]][R[16]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[24]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[25]][R[16]], ({ [0] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 } })[R[25]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[26]][R[16]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[26]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[18]", R[18])
    end
    R[27] = game.rand(8)
    if R[27] == 0 then
      if R[17] == 0 then
        if R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 119, 23 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 116, 112 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 22, 119 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 17, 16 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 1 then
      if R[17] == 0 then
        if R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 120, 108 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 123, 19 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 21, 12 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 26, 115 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 2 then
      if R[17] == 0 then
        if R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 123, 23 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 120, 112 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 26, 119 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 21, 16 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 3 then
      if R[17] == 0 then
        if R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 112, 108 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 115, 19 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 18, 115 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 13, 12 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 4 then
      if R[17] == 0 then
        if R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 119, 22 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 116, 111 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 17, 15 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 22, 118 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 5 then
      if R[17] == 0 then
        if R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 118, 20 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 115, 109 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 21, 116 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 16, 13 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 6 then
      if R[17] == 0 then
        if R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 112, 106 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 115, 17 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 18, 113 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 13, 10 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 7 then
      if R[17] == 0 then
        if R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 118, 109 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 121, 20 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 1 or R[16] == 3 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 19, 13 }, direction = "East", lights = false, exact = true }[1]
        elseif R[16] == 0 or R[16] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 24, 116 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    else
      unseen("R[27]", R[27])
    end
    if R[27] == 0 then
      if R[17] == 0 then
        if R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 119, 23 })
        elseif R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 116, 112 })
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 22, 119 })
        elseif R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 17, 16 })
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 1 then
      if R[17] == 0 then
        if R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 120, 108 })
        elseif R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 123, 19 })
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 21, 12 })
        elseif R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 26, 115 })
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 2 then
      if R[17] == 0 then
        if R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 123, 23 })
        elseif R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 120, 112 })
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 26, 119 })
        elseif R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 21, 16 })
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 3 then
      if R[17] == 0 then
        if R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 112, 108 })
        elseif R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 115, 19 })
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 18, 115 })
        elseif R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 13, 12 })
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 4 then
      if R[17] == 0 then
        if R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 119, 22 })
        elseif R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 116, 111 })
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 17, 15 })
        elseif R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 22, 118 })
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 5 then
      if R[17] == 0 then
        if R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 118, 20 })
        elseif R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 115, 109 })
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 21, 116 })
        elseif R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 16, 13 })
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 6 then
      if R[17] == 0 then
        if R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 112, 106 })
        elseif R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 115, 17 })
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 18, 113 })
        elseif R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 13, 10 })
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[27] == 7 then
      if R[17] == 0 then
        if R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 118, 109 })
        elseif R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 121, 20 })
        else
          unseen("R[16]", R[16])
        end
      elseif R[17] == 1 then
        if R[16] == 1 or R[16] == 3 then
          players[2]:center_view({ 19, 13 })
        elseif R[16] == 0 or R[16] == 2 then
          players[2]:center_view({ 24, 116 })
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    else
      unseen("R[27]", R[27])
    end
    if R[27] == 1 or R[27] == 2 or R[27] == 3 or R[27] == 4 then
      if R[17] == 0 then
        if R[27] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 120, 115 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 123, 26 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[27] == 2 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 116, 26 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 113, 115 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[27] == 3 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 117, 115 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 120, 26 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[27] == 4 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 116, 26 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 113, 115 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[27]", R[27])
        end
      elseif R[17] == 1 then
        if R[27] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 21, 19 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 26, 122 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[27] == 2 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 14, 19 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 19, 122 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[27] == 3 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 23, 122 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 18, 19 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[27] == 4 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 14, 19 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 19, 122 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[27]", R[27])
        end
      else
        unseen("R[17]", R[17])
      end
      if R[27] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 116, [1] = 113, [2] = 116, [3] = 113 }, [1] = { [0] = 19, [1] = 14, [2] = 19, [3] = 14 } })[R[17]][R[16]], ({ [0] = { [0] = 18, [1] = 107, [2] = 18, [3] = 107 }, [1] = { [0] = 114, [1] = 11, [2] = 114, [3] = 11 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 19, [1] = 108, [2] = 19, [3] = 108 }, [1] = { [0] = 115, [1] = 12, [2] = 115, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 115, [1] = 112, [2] = 115, [3] = 112 }, [1] = { [0] = 18, [1] = 13, [2] = 18, [3] = 13 } })[R[17]][R[16]], ({ [0] = { [0] = 22, [1] = 111, [2] = 22, [3] = 111 }, [1] = { [0] = 118, [1] = 15, [2] = 118, [3] = 15 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 124, [1] = 121, [2] = 124, [3] = 121 }, [1] = { [0] = 27, [1] = 22, [2] = 27, [3] = 22 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 116, [2] = 27, [3] = 116 }, [1] = { [0] = 123, [1] = 20, [2] = 123, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 16, [1] = 105, [2] = 16, [3] = 105 }, [1] = { [0] = 112, [1] = 9, [2] = 112, [3] = 9 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 119, [1] = 116, [2] = 119, [3] = 116 }, [1] = { [0] = 22, [1] = 17, [2] = 22, [3] = 17 } })[R[17]][R[16]], ({ [0] = { [0] = 17, [1] = 106, [2] = 17, [3] = 106 }, [1] = { [0] = 113, [1] = 10, [2] = 113, [3] = 10 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[27] == 1 or R[27] == 2 then
        if R[27] == 1 then
          if R[17] == 0 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 111, 106 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 114, 17 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 12, 10 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 17, 113 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        elseif R[27] == 2 then
          if R[17] == 0 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 115, 17 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 112, 106 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 18, 113 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 13, 10 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        else
          unseen("R[27]", R[27])
        end
        if R[27] == 1 then
          if R[17] == 0 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 120, 111 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 123, 22 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 21, 15 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 26, 118 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        elseif R[27] == 2 then
          if R[17] == 0 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 123, 26 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 120, 115 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 26, 122 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 21, 19 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        else
          unseen("R[27]", R[27])
        end
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        if R[27] == 1 then
          if R[17] == 0 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 115, 116 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 118, 27 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 16, 20 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 21, 123 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        elseif R[27] == 2 then
          if R[17] == 0 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 119, 23 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 116, 112 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 22, 119 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 17, 16 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        else
          unseen("R[27]", R[27])
        end
        if R[27] == 1 then
          if R[17] == 0 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 115, 112 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 118, 23 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 16, 16 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 21, 119 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        elseif R[27] == 2 then
          if R[17] == 0 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 123, 20 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 120, 109 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 26, 116 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 21, 13 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        else
          unseen("R[27]", R[27])
        end
        if R[27] == 1 then
          if R[17] == 0 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 121, 117 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 124, 28 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 22, 21 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 27, 124 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        elseif R[27] == 2 then
          if R[17] == 0 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 122, 28 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 119, 117 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 25, 124 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 20, 21 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        else
          unseen("R[27]", R[27])
        end
        U[#U]:set_lights(true)
        if R[27] == 1 then
          if R[17] == 0 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 122, 116 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 125, 27 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 23, 20 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 28, 123 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        elseif R[27] == 2 then
          if R[17] == 0 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 124, 28 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 121, 117 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 27, 124 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 22, 21 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        else
          unseen("R[27]", R[27])
        end
      elseif R[27] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 115, [1] = 112, [2] = 115, [3] = 112 }, [1] = { [0] = 18, [1] = 13, [2] = 18, [3] = 13 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 116, [2] = 27, [3] = 116 }, [1] = { [0] = 123, [1] = 20, [2] = 123, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 122, [1] = 119, [2] = 122, [3] = 119 }, [1] = { [0] = 25, [1] = 20, [2] = 25, [3] = 20 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 112, [2] = 23, [3] = 112 }, [1] = { [0] = 119, [1] = 16, [2] = 119, [3] = 16 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 116, [1] = 113, [2] = 116, [3] = 113 }, [1] = { [0] = 19, [1] = 14, [2] = 19, [3] = 14 } })[R[17]][R[16]], ({ [0] = { [0] = 22, [1] = 111, [2] = 22, [3] = 111 }, [1] = { [0] = 118, [1] = 15, [2] = 118, [3] = 15 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 124, [1] = 121, [2] = 124, [3] = 121 }, [1] = { [0] = 27, [1] = 22, [2] = 27, [3] = 22 } })[R[17]][R[16]], ({ [0] = { [0] = 17, [1] = 106, [2] = 17, [3] = 106 }, [1] = { [0] = 113, [1] = 10, [2] = 113, [3] = 10 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 121, [1] = 118, [2] = 121, [3] = 118 }, [1] = { [0] = 24, [1] = 19, [2] = 24, [3] = 19 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 122, [1] = 119, [2] = 122, [3] = 119 }, [1] = { [0] = 25, [1] = 20, [2] = 25, [3] = 20 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 116, [2] = 27, [3] = 116 }, [1] = { [0] = 123, [1] = 20, [2] = 123, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[27]", R[27])
      end
      U[#U]:set_lights(true)
      if R[27] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 122, [1] = 119, [2] = 122, [3] = 119 }, [1] = { [0] = 25, [1] = 20, [2] = 25, [3] = 20 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 116, [2] = 27, [3] = 116 }, [1] = { [0] = 123, [1] = 20, [2] = 123, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 123, [1] = 120, [2] = 123, [3] = 120 }, [1] = { [0] = 26, [1] = 21, [2] = 26, [3] = 21 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 113, [1] = 110, [2] = 113, [3] = 110 }, [1] = { [0] = 16, [1] = 11, [2] = 16, [3] = 11 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 113, [2] = 24, [3] = 113 }, [1] = { [0] = 120, [1] = 17, [2] = 120, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 119, [1] = 116, [2] = 119, [3] = 116 }, [1] = { [0] = 22, [1] = 17, [2] = 22, [3] = 17 } })[R[17]][R[16]], ({ [0] = { [0] = 17, [1] = 106, [2] = 17, [3] = 106 }, [1] = { [0] = 113, [1] = 10, [2] = 113, [3] = 10 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[27]", R[27])
      end
      U[#U]:set_lights(true)
      if R[27] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 122, [2] = 125, [3] = 122 }, [1] = { [0] = 28, [1] = 23, [2] = 28, [3] = 23 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 113, [2] = 24, [3] = 113 }, [1] = { [0] = 120, [1] = 17, [2] = 120, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 114, [2] = 117, [3] = 114 }, [1] = { [0] = 20, [1] = 15, [2] = 20, [3] = 15 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 114, [2] = 117, [3] = 114 }, [1] = { [0] = 20, [1] = 15, [2] = 20, [3] = 15 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 113, [2] = 24, [3] = 113 }, [1] = { [0] = 120, [1] = 17, [2] = 120, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 114, [2] = 117, [3] = 114 }, [1] = { [0] = 20, [1] = 15, [2] = 20, [3] = 15 } })[R[17]][R[16]], ({ [0] = { [0] = 20, [1] = 109, [2] = 20, [3] = 109 }, [1] = { [0] = 116, [1] = 13, [2] = 116, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 113, [1] = 110, [2] = 113, [3] = 110 }, [1] = { [0] = 16, [1] = 11, [2] = 16, [3] = 11 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 113, [2] = 24, [3] = 113 }, [1] = { [0] = 120, [1] = 17, [2] = 120, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[27]", R[27])
      end
      U[#U]:set_lights(true)
      if R[27] == 1 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 122, 113 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 125, 24 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 23, 17 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 28, 120 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 2 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 117, 28 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 114, 117 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 20, 124 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 15, 21 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 3 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 114, 113 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 117, 24 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 20, 120 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 15, 17 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 4 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 117, 20 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 114, 109 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 15, 13 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 20, 116 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      else
        unseen("R[27]", R[27])
      end
    elseif R[27] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 116, [1] = 113, [2] = 116, [3] = 113 }, [1] = { [0] = 19, [1] = 14, [2] = 19, [3] = 14 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 115, [2] = 26, [3] = 115 }, [1] = { [0] = 122, [1] = 19, [2] = 122, [3] = 19 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 121, [1] = 118, [2] = 121, [3] = 118 }, [1] = { [0] = 24, [1] = 19, [2] = 24, [3] = 19 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 115, [2] = 26, [3] = 115 }, [1] = { [0] = 122, [1] = 19, [2] = 122, [3] = 19 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 115, [1] = 112, [2] = 115, [3] = 112 }, [1] = { [0] = 18, [1] = 13, [2] = 18, [3] = 13 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 112, [2] = 23, [3] = 112 }, [1] = { [0] = 119, [1] = 16, [2] = 119, [3] = 16 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 123, [1] = 120, [2] = 123, [3] = 120 }, [1] = { [0] = 26, [1] = 21, [2] = 26, [3] = 21 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 112, [2] = 23, [3] = 112 }, [1] = { [0] = 119, [1] = 16, [2] = 119, [3] = 16 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 124, [1] = 121, [2] = 124, [3] = 121 }, [1] = { [0] = 27, [1] = 22, [2] = 27, [3] = 22 } })[R[17]][R[16]], ({ [0] = { [0] = 17, [1] = 106, [2] = 17, [3] = 106 }, [1] = { [0] = 113, [1] = 10, [2] = 113, [3] = 10 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 122, [1] = 119, [2] = 122, [3] = 119 }, [1] = { [0] = 25, [1] = 20, [2] = 25, [3] = 20 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 123, [1] = 120, [2] = 123, [3] = 120 }, [1] = { [0] = 26, [1] = 21, [2] = 26, [3] = 21 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 116, [2] = 27, [3] = 116 }, [1] = { [0] = 123, [1] = 20, [2] = 123, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 122, [2] = 125, [3] = 122 }, [1] = { [0] = 28, [1] = 23, [2] = 28, [3] = 23 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 115, [2] = 26, [3] = 115 }, [1] = { [0] = 122, [1] = 19, [2] = 122, [3] = 19 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[27] == 5 or R[27] == 6 or R[27] == 7 then
      if R[17] == 0 then
        if R[27] == 5 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 115, 27 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 112, 116 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[27] == 6 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 121, 116 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 124, 27 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[27] == 7 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 115, 27 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 112, 116 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[27]", R[27])
        end
      elseif R[17] == 1 then
        if R[27] == 5 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 18, 123 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 13, 20 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[27] == 6 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 27, 123 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 22, 20 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[27] == 7 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 18, 123 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { 13, 20 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[27]", R[27])
        end
      else
        unseen("R[17]", R[17])
      end
      if R[27] == 5 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 123, 21 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 120, 110 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 26, 117 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 21, 14 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 6 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 112, 115 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 115, 26 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 18, 122 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 13, 19 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 7 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 120, 115 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 123, 26 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 21, 19 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 26, 122 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      else
        unseen("R[27]", R[27])
      end
      if R[27] == 5 or R[27] == 7 then
        if R[27] == 5 then
          if R[17] == 0 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 123, 17 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 120, 106 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 26, 113 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 21, 10 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        elseif R[27] == 7 then
          if R[17] == 0 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 113, 106 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 116, 17 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 14, 10 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 19, 113 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        else
          unseen("R[27]", R[27])
        end
        if R[27] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[27] == 7 then
          if LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 17, [1] = 106, [2] = 17, [3] = 106 }, [1] = { [0] = 113, [1] = 10, [2] = 113, [3] = 10 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 17, [1] = 106, [2] = 17, [3] = 106 }, [1] = { [0] = 113, [1] = 10, [2] = 113, [3] = 10 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 17, [1] = 106, [2] = 17, [3] = 106 }, [1] = { [0] = 113, [1] = 10, [2] = 113, [3] = 10 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[27]", R[27])
        end
        if R[27] == 5 then
          if R[17] == 0 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 122, 25 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 119, 114 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 25, 121 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 20, 18 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        elseif R[27] == 7 then
          if R[17] == 0 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 118, 112 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 121, 23 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 19, 16 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 24, 119 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        else
          unseen("R[27]", R[27])
        end
        if R[27] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 17, [1] = 106, [2] = 17, [3] = 106 }, [1] = { [0] = 113, [1] = 10, [2] = 113, [3] = 10 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[27] == 7 then
        else
          unseen("R[27]", R[27])
        end
        if R[27] == 5 then
          if R[17] == 0 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 118, 23 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 115, 112 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 21, 119 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 16, 16 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        elseif R[27] == 7 then
          if R[17] == 0 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 115, 109 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 118, 20 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 16, 13 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 21, 116 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        else
          unseen("R[27]", R[27])
        end
        U[#U]:set_lights(true)
        if R[27] == 5 then
          if R[17] == 0 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 119, 22 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 111 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 22, 118 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 17, 15 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        elseif R[27] == 7 then
          if R[17] == 0 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 110 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 119, 21 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 17, 14 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 22, 117 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        else
          unseen("R[27]", R[27])
        end
        U[#U]:set_lights(true)
        if R[27] == 5 then
          if R[17] == 0 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 119, 24 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 116, 113 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 22, 120 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 17, 17 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        elseif R[27] == 7 then
          if R[17] == 0 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 121, 110 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 124, 21 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          elseif R[17] == 1 then
            if R[16] == 1 or R[16] == 3 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 22, 14 }, direction = "East", lights = false, exact = true }[1]
            elseif R[16] == 0 or R[16] == 2 then
              U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 27, 117 }, direction = "East", lights = false, exact = true }[1]
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[17]", R[17])
          end
        else
          unseen("R[27]", R[27])
        end
        U[#U]:set_lights(true)
      elseif R[27] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 115, [1] = 112, [2] = 115, [3] = 112 }, [1] = { [0] = 18, [1] = 13, [2] = 18, [3] = 13 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 112, [2] = 23, [3] = 112 }, [1] = { [0] = 119, [1] = 16, [2] = 119, [3] = 16 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 115, [1] = 112, [2] = 115, [3] = 112 }, [1] = { [0] = 18, [1] = 13, [2] = 18, [3] = 13 } })[R[17]][R[16]], ({ [0] = { [0] = 20, [1] = 109, [2] = 20, [3] = 109 }, [1] = { [0] = 116, [1] = 13, [2] = 116, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 18, [1] = 107, [2] = 18, [3] = 107 }, [1] = { [0] = 114, [1] = 11, [2] = 114, [3] = 11 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 1 then
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[27]", R[27])
      end
      if R[27] == 5 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 125, 19 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 122, 108 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 28, 115 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 23, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 6 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 119, 109 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 122, 20 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 25, 116 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 20, 13 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 7 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 115, 107 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 118, 18 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 16, 11 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 21, 114 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      else
        unseen("R[27]", R[27])
      end
      if R[27] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 122, [2] = 125, [3] = 122 }, [1] = { [0] = 28, [1] = 23, [2] = 28, [3] = 23 } })[R[17]][R[16]], ({ [0] = { [0] = 19, [1] = 108, [2] = 19, [3] = 108 }, [1] = { [0] = 115, [1] = 12, [2] = 115, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[27] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 122, [1] = 119, [2] = 122, [3] = 119 }, [1] = { [0] = 25, [1] = 20, [2] = 25, [3] = 20 } })[R[17]][R[16]], ({ [0] = { [0] = 20, [1] = 109, [2] = 20, [3] = 109 }, [1] = { [0] = 116, [1] = 13, [2] = 116, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 122, [1] = 119, [2] = 122, [3] = 119 }, [1] = { [0] = 25, [1] = 20, [2] = 25, [3] = 20 } })[R[17]][R[16]], ({ [0] = { [0] = 20, [1] = 109, [2] = 20, [3] = 109 }, [1] = { [0] = 116, [1] = 13, [2] = 116, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 114, [2] = 117, [3] = 114 }, [1] = { [0] = 20, [1] = 15, [2] = 20, [3] = 15 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 116, [2] = 27, [3] = 116 }, [1] = { [0] = 123, [1] = 20, [2] = 123, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[27] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 18, [1] = 107, [2] = 18, [3] = 107 }, [1] = { [0] = 114, [1] = 11, [2] = 114, [3] = 11 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[27]", R[27])
      end
    else
      unseen("R[27]", R[27])
    end
    U[#U]:set_lights(true)
    if R[27] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 114, [1] = 111, [2] = 114, [3] = 111 }, [1] = { [0] = 17, [1] = 12, [2] = 17, [3] = 12 } })[R[17]][R[16]], ({ [0] = { [0] = 19, [1] = 108, [2] = 19, [3] = 108 }, [1] = { [0] = 115, [1] = 12, [2] = 115, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 114, [1] = 111, [2] = 114, [3] = 111 }, [1] = { [0] = 17, [1] = 12, [2] = 17, [3] = 12 } })[R[17]][R[16]], ({ [0] = { [0] = 19, [1] = 108, [2] = 19, [3] = 108 }, [1] = { [0] = 115, [1] = 12, [2] = 115, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 122, [2] = 125, [3] = 122 }, [1] = { [0] = 28, [1] = 23, [2] = 28, [3] = 23 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 113, [2] = 24, [3] = 113 }, [1] = { [0] = 120, [1] = 17, [2] = 120, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 115, [1] = 112, [2] = 115, [3] = 112 }, [1] = { [0] = 18, [1] = 13, [2] = 18, [3] = 13 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 112, [2] = 23, [3] = 112 }, [1] = { [0] = 119, [1] = 16, [2] = 119, [3] = 16 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 115, [1] = 112, [2] = 115, [3] = 112 }, [1] = { [0] = 18, [1] = 13, [2] = 18, [3] = 13 } })[R[17]][R[16]], ({ [0] = { [0] = 23, [1] = 112, [2] = 23, [3] = 112 }, [1] = { [0] = 119, [1] = 16, [2] = 119, [3] = 16 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 114, [2] = 117, [3] = 114 }, [1] = { [0] = 20, [1] = 15, [2] = 20, [3] = 15 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 119, [1] = 116, [2] = 119, [3] = 116 }, [1] = { [0] = 22, [1] = 17, [2] = 22, [3] = 17 } })[R[17]][R[16]], ({ [0] = { [0] = 19, [1] = 108, [2] = 19, [3] = 108 }, [1] = { [0] = 115, [1] = 12, [2] = 115, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 119, [1] = 116, [2] = 119, [3] = 116 }, [1] = { [0] = 22, [1] = 17, [2] = 22, [3] = 17 } })[R[17]][R[16]], ({ [0] = { [0] = 19, [1] = 108, [2] = 19, [3] = 108 }, [1] = { [0] = 115, [1] = 12, [2] = 115, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 114, [2] = 117, [3] = 114 }, [1] = { [0] = 20, [1] = 15, [2] = 20, [3] = 15 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 113, [2] = 24, [3] = 113 }, [1] = { [0] = 120, [1] = 17, [2] = 120, [3] = 17 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 20, [1] = 109, [2] = 20, [3] = 109 }, [1] = { [0] = 116, [1] = 13, [2] = 116, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 20, [1] = 109, [2] = 20, [3] = 109 }, [1] = { [0] = 116, [1] = 13, [2] = 116, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 114, [2] = 117, [3] = 114 }, [1] = { [0] = 20, [1] = 15, [2] = 20, [3] = 15 } })[R[17]][R[16]], ({ [0] = { [0] = 20, [1] = 109, [2] = 20, [3] = 109 }, [1] = { [0] = 116, [1] = 13, [2] = 116, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 114, [1] = 111, [2] = 114, [3] = 111 }, [1] = { [0] = 17, [1] = 12, [2] = 17, [3] = 12 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[27] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 122, [2] = 125, [3] = 122 }, [1] = { [0] = 28, [1] = 23, [2] = 28, [3] = 23 } })[R[17]][R[16]], ({ [0] = { [0] = 19, [1] = 108, [2] = 19, [3] = 108 }, [1] = { [0] = 115, [1] = 12, [2] = 115, [3] = 12 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 122, [2] = 125, [3] = 122 }, [1] = { [0] = 28, [1] = 23, [2] = 28, [3] = 23 } })[R[17]][R[16]], ({ [0] = { [0] = 25, [1] = 114, [2] = 25, [3] = 114 }, [1] = { [0] = 121, [1] = 18, [2] = 121, [3] = 18 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[27] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 122, [1] = 119, [2] = 122, [3] = 119 }, [1] = { [0] = 25, [1] = 20, [2] = 25, [3] = 20 } })[R[17]][R[16]], ({ [0] = { [0] = 20, [1] = 109, [2] = 20, [3] = 109 }, [1] = { [0] = 116, [1] = 13, [2] = 116, [3] = 13 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 114, [2] = 117, [3] = 114 }, [1] = { [0] = 20, [1] = 15, [2] = 20, [3] = 15 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 27, [1] = 116, [2] = 27, [3] = 116 }, [1] = { [0] = 123, [1] = 20, [2] = 123, [3] = 20 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 21, [1] = 110, [2] = 21, [3] = 110 }, [1] = { [0] = 117, [1] = 14, [2] = 117, [3] = 14 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 28, [1] = 117, [2] = 28, [3] = 117 }, [1] = { [0] = 124, [1] = 21, [2] = 124, [3] = 21 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 21, [1] = 110, [2] = 21, [3] = 110 }, [1] = { [0] = 117, [1] = 14, [2] = 117, [3] = 14 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 18, [1] = 107, [2] = 18, [3] = 107 }, [1] = { [0] = 114, [1] = 11, [2] = 114, [3] = 11 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 122, [2] = 125, [3] = 122 }, [1] = { [0] = 28, [1] = 23, [2] = 28, [3] = 23 } })[R[17]][R[16]], ({ [0] = { [0] = 25, [1] = 114, [2] = 25, [3] = 114 }, [1] = { [0] = 121, [1] = 18, [2] = 121, [3] = 18 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[27]", R[27])
    end
    U[#U]:set_lights(true)
    if R[27] == 4 or R[27] == 5 or R[27] == 7 then
      if R[27] == 4 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 117, 28 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 114, 117 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 15, 21 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 20, 124 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 5 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 124, 23 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 121, 112 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 27, 119 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 22, 16 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 7 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 121, 117 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 124, 28 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 22, 21 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 27, 124 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      else
        unseen("R[27]", R[27])
      end
    elseif R[27] == 0 or R[27] == 1 or R[27] == 2 or R[27] == 3 or R[27] == 6 then
      if R[27] == 0 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 115, 20 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 112, 109 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 18, 116 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 13, 13 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 1 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 111, 111 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 114, 22 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 12, 15 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 17, 118 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 2 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 120, 18 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 117, 107 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 23, 114 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 18, 11 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 3 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 108 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 119, 19 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 22, 115 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 17, 12 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 6 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 111 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 119, 22 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 22, 118 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 17, 15 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      else
        unseen("R[27]", R[27])
      end
    else
      unseen("R[27]", R[27])
    end
    U[#U]:set_lights(true)
    if R[27] == 4 or R[27] == 5 or R[27] == 7 then
      if R[27] == 4 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 118, 27 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 115, 116 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 16, 20 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 21, 123 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 5 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 125, 22 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 122, 111 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 28, 118 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 23, 15 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 7 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 122, 117 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 125, 28 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 23, 21 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 28, 124 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      else
        unseen("R[27]", R[27])
      end
    elseif R[27] == 0 or R[27] == 1 or R[27] == 2 or R[27] == 3 or R[27] == 6 then
      if R[27] == 0 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 116, 20 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 113, 109 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 19, 116 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 14, 13 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 1 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 113, 110 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 116, 21 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 14, 14 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 19, 117 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 2 then
        if R[17] == 0 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 119, 17 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 116, 106 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 22, 113 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 17, 10 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 3 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 115, 107 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 118, 18 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 21, 114 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 16, 11 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      elseif R[27] == 6 then
        if R[17] == 0 then
          if R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 117, 110 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 120, 21 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        elseif R[17] == 1 then
          if R[16] == 0 or R[16] == 2 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 23, 117 }, direction = "East", lights = false, exact = true }[1]
          elseif R[16] == 1 or R[16] == 3 then
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 18, 14 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[17]", R[17])
        end
      else
        unseen("R[27]", R[27])
      end
    else
      unseen("R[27]", R[27])
    end
    U[#U]:set_lights(true)
    if R[27] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          if R[28] == 0 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 105 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 105 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 105 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 105 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 9 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 9 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 9 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 9 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[28] == 1 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 119, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 119, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 119, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 119, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 12 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 12 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[28] == 2 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 25 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 25 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 25 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 25 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 121 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 121 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 18 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 18 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 121 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 121 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 18 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 18 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          else
            unseen("R[28]", R[28])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 25, [1] = 114, [2] = 25, [3] = 114 }, [1] = { [0] = 121, [1] = 18, [2] = 121, [3] = 18 } })[R[17]][R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = { [0] = 118, [1] = 115, [2] = 118, [3] = 115 }, [1] = { [0] = 21, [1] = 16, [2] = 21, [3] = 16 } })[R[17]][R[16]], ({ [0] = { [0] = 25, [1] = 114, [2] = 25, [3] = 114 }, [1] = { [0] = 121, [1] = 18, [2] = 121, [3] = 18 } })[R[17]][R[16]] })
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          if R[29] == 0 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 26 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 26 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 26 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 26 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[29] == 1 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 109 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 109 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 109 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 109 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 13 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 13 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 13 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 13 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[29] == 2 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 105 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 105 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 105 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 105 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 24, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 24, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 9 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 9 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 24, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 24, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 9 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 9 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          else
            unseen("R[29]", R[29])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = { [0] = 119, [1] = 116, [2] = 119, [3] = 116 }, [1] = { [0] = 22, [1] = 17, [2] = 22, [3] = 17 } })[R[17]][R[16]], ({ [0] = { [0] = 25, [1] = 114, [2] = 25, [3] = 114 }, [1] = { [0] = 121, [1] = 18, [2] = 121, [3] = 18 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 119, [1] = 116, [2] = 119, [3] = 116 }, [1] = { [0] = 22, [1] = 17, [2] = 22, [3] = 17 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 115, [2] = 26, [3] = 115 }, [1] = { [0] = 122, [1] = 19, [2] = 122, [3] = 19 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 115, [2] = 26, [3] = 115 }, [1] = { [0] = 122, [1] = 19, [2] = 122, [3] = 19 } })[R[17]][R[16]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          if R[30] == 0 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 105 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 105 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 105 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 105 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 9 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 9 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 9 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 9 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[30] == 1 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 21 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 21 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 21 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 21 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 117 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 117 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 13, 14 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 13, 14 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 117 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 117 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 13, 14 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 13, 14 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[30] == 2 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 119, 26 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 119, 26 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 119, 26 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 119, 26 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          else
            unseen("R[30]", R[30])
          end
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = { [0] = 119, [1] = 116, [2] = 119, [3] = 116 }, [1] = { [0] = 22, [1] = 17, [2] = 22, [3] = 17 } })[R[17]][R[16]], ({ [0] = { [0] = 25, [1] = 114, [2] = 25, [3] = 114 }, [1] = { [0] = 121, [1] = 18, [2] = 121, [3] = 18 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 119, [1] = 116, [2] = 119, [3] = 116 }, [1] = { [0] = 22, [1] = 17, [2] = 22, [3] = 17 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 115, [2] = 26, [3] = 115 }, [1] = { [0] = 122, [1] = 19, [2] = 122, [3] = 19 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 115, [2] = 26, [3] = 115 }, [1] = { [0] = 122, [1] = 19, [2] = 122, [3] = 19 } })[R[17]][R[16]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = { [0] = 116, [1] = 113, [2] = 116, [3] = 113 }, [1] = { [0] = 19, [1] = 14, [2] = 19, [3] = 14 } })[R[17]][R[16]], ({ [0] = { [0] = 25, [1] = 114, [2] = 25, [3] = 114 }, [1] = { [0] = 121, [1] = 18, [2] = 121, [3] = 18 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 119, [1] = 116, [2] = 119, [3] = 116 }, [1] = { [0] = 22, [1] = 17, [2] = 22, [3] = 17 } })[R[17]][R[16]], ({ [0] = { [0] = 22, [1] = 111, [2] = 22, [3] = 111 }, [1] = { [0] = 118, [1] = 15, [2] = 118, [3] = 15 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 22, [1] = 111, [2] = 22, [3] = 111 }, [1] = { [0] = 118, [1] = 15, [2] = 118, [3] = 15 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 122, [1] = 119, [2] = 122, [3] = 119 }, [1] = { [0] = 25, [1] = 20, [2] = 25, [3] = 20 } })[R[17]][R[16]], ({ [0] = { [0] = 25, [1] = 114, [2] = 25, [3] = 114 }, [1] = { [0] = 121, [1] = 18, [2] = 121, [3] = 18 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 122, [1] = 119, [2] = 122, [3] = 119 }, [1] = { [0] = 25, [1] = 20, [2] = 25, [3] = 20 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 115, [2] = 26, [3] = 115 }, [1] = { [0] = 122, [1] = 19, [2] = 122, [3] = 19 } })[R[17]][R[16]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          if R[31] == 0 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 27 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 27 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 27 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 27 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 123 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 123 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 123 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 123 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[31] == 1 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 21 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 21 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 21 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 21 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 110 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 110 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 117 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 117 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 14 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 14 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 117 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 117 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 14 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 14 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[31] == 2 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 105 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 105 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 116, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 105 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 105 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 9 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 9 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 19, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 9 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 14, 9 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          else
            unseen("R[31]", R[31])
          end
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = { [0] = 116, [1] = 113, [2] = 116, [3] = 113 }, [1] = { [0] = 19, [1] = 14, [2] = 19, [3] = 14 } })[R[17]][R[16]], ({ [0] = { [0] = 25, [1] = 114, [2] = 25, [3] = 114 }, [1] = { [0] = 121, [1] = 18, [2] = 121, [3] = 18 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 119, [1] = 116, [2] = 119, [3] = 116 }, [1] = { [0] = 22, [1] = 17, [2] = 22, [3] = 17 } })[R[17]][R[16]], ({ [0] = { [0] = 22, [1] = 111, [2] = 22, [3] = 111 }, [1] = { [0] = 118, [1] = 15, [2] = 118, [3] = 15 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 120, [1] = 117, [2] = 120, [3] = 117 }, [1] = { [0] = 23, [1] = 18, [2] = 23, [3] = 18 } })[R[17]][R[16]], ({ [0] = { [0] = 22, [1] = 111, [2] = 22, [3] = 111 }, [1] = { [0] = 118, [1] = 15, [2] = 118, [3] = 15 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 122, [1] = 119, [2] = 122, [3] = 119 }, [1] = { [0] = 25, [1] = 20, [2] = 25, [3] = 20 } })[R[17]][R[16]], ({ [0] = { [0] = 25, [1] = 114, [2] = 25, [3] = 114 }, [1] = { [0] = 121, [1] = 18, [2] = 121, [3] = 18 } })[R[17]][R[16]] })
        game.create_tube({ ({ [0] = { [0] = 122, [1] = 119, [2] = 122, [3] = 119 }, [1] = { [0] = 25, [1] = 20, [2] = 25, [3] = 20 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 115, [2] = 26, [3] = 115 }, [1] = { [0] = 122, [1] = 19, [2] = 122, [3] = 19 } })[R[17]][R[16]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = { [0] = 115, [1] = 112, [2] = 115, [3] = 112 }, [1] = { [0] = 18, [1] = 13, [2] = 18, [3] = 13 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 113, [2] = 24, [3] = 113 }, [1] = { [0] = 120, [1] = 17, [2] = 120, [3] = 17 } })[R[17]][R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = { [0] = 115, [1] = 112, [2] = 115, [3] = 112 }, [1] = { [0] = 18, [1] = 13, [2] = 18, [3] = 13 } })[R[17]][R[16]], ({ [0] = { [0] = 24, [1] = 113, [2] = 24, [3] = 113 }, [1] = { [0] = 120, [1] = 17, [2] = 120, [3] = 17 } })[R[17]][R[16]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          if R[32] == 0 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 105 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 105 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 105 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 105 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 9 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 9 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 9 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 9 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[32] == 1 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[32] == 2 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 26 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 26 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 26 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 26 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          else
            unseen("R[32]", R[32])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          if R[33] == 0 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 27 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 27 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 27 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 27 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 116 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 116 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 123 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 123 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 123 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 123 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 20 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 20 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[33] == 1 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[33] == 2 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 106 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 106 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 106 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 106 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          else
            unseen("R[33]", R[33])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          if R[34] == 0 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 106 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 106 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 106 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 106 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[34] == 1 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 23 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 23 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 23 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 23 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 112 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 112 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 119 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 119 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 119 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 26, 119 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 16 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 16 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[34] == 2 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 24 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 24 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 24 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 120, 24 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 120 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 23, 120 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 18, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          else
            unseen("R[34]", R[34])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[35] = game.rand(3)
          if R[35] == 0 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 26 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 26 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 26 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 26 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 115 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 115 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 21, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 19 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 16, 19 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[35] == 1 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 114, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 111 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 111 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 118 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 17, 118 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 15 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 12, 15 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          elseif R[35] == 2 then
            if R[17] == 0 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 106 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 106 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 17 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 17 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 106 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 121, 106 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            elseif R[17] == 1 then
              if R[16] == 0 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 1 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 2 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 113 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 27, 113 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              elseif R[16] == 3 then
                if (players[2].is_eden and 1 or 0) == 1 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 10 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
                elseif (players[2].is_eden and 1 or 0) == 0 then
                  U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 10 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
                else
                  unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
                end
              else
                unseen("R[16]", R[16])
              end
            else
              unseen("R[17]", R[17])
            end
          else
            unseen("R[35]", R[35])
          end
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[27]", R[27])
    end
    players[1]:mark_research(3303)
    players[1].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[1].difficulty]]
    players[1].scientists = 18 - 3 * LEVEL_OF[players[1].difficulty]
    players[1].kids = 22 - 2 * LEVEL_OF[players[1].difficulty]
    players[1].food = 3000 - 1000 * LEVEL_OF[players[1].difficulty]
    players[1].ore = 6000 - 2000 * LEVEL_OF[players[1].difficulty]
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
    players[2].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[2].difficulty]]
    players[2].scientists = 18 - 3 * LEVEL_OF[players[2].difficulty]
    players[2].kids = 22 - 2 * LEVEL_OF[players[2].difficulty]
    players[2].food = 3000 - 1000 * LEVEL_OF[players[2].difficulty]
    players[2].ore = 6000 - 2000 * LEVEL_OF[players[2].difficulty]
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 39, 22 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 106, 15 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 118, 90 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 40, 121 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 27, 33 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 18, 96 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[0]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[1]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[2]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[3]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[4]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[5]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[6]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[7]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[8]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[9]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[10]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[11]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[12]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[13]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[14]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[15]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[15]] } }
    pick(4, 3, { 16, 36, 37 })
    R[18] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[18]][R[16]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[18]][R[16]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] })
    if R[18] == 5 or R[18] == 6 or R[18] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [6] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [7] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[18]][R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[18]][R[16]], ({ [5] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [6] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [7] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[18] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[18] == 5 or R[18] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [7] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[18]][R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[18] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[18] == 7 then
          if LEVEL_OF[players[1].difficulty] == 2 then
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[18]", R[18])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [7] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[18]][R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[18] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[18] == 5 then
        else
          unseen("R[18]", R[18])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[18]][R[16]], ({ [5] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[18]", R[18])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 }, [7] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 } })[R[18]][R[16]], ({ [5] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [6] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [7] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[18] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[18] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[18] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[18]", R[18])
      end
    elseif R[18] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[18] == 1 or R[18] == 2 or R[18] == 3 or R[18] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [3] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [4] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[18]][R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[18] == 1 or R[18] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[18]][R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[16]], ({ [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[18]][R[16]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[18]][R[16]], ({ [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 } })[R[18]][R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[18]][R[16]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 9, [1] = 112, [2] = 105, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[18]", R[18])
      end
      U[#U]:set_lights(true)
      if R[18] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[18]", R[18])
      end
      U[#U]:set_lights(true)
      if R[18] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[18]", R[18])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [3] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 } })[R[18]][R[16]], ({ [1] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [3] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [4] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[18]", R[18])
    end
    U[#U]:set_lights(true)
    if R[18] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[18] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[18] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[18]", R[18])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[18]], player = players[1], at = { ({ [0] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [3] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [5] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [6] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[18]][R[16]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [6] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[18]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [1] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [3] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [4] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [7] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 } })[R[18]][R[16]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [3] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [4] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [6] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[18] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[38]][R[16]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 18, [1] = 121, [2] = 114, [3] = 25 } })[R[38]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[39]][R[16]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[39]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[40]][R[16]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[40]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[41]][R[16]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[41]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[42]][R[16]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[42]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 } })[R[43]][R[16]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[43]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[44]][R[16]], ({ [0] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 } })[R[44]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[45]][R[16]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[45]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[18]", R[18])
    end
    R[27] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 21, [3] = 13, [4] = 17, [5] = 16, [6] = 13, [7] = 19 }, [1] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 }, [2] = { [0] = 116, [1] = 120, [2] = 120, [3] = 112, [4] = 116, [5] = 115, [6] = 112, [7] = 118 }, [3] = { [0] = 119, [1] = 123, [2] = 123, [3] = 115, [4] = 119, [5] = 118, [6] = 115, [7] = 121 } })[R[36]][R[27]], ({ [0] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 112, [1] = 108, [2] = 112, [3] = 108, [4] = 111, [5] = 109, [6] = 106, [7] = 109 }, [3] = { [0] = 23, [1] = 19, [2] = 23, [3] = 19, [4] = 22, [5] = 20, [6] = 17, [7] = 20 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 17, [1] = 21, [2] = 21, [3] = 13, [4] = 17, [5] = 16, [6] = 13, [7] = 19 }, [1] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 }, [2] = { [0] = 116, [1] = 120, [2] = 120, [3] = 112, [4] = 116, [5] = 115, [6] = 112, [7] = 118 }, [3] = { [0] = 119, [1] = 123, [2] = 123, [3] = 115, [4] = 119, [5] = 118, [6] = 115, [7] = 121 } })[R[36]][R[27]], ({ [0] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 112, [1] = 108, [2] = 112, [3] = 108, [4] = 111, [5] = 109, [6] = 106, [7] = 109 }, [3] = { [0] = 23, [1] = 19, [2] = 23, [3] = 19, [4] = 22, [5] = 20, [6] = 17, [7] = 20 } })[R[36]][R[27]] })
    if R[27] == 5 or R[27] == 6 or R[27] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 13, [6] = 22, [7] = 13 }, [1] = { [5] = 18, [6] = 27, [7] = 18 }, [2] = { [5] = 112, [6] = 121, [7] = 112 }, [3] = { [5] = 115, [6] = 124, [7] = 115 } })[R[36]][R[27]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 21, [6] = 13, [7] = 21 }, [1] = { [5] = 26, [6] = 18, [7] = 26 }, [2] = { [5] = 120, [6] = 112, [7] = 120 }, [3] = { [5] = 123, [6] = 115, [7] = 123 } })[R[36]][R[27]], ({ [0] = { [5] = 14, [6] = 19, [7] = 19 }, [1] = { [5] = 117, [6] = 122, [7] = 122 }, [2] = { [5] = 110, [6] = 115, [7] = 115 }, [3] = { [5] = 21, [6] = 26, [7] = 26 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
      if R[27] == 5 or R[27] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 21, [7] = 14 }, [1] = { [5] = 26, [7] = 19 }, [2] = { [5] = 120, [7] = 113 }, [3] = { [5] = 123, [7] = 116 } })[R[36]][R[27]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if R[27] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[27] == 7 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[27]", R[27])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [5] = 20, [7] = 19 }, [1] = { [5] = 25, [7] = 24 }, [2] = { [5] = 119, [7] = 118 }, [3] = { [5] = 122, [7] = 121 } })[R[36]][R[27]], ({ [0] = { [5] = 18, [7] = 16 }, [1] = { [5] = 121, [7] = 119 }, [2] = { [5] = 114, [7] = 112 }, [3] = { [5] = 25, [7] = 23 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        if R[27] == 7 then
        elseif R[27] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[27]", R[27])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = { [5] = 16, [7] = 13 }, [1] = { [5] = 119, [7] = 116 }, [2] = { [5] = 112, [7] = 109 }, [3] = { [5] = 23, [7] = 20 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = { [5] = 15, [7] = 14 }, [1] = { [5] = 118, [7] = 117 }, [2] = { [5] = 111, [7] = 110 }, [3] = { [5] = 22, [7] = 21 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 17, [7] = 22 }, [1] = { [5] = 22, [7] = 27 }, [2] = { [5] = 116, [7] = 121 }, [3] = { [5] = 119, [7] = 124 } })[R[36]][R[27]], ({ [0] = { [5] = 17, [7] = 14 }, [1] = { [5] = 120, [7] = 117 }, [2] = { [5] = 113, [7] = 110 }, [3] = { [5] = 24, [7] = 21 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[27] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[27]", R[27])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 23, [6] = 20, [7] = 16 }, [1] = { [5] = 28, [6] = 25, [7] = 21 }, [2] = { [5] = 122, [6] = 119, [7] = 115 }, [3] = { [5] = 125, [6] = 122, [7] = 118 } })[R[36]][R[27]], ({ [0] = { [5] = 12, [6] = 13, [7] = 11 }, [1] = { [5] = 115, [6] = 116, [7] = 114 }, [2] = { [5] = 108, [6] = 109, [7] = 107 }, [3] = { [5] = 19, [6] = 20, [7] = 18 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
      if R[27] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[27] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[27] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[27]", R[27])
      end
    elseif R[27] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[27] == 1 or R[27] == 2 or R[27] == 3 or R[27] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 21, [2] = 14, [3] = 18, [4] = 14 }, [1] = { [1] = 26, [2] = 19, [3] = 23, [4] = 19 }, [2] = { [1] = 120, [2] = 113, [3] = 117, [4] = 113 }, [3] = { [1] = 123, [2] = 116, [3] = 120, [4] = 116 } })[R[36]][R[27]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[27] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[36]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 1 then
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 9, [1] = 112, [2] = 105, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[27] == 1 or R[27] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 12, [2] = 13 }, [1] = { [1] = 17, [2] = 18 }, [2] = { [1] = 111, [2] = 112 }, [3] = { [1] = 114, [2] = 115 } })[R[36]][R[27]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[36]], ({ [0] = { [1] = 15, [2] = 19 }, [1] = { [1] = 118, [2] = 122 }, [2] = { [1] = 111, [2] = 115 }, [3] = { [1] = 22, [2] = 26 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 1 then
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 16, [2] = 17 }, [1] = { [1] = 21, [2] = 22 }, [2] = { [1] = 115, [2] = 116 }, [3] = { [1] = 118, [2] = 119 } })[R[36]][R[27]], ({ [0] = { [1] = 20, [2] = 16 }, [1] = { [1] = 123, [2] = 119 }, [2] = { [1] = 116, [2] = 112 }, [3] = { [1] = 27, [2] = 23 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 16, [2] = 21 }, [1] = { [1] = 21, [2] = 26 }, [2] = { [1] = 115, [2] = 120 }, [3] = { [1] = 118, [2] = 123 } })[R[36]][R[27]], ({ [0] = { [1] = 16, [2] = 13 }, [1] = { [1] = 119, [2] = 116 }, [2] = { [1] = 112, [2] = 109 }, [3] = { [1] = 23, [2] = 20 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 22, [2] = 20 }, [1] = { [1] = 27, [2] = 25 }, [2] = { [1] = 121, [2] = 119 }, [3] = { [1] = 124, [2] = 122 } })[R[36]][R[27]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 23, [2] = 22 }, [1] = { [1] = 28, [2] = 27 }, [2] = { [1] = 122, [2] = 121 }, [3] = { [1] = 125, [2] = 124 } })[R[36]][R[27]], ({ [0] = { [1] = 20, [2] = 21 }, [1] = { [1] = 123, [2] = 124 }, [2] = { [1] = 116, [2] = 117 }, [3] = { [1] = 27, [2] = 28 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[27]", R[27])
      end
      U[#U]:set_lights(true)
      if R[27] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[27]", R[27])
      end
      U[#U]:set_lights(true)
      if R[27] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[27]", R[27])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 23, [2] = 15, [3] = 15, [4] = 15 }, [1] = { [1] = 28, [2] = 20, [3] = 20, [4] = 20 }, [2] = { [1] = 122, [2] = 114, [3] = 114, [4] = 114 }, [3] = { [1] = 125, [2] = 117, [3] = 117, [4] = 117 } })[R[36]][R[27]], ({ [0] = { [1] = 17, [2] = 21, [3] = 17, [4] = 13 }, [1] = { [1] = 120, [2] = 124, [3] = 120, [4] = 116 }, [2] = { [1] = 113, [2] = 117, [3] = 113, [4] = 109 }, [3] = { [1] = 24, [2] = 28, [3] = 24, [4] = 20 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[27]", R[27])
    end
    U[#U]:set_lights(true)
    if R[27] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[27] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[27] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[27]", R[27])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[27]], player = players[2], at = { ({ [0] = { [0] = 13, [1] = 12, [2] = 18, [3] = 17, [4] = 15, [5] = 22, [6] = 17, [7] = 22 }, [1] = { [0] = 18, [1] = 17, [2] = 23, [3] = 22, [4] = 20, [5] = 27, [6] = 22, [7] = 27 }, [2] = { [0] = 112, [1] = 111, [2] = 117, [3] = 116, [4] = 114, [5] = 121, [6] = 116, [7] = 121 }, [3] = { [0] = 115, [1] = 114, [2] = 120, [3] = 119, [4] = 117, [5] = 124, [6] = 119, [7] = 124 } })[R[36]][R[27]], ({ [0] = { [0] = 13, [1] = 15, [2] = 11, [3] = 12, [4] = 21, [5] = 16, [6] = 15, [7] = 21 }, [1] = { [0] = 116, [1] = 118, [2] = 114, [3] = 115, [4] = 124, [5] = 119, [6] = 118, [7] = 124 }, [2] = { [0] = 109, [1] = 111, [2] = 107, [3] = 108, [4] = 117, [5] = 112, [6] = 111, [7] = 117 }, [3] = { [0] = 20, [1] = 22, [2] = 18, [3] = 19, [4] = 28, [5] = 23, [6] = 22, [7] = 28 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[27]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 14, [2] = 17, [3] = 16, [4] = 16, [5] = 23, [6] = 18, [7] = 23 }, [1] = { [0] = 19, [1] = 19, [2] = 22, [3] = 21, [4] = 21, [5] = 28, [6] = 23, [7] = 28 }, [2] = { [0] = 113, [1] = 113, [2] = 116, [3] = 115, [4] = 115, [5] = 122, [6] = 117, [7] = 122 }, [3] = { [0] = 116, [1] = 116, [2] = 119, [3] = 118, [4] = 118, [5] = 125, [6] = 120, [7] = 125 } })[R[36]][R[27]], ({ [0] = { [0] = 13, [1] = 14, [2] = 10, [3] = 11, [4] = 20, [5] = 15, [6] = 14, [7] = 21 }, [1] = { [0] = 116, [1] = 117, [2] = 113, [3] = 114, [4] = 123, [5] = 118, [6] = 117, [7] = 124 }, [2] = { [0] = 109, [1] = 110, [2] = 106, [3] = 107, [4] = 116, [5] = 111, [6] = 110, [7] = 117 }, [3] = { [0] = 20, [1] = 21, [2] = 17, [3] = 18, [4] = 27, [5] = 22, [6] = 21, [7] = 28 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[27] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[46] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[46]][R[36]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 18, [1] = 121, [2] = 114, [3] = 25 } })[R[46]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[47]][R[36]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[47]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[48]][R[36]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[48]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[49]][R[36]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[49]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] })
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[50]][R[36]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[50]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 } })[R[51]][R[36]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[51]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[52]][R[36]], ({ [0] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 } })[R[52]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[53]][R[36]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[53]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[27]", R[27])
    end
    R[54] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[54]][R[37]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[54]][R[37]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[54]][R[37]] })
    if R[54] == 5 or R[54] == 6 or R[54] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [6] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [7] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[54]][R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[54]][R[37]], ({ [5] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [6] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [7] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
      if R[54] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[54] == 5 or R[54] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [7] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[54]][R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        if R[54] == 5 then
          if LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[54] == 7 then
          if LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[54]", R[54])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [5] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[54]][R[37]], ({ [5] = { [0] = 18, [1] = 121, [2] = 114, [3] = 25 }, [7] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        if R[54] == 7 then
        elseif R[54] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[54]", R[54])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[54]][R[37]], ({ [5] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[54]", R[54])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 }, [7] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 } })[R[54]][R[37]], ({ [5] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [6] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [7] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
      if R[54] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[54] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[54] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[54]", R[54])
      end
    elseif R[54] == 1 or R[54] == 2 or R[54] == 3 or R[54] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [3] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [4] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[54]][R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      if R[54] == 1 or R[54] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[54]][R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[37]], ({ [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[54]][R[37]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[54]][R[37]], ({ [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 } })[R[54]][R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[54]][R[37]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[37]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 9, [1] = 112, [2] = 105, [3] = 16 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[54]", R[54])
      end
      U[#U]:set_lights(true)
      if R[54] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[54]", R[54])
      end
      U[#U]:set_lights(true)
      if R[54] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[54]", R[54])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [3] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 } })[R[54]][R[37]], ({ [1] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [3] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [4] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[54] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[54]", R[54])
    end
    U[#U]:set_lights(true)
    if R[54] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[54] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[54] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[54] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[54] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[54] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[54] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[54] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[54]", R[54])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[54]], player = players[3], at = { ({ [0] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [3] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [5] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [6] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[54]][R[37]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [6] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[54]], player = players[3], at = { ({ [0] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [1] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [3] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [4] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [7] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 } })[R[54]][R[37]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [3] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [4] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [6] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[54] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[55]][R[37]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 18, [1] = 121, [2] = 114, [3] = 25 } })[R[55]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[56]][R[37]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[56]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[57]][R[37]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[57]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[58]][R[37]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[58]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] })
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[59]][R[37]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[59]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 } })[R[60]][R[37]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[60]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[61]][R[37]], ({ [0] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 } })[R[61]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[62] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[62]][R[37]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[62]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[54]", R[54])
    end
    players[1]:mark_research(3303)
    players[1].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[1].difficulty]]
    players[1].scientists = 18 - 3 * LEVEL_OF[players[1].difficulty]
    players[1].kids = 22 - 2 * LEVEL_OF[players[1].difficulty]
    players[1].food = 3000 - 1000 * LEVEL_OF[players[1].difficulty]
    players[1].ore = 6000 - 2000 * LEVEL_OF[players[1].difficulty]
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
    players[2].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[2].difficulty]]
    players[2].scientists = 18 - 3 * LEVEL_OF[players[2].difficulty]
    players[2].kids = 22 - 2 * LEVEL_OF[players[2].difficulty]
    players[2].food = 3000 - 1000 * LEVEL_OF[players[2].difficulty]
    players[2].ore = 6000 - 2000 * LEVEL_OF[players[2].difficulty]
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
    players[3].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[3].difficulty]]
    players[3].scientists = 18 - 3 * LEVEL_OF[players[3].difficulty]
    players[3].kids = 22 - 2 * LEVEL_OF[players[3].difficulty]
    players[3].food = 3000 - 1000 * LEVEL_OF[players[3].difficulty]
    players[3].ore = 6000 - 2000 * LEVEL_OF[players[3].difficulty]
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 39, 22 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 106, 15 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 118, 90 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 40, 121 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 27, 33 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 18, 96 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[0]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[1]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[2]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[3]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[4]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[5]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[6]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[7]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[8]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[9]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[10]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[11]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 6, [1] = 19, [2] = 15, [3] = 49, [4] = 57, [5] = 38, [6] = 33, [7] = 64 })[R[12]], ({ [0] = 58, [1] = 71, [2] = 36, [3] = 34, [4] = 26, [5] = 10, [6] = 36, [7] = 39 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 10, [1] = 7, [2] = 23, [3] = 49, [4] = 67, [5] = 48, [6] = 51, [7] = 33 })[R[13]], ({ [0] = 114, [1] = 83, [2] = 103, [3] = 88, [4] = 123, [5] = 116, [6] = 69, [7] = 99 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 92, [1] = 82, [2] = 93, [3] = 106, [4] = 125, [5] = 103, [6] = 83, [7] = 64 })[R[14]], ({ [0] = 126, [1] = 87, [2] = 88, [3] = 81, [4] = 87, [5] = 68, [6] = 76, [7] = 77 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 97, [1] = 67, [2] = 86, [3] = 126, [4] = 113, [5] = 102, [6] = 63, [7] = 86 })[R[15]], ({ [0] = 4, [1] = 21, [2] = 19, [3] = 50, [4] = 46, [5] = 51, [6] = 22, [7] = 3 })[R[15]] } }
    pick(4, 4, { 16, 36, 37, 63 })
    R[18] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[18]][R[16]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[18]][R[16]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] })
    if R[18] == 1 or R[18] == 2 or R[18] == 3 or R[18] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [3] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [4] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[18]][R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[18] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 9, [1] = 112, [2] = 105, [3] = 16 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 1 or R[18] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[18]][R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[16]], ({ [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 1 then
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[18]][R[16]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[18]][R[16]], ({ [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 } })[R[18]][R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[18]", R[18])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[18]], player = players[1], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [3] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[18]][R[16]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [3] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [4] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[18]], player = players[1], at = { ({ [1] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [3] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [4] = { [0] = 11, [1] = 16, [2] = 110, [3] = 113 } })[R[18]][R[16]], ({ [1] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [2] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [3] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [4] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [3] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 } })[R[18]][R[16]], ({ [1] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [3] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [4] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[18] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[18] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[18]", R[18])
      end
    elseif R[18] == 5 or R[18] == 6 or R[18] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [6] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [7] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[18]][R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[18]][R[16]], ({ [5] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [6] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [7] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[18] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[18] == 5 or R[18] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [7] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[18]][R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[18] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[18] == 7 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[18]", R[18])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[18]][R[16]], ({ [5] = { [0] = 18, [1] = 121, [2] = 114, [3] = 25 }, [7] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        if R[18] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[18] == 7 then
        else
          unseen("R[18]", R[18])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[18]][R[16]], ({ [5] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[18]", R[18])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 }, [7] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 } })[R[18]][R[16]], ({ [5] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [6] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [7] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[18] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[18] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[18] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[18]", R[18])
      end
    elseif R[18] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[16]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[18]", R[18])
    end
    U[#U]:set_lights(true)
    if R[18] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[18] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[18] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[18] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[18]", R[18])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[18]], player = players[1], at = { ({ [0] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [3] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [5] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [6] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[18]][R[16]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [6] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[18]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [1] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [3] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [4] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [7] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 } })[R[18]][R[16]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [3] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [4] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [6] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[18]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[18] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[64]][R[16]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 18, [1] = 121, [2] = 114, [3] = 25 } })[R[64]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[65]][R[16]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[65]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[66]][R[16]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[66]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[16]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[16]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[16]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[16]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[67]][R[16]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[67]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[16]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[16]] })
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[68]][R[16]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[68]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 } })[R[69]][R[16]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[69]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[70]][R[16]], ({ [0] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 } })[R[70]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[18] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[71] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[71]][R[16]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[71]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[18]", R[18])
    end
    R[27] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 21, [3] = 13, [4] = 17, [5] = 16, [6] = 13, [7] = 19 }, [1] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 }, [2] = { [0] = 116, [1] = 120, [2] = 120, [3] = 112, [4] = 116, [5] = 115, [6] = 112, [7] = 118 }, [3] = { [0] = 119, [1] = 123, [2] = 123, [3] = 115, [4] = 119, [5] = 118, [6] = 115, [7] = 121 } })[R[36]][R[27]], ({ [0] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 112, [1] = 108, [2] = 112, [3] = 108, [4] = 111, [5] = 109, [6] = 106, [7] = 109 }, [3] = { [0] = 23, [1] = 19, [2] = 23, [3] = 19, [4] = 22, [5] = 20, [6] = 17, [7] = 20 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 17, [1] = 21, [2] = 21, [3] = 13, [4] = 17, [5] = 16, [6] = 13, [7] = 19 }, [1] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 }, [2] = { [0] = 116, [1] = 120, [2] = 120, [3] = 112, [4] = 116, [5] = 115, [6] = 112, [7] = 118 }, [3] = { [0] = 119, [1] = 123, [2] = 123, [3] = 115, [4] = 119, [5] = 118, [6] = 115, [7] = 121 } })[R[36]][R[27]], ({ [0] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 112, [1] = 108, [2] = 112, [3] = 108, [4] = 111, [5] = 109, [6] = 106, [7] = 109 }, [3] = { [0] = 23, [1] = 19, [2] = 23, [3] = 19, [4] = 22, [5] = 20, [6] = 17, [7] = 20 } })[R[36]][R[27]] })
    if R[27] == 5 or R[27] == 6 or R[27] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 13, [6] = 22, [7] = 13 }, [1] = { [5] = 18, [6] = 27, [7] = 18 }, [2] = { [5] = 112, [6] = 121, [7] = 112 }, [3] = { [5] = 115, [6] = 124, [7] = 115 } })[R[36]][R[27]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 21, [6] = 13, [7] = 21 }, [1] = { [5] = 26, [6] = 18, [7] = 26 }, [2] = { [5] = 120, [6] = 112, [7] = 120 }, [3] = { [5] = 123, [6] = 115, [7] = 123 } })[R[36]][R[27]], ({ [0] = { [5] = 14, [6] = 19, [7] = 19 }, [1] = { [5] = 117, [6] = 122, [7] = 122 }, [2] = { [5] = 110, [6] = 115, [7] = 115 }, [3] = { [5] = 21, [6] = 26, [7] = 26 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
      if R[27] == 5 or R[27] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 21, [7] = 14 }, [1] = { [5] = 26, [7] = 19 }, [2] = { [5] = 120, [7] = 113 }, [3] = { [5] = 123, [7] = 116 } })[R[36]][R[27]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if R[27] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[27] == 7 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[27]", R[27])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [5] = 20, [7] = 19 }, [1] = { [5] = 25, [7] = 24 }, [2] = { [5] = 119, [7] = 118 }, [3] = { [5] = 122, [7] = 121 } })[R[36]][R[27]], ({ [0] = { [5] = 18, [7] = 16 }, [1] = { [5] = 121, [7] = 119 }, [2] = { [5] = 114, [7] = 112 }, [3] = { [5] = 25, [7] = 23 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        if R[27] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[27] == 7 then
        else
          unseen("R[27]", R[27])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = { [5] = 16, [7] = 13 }, [1] = { [5] = 119, [7] = 116 }, [2] = { [5] = 112, [7] = 109 }, [3] = { [5] = 23, [7] = 20 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = { [5] = 15, [7] = 14 }, [1] = { [5] = 118, [7] = 117 }, [2] = { [5] = 111, [7] = 110 }, [3] = { [5] = 22, [7] = 21 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 17, [7] = 22 }, [1] = { [5] = 22, [7] = 27 }, [2] = { [5] = 116, [7] = 121 }, [3] = { [5] = 119, [7] = 124 } })[R[36]][R[27]], ({ [0] = { [5] = 17, [7] = 14 }, [1] = { [5] = 120, [7] = 117 }, [2] = { [5] = 113, [7] = 110 }, [3] = { [5] = 24, [7] = 21 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[27] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[27]", R[27])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 23, [6] = 20, [7] = 16 }, [1] = { [5] = 28, [6] = 25, [7] = 21 }, [2] = { [5] = 122, [6] = 119, [7] = 115 }, [3] = { [5] = 125, [6] = 122, [7] = 118 } })[R[36]][R[27]], ({ [0] = { [5] = 12, [6] = 13, [7] = 11 }, [1] = { [5] = 115, [6] = 116, [7] = 114 }, [2] = { [5] = 108, [6] = 109, [7] = 107 }, [3] = { [5] = 19, [6] = 20, [7] = 18 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
      if R[27] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[27] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[27] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[27]", R[27])
      end
    elseif R[27] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[27] == 1 or R[27] == 2 or R[27] == 3 or R[27] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 21, [2] = 14, [3] = 18, [4] = 14 }, [1] = { [1] = 26, [2] = 19, [3] = 23, [4] = 19 }, [2] = { [1] = 120, [2] = 113, [3] = 117, [4] = 113 }, [3] = { [1] = 123, [2] = 116, [3] = 120, [4] = 116 } })[R[36]][R[27]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[27] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[36]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 9, [1] = 112, [2] = 105, [3] = 16 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 1 or R[27] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 12, [2] = 13 }, [1] = { [1] = 17, [2] = 18 }, [2] = { [1] = 111, [2] = 112 }, [3] = { [1] = 114, [2] = 115 } })[R[36]][R[27]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[36]], ({ [0] = { [1] = 15, [2] = 19 }, [1] = { [1] = 118, [2] = 122 }, [2] = { [1] = 111, [2] = 115 }, [3] = { [1] = 22, [2] = 26 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 16, [2] = 17 }, [1] = { [1] = 21, [2] = 22 }, [2] = { [1] = 115, [2] = 116 }, [3] = { [1] = 118, [2] = 119 } })[R[36]][R[27]], ({ [0] = { [1] = 20, [2] = 16 }, [1] = { [1] = 123, [2] = 119 }, [2] = { [1] = 116, [2] = 112 }, [3] = { [1] = 27, [2] = 23 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 16, [2] = 21 }, [1] = { [1] = 21, [2] = 26 }, [2] = { [1] = 115, [2] = 120 }, [3] = { [1] = 118, [2] = 123 } })[R[36]][R[27]], ({ [0] = { [1] = 16, [2] = 13 }, [1] = { [1] = 119, [2] = 116 }, [2] = { [1] = 112, [2] = 109 }, [3] = { [1] = 23, [2] = 20 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 22, [2] = 20 }, [1] = { [1] = 27, [2] = 25 }, [2] = { [1] = 121, [2] = 119 }, [3] = { [1] = 124, [2] = 122 } })[R[36]][R[27]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[36]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[27]", R[27])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[27]], player = players[2], at = { ({ [0] = { [1] = 23, [2] = 22, [3] = 20, [4] = 17 }, [1] = { [1] = 28, [2] = 27, [3] = 25, [4] = 22 }, [2] = { [1] = 122, [2] = 121, [3] = 119, [4] = 116 }, [3] = { [1] = 125, [2] = 124, [3] = 122, [4] = 119 } })[R[36]][R[27]], ({ [0] = { [1] = 20, [2] = 21, [3] = 20, [4] = 10 }, [1] = { [1] = 123, [2] = 124, [3] = 123, [4] = 113 }, [2] = { [1] = 116, [2] = 117, [3] = 116, [4] = 106 }, [3] = { [1] = 27, [2] = 28, [3] = 27, [4] = 17 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[27]], player = players[2], at = { ({ [0] = { [1] = 20, [2] = 18, [3] = 21, [4] = 11 }, [1] = { [1] = 25, [2] = 23, [3] = 26, [4] = 16 }, [2] = { [1] = 119, [2] = 117, [3] = 120, [4] = 110 }, [3] = { [1] = 122, [2] = 120, [3] = 123, [4] = 113 } })[R[36]][R[27]], ({ [0] = { [1] = 21, [2] = 20, [3] = 21, [4] = 17 }, [1] = { [1] = 124, [2] = 123, [3] = 124, [4] = 120 }, [2] = { [1] = 117, [2] = 116, [3] = 117, [4] = 113 }, [3] = { [1] = 28, [2] = 27, [3] = 28, [4] = 24 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 23, [2] = 15, [3] = 15, [4] = 15 }, [1] = { [1] = 28, [2] = 20, [3] = 20, [4] = 20 }, [2] = { [1] = 122, [2] = 114, [3] = 114, [4] = 114 }, [3] = { [1] = 125, [2] = 117, [3] = 117, [4] = 117 } })[R[36]][R[27]], ({ [0] = { [1] = 17, [2] = 21, [3] = 17, [4] = 13 }, [1] = { [1] = 120, [2] = 124, [3] = 120, [4] = 116 }, [2] = { [1] = 113, [2] = 117, [3] = 113, [4] = 109 }, [3] = { [1] = 24, [2] = 28, [3] = 24, [4] = 20 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
      if R[27] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[27] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[27]", R[27])
      end
    else
      unseen("R[27]", R[27])
    end
    U[#U]:set_lights(true)
    if R[27] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[27] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[27] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[27] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[27]", R[27])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[27]], player = players[2], at = { ({ [0] = { [0] = 13, [1] = 12, [2] = 18, [3] = 17, [4] = 15, [5] = 22, [6] = 17, [7] = 22 }, [1] = { [0] = 18, [1] = 17, [2] = 23, [3] = 22, [4] = 20, [5] = 27, [6] = 22, [7] = 27 }, [2] = { [0] = 112, [1] = 111, [2] = 117, [3] = 116, [4] = 114, [5] = 121, [6] = 116, [7] = 121 }, [3] = { [0] = 115, [1] = 114, [2] = 120, [3] = 119, [4] = 117, [5] = 124, [6] = 119, [7] = 124 } })[R[36]][R[27]], ({ [0] = { [0] = 13, [1] = 15, [2] = 11, [3] = 12, [4] = 21, [5] = 16, [6] = 15, [7] = 21 }, [1] = { [0] = 116, [1] = 118, [2] = 114, [3] = 115, [4] = 124, [5] = 119, [6] = 118, [7] = 124 }, [2] = { [0] = 109, [1] = 111, [2] = 107, [3] = 108, [4] = 117, [5] = 112, [6] = 111, [7] = 117 }, [3] = { [0] = 20, [1] = 22, [2] = 18, [3] = 19, [4] = 28, [5] = 23, [6] = 22, [7] = 28 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[27]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 14, [2] = 17, [3] = 16, [4] = 16, [5] = 23, [6] = 18, [7] = 23 }, [1] = { [0] = 19, [1] = 19, [2] = 22, [3] = 21, [4] = 21, [5] = 28, [6] = 23, [7] = 28 }, [2] = { [0] = 113, [1] = 113, [2] = 116, [3] = 115, [4] = 115, [5] = 122, [6] = 117, [7] = 122 }, [3] = { [0] = 116, [1] = 116, [2] = 119, [3] = 118, [4] = 118, [5] = 125, [6] = 120, [7] = 125 } })[R[36]][R[27]], ({ [0] = { [0] = 13, [1] = 14, [2] = 10, [3] = 11, [4] = 20, [5] = 15, [6] = 14, [7] = 21 }, [1] = { [0] = 116, [1] = 117, [2] = 113, [3] = 114, [4] = 123, [5] = 118, [6] = 117, [7] = 124 }, [2] = { [0] = 109, [1] = 110, [2] = 106, [3] = 107, [4] = 116, [5] = 111, [6] = 110, [7] = 117 }, [3] = { [0] = 20, [1] = 21, [2] = 17, [3] = 18, [4] = 27, [5] = 22, [6] = 21, [7] = 28 } })[R[36]][R[27]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[27] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[72]][R[36]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 18, [1] = 121, [2] = 114, [3] = 25 } })[R[72]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[73]][R[36]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[73]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[74]][R[36]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[74]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[36]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[36]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[36]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[36]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[36]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[75]][R[36]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[75]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[36]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[36]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[76]][R[36]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[76]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[77] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 } })[R[77]][R[36]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[77]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[78] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[78]][R[36]], ({ [0] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 } })[R[78]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[27] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[79]][R[36]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[79]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[27]", R[27])
    end
    R[54] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[54]][R[37]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[54]][R[37]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[54]][R[37]] })
    if R[54] == 5 or R[54] == 6 or R[54] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [6] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [7] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[54]][R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[54]][R[37]], ({ [5] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [6] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [7] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
      if R[54] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[54] == 5 or R[54] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [7] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[54]][R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        if R[54] == 5 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[54] == 7 then
          if LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[54]", R[54])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [7] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[54]][R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        if R[54] == 5 then
        elseif R[54] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[54]", R[54])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[54]][R[37]], ({ [5] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[54]", R[54])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 }, [7] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 } })[R[54]][R[37]], ({ [5] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [6] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [7] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
      if R[54] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[54] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[54] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[54]", R[54])
      end
    elseif R[54] == 1 or R[54] == 2 or R[54] == 3 or R[54] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [3] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [4] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[54]][R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      if R[54] == 1 or R[54] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[54]][R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[37]], ({ [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[54]][R[37]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[54]][R[37]], ({ [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 } })[R[54]][R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[54]][R[37]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[37]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 9, [1] = 112, [2] = 105, [3] = 16 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 2 then
        elseif LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[54]", R[54])
      end
      U[#U]:set_lights(true)
      if R[54] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 4 then
        if LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[54]", R[54])
      end
      U[#U]:set_lights(true)
      if R[54] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[54] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[54]", R[54])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [3] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 } })[R[54]][R[37]], ({ [1] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [3] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [4] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[54] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        if LEVEL_OF[players[1].difficulty] == 1 then
        elseif LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[37]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[54]", R[54])
    end
    U[#U]:set_lights(true)
    if R[54] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[54] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[54] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[54] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[54] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[54] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[54] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[54] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[54]", R[54])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[54]], player = players[3], at = { ({ [0] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [3] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [5] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [6] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[54]][R[37]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [6] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[54]], player = players[3], at = { ({ [0] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [1] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [3] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [4] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [7] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 } })[R[54]][R[37]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [3] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [4] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [6] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[54]][R[37]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[54] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[80] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[80]][R[37]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 18, [1] = 121, [2] = 114, [3] = 25 } })[R[80]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        for i = 1, game.initial_units() do
          R[81] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[81]][R[37]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[81]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
        for i = 1, game.initial_units() do
          R[82] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[82]][R[37]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[82]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[37]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[37]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[37]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[37]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[37]] })
        for i = 1, game.initial_units() do
          R[83] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[83]][R[37]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[83]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[37]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[37]] })
        for i = 1, game.initial_units() do
          R[84] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[84]][R[37]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[84]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[85] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 } })[R[85]][R[37]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[85]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[86] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[86]][R[37]], ({ [0] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 } })[R[86]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[54] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[87] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[87]][R[37]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[87]][R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[54]", R[54])
    end
    R[88] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[88]][R[63]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [3] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [4] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[88]][R[63]], ({ [0] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [5] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [6] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[88]][R[63]] })
    if R[88] == 5 or R[88] == 6 or R[88] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [5] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [6] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [7] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[88]][R[63]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [6] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [7] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[88]][R[63]], ({ [5] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [6] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [7] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
      if R[88] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[63]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[63]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[63]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[88] == 5 or R[88] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [5] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [7] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[88]][R[63]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        if R[88] == 5 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[88] == 7 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[88]", R[88])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [5] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [7] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[88]][R[63]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        if R[88] == 5 then
        elseif R[88] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[63]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[88]", R[88])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [7] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[63]], ({ [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [5] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[88]][R[63]], ({ [5] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [7] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[88]", R[88])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 }, [7] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 } })[R[88]][R[63]], ({ [5] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [6] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [7] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
      if R[88] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[63]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[88] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[88] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[88]", R[88])
      end
    elseif R[88] == 1 or R[88] == 2 or R[88] == 3 or R[88] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [3] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [4] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[88]][R[63]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      if R[88] == 1 or R[88] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 } })[R[88]][R[63]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[63]], ({ [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[88]][R[63]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 } })[R[88]][R[63]], ({ [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 20, [1] = 25, [2] = 119, [3] = 122 } })[R[88]][R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[88]][R[63]], ({ [1] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[88] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[63]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[63]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[63]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[88] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[63]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[63]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[63]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[63]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 9, [1] = 112, [2] = 105, [3] = 16 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[63]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[88]", R[88])
      end
      U[#U]:set_lights(true)
      if R[88] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[88] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[63]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[88] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[88] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[63]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[63]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[88]", R[88])
      end
      U[#U]:set_lights(true)
      if R[88] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[63]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[88] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[88] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[63]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[88] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[63]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 11, [1] = 16, [2] = 110, [3] = 113 })[R[63]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[88]", R[88])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [1] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [2] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [3] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 } })[R[88]][R[63]], ({ [1] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [2] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [3] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 }, [4] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[88] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[63]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        if LEVEL_OF[players[1].difficulty] == 1 then
        elseif LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 19, [1] = 24, [2] = 118, [3] = 121 })[R[63]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[63]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[63]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 22, [1] = 27, [2] = 121, [3] = 124 })[R[63]], ({ [0] = 10, [1] = 113, [2] = 106, [3] = 17 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 21, [1] = 26, [2] = 120, [3] = 123 })[R[63]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[63]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[88]", R[88])
    end
    U[#U]:set_lights(true)
    if R[88] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[63]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[63]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[88] == 1 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[63]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[63]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[63]], ({ [0] = 16, [1] = 119, [2] = 112, [3] = 23 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[88] == 2 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[63]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[63]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[88] == 3 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[63]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[88] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[63]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 12, [1] = 17, [2] = 111, [3] = 114 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[88] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[63]], ({ [0] = 12, [1] = 115, [2] = 108, [3] = 19 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[88] == 6 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 13, [1] = 116, [2] = 109, [3] = 20 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 15, [1] = 20, [2] = 114, [3] = 117 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 20, [1] = 123, [2] = 116, [3] = 27 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[63]], ({ [0] = 21, [1] = 124, [2] = 117, [3] = 28 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 14, [1] = 117, [2] = 110, [3] = 21 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[88] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 11, [1] = 114, [2] = 107, [3] = 18 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 23, [1] = 28, [2] = 122, [3] = 125 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[88]", R[88])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[88]], player = players[4], at = { ({ [0] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [3] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [4] = { [0] = 15, [1] = 20, [2] = 114, [3] = 117 }, [5] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [6] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [7] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[88]][R[63]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [3] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [4] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 }, [5] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [6] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[88]], player = players[4], at = { ({ [0] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [1] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [3] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [4] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [5] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 }, [6] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [7] = { [0] = 23, [1] = 28, [2] = 122, [3] = 125 } })[R[88]][R[63]], ({ [0] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [3] = { [0] = 11, [1] = 114, [2] = 107, [3] = 18 }, [4] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [5] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [6] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [7] = { [0] = 21, [1] = 124, [2] = 117, [3] = 28 } })[R[88]][R[63]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[88] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[89] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[89]][R[63]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 12, [1] = 115, [2] = 108, [3] = 19 }, [2] = { [0] = 18, [1] = 121, [2] = 114, [3] = 25 } })[R[89]][R[63]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[88] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 21, [2] = 115, [3] = 118 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] })
        for i = 1, game.initial_units() do
          R[90] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [1] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [2] = { [0] = 19, [1] = 24, [2] = 118, [3] = 121 } })[R[90]][R[63]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 13, [1] = 116, [2] = 109, [3] = 20 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[90]][R[63]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[88] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[63]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[63]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[63]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[63]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[63]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[63]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[63]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[63]] })
        for i = 1, game.initial_units() do
          R[91] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 13, [1] = 18, [2] = 112, [3] = 115 }, [2] = { [0] = 17, [1] = 22, [2] = 116, [3] = 119 } })[R[91]][R[63]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[91]][R[63]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[88] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[63]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[63]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[63]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[63]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[63]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 19, [2] = 113, [3] = 116 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] })
        game.create_tube({ ({ [0] = 17, [1] = 22, [2] = 116, [3] = 119 })[R[63]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[63]] })
        game.create_tube({ ({ [0] = 18, [1] = 23, [2] = 117, [3] = 120 })[R[63]], ({ [0] = 15, [1] = 118, [2] = 111, [3] = 22 })[R[63]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 18, [1] = 121, [2] = 114, [3] = 25 })[R[63]] })
        game.create_tube({ ({ [0] = 20, [1] = 25, [2] = 119, [3] = 122 })[R[63]], ({ [0] = 19, [1] = 122, [2] = 115, [3] = 26 })[R[63]] })
        for i = 1, game.initial_units() do
          R[92] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [2] = { [0] = 14, [1] = 19, [2] = 113, [3] = 116 } })[R[92]][R[63]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 14, [1] = 117, [2] = 110, [3] = 21 }, [2] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 } })[R[92]][R[63]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[88] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[63]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[63]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 13, [1] = 18, [2] = 112, [3] = 115 })[R[63]], ({ [0] = 17, [1] = 120, [2] = 113, [3] = 24 })[R[63]] })
        for i = 1, game.initial_units() do
          R[93] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [1] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[93]][R[63]], ({ [0] = { [0] = 9, [1] = 112, [2] = 105, [3] = 16 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 } })[R[93]][R[63]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[88] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[94] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 } })[R[94]][R[63]], ({ [0] = { [0] = 20, [1] = 123, [2] = 116, [3] = 27 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[94]][R[63]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[88] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[95] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 }, [1] = { [0] = 21, [1] = 26, [2] = 120, [3] = 123 }, [2] = { [0] = 18, [1] = 23, [2] = 117, [3] = 120 } })[R[95]][R[63]], ({ [0] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 }, [1] = { [0] = 16, [1] = 119, [2] = 112, [3] = 23 }, [2] = { [0] = 17, [1] = 120, [2] = 113, [3] = 24 } })[R[95]][R[63]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[88] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[96] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 16, [1] = 21, [2] = 115, [3] = 118 }, [1] = { [0] = 12, [1] = 17, [2] = 111, [3] = 114 }, [2] = { [0] = 22, [1] = 27, [2] = 121, [3] = 124 } })[R[96]][R[63]], ({ [0] = { [0] = 19, [1] = 122, [2] = 115, [3] = 26 }, [1] = { [0] = 15, [1] = 118, [2] = 111, [3] = 22 }, [2] = { [0] = 10, [1] = 113, [2] = 106, [3] = 17 } })[R[96]][R[63]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[88]", R[88])
    end
    players[1]:mark_research(3303)
    players[1].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[1].difficulty]]
    players[1].scientists = 18 - 3 * LEVEL_OF[players[1].difficulty]
    players[1].kids = 22 - 2 * LEVEL_OF[players[1].difficulty]
    players[1].food = 3000 - 1000 * LEVEL_OF[players[1].difficulty]
    players[1].ore = 6000 - 2000 * LEVEL_OF[players[1].difficulty]
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
    players[2].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[2].difficulty]]
    players[2].scientists = 18 - 3 * LEVEL_OF[players[2].difficulty]
    players[2].kids = 22 - 2 * LEVEL_OF[players[2].difficulty]
    players[2].food = 3000 - 1000 * LEVEL_OF[players[2].difficulty]
    players[2].ore = 6000 - 2000 * LEVEL_OF[players[2].difficulty]
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
    players[3].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[3].difficulty]]
    players[3].scientists = 18 - 3 * LEVEL_OF[players[3].difficulty]
    players[3].kids = 22 - 2 * LEVEL_OF[players[3].difficulty]
    players[3].food = 3000 - 1000 * LEVEL_OF[players[3].difficulty]
    players[3].ore = 6000 - 2000 * LEVEL_OF[players[3].difficulty]
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
    players[4].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[4].difficulty]]
    players[4].scientists = 18 - 3 * LEVEL_OF[players[4].difficulty]
    players[4].kids = 22 - 2 * LEVEL_OF[players[4].difficulty]
    players[4].food = 3000 - 1000 * LEVEL_OF[players[4].difficulty]
    players[4].ore = 6000 - 2000 * LEVEL_OF[players[4].difficulty]
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
  mission.last_one_standing("Eliminate your opponents.")
  if game.disasters_enabled() then
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Tornados}  -- after 60 to 120 marks
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Meteors}  -- after 60 to 120 marks
  end
  return true
end
