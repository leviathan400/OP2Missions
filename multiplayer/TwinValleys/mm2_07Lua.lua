-- mm2_07Lua.lua  -  2 Player, Midas, 'Twin Valleys' map. (Lua)
--
-- Converted by op2dll from mm2_07.dll ("2 Player, Midas, 'Twin Valleys' map."): its setup replayed. `on_init` makes the original's
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
local Meteor, Storm

function Meteor(t)
  local r1 = game.rand(230)
  local r2 = game.rand(40)
  game.create_meteor({ r2 + 10, r1 + 11 }, -1)
end

function Storm(t)
  local r1 = game.rand(0)
  local r2 = game.rand(7)
  local r3 = game.rand(50)
  game.create_lightning({ 64, r3 + 91 }, nil, r2 + 10)
end

function on_init()
  local n = game.num_players()
  R[0] = game.rand(7)
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 60, [1] = 23, [2] = 30, [3] = 14, [4] = 7, [5] = 49, [6] = 43 })[R[0]], ({ [0] = 17, [1] = 20, [2] = 57, [3] = 43, [4] = 54, [5] = 51, [6] = 7 })[R[0]] } }
  R[1] = game.rand(7)
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 44, [1] = 22, [2] = 6, [3] = 18, [4] = 49, [5] = 46, [6] = 48 })[R[1]], ({ [0] = 115, [1] = 125, [2] = 124, [3] = 113, [4] = 99, [5] = 109, [6] = 124 })[R[1]] } }
  R[2] = game.rand(7)
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 24, [1] = 48, [2] = 49, [3] = 13, [4] = 5, [5] = 10, [6] = 48 })[R[2]], ({ [0] = 246, [1] = 232, [2] = 204, [3] = 190, [4] = 198, [5] = 215, [6] = 176 })[R[2]] } }
  R[3] = draw_avoid(7, { R[0] })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 60, [1] = 23, [2] = 30, [3] = 14, [4] = 7, [5] = 49, [6] = 43 })[R[3]], ({ [0] = 17, [1] = 20, [2] = 57, [3] = 43, [4] = 54, [5] = 51, [6] = 7 })[R[3]] } }
  R[4] = draw_avoid(7, { R[1] })
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 44, [1] = 22, [2] = 6, [3] = 18, [4] = 49, [5] = 46, [6] = 48 })[R[4]], ({ [0] = 115, [1] = 125, [2] = 124, [3] = 113, [4] = 99, [5] = 109, [6] = 124 })[R[4]] } }
  R[5] = draw_avoid(7, { R[2] })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 24, [1] = 48, [2] = 49, [3] = 13, [4] = 5, [5] = 10, [6] = 48 })[R[5]], ({ [0] = 246, [1] = 232, [2] = 204, [3] = 190, [4] = 198, [5] = 215, [6] = 176 })[R[5]] } }
  R[6] = draw_avoid(7, { R[3], R[0] })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 60, [1] = 23, [2] = 30, [3] = 14, [4] = 7, [5] = 49, [6] = 43 })[R[6]], ({ [0] = 17, [1] = 20, [2] = 57, [3] = 43, [4] = 54, [5] = 51, [6] = 7 })[R[6]] } }
  R[7] = draw_avoid(7, { R[4], R[1] })
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 44, [1] = 22, [2] = 6, [3] = 18, [4] = 49, [5] = 46, [6] = 48 })[R[7]], ({ [0] = 115, [1] = 125, [2] = 124, [3] = 113, [4] = 99, [5] = 109, [6] = 124 })[R[7]] } }
  R[8] = draw_avoid(7, { R[5], R[2] })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 24, [1] = 48, [2] = 49, [3] = 13, [4] = 5, [5] = 10, [6] = 48 })[R[8]], ({ [0] = 246, [1] = 232, [2] = 204, [3] = 190, [4] = 198, [5] = 215, [6] = 176 })[R[8]] } }
  R[9] = draw_avoid(7, { R[6], R[3], R[0] })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 60, [1] = 23, [2] = 30, [3] = 14, [4] = 7, [5] = 49, [6] = 43 })[R[9]], ({ [0] = 17, [1] = 20, [2] = 57, [3] = 43, [4] = 54, [5] = 51, [6] = 7 })[R[9]] } }
  R[10] = draw_avoid(7, { R[7], R[4], R[1] })
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 44, [1] = 22, [2] = 6, [3] = 18, [4] = 49, [5] = 46, [6] = 48 })[R[10]], ({ [0] = 115, [1] = 125, [2] = 124, [3] = 113, [4] = 99, [5] = 109, [6] = 124 })[R[10]] } }
  R[11] = draw_avoid(7, { R[8], R[5], R[2] })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 24, [1] = 48, [2] = 49, [3] = 13, [4] = 5, [5] = 10, [6] = 48 })[R[11]], ({ [0] = 246, [1] = 232, [2] = 204, [3] = 190, [4] = 198, [5] = 215, [6] = 176 })[R[11]] } }
  pick(2, 2, { 12, 13 })
  R[14] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 20, [1] = 24 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 30, [1] = 34 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 22, [1] = 26 }, [6] = { [0] = 25, [1] = 29 }, [7] = { [0] = 30, [1] = 34 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 195, [1] = 32 }, [3] = { [0] = 205, [1] = 42 }, [4] = { [0] = 206, [1] = 43 }, [5] = { [0] = 208, [1] = 45 }, [6] = { [0] = 194, [1] = 31 }, [7] = { [0] = 207, [1] = 44 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  players[1]:center_view({ ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 20, [1] = 24 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 30, [1] = 34 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 22, [1] = 26 }, [6] = { [0] = 25, [1] = 29 }, [7] = { [0] = 30, [1] = 34 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 195, [1] = 32 }, [3] = { [0] = 205, [1] = 42 }, [4] = { [0] = 206, [1] = 43 }, [5] = { [0] = 208, [1] = 45 }, [6] = { [0] = 194, [1] = 31 }, [7] = { [0] = 207, [1] = 44 } })[R[14]][R[13]] })
  U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 30, [1] = 34 }, [2] = { [0] = 19, [1] = 23 }, [3] = { [0] = 38, [1] = 42 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 22, [1] = 26 }, [6] = { [0] = 34, [1] = 38 }, [7] = { [0] = 23, [1] = 27 } })[R[14]][R[13]], ({ [0] = { [0] = 192, [1] = 29 }, [1] = { [0] = 191, [1] = 28 }, [2] = { [0] = 200, [1] = 37 }, [3] = { [0] = 209, [1] = 46 }, [4] = { [0] = 214, [1] = 51 }, [5] = { [0] = 214, [1] = 51 }, [6] = { [0] = 194, [1] = 31 }, [7] = { [0] = 213, [1] = 50 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  if R[14] == 3 or R[14] == 4 then
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 22, [1] = 26 }, [4] = { [0] = 29, [1] = 33 } })[R[14]][R[13]], ({ [3] = { [0] = 209, [1] = 46 }, [4] = { [0] = 198, [1] = 35 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    if R[14] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
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
    elseif R[14] == 3 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 25, [1] = 29 })[R[13]], ({ [0] = 198, [1] = 35 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 198, [1] = 35 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[14]", R[14])
    end
  elseif R[14] == 0 or R[14] == 1 or R[14] == 2 or R[14] == 5 or R[14] == 6 or R[14] == 7 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 44, [1] = 48 }, [1] = { [0] = 31, [1] = 35 }, [2] = { [0] = 22, [1] = 26 }, [5] = { [0] = 32, [1] = 36 }, [6] = { [0] = 35, [1] = 39 }, [7] = { [0] = 23, [1] = 27 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 198, [1] = 35 }, [2] = { [0] = 206, [1] = 43 }, [5] = { [0] = 213, [1] = 50 }, [6] = { [0] = 202, [1] = 39 }, [7] = { [0] = 200, [1] = 37 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    if R[14] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 25 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 25 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 25 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 208, [1] = 45 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 208, [1] = 45 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 208, [1] = 45 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[14] == 2 then
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
    elseif R[14] == 5 then
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
    elseif R[14] == 6 then
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
    elseif R[14] == 7 then
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
      unseen("R[14]", R[14])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 30, [1] = 34 }, [2] = { [0] = 31, [1] = 35 }, [5] = { [0] = 32, [1] = 36 }, [6] = { [0] = 43, [1] = 47 }, [7] = { [0] = 38, [1] = 42 } })[R[14]][R[13]], ({ [0] = { [0] = 206, [1] = 43 }, [1] = { [0] = 216, [1] = 53 }, [2] = { [0] = 200, [1] = 37 }, [5] = { [0] = 206, [1] = 43 }, [6] = { [0] = 202, [1] = 39 }, [7] = { [0] = 200, [1] = 37 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    if R[14] == 2 or R[14] == 5 or R[14] == 6 or R[14] == 7 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [2] = { [0] = 31, [1] = 35 }, [5] = { [0] = 22, [1] = 26 }, [6] = { [0] = 26, [1] = 30 }, [7] = { [0] = 39, [1] = 43 } })[R[14]][R[13]], ({ [2] = { [0] = 206, [1] = 43 }, [5] = { [0] = 201, [1] = 38 }, [6] = { [0] = 202, [1] = 39 }, [7] = { [0] = 212, [1] = 49 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 0 or R[14] == 1 then
    else
      unseen("R[14]", R[14])
    end
  else
    unseen("R[14]", R[14])
  end
  U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 25 }, [1] = { [0] = 21, [1] = 25 }, [2] = { [0] = 39, [1] = 43 }, [3] = { [0] = 31, [1] = 35 }, [4] = { [0] = 21, [1] = 25 }, [5] = { [0] = 12, [1] = 16 }, [6] = { [0] = 18, [1] = 22 }, [7] = { [0] = 31, [1] = 35 } })[R[14]][R[13]], ({ [0] = { [0] = 208, [1] = 45 }, [1] = { [0] = 213, [1] = 50 }, [2] = { [0] = 200, [1] = 37 }, [3] = { [0] = 192, [1] = 29 }, [4] = { [0] = 202, [1] = 39 }, [5] = { [0] = 208, [1] = 45 }, [6] = { [0] = 202, [1] = 39 }, [7] = { [0] = 216, [1] = 53 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32 }, [1] = { [0] = 20, [1] = 24 }, [2] = { [0] = 35, [1] = 39 }, [3] = { [0] = 20, [1] = 24 }, [4] = { [0] = 39, [1] = 43 }, [5] = { [0] = 30, [1] = 34 }, [6] = { [0] = 25, [1] = 29 }, [7] = { [0] = 41, [1] = 45 } })[R[14]][R[13]], ({ [0] = { [0] = 195, [1] = 32 }, [1] = { [0] = 199, [1] = 36 }, [2] = { [0] = 204, [1] = 41 }, [3] = { [0] = 199, [1] = 36 }, [4] = { [0] = 206, [1] = 43 }, [5] = { [0] = 199, [1] = 36 }, [6] = { [0] = 207, [1] = 44 }, [7] = { [0] = 207, [1] = 44 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 30 }, [1] = { [0] = 20, [1] = 24 }, [2] = { [0] = 35, [1] = 39 }, [3] = { [0] = 23, [1] = 27 }, [4] = { [0] = 41, [1] = 45 }, [5] = { [0] = 30, [1] = 34 }, [6] = { [0] = 23, [1] = 27 }, [7] = { [0] = 41, [1] = 45 } })[R[14]][R[13]], ({ [0] = { [0] = 195, [1] = 32 }, [1] = { [0] = 197, [1] = 34 }, [2] = { [0] = 202, [1] = 39 }, [3] = { [0] = 195, [1] = 32 }, [4] = { [0] = 206, [1] = 43 }, [5] = { [0] = 201, [1] = 38 }, [6] = { [0] = 207, [1] = 44 }, [7] = { [0] = 209, [1] = 46 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[14] == 0 or R[14] == 1 or R[14] == 2 or R[14] == 4 or R[14] == 5 or R[14] == 6 or R[14] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 37, [1] = 41 }, [1] = { [0] = 23, [1] = 27 }, [2] = { [0] = 17, [1] = 21 }, [4] = { [0] = 33, [1] = 37 }, [5] = { [0] = 18, [1] = 22 }, [6] = { [0] = 38, [1] = 42 }, [7] = { [0] = 40, [1] = 44 } })[R[14]][R[13]], ({ [0] = { [0] = 201, [1] = 38 }, [1] = { [0] = 199, [1] = 36 }, [2] = { [0] = 205, [1] = 42 }, [4] = { [0] = 214, [1] = 51 }, [5] = { [0] = 209, [1] = 46 }, [6] = { [0] = 194, [1] = 31 }, [7] = { [0] = 201, [1] = 38 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 37, [1] = 41 }, [1] = { [0] = 23, [1] = 27 }, [2] = { [0] = 17, [1] = 21 }, [4] = { [0] = 33, [1] = 37 }, [5] = { [0] = 18, [1] = 22 }, [6] = { [0] = 38, [1] = 42 }, [7] = { [0] = 40, [1] = 44 } })[R[14]][R[13]], ({ [0] = { [0] = 201, [1] = 38 }, [1] = { [0] = 199, [1] = 36 }, [2] = { [0] = 205, [1] = 42 }, [4] = { [0] = 214, [1] = 51 }, [5] = { [0] = 209, [1] = 46 }, [6] = { [0] = 194, [1] = 31 }, [7] = { [0] = 201, [1] = 38 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[14] == 3 then
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 195, [1] = 32 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  else
    unseen("R[14]", R[14])
  end
  U[#U]:set_lights(true)
  if R[14] == 0 then
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 195, [1] = 32 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 195, [1] = 32 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 195, [1] = 32 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 192, [1] = 29 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 195, [1] = 32 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 192, [1] = 29 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 195, [1] = 32 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 195, [1] = 32 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 192, [1] = 29 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[14] == 1 then
    if LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 193, [1] = 30 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 190, [1] = 27 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 24 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 193, [1] = 30 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 190, [1] = 27 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 24 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 24 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 193, [1] = 30 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 190, [1] = 27 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[14] == 2 then
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 21 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 208, [1] = 45 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 208, [1] = 45 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 21 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 208, [1] = 45 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[14] == 3 then
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 24 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 24 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 195, [1] = 32 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 24 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[14] == 4 then
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 41, [1] = 45 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 41, [1] = 45 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 33, [1] = 37 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 34, [1] = 38 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 34, [1] = 38 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 41, [1] = 45 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 33, [1] = 37 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 34, [1] = 38 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[14] == 5 then
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 22 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 21 })[R[13]], ({ [0] = 198, [1] = 35 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 21 })[R[13]], ({ [0] = 198, [1] = 35 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 22 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 17, [1] = 21 })[R[13]], ({ [0] = 198, [1] = 35 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 26, [1] = 30 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[14] == 6 then
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 194, [1] = 31 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 39, [1] = 43 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 39, [1] = 43 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 27 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 194, [1] = 31 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 39, [1] = 43 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[14] == 7 then
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 41, [1] = 45 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 41, [1] = 45 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 29 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 20, [1] = 24 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 29 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 20, [1] = 24 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 41, [1] = 45 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 25, [1] = 29 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 20, [1] = 24 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  else
    unseen("R[14]", R[14])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 44, [1] = 48 }, [1] = { [0] = 29, [1] = 33 }, [2] = { [0] = 27, [1] = 31 }, [3] = { [0] = 30, [1] = 34 }, [4] = { [0] = 42, [1] = 46 }, [5] = { [0] = 18, [1] = 22 }, [6] = { [0] = 39, [1] = 43 }, [7] = { [0] = 34, [1] = 38 } })[R[14]][R[13]], ({ [0] = { [0] = 203, [1] = 40 }, [1] = { [0] = 203, [1] = 40 }, [2] = { [0] = 202, [1] = 39 }, [3] = { [0] = 196, [1] = 33 }, [4] = { [0] = 197, [1] = 34 }, [5] = { [0] = 215, [1] = 52 }, [6] = { [0] = 204, [1] = 41 }, [7] = { [0] = 206, [1] = 43 } })[R[14]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  game.create_tube({ ({ [0] = { [0] = 24, [1] = 28 }, [1] = { [0] = 23, [1] = 27 }, [2] = { [0] = 22, [1] = 26 }, [3] = { [0] = 22, [1] = 26 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 22, [1] = 26 }, [6] = { [0] = 25, [1] = 29 }, [7] = { [0] = 23, [1] = 27 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 200, [1] = 37 }, [3] = { [0] = 205, [1] = 42 }, [4] = { [0] = 200, [1] = 37 }, [5] = { [0] = 204, [1] = 41 }, [6] = { [0] = 196, [1] = 33 }, [7] = { [0] = 203, [1] = 40 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 25, [1] = 29 }, [1] = { [0] = 24, [1] = 28 }, [2] = { [0] = 23, [1] = 27 }, [3] = { [0] = 22, [1] = 26 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 22, [1] = 26 }, [6] = { [0] = 25, [1] = 29 }, [7] = { [0] = 23, [1] = 27 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 200, [1] = 37 }, [3] = { [0] = 206, [1] = 43 }, [4] = { [0] = 201, [1] = 38 }, [5] = { [0] = 205, [1] = 42 }, [6] = { [0] = 197, [1] = 34 }, [7] = { [0] = 204, [1] = 41 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 26, [1] = 30 }, [1] = { [0] = 25, [1] = 29 }, [2] = { [0] = 24, [1] = 28 }, [3] = { [0] = 22, [1] = 26 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 22, [1] = 26 }, [6] = { [0] = 25, [1] = 29 }, [7] = { [0] = 23, [1] = 27 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 200, [1] = 37 }, [3] = { [0] = 207, [1] = 44 }, [4] = { [0] = 202, [1] = 39 }, [5] = { [0] = 206, [1] = 43 }, [6] = { [0] = 198, [1] = 35 }, [7] = { [0] = 205, [1] = 42 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 27, [1] = 31 }, [1] = { [0] = 26, [1] = 30 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 23, [1] = 27 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 22, [1] = 26 }, [6] = { [0] = 25, [1] = 29 }, [7] = { [0] = 23, [1] = 27 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 197, [1] = 34 }, [3] = { [0] = 205, [1] = 42 }, [4] = { [0] = 203, [1] = 40 }, [5] = { [0] = 210, [1] = 47 }, [6] = { [0] = 199, [1] = 36 }, [7] = { [0] = 206, [1] = 43 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 28, [1] = 32 }, [1] = { [0] = 27, [1] = 31 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 24, [1] = 28 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 22, [1] = 26 }, [6] = { [0] = 25, [1] = 29 }, [7] = { [0] = 23, [1] = 27 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 198, [1] = 35 }, [3] = { [0] = 201, [1] = 38 }, [4] = { [0] = 204, [1] = 41 }, [5] = { [0] = 211, [1] = 48 }, [6] = { [0] = 200, [1] = 37 }, [7] = { [0] = 207, [1] = 44 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 29, [1] = 33 }, [1] = { [0] = 28, [1] = 32 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 24, [1] = 28 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 22, [1] = 26 }, [6] = { [0] = 28, [1] = 32 }, [7] = { [0] = 23, [1] = 27 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 199, [1] = 36 }, [3] = { [0] = 202, [1] = 39 }, [4] = { [0] = 208, [1] = 45 }, [5] = { [0] = 212, [1] = 49 }, [6] = { [0] = 194, [1] = 31 }, [7] = { [0] = 208, [1] = 45 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 30, [1] = 34 }, [1] = { [0] = 29, [1] = 33 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 24, [1] = 28 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 25, [1] = 29 }, [6] = { [0] = 29, [1] = 33 }, [7] = { [0] = 23, [1] = 27 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 200, [1] = 37 }, [3] = { [0] = 203, [1] = 40 }, [4] = { [0] = 209, [1] = 46 }, [5] = { [0] = 208, [1] = 45 }, [6] = { [0] = 194, [1] = 31 }, [7] = { [0] = 209, [1] = 46 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 30, [1] = 34 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 24, [1] = 28 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 25, [1] = 29 }, [6] = { [0] = 29, [1] = 33 }, [7] = { [0] = 23, [1] = 27 } })[R[14]][R[13]], ({ [0] = { [0] = 194, [1] = 31 }, [1] = { [0] = 193, [1] = 30 }, [2] = { [0] = 201, [1] = 38 }, [3] = { [0] = 204, [1] = 41 }, [4] = { [0] = 210, [1] = 47 }, [5] = { [0] = 214, [1] = 51 }, [6] = { [0] = 202, [1] = 39 }, [7] = { [0] = 210, [1] = 47 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 30, [1] = 34 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 24, [1] = 28 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 26, [1] = 30 }, [6] = { [0] = 30, [1] = 34 }, [7] = { [0] = 23, [1] = 27 } })[R[14]][R[13]], ({ [0] = { [0] = 195, [1] = 32 }, [1] = { [0] = 194, [1] = 31 }, [2] = { [0] = 202, [1] = 39 }, [3] = { [0] = 205, [1] = 42 }, [4] = { [0] = 211, [1] = 48 }, [5] = { [0] = 208, [1] = 45 }, [6] = { [0] = 194, [1] = 31 }, [7] = { [0] = 211, [1] = 48 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 30, [1] = 34 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 25, [1] = 29 }, [4] = { [0] = 29, [1] = 33 }, [5] = { [0] = 26, [1] = 30 }, [6] = { [0] = 30, [1] = 34 }, [7] = { [0] = 26, [1] = 30 } })[R[14]][R[13]], ({ [0] = { [0] = 196, [1] = 33 }, [1] = { [0] = 195, [1] = 32 }, [2] = { [0] = 203, [1] = 40 }, [3] = { [0] = 201, [1] = 38 }, [4] = { [0] = 212, [1] = 49 }, [5] = { [0] = 214, [1] = 51 }, [6] = { [0] = 202, [1] = 39 }, [7] = { [0] = 200, [1] = 37 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 30, [1] = 34 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 25, [1] = 29 }, [4] = { [0] = 32, [1] = 36 }, [5] = { [0] = 27, [1] = 31 }, [6] = { [0] = 31, [1] = 35 }, [7] = { [0] = 26, [1] = 30 } })[R[14]][R[13]], ({ [0] = { [0] = 197, [1] = 34 }, [1] = { [0] = 196, [1] = 33 }, [2] = { [0] = 204, [1] = 41 }, [3] = { [0] = 205, [1] = 42 }, [4] = { [0] = 198, [1] = 35 }, [5] = { [0] = 208, [1] = 45 }, [6] = { [0] = 194, [1] = 31 }, [7] = { [0] = 213, [1] = 50 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 30, [1] = 34 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 26, [1] = 30 }, [4] = { [0] = 32, [1] = 36 }, [5] = { [0] = 27, [1] = 31 }, [6] = { [0] = 31, [1] = 35 }, [7] = { [0] = 27, [1] = 31 } })[R[14]][R[13]], ({ [0] = { [0] = 201, [1] = 38 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 205, [1] = 42 }, [3] = { [0] = 205, [1] = 42 }, [4] = { [0] = 206, [1] = 43 }, [5] = { [0] = 214, [1] = 51 }, [6] = { [0] = 202, [1] = 39 }, [7] = { [0] = 200, [1] = 37 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 31, [1] = 35 }, [2] = { [0] = 25, [1] = 29 }, [3] = { [0] = 27, [1] = 31 }, [4] = { [0] = 32, [1] = 36 }, [5] = { [0] = 28, [1] = 32 }, [6] = { [0] = 32, [1] = 36 }, [7] = { [0] = 27, [1] = 31 } })[R[14]][R[13]], ({ [0] = { [0] = 202, [1] = 39 }, [1] = { [0] = 201, [1] = 38 }, [2] = { [0] = 206, [1] = 43 }, [3] = { [0] = 205, [1] = 42 }, [4] = { [0] = 214, [1] = 51 }, [5] = { [0] = 208, [1] = 45 }, [6] = { [0] = 194, [1] = 31 }, [7] = { [0] = 213, [1] = 50 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 31, [1] = 35 }, [2] = { [0] = 26, [1] = 30 }, [3] = { [0] = 28, [1] = 32 }, [4] = { [0] = 33, [1] = 37 }, [5] = { [0] = 28, [1] = 32 }, [6] = { [0] = 32, [1] = 36 }, [7] = { [0] = 28, [1] = 32 } })[R[14]][R[13]], ({ [0] = { [0] = 203, [1] = 40 }, [1] = { [0] = 202, [1] = 39 }, [2] = { [0] = 200, [1] = 37 }, [3] = { [0] = 198, [1] = 35 }, [4] = { [0] = 198, [1] = 35 }, [5] = { [0] = 214, [1] = 51 }, [6] = { [0] = 202, [1] = 39 }, [7] = { [0] = 200, [1] = 37 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 32, [1] = 36 }, [1] = { [0] = 31, [1] = 35 }, [2] = { [0] = 26, [1] = 30 }, [3] = { [0] = 28, [1] = 32 }, [4] = { [0] = 33, [1] = 37 }, [5] = { [0] = 29, [1] = 33 }, [6] = { [0] = 34, [1] = 38 }, [7] = { [0] = 28, [1] = 32 } })[R[14]][R[13]], ({ [0] = { [0] = 204, [1] = 41 }, [1] = { [0] = 203, [1] = 40 }, [2] = { [0] = 206, [1] = 43 }, [3] = { [0] = 205, [1] = 42 }, [4] = { [0] = 206, [1] = 43 }, [5] = { [0] = 208, [1] = 45 }, [6] = { [0] = 196, [1] = 33 }, [7] = { [0] = 213, [1] = 50 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 35, [1] = 39 }, [1] = { [0] = 31, [1] = 35 }, [2] = { [0] = 27, [1] = 31 }, [3] = { [0] = 29, [1] = 33 }, [4] = { [0] = 33, [1] = 37 }, [5] = { [0] = 29, [1] = 33 }, [6] = { [0] = 34, [1] = 38 }, [7] = { [0] = 29, [1] = 33 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 200, [1] = 37 }, [3] = { [0] = 198, [1] = 35 }, [4] = { [0] = 214, [1] = 51 }, [5] = { [0] = 214, [1] = 51 }, [6] = { [0] = 197, [1] = 34 }, [7] = { [0] = 200, [1] = 37 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 36, [1] = 40 }, [1] = { [0] = 31, [1] = 35 }, [2] = { [0] = 27, [1] = 31 }, [3] = { [0] = 30, [1] = 34 }, [4] = { [0] = 34, [1] = 38 }, [5] = { [0] = 30, [1] = 34 }, [6] = { [0] = 34, [1] = 38 }, [7] = { [0] = 29, [1] = 33 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 205, [1] = 42 }, [2] = { [0] = 206, [1] = 43 }, [3] = { [0] = 198, [1] = 35 }, [4] = { [0] = 198, [1] = 35 }, [5] = { [0] = 208, [1] = 45 }, [6] = { [0] = 198, [1] = 35 }, [7] = { [0] = 213, [1] = 50 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 37, [1] = 41 }, [1] = { [0] = 31, [1] = 35 }, [2] = { [0] = 28, [1] = 32 }, [3] = { [0] = 31, [1] = 35 }, [4] = { [0] = 34, [1] = 38 }, [5] = { [0] = 31, [1] = 35 }, [6] = { [0] = 34, [1] = 38 }, [7] = { [0] = 30, [1] = 34 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 206, [1] = 43 }, [2] = { [0] = 200, [1] = 37 }, [3] = { [0] = 198, [1] = 35 }, [4] = { [0] = 199, [1] = 36 }, [5] = { [0] = 208, [1] = 45 }, [6] = { [0] = 199, [1] = 36 }, [7] = { [0] = 200, [1] = 37 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 38, [1] = 42 }, [1] = { [0] = 31, [1] = 35 }, [2] = { [0] = 28, [1] = 32 }, [3] = { [0] = 32, [1] = 36 }, [4] = { [0] = 34, [1] = 38 }, [5] = { [0] = 32, [1] = 36 }, [6] = { [0] = 34, [1] = 38 }, [7] = { [0] = 30, [1] = 34 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 211, [1] = 48 }, [2] = { [0] = 206, [1] = 43 }, [3] = { [0] = 198, [1] = 35 }, [4] = { [0] = 206, [1] = 43 }, [5] = { [0] = 208, [1] = 45 }, [6] = { [0] = 200, [1] = 37 }, [7] = { [0] = 201, [1] = 38 } })[R[14]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 39, [1] = 43 }, [1] = { [0] = 31, [1] = 35 }, [2] = { [0] = 29, [1] = 33 }, [3] = { [0] = 33, [1] = 37 }, [4] = { [0] = 34, [1] = 38 }, [5] = { [0] = 32, [1] = 36 }, [6] = { [0] = 38, [1] = 42 }, [7] = { [0] = 30, [1] = 34 } })[R[14]][R[13]], ({ [0] = { [0] = 199, [1] = 36 }, [1] = { [0] = 212, [1] = 49 }, [2] = { [0] = 200, [1] = 37 }, [3] = { [0] = 198, [1] = 35 }, [4] = { [0] = 214, [1] = 51 }, [5] = { [0] = 209, [1] = 46 }, [6] = { [0] = 202, [1] = 39 }, [7] = { [0] = 202, [1] = 39 } })[R[14]][R[13]] })
  if R[14] == 0 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 45 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 45 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] })
      for i = 1, game.initial_units() do
        R[15] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 42 }, [1] = { [0] = 25, [1] = 29 }, [2] = { [0] = 37, [1] = 41 } })[R[15]][R[13]], ({ [0] = { [0] = 193, [1] = 30 }, [1] = { [0] = 202, [1] = 39 }, [2] = { [0] = 205, [1] = 42 } })[R[15]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[14] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] })
      for i = 1, game.initial_units() do
        R[16] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 26 }, [1] = { [0] = 24, [1] = 28 }, [2] = { [0] = 26, [1] = 30 } })[R[16]][R[13]], ({ [0] = { [0] = 208, [1] = 45 }, [1] = { [0] = 210, [1] = 47 }, [2] = { [0] = 202, [1] = 39 } })[R[16]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[14] == 2 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[17] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 24 }, [1] = { [0] = 25, [1] = 29 }, [2] = { [0] = 38, [1] = 42 } })[R[17]][R[13]], ({ [0] = { [0] = 194, [1] = 31 }, [1] = { [0] = 210, [1] = 47 }, [2] = { [0] = 203, [1] = 40 } })[R[17]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[14] == 3 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 33, [1] = 37 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 38 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 203, [1] = 40 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 33, [1] = 37 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 38 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 201, [1] = 38 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 203, [1] = 40 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] })
      for i = 1, game.initial_units() do
        R[18] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 31, [1] = 35 }, [1] = { [0] = 32, [1] = 36 }, [2] = { [0] = 19, [1] = 23 } })[R[18]][R[13]], ({ [0] = { [0] = 201, [1] = 38 }, [1] = { [0] = 208, [1] = 45 }, [2] = { [0] = 205, [1] = 42 } })[R[18]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[14] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 208, [1] = 45 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 43 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 43 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 203, [1] = 40 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 199, [1] = 36 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 41 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 208, [1] = 45 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 214, [1] = 51 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 43 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 43 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 203, [1] = 40 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      for i = 1, game.initial_units() do
        R[19] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 33, [1] = 37 }, [1] = { [0] = 24, [1] = 28 }, [2] = { [0] = 32, [1] = 36 } })[R[19]][R[13]], ({ [0] = { [0] = 197, [1] = 34 }, [1] = { [0] = 205, [1] = 42 }, [2] = { [0] = 200, [1] = 37 } })[R[19]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[14] == 5 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 32, [1] = 36 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] })
      game.create_tube({ ({ [0] = 32, [1] = 36 })[R[13]], ({ [0] = 211, [1] = 48 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 32, [1] = 36 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] })
      game.create_tube({ ({ [0] = 32, [1] = 36 })[R[13]], ({ [0] = 211, [1] = 48 })[R[13]] })
      for i = 1, game.initial_units() do
        R[20] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32 }, [1] = { [0] = 11, [1] = 15 }, [2] = { [0] = 33, [1] = 37 } })[R[20]][R[13]], ({ [0] = { [0] = 217, [1] = 54 }, [1] = { [0] = 204, [1] = 41 }, [2] = { [0] = 217, [1] = 54 } })[R[20]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[14] == 6 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 39, [1] = 43 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 45 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 39, [1] = 43 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 44 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 45 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] })
      for i = 1, game.initial_units() do
        R[21] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 24 }, [1] = { [0] = 25, [1] = 29 }, [2] = { [0] = 46, [1] = 50 } })[R[21]][R[13]], ({ [0] = { [0] = 192, [1] = 29 }, [1] = { [0] = 190, [1] = 27 }, [2] = { [0] = 205, [1] = 42 } })[R[21]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[14] == 7 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 203, [1] = 40 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 211, [1] = 48 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 212, [1] = 49 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 32, [1] = 36 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 32, [1] = 36 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 33, [1] = 37 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 33, [1] = 37 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 38 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 38 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 203, [1] = 40 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 208, [1] = 45 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] })
      for i = 1, game.initial_units() do
        R[22] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32 }, [1] = { [0] = 34, [1] = 38 }, [2] = { [0] = 22, [1] = 26 } })[R[22]][R[13]], ({ [0] = { [0] = 196, [1] = 33 }, [1] = { [0] = 196, [1] = 33 }, [2] = { [0] = 217, [1] = 54 } })[R[22]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 203, [1] = 40 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 211, [1] = 48 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 212, [1] = 49 })[R[13]] })
      game.create_tube({ ({ [0] = 30, [1] = 34 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 31, [1] = 35 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 32, [1] = 36 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 32, [1] = 36 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 33, [1] = 37 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 33, [1] = 37 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 38 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 38 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 39 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 200, [1] = 37 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 40 })[R[13]], ({ [0] = 213, [1] = 50 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 202, [1] = 39 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 203, [1] = 40 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 204, [1] = 41 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 205, [1] = 42 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 206, [1] = 43 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 207, [1] = 44 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 208, [1] = 45 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 209, [1] = 46 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 42 })[R[13]], ({ [0] = 210, [1] = 47 })[R[13]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[14]", R[14])
  end
  R[23] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 24, [1] = 20 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 34, [1] = 30 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 26, [1] = 22 }, [6] = { [0] = 29, [1] = 25 }, [7] = { [0] = 34, [1] = 30 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 32, [1] = 195 }, [3] = { [0] = 42, [1] = 205 }, [4] = { [0] = 43, [1] = 206 }, [5] = { [0] = 45, [1] = 208 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 44, [1] = 207 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  players[2]:center_view({ ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 24, [1] = 20 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 34, [1] = 30 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 26, [1] = 22 }, [6] = { [0] = 29, [1] = 25 }, [7] = { [0] = 34, [1] = 30 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 32, [1] = 195 }, [3] = { [0] = 42, [1] = 205 }, [4] = { [0] = 43, [1] = 206 }, [5] = { [0] = 45, [1] = 208 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 44, [1] = 207 } })[R[23]][R[13]] })
  U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 34, [1] = 30 }, [2] = { [0] = 23, [1] = 19 }, [3] = { [0] = 42, [1] = 38 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 26, [1] = 22 }, [6] = { [0] = 38, [1] = 34 }, [7] = { [0] = 27, [1] = 23 } })[R[23]][R[13]], ({ [0] = { [0] = 29, [1] = 192 }, [1] = { [0] = 28, [1] = 191 }, [2] = { [0] = 37, [1] = 200 }, [3] = { [0] = 46, [1] = 209 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 51, [1] = 214 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 50, [1] = 213 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  if R[23] == 0 or R[23] == 1 or R[23] == 2 or R[23] == 5 or R[23] == 6 or R[23] == 7 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 48, [1] = 44 }, [1] = { [0] = 35, [1] = 31 }, [2] = { [0] = 26, [1] = 22 }, [5] = { [0] = 36, [1] = 32 }, [6] = { [0] = 39, [1] = 35 }, [7] = { [0] = 27, [1] = 23 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 35, [1] = 198 }, [2] = { [0] = 43, [1] = 206 }, [5] = { [0] = 50, [1] = 213 }, [6] = { [0] = 39, [1] = 202 }, [7] = { [0] = 37, [1] = 200 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    if R[23] == 0 then
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
    elseif R[23] == 1 then
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
    elseif R[23] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 36, [1] = 32 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 36, [1] = 32 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 36, [1] = 32 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 47, [1] = 43 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 47, [1] = 43 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 47, [1] = 43 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[23] == 7 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[23]", R[23])
    end
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 25, [1] = 21 }, [1] = { [0] = 35, [1] = 31 }, [2] = { [0] = 35, [1] = 31 }, [5] = { [0] = 26, [1] = 22 }, [6] = { [0] = 30, [1] = 26 }, [7] = { [0] = 43, [1] = 39 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 45, [1] = 208 }, [2] = { [0] = 43, [1] = 206 }, [5] = { [0] = 38, [1] = 201 }, [6] = { [0] = 39, [1] = 202 }, [7] = { [0] = 49, [1] = 212 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    if R[23] == 2 or R[23] == 5 or R[23] == 6 or R[23] == 7 then
    elseif R[23] == 0 or R[23] == 1 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 34, [1] = 30 } })[R[23]][R[13]], ({ [0] = { [0] = 43, [1] = 206 }, [1] = { [0] = 53, [1] = 216 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[23]", R[23])
    end
  elseif R[23] == 3 or R[23] == 4 then
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 26, [1] = 22 }, [4] = { [0] = 33, [1] = 29 } })[R[23]][R[13]], ({ [3] = { [0] = 46, [1] = 209 }, [4] = { [0] = 35, [1] = 198 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    if R[23] == 3 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 29, [1] = 25 })[R[13]], ({ [0] = 35, [1] = 198 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 35, [1] = 198 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[23] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 47, [1] = 210 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
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
    else
      unseen("R[23]", R[23])
    end
  else
    unseen("R[23]", R[23])
  end
  U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 25, [1] = 21 }, [1] = { [0] = 25, [1] = 21 }, [2] = { [0] = 43, [1] = 39 }, [3] = { [0] = 35, [1] = 31 }, [4] = { [0] = 25, [1] = 21 }, [5] = { [0] = 16, [1] = 12 }, [6] = { [0] = 22, [1] = 18 }, [7] = { [0] = 35, [1] = 31 } })[R[23]][R[13]], ({ [0] = { [0] = 45, [1] = 208 }, [1] = { [0] = 50, [1] = 213 }, [2] = { [0] = 37, [1] = 200 }, [3] = { [0] = 29, [1] = 192 }, [4] = { [0] = 39, [1] = 202 }, [5] = { [0] = 45, [1] = 208 }, [6] = { [0] = 39, [1] = 202 }, [7] = { [0] = 53, [1] = 216 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 28 }, [1] = { [0] = 24, [1] = 20 }, [2] = { [0] = 39, [1] = 35 }, [3] = { [0] = 24, [1] = 20 }, [4] = { [0] = 43, [1] = 39 }, [5] = { [0] = 34, [1] = 30 }, [6] = { [0] = 29, [1] = 25 }, [7] = { [0] = 45, [1] = 41 } })[R[23]][R[13]], ({ [0] = { [0] = 32, [1] = 195 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 41, [1] = 204 }, [3] = { [0] = 36, [1] = 199 }, [4] = { [0] = 43, [1] = 206 }, [5] = { [0] = 36, [1] = 199 }, [6] = { [0] = 44, [1] = 207 }, [7] = { [0] = 44, [1] = 207 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 26 }, [1] = { [0] = 24, [1] = 20 }, [2] = { [0] = 39, [1] = 35 }, [3] = { [0] = 27, [1] = 23 }, [4] = { [0] = 45, [1] = 41 }, [5] = { [0] = 34, [1] = 30 }, [6] = { [0] = 27, [1] = 23 }, [7] = { [0] = 45, [1] = 41 } })[R[23]][R[13]], ({ [0] = { [0] = 32, [1] = 195 }, [1] = { [0] = 34, [1] = 197 }, [2] = { [0] = 39, [1] = 202 }, [3] = { [0] = 32, [1] = 195 }, [4] = { [0] = 43, [1] = 206 }, [5] = { [0] = 38, [1] = 201 }, [6] = { [0] = 44, [1] = 207 }, [7] = { [0] = 46, [1] = 209 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if LEVEL_OF[players[2].difficulty] == 0 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 37 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 21, [1] = 17 }, [3] = { [0] = 44, [1] = 40 }, [4] = { [0] = 37, [1] = 33 }, [5] = { [0] = 22, [1] = 18 }, [6] = { [0] = 42, [1] = 38 }, [7] = { [0] = 44, [1] = 40 } })[R[23]][R[13]], ({ [0] = { [0] = 38, [1] = 201 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 42, [1] = 205 }, [3] = { [0] = 36, [1] = 199 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 46, [1] = 209 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 38, [1] = 201 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 37 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 21, [1] = 17 }, [3] = { [0] = 42, [1] = 38 }, [4] = { [0] = 37, [1] = 33 }, [5] = { [0] = 22, [1] = 18 }, [6] = { [0] = 42, [1] = 38 }, [7] = { [0] = 44, [1] = 40 } })[R[23]][R[13]], ({ [0] = { [0] = 38, [1] = 201 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 42, [1] = 205 }, [3] = { [0] = 32, [1] = 195 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 46, [1] = 209 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 38, [1] = 201 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 30, [1] = 26 }, [1] = { [0] = 24, [1] = 20 }, [2] = { [0] = 39, [1] = 35 }, [3] = { [0] = 30, [1] = 26 }, [4] = { [0] = 45, [1] = 41 }, [5] = { [0] = 34, [1] = 30 }, [6] = { [0] = 27, [1] = 23 }, [7] = { [0] = 45, [1] = 41 } })[R[23]][R[13]], ({ [0] = { [0] = 32, [1] = 195 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 39, [1] = 202 }, [3] = { [0] = 47, [1] = 210 }, [4] = { [0] = 43, [1] = 206 }, [5] = { [0] = 38, [1] = 201 }, [6] = { [0] = 44, [1] = 207 }, [7] = { [0] = 46, [1] = 209 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 30, [1] = 26 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 39, [1] = 35 }, [3] = { [0] = 30, [1] = 26 }, [4] = { [0] = 45, [1] = 41 }, [5] = { [0] = 34, [1] = 30 }, [6] = { [0] = 27, [1] = 23 }, [7] = { [0] = 45, [1] = 41 } })[R[23]][R[13]], ({ [0] = { [0] = 32, [1] = 195 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 39, [1] = 202 }, [3] = { [0] = 47, [1] = 210 }, [4] = { [0] = 43, [1] = 206 }, [5] = { [0] = 38, [1] = 201 }, [6] = { [0] = 44, [1] = 207 }, [7] = { [0] = 46, [1] = 209 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 37 }, [1] = { [0] = 24, [1] = 20 }, [2] = { [0] = 21, [1] = 17 }, [3] = { [0] = 24, [1] = 20 }, [4] = { [0] = 37, [1] = 33 }, [5] = { [0] = 22, [1] = 18 }, [6] = { [0] = 42, [1] = 38 }, [7] = { [0] = 44, [1] = 40 } })[R[23]][R[13]], ({ [0] = { [0] = 38, [1] = 201 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 42, [1] = 205 }, [3] = { [0] = 36, [1] = 199 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 46, [1] = 209 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 38, [1] = 201 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 27, [1] = 23 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 39, [1] = 35 }, [3] = { [0] = 24, [1] = 20 }, [4] = { [0] = 38, [1] = 34 }, [5] = { [0] = 21, [1] = 17 }, [6] = { [0] = 34, [1] = 30 }, [7] = { [0] = 29, [1] = 25 } })[R[23]][R[13]], ({ [0] = { [0] = 32, [1] = 195 }, [1] = { [0] = 30, [1] = 193 }, [2] = { [0] = 45, [1] = 208 }, [3] = { [0] = 36, [1] = 199 }, [4] = { [0] = 47, [1] = 210 }, [5] = { [0] = 35, [1] = 198 }, [6] = { [0] = 41, [1] = 204 }, [7] = { [0] = 44, [1] = 207 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 27, [1] = 23 }, [1] = { [0] = 30, [1] = 26 }, [2] = { [0] = 35, [1] = 31 }, [3] = { [0] = 30, [1] = 26 }, [4] = { [0] = 40, [1] = 36 }, [5] = { [0] = 30, [1] = 26 }, [6] = { [0] = 43, [1] = 39 }, [7] = { [0] = 24, [1] = 20 } })[R[23]][R[13]], ({ [0] = { [0] = 29, [1] = 192 }, [1] = { [0] = 27, [1] = 190 }, [2] = { [0] = 46, [1] = 209 }, [3] = { [0] = 47, [1] = 210 }, [4] = { [0] = 38, [1] = 201 }, [5] = { [0] = 43, [1] = 206 }, [6] = { [0] = 38, [1] = 201 }, [7] = { [0] = 41, [1] = 204 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[2].difficulty] == 2 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 37 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 21, [1] = 17 }, [3] = { [0] = 44, [1] = 40 }, [4] = { [0] = 37, [1] = 33 }, [5] = { [0] = 22, [1] = 18 }, [6] = { [0] = 42, [1] = 38 }, [7] = { [0] = 44, [1] = 40 } })[R[23]][R[13]], ({ [0] = { [0] = 38, [1] = 201 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 42, [1] = 205 }, [3] = { [0] = 36, [1] = 199 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 46, [1] = 209 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 38, [1] = 201 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 37 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 21, [1] = 17 }, [3] = { [0] = 42, [1] = 38 }, [4] = { [0] = 37, [1] = 33 }, [5] = { [0] = 22, [1] = 18 }, [6] = { [0] = 42, [1] = 38 }, [7] = { [0] = 44, [1] = 40 } })[R[23]][R[13]], ({ [0] = { [0] = 38, [1] = 201 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 42, [1] = 205 }, [3] = { [0] = 32, [1] = 195 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 46, [1] = 209 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 38, [1] = 201 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 27, [1] = 23 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 39, [1] = 35 }, [3] = { [0] = 30, [1] = 26 }, [4] = { [0] = 38, [1] = 34 }, [5] = { [0] = 21, [1] = 17 }, [6] = { [0] = 34, [1] = 30 }, [7] = { [0] = 29, [1] = 25 } })[R[23]][R[13]], ({ [0] = { [0] = 32, [1] = 195 }, [1] = { [0] = 30, [1] = 193 }, [2] = { [0] = 45, [1] = 208 }, [3] = { [0] = 47, [1] = 210 }, [4] = { [0] = 47, [1] = 210 }, [5] = { [0] = 35, [1] = 198 }, [6] = { [0] = 41, [1] = 204 }, [7] = { [0] = 44, [1] = 207 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 27, [1] = 23 }, [1] = { [0] = 30, [1] = 26 }, [2] = { [0] = 35, [1] = 31 }, [3] = { [0] = 30, [1] = 26 }, [4] = { [0] = 40, [1] = 36 }, [5] = { [0] = 30, [1] = 26 }, [6] = { [0] = 43, [1] = 39 }, [7] = { [0] = 24, [1] = 20 } })[R[23]][R[13]], ({ [0] = { [0] = 29, [1] = 192 }, [1] = { [0] = 27, [1] = 190 }, [2] = { [0] = 46, [1] = 209 }, [3] = { [0] = 47, [1] = 210 }, [4] = { [0] = 38, [1] = 201 }, [5] = { [0] = 43, [1] = 206 }, [6] = { [0] = 38, [1] = 201 }, [7] = { [0] = 41, [1] = 204 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[2].difficulty] == 1 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 37 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 21, [1] = 17 }, [3] = { [0] = 44, [1] = 40 }, [4] = { [0] = 37, [1] = 33 }, [5] = { [0] = 22, [1] = 18 }, [6] = { [0] = 42, [1] = 38 }, [7] = { [0] = 44, [1] = 40 } })[R[23]][R[13]], ({ [0] = { [0] = 38, [1] = 201 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 42, [1] = 205 }, [3] = { [0] = 36, [1] = 199 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 46, [1] = 209 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 38, [1] = 201 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 41, [1] = 37 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 21, [1] = 17 }, [3] = { [0] = 42, [1] = 38 }, [4] = { [0] = 37, [1] = 33 }, [5] = { [0] = 22, [1] = 18 }, [6] = { [0] = 42, [1] = 38 }, [7] = { [0] = 44, [1] = 40 } })[R[23]][R[13]], ({ [0] = { [0] = 38, [1] = 201 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 42, [1] = 205 }, [3] = { [0] = 32, [1] = 195 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 46, [1] = 209 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 38, [1] = 201 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 30, [1] = 26 }, [1] = { [0] = 24, [1] = 20 }, [2] = { [0] = 39, [1] = 35 }, [3] = { [0] = 30, [1] = 26 }, [4] = { [0] = 45, [1] = 41 }, [5] = { [0] = 34, [1] = 30 }, [6] = { [0] = 27, [1] = 23 }, [7] = { [0] = 45, [1] = 41 } })[R[23]][R[13]], ({ [0] = { [0] = 32, [1] = 195 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 39, [1] = 202 }, [3] = { [0] = 47, [1] = 210 }, [4] = { [0] = 43, [1] = 206 }, [5] = { [0] = 38, [1] = 201 }, [6] = { [0] = 44, [1] = 207 }, [7] = { [0] = 46, [1] = 209 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 41, [1] = 37 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 21, [1] = 17 }, [3] = { [0] = 30, [1] = 26 }, [4] = { [0] = 37, [1] = 33 }, [5] = { [0] = 22, [1] = 18 }, [6] = { [0] = 42, [1] = 38 }, [7] = { [0] = 44, [1] = 40 } })[R[23]][R[13]], ({ [0] = { [0] = 38, [1] = 201 }, [1] = { [0] = 36, [1] = 199 }, [2] = { [0] = 42, [1] = 205 }, [3] = { [0] = 47, [1] = 210 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 46, [1] = 209 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 38, [1] = 201 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 27, [1] = 23 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 39, [1] = 35 }, [3] = { [0] = 24, [1] = 20 }, [4] = { [0] = 38, [1] = 34 }, [5] = { [0] = 21, [1] = 17 }, [6] = { [0] = 34, [1] = 30 }, [7] = { [0] = 29, [1] = 25 } })[R[23]][R[13]], ({ [0] = { [0] = 32, [1] = 195 }, [1] = { [0] = 30, [1] = 193 }, [2] = { [0] = 45, [1] = 208 }, [3] = { [0] = 36, [1] = 199 }, [4] = { [0] = 47, [1] = 210 }, [5] = { [0] = 35, [1] = 198 }, [6] = { [0] = 41, [1] = 204 }, [7] = { [0] = 44, [1] = 207 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[23]], player = players[2], at = { ({ [0] = { [0] = 27, [1] = 23 }, [1] = { [0] = 30, [1] = 26 }, [2] = { [0] = 35, [1] = 31 }, [3] = { [0] = 30, [1] = 26 }, [4] = { [0] = 40, [1] = 36 }, [5] = { [0] = 30, [1] = 26 }, [6] = { [0] = 43, [1] = 39 }, [7] = { [0] = 24, [1] = 20 } })[R[23]][R[13]], ({ [0] = { [0] = 29, [1] = 192 }, [1] = { [0] = 27, [1] = 190 }, [2] = { [0] = 46, [1] = 209 }, [3] = { [0] = 47, [1] = 210 }, [4] = { [0] = 38, [1] = 201 }, [5] = { [0] = 43, [1] = 206 }, [6] = { [0] = 38, [1] = 201 }, [7] = { [0] = 41, [1] = 204 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 48, [1] = 44 }, [1] = { [0] = 33, [1] = 29 }, [2] = { [0] = 31, [1] = 27 }, [3] = { [0] = 34, [1] = 30 }, [4] = { [0] = 46, [1] = 42 }, [5] = { [0] = 22, [1] = 18 }, [6] = { [0] = 43, [1] = 39 }, [7] = { [0] = 38, [1] = 34 } })[R[23]][R[13]], ({ [0] = { [0] = 40, [1] = 203 }, [1] = { [0] = 40, [1] = 203 }, [2] = { [0] = 39, [1] = 202 }, [3] = { [0] = 33, [1] = 196 }, [4] = { [0] = 34, [1] = 197 }, [5] = { [0] = 52, [1] = 215 }, [6] = { [0] = 41, [1] = 204 }, [7] = { [0] = 43, [1] = 206 } })[R[23]][R[13]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  game.create_tube({ ({ [0] = { [0] = 28, [1] = 24 }, [1] = { [0] = 27, [1] = 23 }, [2] = { [0] = 26, [1] = 22 }, [3] = { [0] = 26, [1] = 22 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 26, [1] = 22 }, [6] = { [0] = 29, [1] = 25 }, [7] = { [0] = 27, [1] = 23 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 37, [1] = 200 }, [3] = { [0] = 42, [1] = 205 }, [4] = { [0] = 37, [1] = 200 }, [5] = { [0] = 41, [1] = 204 }, [6] = { [0] = 33, [1] = 196 }, [7] = { [0] = 40, [1] = 203 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 29, [1] = 25 }, [1] = { [0] = 28, [1] = 24 }, [2] = { [0] = 27, [1] = 23 }, [3] = { [0] = 26, [1] = 22 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 26, [1] = 22 }, [6] = { [0] = 29, [1] = 25 }, [7] = { [0] = 27, [1] = 23 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 37, [1] = 200 }, [3] = { [0] = 43, [1] = 206 }, [4] = { [0] = 38, [1] = 201 }, [5] = { [0] = 42, [1] = 205 }, [6] = { [0] = 34, [1] = 197 }, [7] = { [0] = 41, [1] = 204 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 30, [1] = 26 }, [1] = { [0] = 29, [1] = 25 }, [2] = { [0] = 28, [1] = 24 }, [3] = { [0] = 26, [1] = 22 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 26, [1] = 22 }, [6] = { [0] = 29, [1] = 25 }, [7] = { [0] = 27, [1] = 23 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 37, [1] = 200 }, [3] = { [0] = 44, [1] = 207 }, [4] = { [0] = 39, [1] = 202 }, [5] = { [0] = 43, [1] = 206 }, [6] = { [0] = 35, [1] = 198 }, [7] = { [0] = 42, [1] = 205 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 31, [1] = 27 }, [1] = { [0] = 30, [1] = 26 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 27, [1] = 23 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 26, [1] = 22 }, [6] = { [0] = 29, [1] = 25 }, [7] = { [0] = 27, [1] = 23 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 34, [1] = 197 }, [3] = { [0] = 42, [1] = 205 }, [4] = { [0] = 40, [1] = 203 }, [5] = { [0] = 47, [1] = 210 }, [6] = { [0] = 36, [1] = 199 }, [7] = { [0] = 43, [1] = 206 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 32, [1] = 28 }, [1] = { [0] = 31, [1] = 27 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 28, [1] = 24 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 26, [1] = 22 }, [6] = { [0] = 29, [1] = 25 }, [7] = { [0] = 27, [1] = 23 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 35, [1] = 198 }, [3] = { [0] = 38, [1] = 201 }, [4] = { [0] = 41, [1] = 204 }, [5] = { [0] = 48, [1] = 211 }, [6] = { [0] = 37, [1] = 200 }, [7] = { [0] = 44, [1] = 207 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 33, [1] = 29 }, [1] = { [0] = 32, [1] = 28 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 28, [1] = 24 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 26, [1] = 22 }, [6] = { [0] = 32, [1] = 28 }, [7] = { [0] = 27, [1] = 23 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 36, [1] = 199 }, [3] = { [0] = 39, [1] = 202 }, [4] = { [0] = 45, [1] = 208 }, [5] = { [0] = 49, [1] = 212 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 45, [1] = 208 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 34, [1] = 30 }, [1] = { [0] = 33, [1] = 29 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 28, [1] = 24 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 29, [1] = 25 }, [6] = { [0] = 33, [1] = 29 }, [7] = { [0] = 27, [1] = 23 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 37, [1] = 200 }, [3] = { [0] = 40, [1] = 203 }, [4] = { [0] = 46, [1] = 209 }, [5] = { [0] = 45, [1] = 208 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 46, [1] = 209 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 34, [1] = 30 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 28, [1] = 24 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 29, [1] = 25 }, [6] = { [0] = 33, [1] = 29 }, [7] = { [0] = 27, [1] = 23 } })[R[23]][R[13]], ({ [0] = { [0] = 31, [1] = 194 }, [1] = { [0] = 30, [1] = 193 }, [2] = { [0] = 38, [1] = 201 }, [3] = { [0] = 41, [1] = 204 }, [4] = { [0] = 47, [1] = 210 }, [5] = { [0] = 51, [1] = 214 }, [6] = { [0] = 39, [1] = 202 }, [7] = { [0] = 47, [1] = 210 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 34, [1] = 30 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 28, [1] = 24 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 30, [1] = 26 }, [6] = { [0] = 34, [1] = 30 }, [7] = { [0] = 27, [1] = 23 } })[R[23]][R[13]], ({ [0] = { [0] = 32, [1] = 195 }, [1] = { [0] = 31, [1] = 194 }, [2] = { [0] = 39, [1] = 202 }, [3] = { [0] = 42, [1] = 205 }, [4] = { [0] = 48, [1] = 211 }, [5] = { [0] = 45, [1] = 208 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 48, [1] = 211 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 34, [1] = 30 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 29, [1] = 25 }, [4] = { [0] = 33, [1] = 29 }, [5] = { [0] = 30, [1] = 26 }, [6] = { [0] = 34, [1] = 30 }, [7] = { [0] = 30, [1] = 26 } })[R[23]][R[13]], ({ [0] = { [0] = 33, [1] = 196 }, [1] = { [0] = 32, [1] = 195 }, [2] = { [0] = 40, [1] = 203 }, [3] = { [0] = 38, [1] = 201 }, [4] = { [0] = 49, [1] = 212 }, [5] = { [0] = 51, [1] = 214 }, [6] = { [0] = 39, [1] = 202 }, [7] = { [0] = 37, [1] = 200 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 34, [1] = 30 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 29, [1] = 25 }, [4] = { [0] = 36, [1] = 32 }, [5] = { [0] = 31, [1] = 27 }, [6] = { [0] = 35, [1] = 31 }, [7] = { [0] = 30, [1] = 26 } })[R[23]][R[13]], ({ [0] = { [0] = 34, [1] = 197 }, [1] = { [0] = 33, [1] = 196 }, [2] = { [0] = 41, [1] = 204 }, [3] = { [0] = 42, [1] = 205 }, [4] = { [0] = 35, [1] = 198 }, [5] = { [0] = 45, [1] = 208 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 50, [1] = 213 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 34, [1] = 30 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 30, [1] = 26 }, [4] = { [0] = 36, [1] = 32 }, [5] = { [0] = 31, [1] = 27 }, [6] = { [0] = 35, [1] = 31 }, [7] = { [0] = 31, [1] = 27 } })[R[23]][R[13]], ({ [0] = { [0] = 38, [1] = 201 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 42, [1] = 205 }, [3] = { [0] = 42, [1] = 205 }, [4] = { [0] = 43, [1] = 206 }, [5] = { [0] = 51, [1] = 214 }, [6] = { [0] = 39, [1] = 202 }, [7] = { [0] = 37, [1] = 200 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 35, [1] = 31 }, [2] = { [0] = 29, [1] = 25 }, [3] = { [0] = 31, [1] = 27 }, [4] = { [0] = 36, [1] = 32 }, [5] = { [0] = 32, [1] = 28 }, [6] = { [0] = 36, [1] = 32 }, [7] = { [0] = 31, [1] = 27 } })[R[23]][R[13]], ({ [0] = { [0] = 39, [1] = 202 }, [1] = { [0] = 38, [1] = 201 }, [2] = { [0] = 43, [1] = 206 }, [3] = { [0] = 42, [1] = 205 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 45, [1] = 208 }, [6] = { [0] = 31, [1] = 194 }, [7] = { [0] = 50, [1] = 213 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 35, [1] = 31 }, [2] = { [0] = 30, [1] = 26 }, [3] = { [0] = 32, [1] = 28 }, [4] = { [0] = 37, [1] = 33 }, [5] = { [0] = 32, [1] = 28 }, [6] = { [0] = 36, [1] = 32 }, [7] = { [0] = 32, [1] = 28 } })[R[23]][R[13]], ({ [0] = { [0] = 40, [1] = 203 }, [1] = { [0] = 39, [1] = 202 }, [2] = { [0] = 37, [1] = 200 }, [3] = { [0] = 35, [1] = 198 }, [4] = { [0] = 35, [1] = 198 }, [5] = { [0] = 51, [1] = 214 }, [6] = { [0] = 39, [1] = 202 }, [7] = { [0] = 37, [1] = 200 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 36, [1] = 32 }, [1] = { [0] = 35, [1] = 31 }, [2] = { [0] = 30, [1] = 26 }, [3] = { [0] = 32, [1] = 28 }, [4] = { [0] = 37, [1] = 33 }, [5] = { [0] = 33, [1] = 29 }, [6] = { [0] = 38, [1] = 34 }, [7] = { [0] = 32, [1] = 28 } })[R[23]][R[13]], ({ [0] = { [0] = 41, [1] = 204 }, [1] = { [0] = 40, [1] = 203 }, [2] = { [0] = 43, [1] = 206 }, [3] = { [0] = 42, [1] = 205 }, [4] = { [0] = 43, [1] = 206 }, [5] = { [0] = 45, [1] = 208 }, [6] = { [0] = 33, [1] = 196 }, [7] = { [0] = 50, [1] = 213 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 39, [1] = 35 }, [1] = { [0] = 35, [1] = 31 }, [2] = { [0] = 31, [1] = 27 }, [3] = { [0] = 33, [1] = 29 }, [4] = { [0] = 37, [1] = 33 }, [5] = { [0] = 33, [1] = 29 }, [6] = { [0] = 38, [1] = 34 }, [7] = { [0] = 33, [1] = 29 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 37, [1] = 200 }, [3] = { [0] = 35, [1] = 198 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 51, [1] = 214 }, [6] = { [0] = 34, [1] = 197 }, [7] = { [0] = 37, [1] = 200 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 40, [1] = 36 }, [1] = { [0] = 35, [1] = 31 }, [2] = { [0] = 31, [1] = 27 }, [3] = { [0] = 34, [1] = 30 }, [4] = { [0] = 38, [1] = 34 }, [5] = { [0] = 34, [1] = 30 }, [6] = { [0] = 38, [1] = 34 }, [7] = { [0] = 33, [1] = 29 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 42, [1] = 205 }, [2] = { [0] = 43, [1] = 206 }, [3] = { [0] = 35, [1] = 198 }, [4] = { [0] = 35, [1] = 198 }, [5] = { [0] = 45, [1] = 208 }, [6] = { [0] = 35, [1] = 198 }, [7] = { [0] = 50, [1] = 213 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 41, [1] = 37 }, [1] = { [0] = 35, [1] = 31 }, [2] = { [0] = 32, [1] = 28 }, [3] = { [0] = 35, [1] = 31 }, [4] = { [0] = 38, [1] = 34 }, [5] = { [0] = 35, [1] = 31 }, [6] = { [0] = 38, [1] = 34 }, [7] = { [0] = 34, [1] = 30 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 43, [1] = 206 }, [2] = { [0] = 37, [1] = 200 }, [3] = { [0] = 35, [1] = 198 }, [4] = { [0] = 36, [1] = 199 }, [5] = { [0] = 45, [1] = 208 }, [6] = { [0] = 36, [1] = 199 }, [7] = { [0] = 37, [1] = 200 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 42, [1] = 38 }, [1] = { [0] = 35, [1] = 31 }, [2] = { [0] = 32, [1] = 28 }, [3] = { [0] = 36, [1] = 32 }, [4] = { [0] = 38, [1] = 34 }, [5] = { [0] = 36, [1] = 32 }, [6] = { [0] = 38, [1] = 34 }, [7] = { [0] = 34, [1] = 30 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 48, [1] = 211 }, [2] = { [0] = 43, [1] = 206 }, [3] = { [0] = 35, [1] = 198 }, [4] = { [0] = 43, [1] = 206 }, [5] = { [0] = 45, [1] = 208 }, [6] = { [0] = 37, [1] = 200 }, [7] = { [0] = 38, [1] = 201 } })[R[23]][R[13]] })
  game.create_tube({ ({ [0] = { [0] = 43, [1] = 39 }, [1] = { [0] = 35, [1] = 31 }, [2] = { [0] = 33, [1] = 29 }, [3] = { [0] = 37, [1] = 33 }, [4] = { [0] = 38, [1] = 34 }, [5] = { [0] = 36, [1] = 32 }, [6] = { [0] = 42, [1] = 38 }, [7] = { [0] = 34, [1] = 30 } })[R[23]][R[13]], ({ [0] = { [0] = 36, [1] = 199 }, [1] = { [0] = 49, [1] = 212 }, [2] = { [0] = 37, [1] = 200 }, [3] = { [0] = 35, [1] = 198 }, [4] = { [0] = 51, [1] = 214 }, [5] = { [0] = 46, [1] = 209 }, [6] = { [0] = 39, [1] = 202 }, [7] = { [0] = 39, [1] = 202 } })[R[23]][R[13]] })
  if R[23] == 0 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 36, [1] = 199 })[R[13]] })
      game.create_tube({ ({ [0] = 45, [1] = 41 })[R[13]], ({ [0] = 36, [1] = 199 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 36, [1] = 199 })[R[13]] })
      game.create_tube({ ({ [0] = 45, [1] = 41 })[R[13]], ({ [0] = 36, [1] = 199 })[R[13]] })
      for i = 1, game.initial_units() do
        R[24] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 38 }, [1] = { [0] = 29, [1] = 25 }, [2] = { [0] = 41, [1] = 37 } })[R[24]][R[13]], ({ [0] = { [0] = 30, [1] = 193 }, [1] = { [0] = 39, [1] = 202 }, [2] = { [0] = 42, [1] = 205 } })[R[24]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[23] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 51, [1] = 214 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 51, [1] = 214 })[R[13]] })
      for i = 1, game.initial_units() do
        R[25] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 22 }, [1] = { [0] = 28, [1] = 24 }, [2] = { [0] = 30, [1] = 26 } })[R[25]][R[13]], ({ [0] = { [0] = 45, [1] = 208 }, [1] = { [0] = 47, [1] = 210 }, [2] = { [0] = 39, [1] = 202 } })[R[25]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[23] == 2 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[26] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 20 }, [1] = { [0] = 29, [1] = 25 }, [2] = { [0] = 42, [1] = 38 } })[R[26]][R[13]], ({ [0] = { [0] = 31, [1] = 194 }, [1] = { [0] = 47, [1] = 210 }, [2] = { [0] = 40, [1] = 203 } })[R[26]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[23] == 3 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 37, [1] = 33 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 34 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 38, [1] = 201 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 38, [1] = 201 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 40, [1] = 203 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 41, [1] = 204 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 44, [1] = 207 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 37, [1] = 33 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 34 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 38, [1] = 201 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 38, [1] = 201 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 40, [1] = 203 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 41, [1] = 204 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 44, [1] = 207 })[R[13]] })
      for i = 1, game.initial_units() do
        R[27] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 35, [1] = 31 }, [1] = { [0] = 36, [1] = 32 }, [2] = { [0] = 23, [1] = 19 } })[R[27]][R[13]], ({ [0] = { [0] = 38, [1] = 201 }, [1] = { [0] = 45, [1] = 208 }, [2] = { [0] = 42, [1] = 205 } })[R[27]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[23] == 4 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 36, [1] = 199 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 51, [1] = 214 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 51, [1] = 214 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 51, [1] = 214 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 44, [1] = 207 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 45, [1] = 208 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 51, [1] = 214 })[R[13]] })
      game.create_tube({ ({ [0] = 43, [1] = 39 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 43, [1] = 39 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 40, [1] = 203 })[R[13]] })
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 41, [1] = 204 })[R[13]] })
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      for i = 1, game.initial_units() do
        R[28] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 37, [1] = 33 }, [1] = { [0] = 28, [1] = 24 }, [2] = { [0] = 36, [1] = 32 } })[R[28]][R[13]], ({ [0] = { [0] = 34, [1] = 197 }, [1] = { [0] = 42, [1] = 205 }, [2] = { [0] = 37, [1] = 200 } })[R[28]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 36, [1] = 199 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 51, [1] = 214 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 51, [1] = 214 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 41, [1] = 37 })[R[13]], ({ [0] = 51, [1] = 214 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 44, [1] = 207 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 45, [1] = 208 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 51, [1] = 214 })[R[13]] })
      game.create_tube({ ({ [0] = 43, [1] = 39 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 43, [1] = 39 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 40, [1] = 203 })[R[13]] })
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 41, [1] = 204 })[R[13]] })
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[23] == 5 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 36, [1] = 32 })[R[13]], ({ [0] = 47, [1] = 210 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 32 })[R[13]], ({ [0] = 48, [1] = 211 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 36, [1] = 32 })[R[13]], ({ [0] = 47, [1] = 210 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 32 })[R[13]], ({ [0] = 48, [1] = 211 })[R[13]] })
      for i = 1, game.initial_units() do
        R[29] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 28 }, [1] = { [0] = 15, [1] = 11 }, [2] = { [0] = 37, [1] = 33 } })[R[29]][R[13]], ({ [0] = { [0] = 54, [1] = 217 }, [1] = { [0] = 41, [1] = 204 }, [2] = { [0] = 54, [1] = 217 } })[R[29]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[23] == 6 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 43, [1] = 39 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] })
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] })
      game.create_tube({ ({ [0] = 45, [1] = 41 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 43, [1] = 39 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] })
      game.create_tube({ ({ [0] = 44, [1] = 40 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] })
      game.create_tube({ ({ [0] = 45, [1] = 41 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] })
      for i = 1, game.initial_units() do
        R[30] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 20 }, [1] = { [0] = 29, [1] = 25 }, [2] = { [0] = 50, [1] = 46 } })[R[30]][R[13]], ({ [0] = { [0] = 29, [1] = 192 }, [1] = { [0] = 27, [1] = 190 }, [2] = { [0] = 42, [1] = 205 } })[R[30]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[23] == 7 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 40, [1] = 203 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 41, [1] = 204 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 46, [1] = 209 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 47, [1] = 210 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 48, [1] = 211 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 49, [1] = 212 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 32 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 32 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 33 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 33 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 34 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 34 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 40, [1] = 203 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 41, [1] = 204 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 44, [1] = 207 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 45, [1] = 208 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 46, [1] = 209 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 47, [1] = 210 })[R[13]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 40, [1] = 203 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 41, [1] = 204 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 46, [1] = 209 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 47, [1] = 210 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 48, [1] = 211 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 49, [1] = 212 })[R[13]] })
      game.create_tube({ ({ [0] = 34, [1] = 30 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 35, [1] = 31 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 32 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 36, [1] = 32 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 33 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 37, [1] = 33 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 34 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 38, [1] = 34 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 39, [1] = 35 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 37, [1] = 200 })[R[13]] })
      game.create_tube({ ({ [0] = 40, [1] = 36 })[R[13]], ({ [0] = 50, [1] = 213 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 39, [1] = 202 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 40, [1] = 203 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 41, [1] = 204 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 42, [1] = 205 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 43, [1] = 206 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 44, [1] = 207 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 45, [1] = 208 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 46, [1] = 209 })[R[13]] })
      game.create_tube({ ({ [0] = 42, [1] = 38 })[R[13]], ({ [0] = 47, [1] = 210 })[R[13]] })
      for i = 1, game.initial_units() do
        R[31] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 28 }, [1] = { [0] = 38, [1] = 34 }, [2] = { [0] = 26, [1] = 22 } })[R[31]][R[13]], ({ [0] = { [0] = 33, [1] = 196 }, [1] = { [0] = 33, [1] = 196 }, [2] = { [0] = 54, [1] = 217 } })[R[31]][R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[23]", R[23])
  end
  players[1]:mark_research(3303)
  players[1].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[1].difficulty]]
  players[1].scientists = 16 - 3 * LEVEL_OF[players[1].difficulty]
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
  players[2].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[2].difficulty]]
  players[2].scientists = 16 - 3 * LEVEL_OF[players[2].difficulty]
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

  -- The win.
  local t4 = trigger.midas{time = 25000}
  mission.victory(t4, "Have the most ore in storage at Mark 250", {one_shot = true})
  if game.disasters_enabled() then
    trigger.time{min = 6000, max = 24000, one_shot = false, on = Storm}  -- after 60 to 240 marks
    trigger.time{min = 24000, max = 54000, one_shot = false, on = Meteor}  -- after 240 to 540 marks
  end
  return true
end
