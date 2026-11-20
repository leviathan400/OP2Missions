-- ml4_41Lua.lua  -  4 Player, LastOne, 'Handprint' map. (Lua)
--
-- Converted by op2dll from ml4_41.dll ("4 Player, LastOne, 'Handprint' map."): its setup replayed. `on_init` makes the original's
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
local DoDisaster

function DoDisaster(t)
  local r1 = game.rand(4)
  local r2 = game.rand(128)
  local r3 = game.rand(64)
  if r1 < 1 then
    game.create_earthquake({ r2 + 1, r3 + 1 }, 1)
  elseif r1 < 2 then
    local r4 = game.rand(128)
    local r5 = game.rand(64)
    game.create_lightning({ r2 + 1, r3 + 1 }, { r4 + 1, r5 + 1 }, 10)
  elseif r1 < 3 then
    local r4 = game.rand(128)
    local r5 = game.rand(64)
    game.create_tornado({ r2 + 1, r3 + 1 }, { r4 + 1, r5 + 1 }, 10)
  else
    game.create_meteor({ r2 + 1, r3 + 1 }, 1)
  end
  t:destroy()
  trigger.time{min = 8000, max = 16000, one_shot = false, on = DoDisaster}  -- after 80 to 160 marks
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 39, 12 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 20, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 8 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 117, 25 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 95, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 113, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 32, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 15, 58 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 35, 25 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 35, 56 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 118, 17 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 90, 54 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 74, 43 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 68, 12 } }
    R[0] = game.rand(5)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[0]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[0]] } }
    R[1] = draw_avoid(5, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[1]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[1]] } }
    R[2] = draw_avoid(5, { R[1], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[2]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[2]] } }
    R[3] = draw_avoid(5, { R[2], R[1], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[3]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[3]] } }
    R[4] = draw_avoid(5, { R[3], R[2], R[1], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[4]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[4]] } }
    R[5] = game.rand(5)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[5]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[5]] } }
    R[6] = draw_avoid(5, { R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[6]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[6]] } }
    R[7] = draw_avoid(5, { R[6], R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[7]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[7]] } }
    R[8] = draw_avoid(5, { R[7], R[6], R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[8]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[8]] } }
    R[9] = draw_avoid(5, { R[8], R[7], R[6], R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[9]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[9]] } }
    R[10] = game.rand(4)
    R[11] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[11]][R[10]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[11]][R[10]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] })
    if R[11] == 1 or R[11] == 2 or R[11] == 3 or R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [3] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [4] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[11]][R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 9, [1] = 9, [2] = 42, [3] = 41 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 1 or R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[11]][R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[10]], ({ [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[11]][R[10]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[11]][R[10]], ({ [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 } })[R[11]][R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[11]][R[10]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      if R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 19, [1] = 99, [2] = 100, [3] = 16 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      if R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 19, [1] = 99, [2] = 100, [3] = 16 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [3] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 } })[R[11]][R[10]], ({ [1] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [3] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [4] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 5 or R[11] == 6 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [6] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [7] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[11]][R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[11]][R[10]], ({ [5] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [6] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [7] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[11] == 5 or R[11] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [7] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[11]][R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 5 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[11] == 7 then
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
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [7] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[11]][R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[11] == 5 then
        else
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[11]][R[10]], ({ [5] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [7] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 } })[R[11]][R[10]], ({ [5] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [6] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [7] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
    elseif R[11] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[11]], player = players[1], at = { ({ [0] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [3] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [5] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [6] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[11]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [6] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[11]], player = players[1], at = { ({ [0] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [1] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [3] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [4] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [7] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 } })[R[11]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [3] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [4] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [6] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[12] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[12]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 18, [1] = 18, [2] = 51, [3] = 50 } })[R[12]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        for i = 1, game.initial_units() do
          R[13] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[13]][R[10]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[13]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[14]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[14]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[15]][R[10]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[15]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] })
        for i = 1, game.initial_units() do
          R[16] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[16]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[16]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[17] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 } })[R[17]][R[10]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[17]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[18]][R[10]], ({ [0] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 } })[R[18]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[19] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[19]][R[10]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[19]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 31, [1] = 100, [2] = 105, [3] = 25 })[R[10]], ({ [0] = 4, [1] = 4, [2] = 36, [3] = 35 })[R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 101, [3] = 29 })[R[10]], ({ [0] = 29, [1] = 30, [2] = 59, [3] = 59 })[R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[20] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 106, [1] = 22, [2] = 25, [3] = 105 }, [1] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 }, [2] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 }, [3] = { [0] = 102, [1] = 18, [2] = 21, [3] = 101 }, [4] = { [0] = 106, [1] = 22, [2] = 25, [3] = 105 }, [5] = { [0] = 105, [1] = 21, [2] = 24, [3] = 104 }, [6] = { [0] = 102, [1] = 18, [2] = 21, [3] = 101 }, [7] = { [0] = 108, [1] = 24, [2] = 27, [3] = 107 } })[R[20]][R[10]], ({ [0] = { [0] = 49, [1] = 48, [2] = 16, [3] = 16 }, [1] = { [0] = 45, [1] = 44, [2] = 12, [3] = 12 }, [2] = { [0] = 49, [1] = 48, [2] = 16, [3] = 16 }, [3] = { [0] = 45, [1] = 44, [2] = 12, [3] = 12 }, [4] = { [0] = 48, [1] = 47, [2] = 15, [3] = 15 }, [5] = { [0] = 46, [1] = 45, [2] = 13, [3] = 13 }, [6] = { [0] = 43, [1] = 42, [2] = 10, [3] = 10 }, [7] = { [0] = 46, [1] = 45, [2] = 13, [3] = 13 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 106, [1] = 22, [2] = 25, [3] = 105 }, [1] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 }, [2] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 }, [3] = { [0] = 102, [1] = 18, [2] = 21, [3] = 101 }, [4] = { [0] = 106, [1] = 22, [2] = 25, [3] = 105 }, [5] = { [0] = 105, [1] = 21, [2] = 24, [3] = 104 }, [6] = { [0] = 102, [1] = 18, [2] = 21, [3] = 101 }, [7] = { [0] = 108, [1] = 24, [2] = 27, [3] = 107 } })[R[20]][R[10]], ({ [0] = { [0] = 49, [1] = 48, [2] = 16, [3] = 16 }, [1] = { [0] = 45, [1] = 44, [2] = 12, [3] = 12 }, [2] = { [0] = 49, [1] = 48, [2] = 16, [3] = 16 }, [3] = { [0] = 45, [1] = 44, [2] = 12, [3] = 12 }, [4] = { [0] = 48, [1] = 47, [2] = 15, [3] = 15 }, [5] = { [0] = 46, [1] = 45, [2] = 13, [3] = 13 }, [6] = { [0] = 43, [1] = 42, [2] = 10, [3] = 10 }, [7] = { [0] = 46, [1] = 45, [2] = 13, [3] = 13 } })[R[20]][R[10]] })
    if R[20] == 1 or R[20] == 2 or R[20] == 3 or R[20] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 }, [2] = { [0] = 103, [1] = 19, [2] = 22, [3] = 102 }, [3] = { [0] = 107, [1] = 23, [2] = 26, [3] = 106 }, [4] = { [0] = 103, [1] = 19, [2] = 22, [3] = 102 } })[R[20]][R[10]], ({ [0] = 52, [1] = 51, [2] = 19, [3] = 19 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[20] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 102, [1] = 18, [2] = 21, [3] = 101 })[R[10]], ({ [0] = 53, [1] = 52, [2] = 20, [3] = 20 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 49, [1] = 48, [2] = 16, [3] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 103, [1] = 19, [2] = 22, [3] = 102 })[R[10]], ({ [0] = 48, [1] = 47, [2] = 15, [3] = 15 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 111, [1] = 27, [2] = 30, [3] = 110 })[R[10]], ({ [0] = 43, [1] = 42, [2] = 10, [3] = 10 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 108, [1] = 24, [2] = 27, [3] = 107 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 53, [1] = 52, [2] = 20, [3] = 20 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 1 or R[20] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 101, [1] = 17, [2] = 20, [3] = 100 }, [2] = { [0] = 102, [1] = 18, [2] = 21, [3] = 101 } })[R[20]][R[10]], ({ [0] = 43, [1] = 42, [2] = 10, [3] = 10 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 110, [1] = 26, [2] = 29, [3] = 109 })[R[10]], ({ [1] = { [0] = 48, [1] = 47, [2] = 15, [3] = 15 }, [2] = { [0] = 52, [1] = 51, [2] = 19, [3] = 19 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 105, [1] = 21, [2] = 24, [3] = 104 }, [2] = { [0] = 106, [1] = 22, [2] = 25, [3] = 105 } })[R[20]][R[10]], ({ [1] = { [0] = 53, [1] = 52, [2] = 20, [3] = 20 }, [2] = { [0] = 49, [1] = 48, [2] = 16, [3] = 16 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 105, [1] = 21, [2] = 24, [3] = 104 }, [2] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 } })[R[20]][R[10]], ({ [1] = { [0] = 49, [1] = 48, [2] = 16, [3] = 16 }, [2] = { [0] = 46, [1] = 45, [2] = 13, [3] = 13 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 111, [1] = 27, [2] = 30, [3] = 110 }, [2] = { [0] = 109, [1] = 25, [2] = 28, [3] = 108 } })[R[20]][R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 112, [1] = 28, [2] = 31, [3] = 111 }, [2] = { [0] = 111, [1] = 27, [2] = 30, [3] = 110 } })[R[20]][R[10]], ({ [1] = { [0] = 53, [1] = 52, [2] = 20, [3] = 20 }, [2] = { [0] = 54, [1] = 53, [2] = 21, [3] = 21 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 103, [1] = 19, [2] = 22, [3] = 102 })[R[10]], ({ [0] = 44, [1] = 43, [2] = 11, [3] = 11 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 107, [1] = 23, [2] = 26, [3] = 106 })[R[10]], ({ [0] = 45, [1] = 44, [2] = 12, [3] = 12 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 102, [1] = 18, [2] = 21, [3] = 101 })[R[10]], ({ [0] = 48, [1] = 47, [2] = 15, [3] = 15 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 111, [1] = 27, [2] = 30, [3] = 110 })[R[10]], ({ [0] = 53, [1] = 52, [2] = 20, [3] = 20 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 42, [1] = 41, [2] = 9, [3] = 9 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 106, [1] = 22, [2] = 25, [3] = 105 })[R[10]], ({ [0] = 43, [1] = 42, [2] = 10, [3] = 10 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[20]", R[20])
      end
      U[#U]:set_lights(true)
      if R[20] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 107, [1] = 23, [2] = 26, [3] = 106 })[R[10]], ({ [0] = 53, [1] = 52, [2] = 20, [3] = 20 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 110, [1] = 26, [2] = 29, [3] = 109 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 100, [1] = 16, [2] = 19, [3] = 99 })[R[10]], ({ [0] = 50, [1] = 49, [2] = 17, [3] = 17 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 106, [1] = 22, [2] = 25, [3] = 105 })[R[10]], ({ [0] = 43, [1] = 42, [2] = 10, [3] = 10 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[20]", R[20])
      end
      U[#U]:set_lights(true)
      if R[20] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 112, [1] = 28, [2] = 31, [3] = 111 })[R[10]], ({ [0] = 50, [1] = 49, [2] = 17, [3] = 17 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 104, [1] = 20, [2] = 23, [3] = 103 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 104, [1] = 20, [2] = 23, [3] = 103 })[R[10]], ({ [0] = 50, [1] = 49, [2] = 17, [3] = 17 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 104, [1] = 20, [2] = 23, [3] = 103 })[R[10]], ({ [0] = 46, [1] = 45, [2] = 13, [3] = 13 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 100, [1] = 16, [2] = 19, [3] = 99 })[R[10]], ({ [0] = 50, [1] = 49, [2] = 17, [3] = 17 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[20]", R[20])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 112, [1] = 28, [2] = 31, [3] = 111 }, [2] = { [0] = 104, [1] = 20, [2] = 23, [3] = 103 }, [3] = { [0] = 104, [1] = 20, [2] = 23, [3] = 103 }, [4] = { [0] = 104, [1] = 20, [2] = 23, [3] = 103 } })[R[20]][R[10]], ({ [1] = { [0] = 50, [1] = 49, [2] = 17, [3] = 17 }, [2] = { [0] = 54, [1] = 53, [2] = 21, [3] = 21 }, [3] = { [0] = 50, [1] = 49, [2] = 17, [3] = 17 }, [4] = { [0] = 46, [1] = 45, [2] = 13, [3] = 13 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[20] == 5 or R[20] == 6 or R[20] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 102, [1] = 18, [2] = 21, [3] = 101 }, [6] = { [0] = 111, [1] = 27, [2] = 30, [3] = 110 }, [7] = { [0] = 102, [1] = 18, [2] = 21, [3] = 101 } })[R[20]][R[10]], ({ [0] = 53, [1] = 52, [2] = 20, [3] = 20 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 }, [6] = { [0] = 102, [1] = 18, [2] = 21, [3] = 101 }, [7] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 } })[R[20]][R[10]], ({ [5] = { [0] = 47, [1] = 46, [2] = 14, [3] = 14 }, [6] = { [0] = 52, [1] = 51, [2] = 19, [3] = 19 }, [7] = { [0] = 52, [1] = 51, [2] = 19, [3] = 19 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[20] == 5 or R[20] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 }, [7] = { [0] = 103, [1] = 19, [2] = 22, [3] = 102 } })[R[20]][R[10]], ({ [0] = 43, [1] = 42, [2] = 10, [3] = 10 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[20] == 5 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[20] == 7 then
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
        else
          unseen("R[20]", R[20])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 105, [1] = 21, [2] = 24, [3] = 104 }, [7] = { [0] = 107, [1] = 23, [2] = 26, [3] = 106 } })[R[20]][R[10]], ({ [0] = 43, [1] = 42, [2] = 10, [3] = 10 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[20] == 5 then
        elseif R[20] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 108, [1] = 24, [2] = 27, [3] = 107 })[R[10]], ({ [0] = 49, [1] = 48, [2] = 16, [3] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[20]", R[20])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [5] = { [0] = 49, [1] = 48, [2] = 16, [3] = 16 }, [7] = { [0] = 46, [1] = 45, [2] = 13, [3] = 13 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 106, [1] = 22, [2] = 25, [3] = 105 })[R[10]], ({ [5] = { [0] = 48, [1] = 47, [2] = 15, [3] = 15 }, [7] = { [0] = 47, [1] = 46, [2] = 14, [3] = 14 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 106, [1] = 22, [2] = 25, [3] = 105 }, [7] = { [0] = 111, [1] = 27, [2] = 30, [3] = 110 } })[R[20]][R[10]], ({ [5] = { [0] = 50, [1] = 49, [2] = 17, [3] = 17 }, [7] = { [0] = 47, [1] = 46, [2] = 14, [3] = 14 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[20] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 102, [1] = 18, [2] = 21, [3] = 101 })[R[10]], ({ [0] = 49, [1] = 48, [2] = 16, [3] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 102, [1] = 18, [2] = 21, [3] = 101 })[R[10]], ({ [0] = 46, [1] = 45, [2] = 13, [3] = 13 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 107, [1] = 23, [2] = 26, [3] = 106 })[R[10]], ({ [0] = 44, [1] = 43, [2] = 11, [3] = 11 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[20]", R[20])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 112, [1] = 28, [2] = 31, [3] = 111 }, [6] = { [0] = 109, [1] = 25, [2] = 28, [3] = 108 }, [7] = { [0] = 105, [1] = 21, [2] = 24, [3] = 104 } })[R[20]][R[10]], ({ [5] = { [0] = 45, [1] = 44, [2] = 12, [3] = 12 }, [6] = { [0] = 46, [1] = 45, [2] = 13, [3] = 13 }, [7] = { [0] = 44, [1] = 43, [2] = 11, [3] = 11 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[20] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 112, [1] = 28, [2] = 31, [3] = 111 })[R[10]], ({ [0] = 45, [1] = 44, [2] = 12, [3] = 12 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[20] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 46, [1] = 45, [2] = 13, [3] = 13 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 46, [1] = 45, [2] = 13, [3] = 13 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 104, [1] = 20, [2] = 23, [3] = 103 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 53, [1] = 52, [2] = 20, [3] = 20 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[20] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 44, [1] = 43, [2] = 11, [3] = 11 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[20]", R[20])
      end
    elseif R[20] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 103, [1] = 19, [2] = 22, [3] = 102 })[R[10]], ({ [0] = 52, [1] = 51, [2] = 19, [3] = 19 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 108, [1] = 24, [2] = 27, [3] = 107 })[R[10]], ({ [0] = 52, [1] = 51, [2] = 19, [3] = 19 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 102, [1] = 18, [2] = 21, [3] = 101 })[R[10]], ({ [0] = 49, [1] = 48, [2] = 16, [3] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 110, [1] = 26, [2] = 29, [3] = 109 })[R[10]], ({ [0] = 49, [1] = 48, [2] = 16, [3] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 111, [1] = 27, [2] = 30, [3] = 110 })[R[10]], ({ [0] = 43, [1] = 42, [2] = 10, [3] = 10 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 110, [1] = 26, [2] = 29, [3] = 109 })[R[10]], ({ [0] = 53, [1] = 52, [2] = 20, [3] = 20 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 112, [1] = 28, [2] = 31, [3] = 111 })[R[10]], ({ [0] = 52, [1] = 51, [2] = 19, [3] = 19 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[20]", R[20])
    end
    U[#U]:set_lights(true)
    if R[20] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 101, [1] = 17, [2] = 20, [3] = 100 })[R[10]], ({ [0] = 45, [1] = 44, [2] = 12, [3] = 12 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 101, [1] = 17, [2] = 20, [3] = 100 })[R[10]], ({ [0] = 45, [1] = 44, [2] = 12, [3] = 12 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 112, [1] = 28, [2] = 31, [3] = 111 })[R[10]], ({ [0] = 50, [1] = 49, [2] = 17, [3] = 17 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 102, [1] = 18, [2] = 21, [3] = 101 })[R[10]], ({ [0] = 49, [1] = 48, [2] = 16, [3] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 102, [1] = 18, [2] = 21, [3] = 101 })[R[10]], ({ [0] = 49, [1] = 48, [2] = 16, [3] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 104, [1] = 20, [2] = 23, [3] = 103 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 106, [1] = 22, [2] = 25, [3] = 105 })[R[10]], ({ [0] = 45, [1] = 44, [2] = 12, [3] = 12 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 106, [1] = 22, [2] = 25, [3] = 105 })[R[10]], ({ [0] = 45, [1] = 44, [2] = 12, [3] = 12 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 104, [1] = 20, [2] = 23, [3] = 103 })[R[10]], ({ [0] = 50, [1] = 49, [2] = 17, [3] = 17 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 46, [1] = 45, [2] = 13, [3] = 13 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 46, [1] = 45, [2] = 13, [3] = 13 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 104, [1] = 20, [2] = 23, [3] = 103 })[R[10]], ({ [0] = 46, [1] = 45, [2] = 13, [3] = 13 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 101, [1] = 17, [2] = 20, [3] = 100 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[20] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 112, [1] = 28, [2] = 31, [3] = 111 })[R[10]], ({ [0] = 45, [1] = 44, [2] = 12, [3] = 12 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 112, [1] = 28, [2] = 31, [3] = 111 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[20] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 46, [1] = 45, [2] = 13, [3] = 13 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 104, [1] = 20, [2] = 23, [3] = 103 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 53, [1] = 52, [2] = 20, [3] = 20 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 107, [1] = 23, [2] = 26, [3] = 106 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 47, [1] = 46, [2] = 14, [3] = 14 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 107, [1] = 23, [2] = 26, [3] = 106 })[R[10]], ({ [0] = 54, [1] = 53, [2] = 21, [3] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 47, [1] = 46, [2] = 14, [3] = 14 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 44, [1] = 43, [2] = 11, [3] = 11 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 112, [1] = 28, [2] = 31, [3] = 111 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[20]", R[20])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[20]], player = players[2], at = { ({ [0] = { [0] = 102, [1] = 18, [2] = 21, [3] = 101 }, [1] = { [0] = 101, [1] = 17, [2] = 20, [3] = 100 }, [2] = { [0] = 107, [1] = 23, [2] = 26, [3] = 106 }, [3] = { [0] = 106, [1] = 22, [2] = 25, [3] = 105 }, [4] = { [0] = 104, [1] = 20, [2] = 23, [3] = 103 }, [5] = { [0] = 111, [1] = 27, [2] = 30, [3] = 110 }, [6] = { [0] = 106, [1] = 22, [2] = 25, [3] = 105 }, [7] = { [0] = 111, [1] = 27, [2] = 30, [3] = 110 } })[R[20]][R[10]], ({ [0] = { [0] = 46, [1] = 45, [2] = 13, [3] = 13 }, [1] = { [0] = 48, [1] = 47, [2] = 15, [3] = 15 }, [2] = { [0] = 44, [1] = 43, [2] = 11, [3] = 11 }, [3] = { [0] = 45, [1] = 44, [2] = 12, [3] = 12 }, [4] = { [0] = 54, [1] = 53, [2] = 21, [3] = 21 }, [5] = { [0] = 49, [1] = 48, [2] = 16, [3] = 16 }, [6] = { [0] = 48, [1] = 47, [2] = 15, [3] = 15 }, [7] = { [0] = 54, [1] = 53, [2] = 21, [3] = 21 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[20]], player = players[2], at = { ({ [0] = { [0] = 103, [1] = 19, [2] = 22, [3] = 102 }, [1] = { [0] = 103, [1] = 19, [2] = 22, [3] = 102 }, [2] = { [0] = 106, [1] = 22, [2] = 25, [3] = 105 }, [3] = { [0] = 105, [1] = 21, [2] = 24, [3] = 104 }, [4] = { [0] = 105, [1] = 21, [2] = 24, [3] = 104 }, [5] = { [0] = 112, [1] = 28, [2] = 31, [3] = 111 }, [6] = { [0] = 107, [1] = 23, [2] = 26, [3] = 106 }, [7] = { [0] = 112, [1] = 28, [2] = 31, [3] = 111 } })[R[20]][R[10]], ({ [0] = { [0] = 46, [1] = 45, [2] = 13, [3] = 13 }, [1] = { [0] = 47, [1] = 46, [2] = 14, [3] = 14 }, [2] = { [0] = 43, [1] = 42, [2] = 10, [3] = 10 }, [3] = { [0] = 44, [1] = 43, [2] = 11, [3] = 11 }, [4] = { [0] = 53, [1] = 52, [2] = 20, [3] = 20 }, [5] = { [0] = 48, [1] = 47, [2] = 15, [3] = 15 }, [6] = { [0] = 47, [1] = 46, [2] = 14, [3] = 14 }, [7] = { [0] = 54, [1] = 53, [2] = 21, [3] = 21 } })[R[20]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[20] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 101, [1] = 17, [2] = 20, [3] = 100 }, [1] = { [0] = 106, [1] = 22, [2] = 25, [3] = 105 }, [2] = { [0] = 111, [1] = 27, [2] = 30, [3] = 110 } })[R[21]][R[10]], ({ [0] = { [0] = 42, [1] = 41, [2] = 9, [3] = 9 }, [1] = { [0] = 45, [1] = 44, [2] = 12, [3] = 12 }, [2] = { [0] = 51, [1] = 50, [2] = 18, [3] = 18 } })[R[21]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 105, [1] = 21, [2] = 24, [3] = 104 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 101, [1] = 17, [2] = 20, [3] = 100 }, [1] = { [0] = 105, [1] = 21, [2] = 24, [3] = 104 }, [2] = { [0] = 108, [1] = 24, [2] = 27, [3] = 107 } })[R[22]][R[10]], ({ [0] = { [0] = 52, [1] = 51, [2] = 19, [3] = 19 }, [1] = { [0] = 46, [1] = 45, [2] = 13, [3] = 13 }, [2] = { [0] = 42, [1] = 41, [2] = 9, [3] = 9 } })[R[22]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 106, [1] = 22, [2] = 25, [3] = 105 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] })
        game.create_tube({ ({ [0] = 106, [1] = 22, [2] = 25, [3] = 105 })[R[10]], ({ [0] = 52, [1] = 51, [2] = 19, [3] = 19 })[R[10]] })
        game.create_tube({ ({ [0] = 107, [1] = 23, [2] = 26, [3] = 106 })[R[10]], ({ [0] = 52, [1] = 51, [2] = 19, [3] = 19 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 106, [1] = 22, [2] = 25, [3] = 105 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] })
        game.create_tube({ ({ [0] = 106, [1] = 22, [2] = 25, [3] = 105 })[R[10]], ({ [0] = 52, [1] = 51, [2] = 19, [3] = 19 })[R[10]] })
        game.create_tube({ ({ [0] = 107, [1] = 23, [2] = 26, [3] = 106 })[R[10]], ({ [0] = 52, [1] = 51, [2] = 19, [3] = 19 })[R[10]] })
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 }, [1] = { [0] = 102, [1] = 18, [2] = 21, [3] = 101 }, [2] = { [0] = 106, [1] = 22, [2] = 25, [3] = 105 } })[R[23]][R[10]], ({ [0] = { [0] = 42, [1] = 41, [2] = 9, [3] = 9 }, [1] = { [0] = 47, [1] = 46, [2] = 14, [3] = 14 }, [2] = { [0] = 52, [1] = 51, [2] = 19, [3] = 19 } })[R[23]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 103, [1] = 19, [2] = 22, [3] = 102 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] })
        game.create_tube({ ({ [0] = 106, [1] = 22, [2] = 25, [3] = 105 })[R[10]], ({ [0] = 48, [1] = 47, [2] = 15, [3] = 15 })[R[10]] })
        game.create_tube({ ({ [0] = 107, [1] = 23, [2] = 26, [3] = 106 })[R[10]], ({ [0] = 48, [1] = 47, [2] = 15, [3] = 15 })[R[10]] })
        game.create_tube({ ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] })
        game.create_tube({ ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 52, [1] = 51, [2] = 19, [3] = 19 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 103, [1] = 19, [2] = 22, [3] = 102 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] })
        game.create_tube({ ({ [0] = 106, [1] = 22, [2] = 25, [3] = 105 })[R[10]], ({ [0] = 48, [1] = 47, [2] = 15, [3] = 15 })[R[10]] })
        game.create_tube({ ({ [0] = 107, [1] = 23, [2] = 26, [3] = 106 })[R[10]], ({ [0] = 48, [1] = 47, [2] = 15, [3] = 15 })[R[10]] })
        game.create_tube({ ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 51, [1] = 50, [2] = 18, [3] = 18 })[R[10]] })
        game.create_tube({ ({ [0] = 109, [1] = 25, [2] = 28, [3] = 108 })[R[10]], ({ [0] = 52, [1] = 51, [2] = 19, [3] = 19 })[R[10]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 111, [1] = 27, [2] = 30, [3] = 110 }, [1] = { [0] = 107, [1] = 23, [2] = 26, [3] = 106 }, [2] = { [0] = 103, [1] = 19, [2] = 22, [3] = 102 } })[R[24]][R[10]], ({ [0] = { [0] = 53, [1] = 52, [2] = 20, [3] = 20 }, [1] = { [0] = 47, [1] = 46, [2] = 14, [3] = 14 }, [2] = { [0] = 42, [1] = 41, [2] = 9, [3] = 9 } })[R[24]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 102, [1] = 18, [2] = 21, [3] = 101 })[R[10]], ({ [0] = 50, [1] = 49, [2] = 17, [3] = 17 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 102, [1] = 18, [2] = 21, [3] = 101 })[R[10]], ({ [0] = 50, [1] = 49, [2] = 17, [3] = 17 })[R[10]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 }, [1] = { [0] = 111, [1] = 27, [2] = 30, [3] = 110 }, [2] = { [0] = 107, [1] = 23, [2] = 26, [3] = 106 } })[R[25]][R[10]], ({ [0] = { [0] = 42, [1] = 41, [2] = 9, [3] = 9 }, [1] = { [0] = 48, [1] = 47, [2] = 15, [3] = 15 }, [2] = { [0] = 52, [1] = 51, [2] = 19, [3] = 19 } })[R[25]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 107, [1] = 23, [2] = 26, [3] = 106 }, [1] = { [0] = 101, [1] = 17, [2] = 20, [3] = 100 }, [2] = { [0] = 101, [1] = 17, [2] = 20, [3] = 100 } })[R[26]][R[10]], ({ [0] = { [0] = 53, [1] = 52, [2] = 20, [3] = 20 }, [1] = { [0] = 48, [1] = 47, [2] = 15, [3] = 15 }, [2] = { [0] = 43, [1] = 42, [2] = 10, [3] = 10 } })[R[26]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 111, [1] = 27, [2] = 30, [3] = 110 }, [1] = { [0] = 110, [1] = 26, [2] = 29, [3] = 109 }, [2] = { [0] = 107, [1] = 23, [2] = 26, [3] = 106 } })[R[27]][R[10]], ({ [0] = { [0] = 43, [1] = 42, [2] = 10, [3] = 10 }, [1] = { [0] = 49, [1] = 48, [2] = 16, [3] = 16 }, [2] = { [0] = 50, [1] = 49, [2] = 17, [3] = 17 } })[R[27]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 105, [1] = 21, [2] = 24, [3] = 104 }, [1] = { [0] = 101, [1] = 17, [2] = 20, [3] = 100 }, [2] = { [0] = 111, [1] = 27, [2] = 30, [3] = 110 } })[R[28]][R[10]], ({ [0] = { [0] = 52, [1] = 51, [2] = 19, [3] = 19 }, [1] = { [0] = 48, [1] = 47, [2] = 15, [3] = 15 }, [2] = { [0] = 43, [1] = 42, [2] = 10, [3] = 10 } })[R[28]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[20]", R[20])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 105, [1] = 25, [2] = 31, [3] = 100 })[R[10]], ({ [0] = 36, [1] = 35, [2] = 4, [3] = 4 })[R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 101, [1] = 29, [2] = 25, [3] = 105 })[R[10]], ({ [0] = 59, [1] = 59, [2] = 29, [3] = 30 })[R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 39, 12 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 20, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 8 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 117, 25 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 95, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 113, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 32, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 15, 58 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 35, 25 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 35, 56 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 118, 17 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 90, 54 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 74, 43 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 68, 12 } }
    R[0] = game.rand(5)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[0]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[0]] } }
    R[1] = draw_avoid(5, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[1]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[1]] } }
    R[2] = draw_avoid(5, { R[1], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[2]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[2]] } }
    R[3] = draw_avoid(5, { R[2], R[1], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[3]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[3]] } }
    R[4] = draw_avoid(5, { R[3], R[2], R[1], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[4]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[4]] } }
    R[5] = game.rand(5)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[5]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[5]] } }
    R[6] = draw_avoid(5, { R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[6]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[6]] } }
    R[7] = draw_avoid(5, { R[6], R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[7]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[7]] } }
    R[8] = draw_avoid(5, { R[7], R[6], R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[8]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[8]] } }
    R[9] = draw_avoid(5, { R[8], R[7], R[6], R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[9]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[9]] } }
    pick(4, 3, { 10, 29, 30 })
    R[11] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[11]][R[10]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[11]][R[10]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] })
    if R[11] == 1 or R[11] == 2 or R[11] == 3 or R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [3] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [4] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[11]][R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 1 or R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[11]][R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[10]], ({ [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[11]][R[10]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[11]][R[10]], ({ [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 } })[R[11]][R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[11]][R[10]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 9, [1] = 9, [2] = 42, [3] = 41 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 2 then
        elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
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
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      if R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 19, [1] = 99, [2] = 100, [3] = 16 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      if R[11] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 19, [1] = 99, [2] = 100, [3] = 16 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [3] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 } })[R[11]][R[10]], ({ [1] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [3] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [4] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 5 or R[11] == 6 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [6] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [7] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[11]][R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[11]][R[10]], ({ [5] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [6] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [7] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 or R[11] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [7] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[11]][R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 5 then
          if LEVEL_OF[players[1].difficulty] == 1 then
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
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[11] == 7 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[11]][R[10]], ({ [5] = { [0] = 18, [1] = 18, [2] = 51, [3] = 50 }, [7] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 7 then
        elseif R[11] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[11]][R[10]], ({ [5] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[11] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [7] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 } })[R[11]][R[10]], ({ [5] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [6] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [7] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[11]], player = players[1], at = { ({ [0] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [3] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [5] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [6] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[11]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [6] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[11]], player = players[1], at = { ({ [0] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [1] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [3] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [4] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [7] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 } })[R[11]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [3] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [4] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [6] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[31]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 18, [1] = 18, [2] = 51, [3] = 50 } })[R[31]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[32]][R[10]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[32]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[33]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[33]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[34]][R[10]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[34]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] })
        for i = 1, game.initial_units() do
          R[35] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[35]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[35]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 } })[R[36]][R[10]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[36]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[37] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[37]][R[10]], ({ [0] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 } })[R[37]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[38]][R[10]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[38]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 31, [1] = 100, [2] = 105, [3] = 25 })[R[10]], ({ [0] = 4, [1] = 4, [2] = 36, [3] = 35 })[R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 101, [3] = 29 })[R[10]], ({ [0] = 29, [1] = 30, [2] = 59, [3] = 59 })[R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[20] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 25, [1] = 29, [2] = 29, [3] = 21, [4] = 25, [5] = 24, [6] = 21, [7] = 27 }, [1] = { [0] = 105, [1] = 109, [2] = 109, [3] = 101, [4] = 105, [5] = 104, [6] = 101, [7] = 107 }, [2] = { [0] = 106, [1] = 110, [2] = 110, [3] = 102, [4] = 106, [5] = 105, [6] = 102, [7] = 108 }, [3] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 } })[R[29]][R[20]], ({ [0] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [1] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [2] = { [0] = 49, [1] = 45, [2] = 49, [3] = 45, [4] = 48, [5] = 46, [6] = 43, [7] = 46 }, [3] = { [0] = 48, [1] = 44, [2] = 48, [3] = 44, [4] = 47, [5] = 45, [6] = 42, [7] = 45 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 25, [1] = 29, [2] = 29, [3] = 21, [4] = 25, [5] = 24, [6] = 21, [7] = 27 }, [1] = { [0] = 105, [1] = 109, [2] = 109, [3] = 101, [4] = 105, [5] = 104, [6] = 101, [7] = 107 }, [2] = { [0] = 106, [1] = 110, [2] = 110, [3] = 102, [4] = 106, [5] = 105, [6] = 102, [7] = 108 }, [3] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 } })[R[29]][R[20]], ({ [0] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [1] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [2] = { [0] = 49, [1] = 45, [2] = 49, [3] = 45, [4] = 48, [5] = 46, [6] = 43, [7] = 46 }, [3] = { [0] = 48, [1] = 44, [2] = 48, [3] = 44, [4] = 47, [5] = 45, [6] = 42, [7] = 45 } })[R[29]][R[20]] })
    if R[20] == 1 or R[20] == 2 or R[20] == 3 or R[20] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 29, [2] = 22, [3] = 26, [4] = 22 }, [1] = { [1] = 109, [2] = 102, [3] = 106, [4] = 102 }, [2] = { [1] = 110, [2] = 103, [3] = 107, [4] = 103 }, [3] = { [1] = 26, [2] = 19, [3] = 23, [4] = 19 } })[R[29]][R[20]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      if R[20] == 1 or R[20] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 20, [2] = 21 }, [1] = { [1] = 100, [2] = 101 }, [2] = { [1] = 101, [2] = 102 }, [3] = { [1] = 17, [2] = 18 } })[R[29]][R[20]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[29]], ({ [0] = { [1] = 15, [2] = 19 }, [1] = { [1] = 15, [2] = 19 }, [2] = { [1] = 48, [2] = 52 }, [3] = { [1] = 47, [2] = 51 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 24, [2] = 25 }, [1] = { [1] = 104, [2] = 105 }, [2] = { [1] = 105, [2] = 106 }, [3] = { [1] = 21, [2] = 22 } })[R[29]][R[20]], ({ [0] = { [1] = 20, [2] = 16 }, [1] = { [1] = 20, [2] = 16 }, [2] = { [1] = 53, [2] = 49 }, [3] = { [1] = 52, [2] = 48 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 24, [2] = 29 }, [1] = { [1] = 104, [2] = 109 }, [2] = { [1] = 105, [2] = 110 }, [3] = { [1] = 21, [2] = 26 } })[R[29]][R[20]], ({ [0] = { [1] = 16, [2] = 13 }, [1] = { [1] = 16, [2] = 13 }, [2] = { [1] = 49, [2] = 46 }, [3] = { [1] = 48, [2] = 45 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 30, [2] = 28 }, [1] = { [1] = 110, [2] = 108 }, [2] = { [1] = 111, [2] = 109 }, [3] = { [1] = 27, [2] = 25 } })[R[29]][R[20]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 31, [2] = 30 }, [1] = { [1] = 111, [2] = 110 }, [2] = { [1] = 112, [2] = 111 }, [3] = { [1] = 28, [2] = 27 } })[R[29]][R[20]], ({ [0] = { [1] = 20, [2] = 21 }, [1] = { [1] = 20, [2] = 21 }, [2] = { [1] = 53, [2] = 54 }, [3] = { [1] = 52, [2] = 53 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[29]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 9, [1] = 9, [2] = 42, [3] = 41 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[20] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[29]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[20]", R[20])
      end
      U[#U]:set_lights(true)
      if R[20] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 19, [1] = 99, [2] = 100, [3] = 16 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[20]", R[20])
      end
      U[#U]:set_lights(true)
      if R[20] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 19, [1] = 99, [2] = 100, [3] = 16 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[20]", R[20])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 31, [2] = 23, [3] = 23, [4] = 23 }, [1] = { [1] = 111, [2] = 103, [3] = 103, [4] = 103 }, [2] = { [1] = 112, [2] = 104, [3] = 104, [4] = 104 }, [3] = { [1] = 28, [2] = 20, [3] = 20, [4] = 20 } })[R[29]][R[20]], ({ [0] = { [1] = 17, [2] = 21, [3] = 17, [4] = 13 }, [1] = { [1] = 17, [2] = 21, [3] = 17, [4] = 13 }, [2] = { [1] = 50, [2] = 54, [3] = 50, [4] = 46 }, [3] = { [1] = 49, [2] = 53, [3] = 49, [4] = 45 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[20] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[29]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[20] == 5 or R[20] == 6 or R[20] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 21, [6] = 30, [7] = 21 }, [1] = { [5] = 101, [6] = 110, [7] = 101 }, [2] = { [5] = 102, [6] = 111, [7] = 102 }, [3] = { [5] = 18, [6] = 27, [7] = 18 } })[R[29]][R[20]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 29, [6] = 21, [7] = 29 }, [1] = { [5] = 109, [6] = 101, [7] = 109 }, [2] = { [5] = 110, [6] = 102, [7] = 110 }, [3] = { [5] = 26, [6] = 18, [7] = 26 } })[R[29]][R[20]], ({ [0] = { [5] = 14, [6] = 19, [7] = 19 }, [1] = { [5] = 14, [6] = 19, [7] = 19 }, [2] = { [5] = 47, [6] = 52, [7] = 52 }, [3] = { [5] = 46, [6] = 51, [7] = 51 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[20] == 5 or R[20] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 29, [7] = 22 }, [1] = { [5] = 109, [7] = 102 }, [2] = { [5] = 110, [7] = 103 }, [3] = { [5] = 26, [7] = 19 } })[R[29]][R[20]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        if R[20] == 5 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[20] == 7 then
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
        else
          unseen("R[20]", R[20])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [5] = 24, [7] = 26 }, [1] = { [5] = 104, [7] = 106 }, [2] = { [5] = 105, [7] = 107 }, [3] = { [5] = 21, [7] = 23 } })[R[29]][R[20]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        if R[20] == 5 then
        elseif R[20] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[20]", R[20])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = { [5] = 16, [7] = 13 }, [1] = { [5] = 16, [7] = 13 }, [2] = { [5] = 49, [7] = 46 }, [3] = { [5] = 48, [7] = 45 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = { [5] = 15, [7] = 14 }, [1] = { [5] = 15, [7] = 14 }, [2] = { [5] = 48, [7] = 47 }, [3] = { [5] = 47, [7] = 46 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 25, [7] = 30 }, [1] = { [5] = 105, [7] = 110 }, [2] = { [5] = 106, [7] = 111 }, [3] = { [5] = 22, [7] = 27 } })[R[29]][R[20]], ({ [0] = { [5] = 17, [7] = 14 }, [1] = { [5] = 17, [7] = 14 }, [2] = { [5] = 50, [7] = 47 }, [3] = { [5] = 49, [7] = 46 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[20] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[20]", R[20])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 31, [6] = 28, [7] = 24 }, [1] = { [5] = 111, [6] = 108, [7] = 104 }, [2] = { [5] = 112, [6] = 109, [7] = 105 }, [3] = { [5] = 28, [6] = 25, [7] = 21 } })[R[29]][R[20]], ({ [0] = { [5] = 12, [6] = 13, [7] = 11 }, [1] = { [5] = 12, [6] = 13, [7] = 11 }, [2] = { [5] = 45, [6] = 46, [7] = 44 }, [3] = { [5] = 44, [6] = 45, [7] = 43 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[20] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[20] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[20] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[20]", R[20])
      end
    else
      unseen("R[20]", R[20])
    end
    U[#U]:set_lights(true)
    if R[20] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[20] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[20] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[20]", R[20])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[20]], player = players[2], at = { ({ [0] = { [0] = 21, [1] = 20, [2] = 26, [3] = 25, [4] = 23, [5] = 30, [6] = 25, [7] = 30 }, [1] = { [0] = 101, [1] = 100, [2] = 106, [3] = 105, [4] = 103, [5] = 110, [6] = 105, [7] = 110 }, [2] = { [0] = 102, [1] = 101, [2] = 107, [3] = 106, [4] = 104, [5] = 111, [6] = 106, [7] = 111 }, [3] = { [0] = 18, [1] = 17, [2] = 23, [3] = 22, [4] = 20, [5] = 27, [6] = 22, [7] = 27 } })[R[29]][R[20]], ({ [0] = { [0] = 13, [1] = 15, [2] = 11, [3] = 12, [4] = 21, [5] = 16, [6] = 15, [7] = 21 }, [1] = { [0] = 13, [1] = 15, [2] = 11, [3] = 12, [4] = 21, [5] = 16, [6] = 15, [7] = 21 }, [2] = { [0] = 46, [1] = 48, [2] = 44, [3] = 45, [4] = 54, [5] = 49, [6] = 48, [7] = 54 }, [3] = { [0] = 45, [1] = 47, [2] = 43, [3] = 44, [4] = 53, [5] = 48, [6] = 47, [7] = 53 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[20]], player = players[2], at = { ({ [0] = { [0] = 22, [1] = 22, [2] = 25, [3] = 24, [4] = 24, [5] = 31, [6] = 26, [7] = 31 }, [1] = { [0] = 102, [1] = 102, [2] = 105, [3] = 104, [4] = 104, [5] = 111, [6] = 106, [7] = 111 }, [2] = { [0] = 103, [1] = 103, [2] = 106, [3] = 105, [4] = 105, [5] = 112, [6] = 107, [7] = 112 }, [3] = { [0] = 19, [1] = 19, [2] = 22, [3] = 21, [4] = 21, [5] = 28, [6] = 23, [7] = 28 } })[R[29]][R[20]], ({ [0] = { [0] = 13, [1] = 14, [2] = 10, [3] = 11, [4] = 20, [5] = 15, [6] = 14, [7] = 21 }, [1] = { [0] = 13, [1] = 14, [2] = 10, [3] = 11, [4] = 20, [5] = 15, [6] = 14, [7] = 21 }, [2] = { [0] = 46, [1] = 47, [2] = 43, [3] = 44, [4] = 53, [5] = 48, [6] = 47, [7] = 54 }, [3] = { [0] = 45, [1] = 46, [2] = 42, [3] = 43, [4] = 52, [5] = 47, [6] = 46, [7] = 53 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[20] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[39]][R[29]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 18, [1] = 18, [2] = 51, [3] = 50 } })[R[39]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[40]][R[29]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[40]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[41]][R[29]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[41]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[42]][R[29]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[42]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] })
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[43]][R[29]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[43]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 } })[R[44]][R[29]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[44]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[45]][R[29]], ({ [0] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 } })[R[45]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[46] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[46]][R[29]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[46]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[20]", R[20])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 31, [1] = 100, [2] = 105, [3] = 25 })[R[29]], ({ [0] = 4, [1] = 4, [2] = 36, [3] = 35 })[R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 25, [1] = 105, [2] = 101, [3] = 29 })[R[29]], ({ [0] = 29, [1] = 30, [2] = 59, [3] = 59 })[R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[47] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[47]][R[30]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[47]][R[30]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[47]][R[30]] })
    if R[47] == 5 or R[47] == 6 or R[47] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [6] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [7] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[47]][R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[47]][R[30]], ({ [5] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [6] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [7] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
      if R[47] == 5 or R[47] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [7] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[47]][R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        if R[47] == 5 then
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
        elseif R[47] == 7 then
          if LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[47]", R[47])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [5] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[47]][R[30]], ({ [5] = { [0] = 18, [1] = 18, [2] = 51, [3] = 50 }, [7] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        if R[47] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[47] == 7 then
        else
          unseen("R[47]", R[47])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[47]][R[30]], ({ [5] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[47] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[47]", R[47])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [7] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 } })[R[47]][R[30]], ({ [5] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [6] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [7] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
      if R[47] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[47] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[47] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[47]", R[47])
      end
    elseif R[47] == 1 or R[47] == 2 or R[47] == 3 or R[47] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [3] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [4] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[47]][R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      if R[47] == 1 or R[47] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[47]][R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[30]], ({ [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[47]][R[30]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[47]][R[30]], ({ [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 } })[R[47]][R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[30]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 9, [1] = 9, [2] = 42, [3] = 41 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[47]", R[47])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[47]], player = players[3], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [3] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[47]][R[30]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [3] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [4] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[47]], player = players[3], at = { ({ [1] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [3] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [4] = { [0] = 19, [1] = 99, [2] = 100, [3] = 16 } })[R[47]][R[30]], ({ [1] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [2] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [3] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [4] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [3] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 } })[R[47]][R[30]], ({ [1] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [3] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [4] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
      if R[47] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[47]", R[47])
      end
    elseif R[47] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[47]", R[47])
    end
    U[#U]:set_lights(true)
    if R[47] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[47] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[47] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[47] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[47] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[47] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[47] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[47] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[47]", R[47])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[47]], player = players[3], at = { ({ [0] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [3] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [5] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [6] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[47]][R[30]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [6] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[47]], player = players[3], at = { ({ [0] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [1] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [3] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [4] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [7] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 } })[R[47]][R[30]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [3] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [4] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [6] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[47] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[48]][R[30]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 18, [1] = 18, [2] = 51, [3] = 50 } })[R[48]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[49]][R[30]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[49]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[50]][R[30]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[50]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[51]][R[30]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[51]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] })
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[52]][R[30]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[52]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 } })[R[53]][R[30]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[53]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[54]][R[30]], ({ [0] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 } })[R[54]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[55]][R[30]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[55]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[47]", R[47])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 31, [1] = 100, [2] = 105, [3] = 25 })[R[30]], ({ [0] = 4, [1] = 4, [2] = 36, [3] = 35 })[R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 25, [1] = 105, [2] = 101, [3] = 29 })[R[30]], ({ [0] = 29, [1] = 30, [2] = 59, [3] = 59 })[R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 39, 12 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 20, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 8 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 117, 25 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 95, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 113, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 32, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 15, 58 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 35, 25 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 35, 56 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 118, 17 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 90, 54 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 74, 43 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 68, 12 } }
    R[0] = game.rand(5)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[0]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[0]] } }
    R[1] = draw_avoid(5, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[1]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[1]] } }
    R[2] = draw_avoid(5, { R[1], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[2]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[2]] } }
    R[3] = draw_avoid(5, { R[2], R[1], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[3]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[3]] } }
    R[4] = draw_avoid(5, { R[3], R[2], R[1], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 50, [1] = 47, [2] = 46, [3] = 7, [4] = 59 })[R[4]], ({ [0] = 49, [1] = 7, [2] = 30, [3] = 29, [4] = 11 })[R[4]] } }
    R[5] = game.rand(5)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[5]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[5]] } }
    R[6] = draw_avoid(5, { R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[6]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[6]] } }
    R[7] = draw_avoid(5, { R[6], R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[7]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[7]] } }
    R[8] = draw_avoid(5, { R[7], R[6], R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[8]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[8]] } }
    R[9] = draw_avoid(5, { R[8], R[7], R[6], R[5] })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Bar1", variant = "Random", at = { ({ [0] = 79, [1] = 84, [2] = 126, [3] = 88, [4] = 73 })[R[9]], ({ [0] = 12, [1] = 21, [2] = 31, [3] = 34, [4] = 55 })[R[9]] } }
    pick(4, 4, { 10, 29, 30, 56 })
    R[11] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[11]][R[10]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[11]][R[10]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] })
    if R[11] == 1 or R[11] == 2 or R[11] == 3 or R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [3] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [4] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[11]][R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 1 or R[11] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[11]][R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[10]], ({ [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[11]][R[10]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[11]][R[10]], ({ [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 } })[R[11]][R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 9, [1] = 9, [2] = 42, [3] = 41 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[11]], player = players[1], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [3] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[11]][R[10]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [3] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [4] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[11]], player = players[1], at = { ({ [1] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [3] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [4] = { [0] = 19, [1] = 99, [2] = 100, [3] = 16 } })[R[11]][R[10]], ({ [1] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [2] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [3] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [4] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [3] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 } })[R[11]][R[10]], ({ [1] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [3] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [4] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[11] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
    elseif R[11] == 5 or R[11] == 6 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [6] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [7] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[11]][R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[11]][R[10]], ({ [5] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [6] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [7] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 or R[11] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [7] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[11]][R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[11] == 7 then
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
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [7] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[11]][R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[11] == 5 then
        elseif R[11] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[11]", R[11])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[11]][R[10]], ({ [5] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[11] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [7] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 } })[R[11]][R[10]], ({ [5] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [6] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [7] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[11] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[11]", R[11])
      end
    elseif R[11] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[10]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[11]], player = players[1], at = { ({ [0] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [3] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [5] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [6] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[11]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [6] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[11]], player = players[1], at = { ({ [0] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [1] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [3] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [4] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [7] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 } })[R[11]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [3] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [4] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [6] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[11]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[11] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[57]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 18, [1] = 18, [2] = 51, [3] = 50 } })[R[57]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[58]][R[10]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[58]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[59]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[59]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[10]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[10]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[10]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[10]] })
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[60]][R[10]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[60]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[10]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[10]] })
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[61]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[61]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[62] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 } })[R[62]][R[10]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[62]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[63]][R[10]], ({ [0] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 } })[R[63]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[11] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[64]][R[10]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[64]][R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 31, [1] = 100, [2] = 105, [3] = 25 })[R[10]], ({ [0] = 4, [1] = 4, [2] = 36, [3] = 35 })[R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 25, [1] = 105, [2] = 101, [3] = 29 })[R[10]], ({ [0] = 29, [1] = 30, [2] = 59, [3] = 59 })[R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[20] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 25, [1] = 29, [2] = 29, [3] = 21, [4] = 25, [5] = 24, [6] = 21, [7] = 27 }, [1] = { [0] = 105, [1] = 109, [2] = 109, [3] = 101, [4] = 105, [5] = 104, [6] = 101, [7] = 107 }, [2] = { [0] = 106, [1] = 110, [2] = 110, [3] = 102, [4] = 106, [5] = 105, [6] = 102, [7] = 108 }, [3] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 } })[R[29]][R[20]], ({ [0] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [1] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [2] = { [0] = 49, [1] = 45, [2] = 49, [3] = 45, [4] = 48, [5] = 46, [6] = 43, [7] = 46 }, [3] = { [0] = 48, [1] = 44, [2] = 48, [3] = 44, [4] = 47, [5] = 45, [6] = 42, [7] = 45 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 25, [1] = 29, [2] = 29, [3] = 21, [4] = 25, [5] = 24, [6] = 21, [7] = 27 }, [1] = { [0] = 105, [1] = 109, [2] = 109, [3] = 101, [4] = 105, [5] = 104, [6] = 101, [7] = 107 }, [2] = { [0] = 106, [1] = 110, [2] = 110, [3] = 102, [4] = 106, [5] = 105, [6] = 102, [7] = 108 }, [3] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 } })[R[29]][R[20]], ({ [0] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [1] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 }, [2] = { [0] = 49, [1] = 45, [2] = 49, [3] = 45, [4] = 48, [5] = 46, [6] = 43, [7] = 46 }, [3] = { [0] = 48, [1] = 44, [2] = 48, [3] = 44, [4] = 47, [5] = 45, [6] = 42, [7] = 45 } })[R[29]][R[20]] })
    if R[20] == 5 or R[20] == 6 or R[20] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 21, [6] = 30, [7] = 21 }, [1] = { [5] = 101, [6] = 110, [7] = 101 }, [2] = { [5] = 102, [6] = 111, [7] = 102 }, [3] = { [5] = 18, [6] = 27, [7] = 18 } })[R[29]][R[20]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 29, [6] = 21, [7] = 29 }, [1] = { [5] = 109, [6] = 101, [7] = 109 }, [2] = { [5] = 110, [6] = 102, [7] = 110 }, [3] = { [5] = 26, [6] = 18, [7] = 26 } })[R[29]][R[20]], ({ [0] = { [5] = 14, [6] = 19, [7] = 19 }, [1] = { [5] = 14, [6] = 19, [7] = 19 }, [2] = { [5] = 47, [6] = 52, [7] = 52 }, [3] = { [5] = 46, [6] = 51, [7] = 51 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[20] == 5 or R[20] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 29, [7] = 22 }, [1] = { [5] = 109, [7] = 102 }, [2] = { [5] = 110, [7] = 103 }, [3] = { [5] = 26, [7] = 19 } })[R[29]][R[20]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        if R[20] == 5 then
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
        elseif R[20] == 7 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[20]", R[20])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [5] = 28, [7] = 27 }, [1] = { [5] = 108, [7] = 107 }, [2] = { [5] = 109, [7] = 108 }, [3] = { [5] = 25, [7] = 24 } })[R[29]][R[20]], ({ [0] = { [5] = 18, [7] = 16 }, [1] = { [5] = 18, [7] = 16 }, [2] = { [5] = 51, [7] = 49 }, [3] = { [5] = 50, [7] = 48 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[20] == 7 then
        elseif R[20] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[20]", R[20])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = { [5] = 16, [7] = 13 }, [1] = { [5] = 16, [7] = 13 }, [2] = { [5] = 49, [7] = 46 }, [3] = { [5] = 48, [7] = 45 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = { [5] = 15, [7] = 14 }, [1] = { [5] = 15, [7] = 14 }, [2] = { [5] = 48, [7] = 47 }, [3] = { [5] = 47, [7] = 46 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 25, [7] = 30 }, [1] = { [5] = 105, [7] = 110 }, [2] = { [5] = 106, [7] = 111 }, [3] = { [5] = 22, [7] = 27 } })[R[29]][R[20]], ({ [0] = { [5] = 17, [7] = 14 }, [1] = { [5] = 17, [7] = 14 }, [2] = { [5] = 50, [7] = 47 }, [3] = { [5] = 49, [7] = 46 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[20] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[20]", R[20])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 31, [6] = 28, [7] = 24 }, [1] = { [5] = 111, [6] = 108, [7] = 104 }, [2] = { [5] = 112, [6] = 109, [7] = 105 }, [3] = { [5] = 28, [6] = 25, [7] = 21 } })[R[29]][R[20]], ({ [0] = { [5] = 12, [6] = 13, [7] = 11 }, [1] = { [5] = 12, [6] = 13, [7] = 11 }, [2] = { [5] = 45, [6] = 46, [7] = 44 }, [3] = { [5] = 44, [6] = 45, [7] = 43 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[20] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[20] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[20] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[20]", R[20])
      end
    elseif R[20] == 1 or R[20] == 2 or R[20] == 3 or R[20] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 29, [2] = 22, [3] = 26, [4] = 22 }, [1] = { [1] = 109, [2] = 102, [3] = 106, [4] = 102 }, [2] = { [1] = 110, [2] = 103, [3] = 107, [4] = 103 }, [3] = { [1] = 26, [2] = 19, [3] = 23, [4] = 19 } })[R[29]][R[20]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      if R[20] == 1 or R[20] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 20, [2] = 21 }, [1] = { [1] = 100, [2] = 101 }, [2] = { [1] = 101, [2] = 102 }, [3] = { [1] = 17, [2] = 18 } })[R[29]][R[20]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[29]], ({ [0] = { [1] = 15, [2] = 19 }, [1] = { [1] = 15, [2] = 19 }, [2] = { [1] = 48, [2] = 52 }, [3] = { [1] = 47, [2] = 51 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 24, [2] = 25 }, [1] = { [1] = 104, [2] = 105 }, [2] = { [1] = 105, [2] = 106 }, [3] = { [1] = 21, [2] = 22 } })[R[29]][R[20]], ({ [0] = { [1] = 20, [2] = 16 }, [1] = { [1] = 20, [2] = 16 }, [2] = { [1] = 53, [2] = 49 }, [3] = { [1] = 52, [2] = 48 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 24, [2] = 29 }, [1] = { [1] = 104, [2] = 109 }, [2] = { [1] = 105, [2] = 110 }, [3] = { [1] = 21, [2] = 26 } })[R[29]][R[20]], ({ [0] = { [1] = 16, [2] = 13 }, [1] = { [1] = 16, [2] = 13 }, [2] = { [1] = 49, [2] = 46 }, [3] = { [1] = 48, [2] = 45 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 30, [2] = 28 }, [1] = { [1] = 110, [2] = 108 }, [2] = { [1] = 111, [2] = 109 }, [3] = { [1] = 27, [2] = 25 } })[R[29]][R[20]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[29]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 9, [1] = 9, [2] = 42, [3] = 41 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[29]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[20]", R[20])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[20]], player = players[2], at = { ({ [0] = { [1] = 31, [2] = 30, [3] = 28, [4] = 25 }, [1] = { [1] = 111, [2] = 110, [3] = 108, [4] = 105 }, [2] = { [1] = 112, [2] = 111, [3] = 109, [4] = 106 }, [3] = { [1] = 28, [2] = 27, [3] = 25, [4] = 22 } })[R[29]][R[20]], ({ [0] = { [1] = 20, [2] = 21, [3] = 20, [4] = 10 }, [1] = { [1] = 20, [2] = 21, [3] = 20, [4] = 10 }, [2] = { [1] = 53, [2] = 54, [3] = 53, [4] = 43 }, [3] = { [1] = 52, [2] = 53, [3] = 52, [4] = 42 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[20]], player = players[2], at = { ({ [0] = { [1] = 28, [2] = 26, [3] = 29, [4] = 19 }, [1] = { [1] = 108, [2] = 106, [3] = 109, [4] = 99 }, [2] = { [1] = 109, [2] = 107, [3] = 110, [4] = 100 }, [3] = { [1] = 25, [2] = 23, [3] = 26, [4] = 16 } })[R[29]][R[20]], ({ [0] = { [1] = 21, [2] = 20, [3] = 21, [4] = 17 }, [1] = { [1] = 21, [2] = 20, [3] = 21, [4] = 17 }, [2] = { [1] = 54, [2] = 53, [3] = 54, [4] = 50 }, [3] = { [1] = 53, [2] = 52, [3] = 53, [4] = 49 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 31, [2] = 23, [3] = 23, [4] = 23 }, [1] = { [1] = 111, [2] = 103, [3] = 103, [4] = 103 }, [2] = { [1] = 112, [2] = 104, [3] = 104, [4] = 104 }, [3] = { [1] = 28, [2] = 20, [3] = 20, [4] = 20 } })[R[29]][R[20]], ({ [0] = { [1] = 17, [2] = 21, [3] = 17, [4] = 13 }, [1] = { [1] = 17, [2] = 21, [3] = 17, [4] = 13 }, [2] = { [1] = 50, [2] = 54, [3] = 50, [4] = 46 }, [3] = { [1] = 49, [2] = 53, [3] = 49, [4] = 45 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[20] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[20] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[20]", R[20])
      end
    elseif R[20] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[29]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[20]", R[20])
    end
    U[#U]:set_lights(true)
    if R[20] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[20] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[20] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[20] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[20]", R[20])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[20]], player = players[2], at = { ({ [0] = { [0] = 21, [1] = 20, [2] = 26, [3] = 25, [4] = 23, [5] = 30, [6] = 25, [7] = 30 }, [1] = { [0] = 101, [1] = 100, [2] = 106, [3] = 105, [4] = 103, [5] = 110, [6] = 105, [7] = 110 }, [2] = { [0] = 102, [1] = 101, [2] = 107, [3] = 106, [4] = 104, [5] = 111, [6] = 106, [7] = 111 }, [3] = { [0] = 18, [1] = 17, [2] = 23, [3] = 22, [4] = 20, [5] = 27, [6] = 22, [7] = 27 } })[R[29]][R[20]], ({ [0] = { [0] = 13, [1] = 15, [2] = 11, [3] = 12, [4] = 21, [5] = 16, [6] = 15, [7] = 21 }, [1] = { [0] = 13, [1] = 15, [2] = 11, [3] = 12, [4] = 21, [5] = 16, [6] = 15, [7] = 21 }, [2] = { [0] = 46, [1] = 48, [2] = 44, [3] = 45, [4] = 54, [5] = 49, [6] = 48, [7] = 54 }, [3] = { [0] = 45, [1] = 47, [2] = 43, [3] = 44, [4] = 53, [5] = 48, [6] = 47, [7] = 53 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[20]], player = players[2], at = { ({ [0] = { [0] = 22, [1] = 22, [2] = 25, [3] = 24, [4] = 24, [5] = 31, [6] = 26, [7] = 31 }, [1] = { [0] = 102, [1] = 102, [2] = 105, [3] = 104, [4] = 104, [5] = 111, [6] = 106, [7] = 111 }, [2] = { [0] = 103, [1] = 103, [2] = 106, [3] = 105, [4] = 105, [5] = 112, [6] = 107, [7] = 112 }, [3] = { [0] = 19, [1] = 19, [2] = 22, [3] = 21, [4] = 21, [5] = 28, [6] = 23, [7] = 28 } })[R[29]][R[20]], ({ [0] = { [0] = 13, [1] = 14, [2] = 10, [3] = 11, [4] = 20, [5] = 15, [6] = 14, [7] = 21 }, [1] = { [0] = 13, [1] = 14, [2] = 10, [3] = 11, [4] = 20, [5] = 15, [6] = 14, [7] = 21 }, [2] = { [0] = 46, [1] = 47, [2] = 43, [3] = 44, [4] = 53, [5] = 48, [6] = 47, [7] = 54 }, [3] = { [0] = 45, [1] = 46, [2] = 42, [3] = 43, [4] = 52, [5] = 47, [6] = 46, [7] = 53 } })[R[29]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[20] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[65]][R[29]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 18, [1] = 18, [2] = 51, [3] = 50 } })[R[65]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[66]][R[29]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[66]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[67]][R[29]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[67]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[29]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[29]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[29]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[29]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[29]] })
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[68]][R[29]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[68]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[29]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[29]] })
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[69]][R[29]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[69]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 } })[R[70]][R[29]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[70]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[71] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[71]][R[29]], ({ [0] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 } })[R[71]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[20] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[72]][R[29]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[72]][R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[20]", R[20])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 31, [1] = 100, [2] = 105, [3] = 25 })[R[29]], ({ [0] = 4, [1] = 4, [2] = 36, [3] = 35 })[R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 25, [1] = 105, [2] = 101, [3] = 29 })[R[29]], ({ [0] = 29, [1] = 30, [2] = 59, [3] = 59 })[R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[47] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[47]][R[30]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[47]][R[30]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[47]][R[30]] })
    if R[47] == 5 or R[47] == 6 or R[47] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [6] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [7] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[47]][R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[47]][R[30]], ({ [5] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [6] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [7] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
      if R[47] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[47] == 5 or R[47] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [7] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[47]][R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        if R[47] == 5 then
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
        elseif R[47] == 7 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[47]", R[47])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [5] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[47]][R[30]], ({ [5] = { [0] = 18, [1] = 18, [2] = 51, [3] = 50 }, [7] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        if R[47] == 7 then
        elseif R[47] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[47]", R[47])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[47]][R[30]], ({ [5] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[47]", R[47])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [7] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 } })[R[47]][R[30]], ({ [5] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [6] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [7] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
      if R[47] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[47] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[47] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[47]", R[47])
      end
    elseif R[47] == 1 or R[47] == 2 or R[47] == 3 or R[47] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [3] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [4] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[47]][R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      if R[47] == 1 or R[47] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[47]][R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[30]], ({ [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[47]][R[30]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[47]][R[30]], ({ [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 } })[R[47]][R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[47]][R[30]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[30]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 9, [1] = 9, [2] = 42, [3] = 41 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[47]", R[47])
      end
      U[#U]:set_lights(true)
      if R[47] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 19, [1] = 99, [2] = 100, [3] = 16 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[47]", R[47])
      end
      U[#U]:set_lights(true)
      if R[47] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[47] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 19, [1] = 99, [2] = 100, [3] = 16 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[47]", R[47])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [3] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 } })[R[47]][R[30]], ({ [1] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [3] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [4] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[47] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[30]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[47]", R[47])
    end
    U[#U]:set_lights(true)
    if R[47] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[47] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[47] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[47] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[47] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[47] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[47] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[47] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[47]", R[47])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[47]], player = players[3], at = { ({ [0] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [3] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [5] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [6] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[47]][R[30]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [6] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[47]], player = players[3], at = { ({ [0] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [1] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [3] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [4] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [7] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 } })[R[47]][R[30]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [3] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [4] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [6] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[47]][R[30]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[47] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[73]][R[30]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 18, [1] = 18, [2] = 51, [3] = 50 } })[R[73]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[74]][R[30]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[74]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[75]][R[30]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[75]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[30]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[30]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[30]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[30]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[30]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[76]][R[30]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[76]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[30]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[30]] })
        for i = 1, game.initial_units() do
          R[77] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[77]][R[30]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[77]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[78] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 } })[R[78]][R[30]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[78]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[79]][R[30]], ({ [0] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 } })[R[79]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[47] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[80] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[80]][R[30]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[80]][R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[47]", R[47])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 31, [1] = 100, [2] = 105, [3] = 25 })[R[30]], ({ [0] = 4, [1] = 4, [2] = 36, [3] = 35 })[R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 25, [1] = 105, [2] = 101, [3] = 29 })[R[30]], ({ [0] = 29, [1] = 30, [2] = 59, [3] = 59 })[R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[81] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[81]][R[56]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [3] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [4] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[81]][R[56]], ({ [0] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [5] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [6] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[81]][R[56]] })
    if R[81] == 5 or R[81] == 6 or R[81] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [5] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [6] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [7] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[81]][R[56]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [6] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [7] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[81]][R[56]], ({ [5] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [6] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [7] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
      if R[81] == 5 or R[81] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [5] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [7] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[81]][R[56]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        if R[81] == 5 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[81] == 7 then
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
          unseen("R[81]", R[81])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [5] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [7] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[81]][R[56]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        if R[81] == 5 then
        elseif R[81] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[56]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[81]", R[81])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [7] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[56]], ({ [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [5] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[81]][R[56]], ({ [5] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [7] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[81] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[56]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[56]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[56]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[81]", R[81])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 }, [7] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 } })[R[81]][R[56]], ({ [5] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [6] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [7] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
      if R[81] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[56]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[81] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[81] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[81]", R[81])
      end
    elseif R[81] == 1 or R[81] == 2 or R[81] == 3 or R[81] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [3] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [4] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[81]][R[56]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      if R[81] == 1 or R[81] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 } })[R[81]][R[56]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[56]], ({ [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[81]][R[56]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 } })[R[81]][R[56]], ({ [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 28, [1] = 108, [2] = 109, [3] = 25 } })[R[81]][R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[81]][R[56]], ({ [1] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[81] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[56]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[56]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[56]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[56]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 9, [1] = 9, [2] = 42, [3] = 41 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[56]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[81] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[56]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[56]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[56]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[81]", R[81])
      end
      U[#U]:set_lights(true)
      if R[81] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[81] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[56]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[81] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[81] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 19, [1] = 99, [2] = 100, [3] = 16 })[R[56]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[56]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[81]", R[81])
      end
      U[#U]:set_lights(true)
      if R[81] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[56]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[81] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[81] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[56]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[81] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[56]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 19, [1] = 99, [2] = 100, [3] = 16 })[R[56]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[81]", R[81])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [1] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [2] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [3] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 } })[R[81]][R[56]], ({ [1] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [2] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [3] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 }, [4] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[81] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[56]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 27, [1] = 107, [2] = 108, [3] = 24 })[R[56]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[56]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[56]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 30, [1] = 110, [2] = 111, [3] = 27 })[R[56]], ({ [0] = 10, [1] = 10, [2] = 43, [3] = 42 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 29, [1] = 109, [2] = 110, [3] = 26 })[R[56]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[56]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[81]", R[81])
    end
    U[#U]:set_lights(true)
    if R[81] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[56]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[56]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[81] == 1 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[56]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[56]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[56]], ({ [0] = 16, [1] = 16, [2] = 49, [3] = 48 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[81] == 2 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[56]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[56]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[81] == 3 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[56]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[81] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[56]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 20, [1] = 100, [2] = 101, [3] = 17 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[81] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[56]], ({ [0] = 12, [1] = 12, [2] = 45, [3] = 44 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[81] == 6 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 13, [1] = 13, [2] = 46, [3] = 45 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 23, [1] = 103, [2] = 104, [3] = 20 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 20, [1] = 20, [2] = 53, [3] = 52 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[56]], ({ [0] = 21, [1] = 21, [2] = 54, [3] = 53 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 14, [1] = 14, [2] = 47, [3] = 46 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[81] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 11, [1] = 11, [2] = 44, [3] = 43 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 31, [1] = 111, [2] = 112, [3] = 28 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[81]", R[81])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[81]], player = players[4], at = { ({ [0] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [3] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [4] = { [0] = 23, [1] = 103, [2] = 104, [3] = 20 }, [5] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [6] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [7] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[81]][R[56]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [3] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [4] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 }, [5] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [6] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[81]], player = players[4], at = { ({ [0] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [1] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [3] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [4] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [5] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 }, [6] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [7] = { [0] = 31, [1] = 111, [2] = 112, [3] = 28 } })[R[81]][R[56]], ({ [0] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [3] = { [0] = 11, [1] = 11, [2] = 44, [3] = 43 }, [4] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [5] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [6] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [7] = { [0] = 21, [1] = 21, [2] = 54, [3] = 53 } })[R[81]][R[56]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[81] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[82] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[82]][R[56]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 12, [1] = 12, [2] = 45, [3] = 44 }, [2] = { [0] = 18, [1] = 18, [2] = 51, [3] = 50 } })[R[82]][R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 104, [2] = 105, [3] = 21 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] })
        for i = 1, game.initial_units() do
          R[83] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [1] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [2] = { [0] = 27, [1] = 107, [2] = 108, [3] = 24 } })[R[83]][R[56]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 13, [1] = 13, [2] = 46, [3] = 45 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[83]][R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[56]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[56]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[56]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[56]] })
        for i = 1, game.initial_units() do
          R[84] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 21, [1] = 101, [2] = 102, [3] = 18 }, [2] = { [0] = 25, [1] = 105, [2] = 106, [3] = 22 } })[R[84]][R[56]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[84]][R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[56]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[56]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[56]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[56]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[56]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[56]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[56]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[56]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[56]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 22, [1] = 102, [2] = 103, [3] = 19 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] })
        game.create_tube({ ({ [0] = 25, [1] = 105, [2] = 106, [3] = 22 })[R[56]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[56]] })
        game.create_tube({ ({ [0] = 26, [1] = 106, [2] = 107, [3] = 23 })[R[56]], ({ [0] = 15, [1] = 15, [2] = 48, [3] = 47 })[R[56]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 18, [1] = 18, [2] = 51, [3] = 50 })[R[56]] })
        game.create_tube({ ({ [0] = 28, [1] = 108, [2] = 109, [3] = 25 })[R[56]], ({ [0] = 19, [1] = 19, [2] = 52, [3] = 51 })[R[56]] })
        for i = 1, game.initial_units() do
          R[85] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [2] = { [0] = 22, [1] = 102, [2] = 103, [3] = 19 } })[R[85]][R[56]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 14, [1] = 14, [2] = 47, [3] = 46 }, [2] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 } })[R[85]][R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[56]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[56]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 21, [1] = 101, [2] = 102, [3] = 18 })[R[56]], ({ [0] = 17, [1] = 17, [2] = 50, [3] = 49 })[R[56]] })
        for i = 1, game.initial_units() do
          R[86] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [1] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[86]][R[56]], ({ [0] = { [0] = 9, [1] = 9, [2] = 42, [3] = 41 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 } })[R[86]][R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[87] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 } })[R[87]][R[56]], ({ [0] = { [0] = 20, [1] = 20, [2] = 53, [3] = 52 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[87]][R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[88] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 }, [1] = { [0] = 29, [1] = 109, [2] = 110, [3] = 26 }, [2] = { [0] = 26, [1] = 106, [2] = 107, [3] = 23 } })[R[88]][R[56]], ({ [0] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 }, [1] = { [0] = 16, [1] = 16, [2] = 49, [3] = 48 }, [2] = { [0] = 17, [1] = 17, [2] = 50, [3] = 49 } })[R[88]][R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[81] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[89] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 24, [1] = 104, [2] = 105, [3] = 21 }, [1] = { [0] = 20, [1] = 100, [2] = 101, [3] = 17 }, [2] = { [0] = 30, [1] = 110, [2] = 111, [3] = 27 } })[R[89]][R[56]], ({ [0] = { [0] = 19, [1] = 19, [2] = 52, [3] = 51 }, [1] = { [0] = 15, [1] = 15, [2] = 48, [3] = 47 }, [2] = { [0] = 10, [1] = 10, [2] = 43, [3] = 42 } })[R[89]][R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[81]", R[81])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 31, [1] = 100, [2] = 105, [3] = 25 })[R[56]], ({ [0] = 4, [1] = 4, [2] = 36, [3] = 35 })[R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 25, [1] = 105, [2] = 101, [3] = 29 })[R[56]], ({ [0] = 29, [1] = 30, [2] = 59, [3] = 59 })[R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    trigger.time{min = 8000, max = 16000, one_shot = false, on = DoDisaster}  -- after 80 to 160 marks
  end
  return true
end
