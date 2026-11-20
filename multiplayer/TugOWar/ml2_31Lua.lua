-- ml2_31Lua.lua  -  2 Player, LastOne, 'Tug-O-War' map. (Lua)
--
-- Converted by op2dll from ml2_31.dll ("2 Player, LastOne, 'Tug-O-War' map."): its setup replayed. `on_init` makes the original's
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

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local DoDisaster

function DoDisaster(t)
  local r1 = game.rand(4)
  local r2 = game.rand(64)
  local r3 = game.rand(64)
  if r1 < 1 then
    game.create_earthquake({ r2 + 1, r3 + 1 }, 1)
  elseif r1 < 2 then
    local r4 = game.rand(64)
    local r5 = game.rand(64)
    game.create_lightning({ r2 + 1, r3 + 1 }, { r4 + 1, r5 + 1 }, 10)
  elseif r1 < 3 then
    local r4 = game.rand(64)
    local r5 = game.rand(64)
    game.create_tornado({ r2 + 1, r3 + 1 }, { r4 + 1, r5 + 1 }, 10)
  else
    game.create_meteor({ r2 + 1, r3 + 1 }, 1)
  end
  t:destroy()
  trigger.time{min = 12000, max = 24000, one_shot = false, on = DoDisaster}  -- after 120 to 240 marks
end

function on_init()
  local n = game.num_players()
  game.create_tube({ 9, 50 })
  game.create_tube({ 9, 51 })
  game.create_tube({ 10, 50 })
  game.create_tube({ 11, 50 })
  game.create_tube({ 12, 23 })
  game.create_tube({ 12, 24 })
  game.create_tube({ 12, 25 })
  game.create_tube({ 12, 26 })
  game.create_tube({ 12, 27 })
  game.create_tube({ 12, 28 })
  game.create_tube({ 12, 29 })
  game.create_tube({ 12, 30 })
  game.create_tube({ 12, 31 })
  game.create_tube({ 12, 32 })
  game.create_tube({ 12, 33 })
  game.create_tube({ 12, 34 })
  game.create_tube({ 12, 35 })
  game.create_tube({ 12, 36 })
  game.create_tube({ 12, 37 })
  game.create_tube({ 12, 38 })
  game.create_tube({ 12, 39 })
  game.create_tube({ 12, 40 })
  game.create_tube({ 12, 41 })
  game.create_tube({ 12, 42 })
  game.create_tube({ 12, 43 })
  game.create_tube({ 12, 44 })
  game.create_tube({ 12, 45 })
  game.create_tube({ 12, 46 })
  game.create_tube({ 12, 47 })
  game.create_tube({ 12, 48 })
  game.create_tube({ 12, 49 })
  game.create_tube({ 12, 50 })
  game.create_tube({ 13, 23 })
  game.create_tube({ 14, 23 })
  game.create_tube({ 23, 17 })
  game.create_tube({ 24, 17 })
  game.create_tube({ 25, 17 })
  game.create_tube({ 26, 17 })
  game.create_tube({ 27, 17 })
  game.create_tube({ 28, 17 })
  game.create_tube({ 29, 17 })
  game.create_tube({ 30, 17 })
  game.create_tube({ 31, 17 })
  game.create_tube({ 32, 17 })
  game.create_tube({ 33, 17 })
  game.create_tube({ 34, 17 })
  game.create_tube({ 35, 17 })
  game.create_tube({ 36, 13 })
  game.create_tube({ 36, 14 })
  game.create_tube({ 36, 15 })
  game.create_tube({ 36, 16 })
  game.create_tube({ 36, 17 })
  game.create_tube({ 37, 13 })
  game.create_tube({ 38, 13 })
  game.create_tube({ 39, 13 })
  game.create_tube({ 40, 13 })
  game.create_tube({ 41, 13 })
  game.create_tube({ 42, 13 })
  game.create_tube({ 43, 13 })
  game.create_tube({ 44, 13 })
  game.create_tube({ 45, 13 })
  game.create_tube({ 46, 13 })
  game.create_tube({ 47, 13 })
  game.create_tube({ 48, 13 })
  game.create_tube({ 49, 13 })
  game.create_tube({ 50, 10 })
  game.create_tube({ 50, 11 })
  game.create_tube({ 50, 12 })
  game.create_tube({ 50, 13 })
  game.create_tube({ 51, 10 })
  R[0] = game.rand(2)
  U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 15, 14 }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 19, 14 }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "Agridome", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 14, 18 }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 20, 17 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
  if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
    U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
    U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
    U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U]:set_factory_cargo(5, "Tokamak")
      U[#U]:set_factory_cargo(6, "Residence")
    elseif LEVEL_OF[players[1].difficulty] == 1 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif LEVEL_OF[players[1].difficulty] == 2 then
  else
    unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
  end
  U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 14, 21 }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 25, 14 }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 13, 49 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 9, 52 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 49, 14 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 52, 9 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
  players[({ [0] = 0, [1] = 1 })[R[0]] + 1]:center_view({ 19, 14 })
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 22, 22 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 22, 22 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 22, 22 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 22, 22 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 22, 22 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 22, 22 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[({ [0] = 0, [1] = 1 })[R[0]] + 1], at = { 22, 22 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if game.initial_units() == 0 then
  elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
    if R[0] == 0 then
      if (players[1].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[1].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
      end
    elseif R[0] == 1 then
      if (players[2].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[2].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
      end
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if R[0] == 0 then
      if (players[1].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[1].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
      end
    elseif R[0] == 1 then
      if (players[2].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[2].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
      end
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if R[0] == 0 then
      if (players[1].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[1].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
      end
    elseif R[0] == 1 then
      if (players[2].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[2].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
      end
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if R[0] == 0 then
      if (players[1].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[1].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
      end
    elseif R[0] == 1 then
      if (players[2].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[2].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
      end
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if game.initial_units() == 4 then
    elseif game.initial_units() == 8 or game.initial_units() == 12 then
      if R[0] == 0 then
        if (players[1].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        elseif (players[1].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
        end
      elseif R[0] == 1 then
        if (players[2].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        elseif (players[2].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
        end
      else
        unseen("R[0]", R[0])
      end
      U[#U]:set_lights(true)
      if R[0] == 0 then
        if (players[1].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        elseif (players[1].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
        end
      elseif R[0] == 1 then
        if (players[2].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        elseif (players[2].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
        end
      else
        unseen("R[0]", R[0])
      end
      U[#U]:set_lights(true)
      if R[0] == 0 then
        if (players[1].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        elseif (players[1].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
        end
      elseif R[0] == 1 then
        if (players[2].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        elseif (players[2].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
        end
      else
        unseen("R[0]", R[0])
      end
      U[#U]:set_lights(true)
      if R[0] == 0 then
        if (players[1].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        elseif (players[1].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
        end
      elseif R[0] == 1 then
        if (players[2].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        elseif (players[2].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
        end
      else
        unseen("R[0]", R[0])
      end
      U[#U]:set_lights(true)
      if game.initial_units() == 8 then
      elseif game.initial_units() == 12 then
        if R[0] == 0 then
          if (players[1].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[1].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
          end
        elseif R[0] == 1 then
          if (players[2].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          elseif (players[2].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
          end
        else
          unseen("R[0]", R[0])
        end
        U[#U]:set_lights(true)
        if R[0] == 0 then
          if (players[1].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[1].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
          end
        elseif R[0] == 1 then
          if (players[2].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          elseif (players[2].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
          end
        else
          unseen("R[0]", R[0])
        end
        U[#U]:set_lights(true)
        if R[0] == 0 then
          if (players[1].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[1].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
          end
        elseif R[0] == 1 then
          if (players[2].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          elseif (players[2].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
          end
        else
          unseen("R[0]", R[0])
        end
        U[#U]:set_lights(true)
        if R[0] == 0 then
          if (players[1].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[1].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
          end
        elseif R[0] == 1 then
          if (players[2].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          elseif (players[2].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 22, 22 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
          end
        else
          unseen("R[0]", R[0])
        end
        U[#U]:set_lights(true)
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("game.initial_units()", game.initial_units())
  end
  game.create_tube({ 20, 53 })
  game.create_tube({ 20, 54 })
  game.create_tube({ 20, 55 })
  game.create_tube({ 20, 56 })
  game.create_tube({ 20, 57 })
  game.create_tube({ 20, 58 })
  game.create_tube({ 21, 53 })
  game.create_tube({ 22, 53 })
  game.create_tube({ 23, 53 })
  game.create_tube({ 24, 53 })
  game.create_tube({ 25, 53 })
  game.create_tube({ 26, 53 })
  game.create_tube({ 27, 53 })
  game.create_tube({ 28, 53 })
  game.create_tube({ 29, 53 })
  game.create_tube({ 30, 53 })
  game.create_tube({ 31, 53 })
  game.create_tube({ 32, 53 })
  game.create_tube({ 33, 53 })
  game.create_tube({ 34, 53 })
  game.create_tube({ 35, 53 })
  game.create_tube({ 36, 53 })
  game.create_tube({ 37, 53 })
  game.create_tube({ 38, 53 })
  game.create_tube({ 39, 53 })
  game.create_tube({ 40, 52 })
  game.create_tube({ 40, 53 })
  game.create_tube({ 53, 25 })
  game.create_tube({ 53, 26 })
  game.create_tube({ 53, 27 })
  game.create_tube({ 53, 28 })
  game.create_tube({ 53, 29 })
  game.create_tube({ 53, 30 })
  game.create_tube({ 53, 31 })
  game.create_tube({ 53, 32 })
  game.create_tube({ 53, 33 })
  game.create_tube({ 53, 34 })
  game.create_tube({ 53, 35 })
  game.create_tube({ 53, 36 })
  game.create_tube({ 53, 37 })
  game.create_tube({ 53, 38 })
  game.create_tube({ 53, 39 })
  game.create_tube({ 53, 40 })
  game.create_tube({ 53, 41 })
  game.create_tube({ 53, 42 })
  game.create_tube({ 53, 43 })
  game.create_tube({ 53, 44 })
  game.create_tube({ 53, 45 })
  game.create_tube({ 53, 46 })
  game.create_tube({ 53, 47 })
  game.create_tube({ 53, 48 })
  game.create_tube({ 54, 25 })
  game.create_tube({ 55, 25 })
  game.create_tube({ 56, 25 })
  U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 51, 51 }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 46, 50 }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "Agridome", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 50, 48 }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 42, 50 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_factory_cargo(({ [0] = 1, [1] = 3, [2] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "VehicleFactory", [1] = "Nursery", [2] = "Residence" })[LEVEL_OF[players[1].difficulty]])
  if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
    U[#U]:set_factory_cargo(({ [0] = 2, [1] = 4 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "RobotCommand", [1] = "University" })[LEVEL_OF[players[1].difficulty]])
    U[#U]:set_factory_cargo(({ [0] = 3, [1] = 5 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "Nursery", [1] = "Tokamak" })[LEVEL_OF[players[1].difficulty]])
    U[#U]:set_factory_cargo(({ [0] = 4, [1] = 6 })[LEVEL_OF[players[1].difficulty]], ({ [0] = "University", [1] = "Residence" })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U]:set_factory_cargo(5, "Tokamak")
      U[#U]:set_factory_cargo(6, "Residence")
    elseif LEVEL_OF[players[1].difficulty] == 1 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif LEVEL_OF[players[1].difficulty] == 2 then
  else
    unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
  end
  U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 46, 47 }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 50, 40 }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 53, 23 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 56, 23 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 18, 58 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 19, 52 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
  players[({ [0] = 1, [1] = 0 })[R[0]] + 1]:center_view({ 46, 50 })
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 43, 41 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 43, 41 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 43, 41 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 43, 41 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 43, 41 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 43, 41 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[({ [0] = 1, [1] = 0 })[R[0]] + 1], at = { 43, 41 }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if game.initial_units() == 0 then
  elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
    if R[0] == 0 then
      if (players[2].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[2].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
      end
    elseif R[0] == 1 then
      if (players[1].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      elseif (players[1].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
      end
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if R[0] == 0 then
      if (players[2].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[2].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
      end
    elseif R[0] == 1 then
      if (players[1].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      elseif (players[1].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
      end
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if R[0] == 0 then
      if (players[2].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[2].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
      end
    elseif R[0] == 1 then
      if (players[1].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      elseif (players[1].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
      end
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if R[0] == 0 then
      if (players[2].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      elseif (players[2].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
      end
    elseif R[0] == 1 then
      if (players[1].is_eden and 1 or 0) == 1 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
      elseif (players[1].is_eden and 1 or 0) == 0 then
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
      else
        unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
      end
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if game.initial_units() == 4 then
    elseif game.initial_units() == 8 or game.initial_units() == 12 then
      if R[0] == 0 then
        if (players[2].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        elseif (players[2].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
        end
      elseif R[0] == 1 then
        if (players[1].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        elseif (players[1].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
        end
      else
        unseen("R[0]", R[0])
      end
      U[#U]:set_lights(true)
      if R[0] == 0 then
        if (players[2].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        elseif (players[2].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
        end
      elseif R[0] == 1 then
        if (players[1].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        elseif (players[1].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
        end
      else
        unseen("R[0]", R[0])
      end
      U[#U]:set_lights(true)
      if R[0] == 0 then
        if (players[2].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        elseif (players[2].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
        end
      elseif R[0] == 1 then
        if (players[1].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        elseif (players[1].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
        end
      else
        unseen("R[0]", R[0])
      end
      U[#U]:set_lights(true)
      if R[0] == 0 then
        if (players[2].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        elseif (players[2].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
        end
      elseif R[0] == 1 then
        if (players[1].is_eden and 1 or 0) == 0 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
        elseif (players[1].is_eden and 1 or 0) == 1 then
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
        else
          unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
        end
      else
        unseen("R[0]", R[0])
      end
      U[#U]:set_lights(true)
      if game.initial_units() == 8 then
      elseif game.initial_units() == 12 then
        if R[0] == 0 then
          if (players[2].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[2].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
          end
        elseif R[0] == 1 then
          if (players[1].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[1].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
          end
        else
          unseen("R[0]", R[0])
        end
        U[#U]:set_lights(true)
        if R[0] == 0 then
          if (players[2].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[2].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
          end
        elseif R[0] == 1 then
          if (players[1].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[1].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
          end
        else
          unseen("R[0]", R[0])
        end
        U[#U]:set_lights(true)
        if R[0] == 0 then
          if (players[2].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[2].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
          end
        elseif R[0] == 1 then
          if (players[1].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[1].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
          end
        else
          unseen("R[0]", R[0])
        end
        U[#U]:set_lights(true)
        if R[0] == 0 then
          if (players[2].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[2].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
          end
        elseif R[0] == 1 then
          if (players[1].is_eden and 1 or 0) == 1 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
          elseif (players[1].is_eden and 1 or 0) == 0 then
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 41 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
          else
            unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
          end
        else
          unseen("R[0]", R[0])
        end
        U[#U]:set_lights(true)
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("game.initial_units()", game.initial_units())
  end
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 7, 8 } }
  R[1] = game.rand(2)
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = ({ [0] = "Bar2", [1] = "Bar1" })[R[1]], variant = "Random", at = { 6, 22 } }
  R[2] = game.rand(2)
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = ({ [0] = "Bar2", [1] = "Bar1" })[R[2]], variant = "Random", at = { 35, 6 } }
  R[3] = game.rand(2)
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = ({ [0] = "Bar2", [1] = "Bar1" })[R[3]], variant = "Random", at = { 18, 8 } }
  R[4] = game.rand(2)
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = ({ [0] = "Bar2", [1] = "Bar1" })[R[4]], variant = "Random", at = { 47, 7 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 33, 27 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 35, 33 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 57, 57 } }
  R[5] = game.rand(2)
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = ({ [0] = "Bar2", [1] = "Bar1" })[R[5]], variant = "Random", at = { 57, 40 } }
  R[6] = game.rand(2)
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = ({ [0] = "Bar2", [1] = "Bar1" })[R[6]], variant = "Random", at = { 49, 58 } }
  R[7] = game.rand(2)
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = ({ [0] = "Bar2", [1] = "Bar1" })[R[7]], variant = "Random", at = { 26, 57 } }
  R[8] = game.rand(2)
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = ({ [0] = "Bar2", [1] = "Bar1" })[R[8]], variant = "Random", at = { 41, 56 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 19, 28 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 47, 35 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 52, 18 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 16, 52 } }
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

  -- The win.
  mission.last_one_standing("Eliminate your opponents.")
  if game.disasters_enabled() then
    trigger.time{min = 12000, max = 24000, one_shot = false, on = DoDisaster}  -- after 120 to 240 marks
  end
  return true
end
