-- ml2_08Lua.lua  -  2 Player, LastOne, 'Ambush Alley' map. (Lua)
--
-- Converted by op2dll from ml2_08.dll ("2 Player, LastOne, 'Ambush Alley' map."): its setup replayed. `on_init` makes the original's
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
local Meteor, Storm

function Meteor(t)
  local r1 = game.rand(64)
  local r2 = game.rand(64)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function Storm(t)
  local r1 = game.rand(7)
  local r2 = game.rand(64)
  local r3 = game.rand(64)
  game.create_lightning({ r3 + 1, r2 + 2 }, nil, r1 + 10)
end

function on_init()
  local n = game.num_players()
  R[0] = game.rand(3)
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 19, [1] = 4, [2] = 28 })[R[0]], ({ [0] = 4, [1] = 24, [2] = 19 })[R[0]] } }
  R[1] = game.rand(3)
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { ({ [0] = 62, [1] = 40, [2] = 52 })[R[1]], ({ [0] = 30, [1] = 61, [2] = 41 })[R[1]] } }
  R[2] = game.rand(2)
  R[3] = game.rand(2)
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = ({ [0] = "Bar3", [1] = "Bar2" })[R[2]], variant = "Random", at = { ({ [0] = 40, [1] = 15 })[R[3]], ({ [0] = 37, [1] = 57 })[R[3]] } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = ({ [0] = "Bar3", [1] = "Bar2" })[R[2]], variant = "Random", at = { ({ [0] = 15, [1] = 43 })[R[3]], ({ [0] = 33, [1] = 14 })[R[3]] } }
  game.initial_set_tile({ 11, 10 }, 3)
  game.initial_set_tile({ 11, 11 }, 13)
  game.initial_set_tile({ 12, 10 }, 13)
  game.initial_set_tile({ 12, 11 }, 3)
  game.initial_set_tile({ 12, 12 }, 13)
  game.initial_set_tile({ 13, 12 }, 3)
  game.initial_set_tile({ 13, 13 }, 13)
  game.initial_set_tile({ 53, 50 }, 9)
  game.initial_set_tile({ 54, 50 }, 9)
  game.initial_set_tile({ 56, 51 }, 13)
  game.initial_set_tile({ 56, 52 }, 9)
  game.initial_set_tile({ 57, 51 }, 9)
  game.initial_set_tile({ 57, 52 }, 13)
  pick(2, 2, { 4, 5 })
  R[6] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 9 }, [1] = { [0] = 61, [1] = 13 }, [2] = { [0] = 61, [1] = 13 }, [3] = { [0] = 53, [1] = 5 }, [4] = { [0] = 57, [1] = 9 }, [5] = { [0] = 56, [1] = 8 }, [6] = { [0] = 53, [1] = 5 }, [7] = { [0] = 59, [1] = 11 } })[R[6]][R[5]], ({ [0] = { [0] = 57, [1] = 12 }, [1] = { [0] = 53, [1] = 8 }, [2] = { [0] = 57, [1] = 12 }, [3] = { [0] = 53, [1] = 8 }, [4] = { [0] = 56, [1] = 11 }, [5] = { [0] = 54, [1] = 9 }, [6] = { [0] = 51, [1] = 6 }, [7] = { [0] = 54, [1] = 9 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  players[1]:center_view({ ({ [0] = { [0] = 57, [1] = 9 }, [1] = { [0] = 61, [1] = 13 }, [2] = { [0] = 61, [1] = 13 }, [3] = { [0] = 53, [1] = 5 }, [4] = { [0] = 57, [1] = 9 }, [5] = { [0] = 56, [1] = 8 }, [6] = { [0] = 53, [1] = 5 }, [7] = { [0] = 59, [1] = 11 } })[R[6]][R[5]], ({ [0] = { [0] = 57, [1] = 12 }, [1] = { [0] = 53, [1] = 8 }, [2] = { [0] = 57, [1] = 12 }, [3] = { [0] = 53, [1] = 8 }, [4] = { [0] = 56, [1] = 11 }, [5] = { [0] = 54, [1] = 9 }, [6] = { [0] = 51, [1] = 6 }, [7] = { [0] = 54, [1] = 9 } })[R[6]][R[5]] })
  if R[6] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 6 })[R[5]], ({ [0] = 60, [1] = 15 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 59, [1] = 11 })[R[5]], ({ [0] = 60, [1] = 15 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 5 })[R[5]], ({ [0] = 57, [1] = 12 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 61, [1] = 13 })[R[5]], ({ [0] = 57, [1] = 12 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 14 })[R[5]], ({ [0] = 51, [1] = 6 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 60, [1] = 12 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 61, [1] = 13 })[R[5]], ({ [0] = 61, [1] = 16 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 15 })[R[5]], ({ [0] = 60, [1] = 15 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[6] == 5 or R[6] == 6 or R[6] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 53, [1] = 5 }, [6] = { [0] = 62, [1] = 14 }, [7] = { [0] = 53, [1] = 5 } })[R[6]][R[5]], ({ [0] = 61, [1] = 16 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 61, [1] = 13 }, [6] = { [0] = 53, [1] = 5 }, [7] = { [0] = 61, [1] = 13 } })[R[6]][R[5]], ({ [5] = { [0] = 55, [1] = 10 }, [6] = { [0] = 60, [1] = 15 }, [7] = { [0] = 60, [1] = 15 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[6] == 5 or R[6] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 61, [1] = 13 }, [7] = { [0] = 54, [1] = 6 } })[R[6]][R[5]], ({ [0] = 51, [1] = 6 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      if R[6] == 5 then
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
      elseif R[6] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 51, [1] = 6 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 51, [1] = 6 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 51, [1] = 6 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[6]", R[6])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 60, [1] = 12 }, [7] = { [0] = 59, [1] = 11 } })[R[6]][R[5]], ({ [5] = { [0] = 59, [1] = 14 }, [7] = { [0] = 57, [1] = 12 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      if R[6] == 5 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 51, [1] = 6 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[6] == 7 then
      else
        unseen("R[6]", R[6])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [5] = { [0] = 57, [1] = 12 }, [7] = { [0] = 54, [1] = 9 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 9 })[R[5]], ({ [5] = { [0] = 56, [1] = 11 }, [7] = { [0] = 55, [1] = 10 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 57, [1] = 9 }, [7] = { [0] = 62, [1] = 14 } })[R[6]][R[5]], ({ [5] = { [0] = 58, [1] = 13 }, [7] = { [0] = 55, [1] = 10 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[6] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 5 })[R[5]], ({ [0] = 57, [1] = 12 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 5 })[R[5]], ({ [0] = 54, [1] = 9 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 52, [1] = 7 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      unseen("R[6]", R[6])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 63, [1] = 15 }, [6] = { [0] = 60, [1] = 12 }, [7] = { [0] = 56, [1] = 8 } })[R[6]][R[5]], ({ [5] = { [0] = 53, [1] = 8 }, [6] = { [0] = 54, [1] = 9 }, [7] = { [0] = 52, [1] = 7 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[6] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 15 })[R[5]], ({ [0] = 53, [1] = 8 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[6] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 12 })[R[5]], ({ [0] = 54, [1] = 9 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 12 })[R[5]], ({ [0] = 54, [1] = 9 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 7 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 61, [1] = 16 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[6] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 52, [1] = 7 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[6]", R[6])
    end
  elseif R[6] == 1 or R[6] == 2 or R[6] == 3 or R[6] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 61, [1] = 13 }, [2] = { [0] = 54, [1] = 6 }, [3] = { [0] = 58, [1] = 10 }, [4] = { [0] = 54, [1] = 6 } })[R[6]][R[5]], ({ [0] = 60, [1] = 15 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[6] == 1 or R[6] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 52, [1] = 4 }, [2] = { [0] = 53, [1] = 5 } })[R[6]][R[5]], ({ [0] = 51, [1] = 6 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 13 })[R[5]], ({ [1] = { [0] = 56, [1] = 11 }, [2] = { [0] = 60, [1] = 15 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 56, [1] = 8 }, [2] = { [0] = 57, [1] = 9 } })[R[6]][R[5]], ({ [1] = { [0] = 61, [1] = 16 }, [2] = { [0] = 57, [1] = 12 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 56, [1] = 8 }, [2] = { [0] = 61, [1] = 13 } })[R[6]][R[5]], ({ [1] = { [0] = 57, [1] = 12 }, [2] = { [0] = 54, [1] = 9 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 62, [1] = 14 }, [2] = { [0] = 60, [1] = 12 } })[R[6]][R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 63, [1] = 15 }, [2] = { [0] = 62, [1] = 14 } })[R[6]][R[5]], ({ [1] = { [0] = 61, [1] = 16 }, [2] = { [0] = 62, [1] = 17 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 6 })[R[5]], ({ [0] = 52, [1] = 7 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 53, [1] = 8 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 5 })[R[5]], ({ [0] = 56, [1] = 11 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 14 })[R[5]], ({ [0] = 61, [1] = 16 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 50, [1] = 5 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 9 })[R[5]], ({ [0] = 51, [1] = 6 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[6] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 5 })[R[5]], ({ [0] = 61, [1] = 16 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 12 })[R[5]], ({ [0] = 57, [1] = 12 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 6 })[R[5]], ({ [0] = 56, [1] = 11 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 14 })[R[5]], ({ [0] = 51, [1] = 6 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 59, [1] = 11 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 60, [1] = 12 })[R[5]], ({ [0] = 61, [1] = 16 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[6]", R[6])
    end
    U[#U]:set_lights(true)
    if R[6] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 60, [1] = 12 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 61, [1] = 16 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 3 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 61, [1] = 13 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 51, [1] = 3 })[R[5]], ({ [0] = 58, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 9 })[R[5]], ({ [0] = 51, [1] = 6 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[6]", R[6])
    end
    U[#U]:set_lights(true)
    if R[6] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 15 })[R[5]], ({ [0] = 58, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 2 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 7 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 7 })[R[5]], ({ [0] = 58, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 7 })[R[5]], ({ [0] = 54, [1] = 9 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 51, [1] = 3 })[R[5]], ({ [0] = 58, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[6]", R[6])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 63, [1] = 15 }, [2] = { [0] = 55, [1] = 7 }, [3] = { [0] = 55, [1] = 7 }, [4] = { [0] = 55, [1] = 7 } })[R[6]][R[5]], ({ [1] = { [0] = 58, [1] = 13 }, [2] = { [0] = 62, [1] = 17 }, [3] = { [0] = 58, [1] = 13 }, [4] = { [0] = 54, [1] = 9 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[6]", R[6])
  end
  U[#U]:set_lights(true)
  if R[6] == 0 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 4 })[R[5]], ({ [0] = 53, [1] = 8 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 4 })[R[5]], ({ [0] = 53, [1] = 8 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[6] == 1 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 15 })[R[5]], ({ [0] = 58, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 53, [1] = 5 })[R[5]], ({ [0] = 57, [1] = 12 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 53, [1] = 5 })[R[5]], ({ [0] = 57, [1] = 12 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[6] == 2 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 7 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 57, [1] = 9 })[R[5]], ({ [0] = 53, [1] = 8 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 57, [1] = 9 })[R[5]], ({ [0] = 53, [1] = 8 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[6] == 3 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 7 })[R[5]], ({ [0] = 58, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 54, [1] = 9 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 54, [1] = 9 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[6] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 7 })[R[5]], ({ [0] = 54, [1] = 9 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 52, [1] = 4 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[6] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 15 })[R[5]], ({ [0] = 53, [1] = 8 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 15 })[R[5]], ({ [0] = 59, [1] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[6] == 6 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 12 })[R[5]], ({ [0] = 54, [1] = 9 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 7 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 61, [1] = 16 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 55, [1] = 10 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 62, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 55, [1] = 10 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[6] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 52, [1] = 7 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 15 })[R[5]], ({ [0] = 59, [1] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[6]", R[6])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[6]], player = players[1], at = { ({ [0] = { [0] = 53, [1] = 5 }, [1] = { [0] = 52, [1] = 4 }, [2] = { [0] = 58, [1] = 10 }, [3] = { [0] = 57, [1] = 9 }, [4] = { [0] = 55, [1] = 7 }, [5] = { [0] = 62, [1] = 14 }, [6] = { [0] = 57, [1] = 9 }, [7] = { [0] = 62, [1] = 14 } })[R[6]][R[5]], ({ [0] = { [0] = 54, [1] = 9 }, [1] = { [0] = 56, [1] = 11 }, [2] = { [0] = 52, [1] = 7 }, [3] = { [0] = 53, [1] = 8 }, [4] = { [0] = 62, [1] = 17 }, [5] = { [0] = 57, [1] = 12 }, [6] = { [0] = 56, [1] = 11 }, [7] = { [0] = 62, [1] = 17 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[6]], player = players[1], at = { ({ [0] = { [0] = 54, [1] = 6 }, [1] = { [0] = 54, [1] = 6 }, [2] = { [0] = 57, [1] = 9 }, [3] = { [0] = 56, [1] = 8 }, [4] = { [0] = 56, [1] = 8 }, [5] = { [0] = 63, [1] = 15 }, [6] = { [0] = 58, [1] = 10 }, [7] = { [0] = 63, [1] = 15 } })[R[6]][R[5]], ({ [0] = { [0] = 54, [1] = 9 }, [1] = { [0] = 55, [1] = 10 }, [2] = { [0] = 51, [1] = 6 }, [3] = { [0] = 52, [1] = 7 }, [4] = { [0] = 61, [1] = 16 }, [5] = { [0] = 56, [1] = 11 }, [6] = { [0] = 55, [1] = 10 }, [7] = { [0] = 62, [1] = 17 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[6] == 0 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[7] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 52, [1] = 4 }, [1] = { [0] = 57, [1] = 9 }, [2] = { [0] = 62, [1] = 14 } })[R[7]][R[5]], ({ [0] = { [0] = 50, [1] = 5 }, [1] = { [0] = 53, [1] = 8 }, [2] = { [0] = 59, [1] = 14 } })[R[7]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 59, [1] = 14 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 56, [1] = 8 })[R[5]], ({ [0] = 59, [1] = 14 })[R[5]] })
      for i = 1, game.initial_units() do
        R[8] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 52, [1] = 4 }, [1] = { [0] = 56, [1] = 8 }, [2] = { [0] = 59, [1] = 11 } })[R[8]][R[5]], ({ [0] = { [0] = 60, [1] = 15 }, [1] = { [0] = 54, [1] = 9 }, [2] = { [0] = 50, [1] = 5 } })[R[8]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 2 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 57, [1] = 9 })[R[5]], ({ [0] = 59, [1] = 14 })[R[5]] })
      game.create_tube({ ({ [0] = 57, [1] = 9 })[R[5]], ({ [0] = 60, [1] = 15 })[R[5]] })
      game.create_tube({ ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 60, [1] = 15 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 57, [1] = 9 })[R[5]], ({ [0] = 59, [1] = 14 })[R[5]] })
      game.create_tube({ ({ [0] = 57, [1] = 9 })[R[5]], ({ [0] = 60, [1] = 15 })[R[5]] })
      game.create_tube({ ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 60, [1] = 15 })[R[5]] })
      for i = 1, game.initial_units() do
        R[9] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 61, [1] = 13 }, [1] = { [0] = 53, [1] = 5 }, [2] = { [0] = 57, [1] = 9 } })[R[9]][R[5]], ({ [0] = { [0] = 50, [1] = 5 }, [1] = { [0] = 55, [1] = 10 }, [2] = { [0] = 60, [1] = 15 } })[R[9]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 3 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 54, [1] = 6 })[R[5]], ({ [0] = 59, [1] = 14 })[R[5]] })
      game.create_tube({ ({ [0] = 57, [1] = 9 })[R[5]], ({ [0] = 56, [1] = 11 })[R[5]] })
      game.create_tube({ ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 56, [1] = 11 })[R[5]] })
      game.create_tube({ ({ [0] = 60, [1] = 12 })[R[5]], ({ [0] = 59, [1] = 14 })[R[5]] })
      game.create_tube({ ({ [0] = 60, [1] = 12 })[R[5]], ({ [0] = 60, [1] = 15 })[R[5]] })
      for i = 1, game.initial_units() do
        R[10] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 14 }, [1] = { [0] = 58, [1] = 10 }, [2] = { [0] = 54, [1] = 6 } })[R[10]][R[5]], ({ [0] = { [0] = 61, [1] = 16 }, [1] = { [0] = 55, [1] = 10 }, [2] = { [0] = 50, [1] = 5 } })[R[10]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 54, [1] = 6 })[R[5]], ({ [0] = 59, [1] = 14 })[R[5]] })
      game.create_tube({ ({ [0] = 57, [1] = 9 })[R[5]], ({ [0] = 56, [1] = 11 })[R[5]] })
      game.create_tube({ ({ [0] = 58, [1] = 10 })[R[5]], ({ [0] = 56, [1] = 11 })[R[5]] })
      game.create_tube({ ({ [0] = 60, [1] = 12 })[R[5]], ({ [0] = 59, [1] = 14 })[R[5]] })
      game.create_tube({ ({ [0] = 60, [1] = 12 })[R[5]], ({ [0] = 60, [1] = 15 })[R[5]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 53, [1] = 5 })[R[5]], ({ [0] = 58, [1] = 13 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 53, [1] = 5 })[R[5]], ({ [0] = 58, [1] = 13 })[R[5]] })
      for i = 1, game.initial_units() do
        R[11] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 61, [1] = 13 }, [1] = { [0] = 62, [1] = 14 }, [2] = { [0] = 58, [1] = 10 } })[R[11]][R[5]], ({ [0] = { [0] = 50, [1] = 5 }, [1] = { [0] = 56, [1] = 11 }, [2] = { [0] = 60, [1] = 15 } })[R[11]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 5 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[12] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 58, [1] = 10 }, [1] = { [0] = 52, [1] = 4 }, [2] = { [0] = 52, [1] = 4 } })[R[12]][R[5]], ({ [0] = { [0] = 61, [1] = 16 }, [1] = { [0] = 56, [1] = 11 }, [2] = { [0] = 51, [1] = 6 } })[R[12]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 6 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[13] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 14 }, [1] = { [0] = 61, [1] = 13 }, [2] = { [0] = 58, [1] = 10 } })[R[13]][R[5]], ({ [0] = { [0] = 51, [1] = 6 }, [1] = { [0] = 57, [1] = 12 }, [2] = { [0] = 58, [1] = 13 } })[R[13]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 7 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[14] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 8 }, [1] = { [0] = 52, [1] = 4 }, [2] = { [0] = 62, [1] = 14 } })[R[14]][R[5]], ({ [0] = { [0] = 60, [1] = 15 }, [1] = { [0] = 56, [1] = 11 }, [2] = { [0] = 51, [1] = 6 } })[R[14]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[6]", R[6])
  end
  R[15] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 9, [1] = 57 }, [1] = { [0] = 13, [1] = 61 }, [2] = { [0] = 13, [1] = 61 }, [3] = { [0] = 5, [1] = 53 }, [4] = { [0] = 9, [1] = 57 }, [5] = { [0] = 8, [1] = 56 }, [6] = { [0] = 5, [1] = 53 }, [7] = { [0] = 11, [1] = 59 } })[R[15]][R[5]], ({ [0] = { [0] = 12, [1] = 57 }, [1] = { [0] = 8, [1] = 53 }, [2] = { [0] = 12, [1] = 57 }, [3] = { [0] = 8, [1] = 53 }, [4] = { [0] = 11, [1] = 56 }, [5] = { [0] = 9, [1] = 54 }, [6] = { [0] = 6, [1] = 51 }, [7] = { [0] = 9, [1] = 54 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  players[2]:center_view({ ({ [0] = { [0] = 9, [1] = 57 }, [1] = { [0] = 13, [1] = 61 }, [2] = { [0] = 13, [1] = 61 }, [3] = { [0] = 5, [1] = 53 }, [4] = { [0] = 9, [1] = 57 }, [5] = { [0] = 8, [1] = 56 }, [6] = { [0] = 5, [1] = 53 }, [7] = { [0] = 11, [1] = 59 } })[R[15]][R[5]], ({ [0] = { [0] = 12, [1] = 57 }, [1] = { [0] = 8, [1] = 53 }, [2] = { [0] = 12, [1] = 57 }, [3] = { [0] = 8, [1] = 53 }, [4] = { [0] = 11, [1] = 56 }, [5] = { [0] = 9, [1] = 54 }, [6] = { [0] = 6, [1] = 51 }, [7] = { [0] = 9, [1] = 54 } })[R[15]][R[5]] })
  if R[15] == 1 or R[15] == 2 or R[15] == 3 or R[15] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 13, [1] = 61 }, [2] = { [0] = 6, [1] = 54 }, [3] = { [0] = 10, [1] = 58 }, [4] = { [0] = 6, [1] = 54 } })[R[15]][R[5]], ({ [0] = 15, [1] = 60 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[15] == 1 or R[15] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 4, [1] = 52 }, [2] = { [0] = 5, [1] = 53 } })[R[15]][R[5]], ({ [0] = 6, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 13, [1] = 61 })[R[5]], ({ [1] = { [0] = 11, [1] = 56 }, [2] = { [0] = 15, [1] = 60 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 8, [1] = 56 }, [2] = { [0] = 9, [1] = 57 } })[R[15]][R[5]], ({ [1] = { [0] = 16, [1] = 61 }, [2] = { [0] = 12, [1] = 57 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 8, [1] = 56 }, [2] = { [0] = 13, [1] = 61 } })[R[15]][R[5]], ({ [1] = { [0] = 12, [1] = 57 }, [2] = { [0] = 9, [1] = 54 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 14, [1] = 62 }, [2] = { [0] = 12, [1] = 60 } })[R[15]][R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 15, [1] = 63 }, [2] = { [0] = 14, [1] = 62 } })[R[15]][R[5]], ({ [1] = { [0] = 16, [1] = 61 }, [2] = { [0] = 17, [1] = 62 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 6, [1] = 54 })[R[5]], ({ [0] = 7, [1] = 52 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 10, [1] = 58 })[R[5]], ({ [0] = 8, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 5, [1] = 53 })[R[5]], ({ [0] = 11, [1] = 56 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 14, [1] = 62 })[R[5]], ({ [0] = 16, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 5, [1] = 50 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 9, [1] = 57 })[R[5]], ({ [0] = 6, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[15] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 5, [1] = 53 })[R[5]], ({ [0] = 16, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 12, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 6, [1] = 54 })[R[5]], ({ [0] = 11, [1] = 56 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 14, [1] = 62 })[R[5]], ({ [0] = 6, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 11, [1] = 59 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 16, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[15]", R[15])
    end
    U[#U]:set_lights(true)
    if R[15] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 10, [1] = 58 })[R[5]], ({ [0] = 16, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 3 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 61 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 3, [1] = 51 })[R[5]], ({ [0] = 13, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 9, [1] = 57 })[R[5]], ({ [0] = 6, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[15]", R[15])
    end
    U[#U]:set_lights(true)
    if R[15] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 63 })[R[5]], ({ [0] = 13, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 2 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 7, [1] = 55 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 7, [1] = 55 })[R[5]], ({ [0] = 13, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 7, [1] = 55 })[R[5]], ({ [0] = 9, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 3, [1] = 51 })[R[5]], ({ [0] = 13, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[15]", R[15])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 15, [1] = 63 }, [2] = { [0] = 7, [1] = 55 }, [3] = { [0] = 7, [1] = 55 }, [4] = { [0] = 7, [1] = 55 } })[R[15]][R[5]], ({ [1] = { [0] = 13, [1] = 58 }, [2] = { [0] = 17, [1] = 62 }, [3] = { [0] = 13, [1] = 58 }, [4] = { [0] = 9, [1] = 54 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[15] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 6, [1] = 54 })[R[5]], ({ [0] = 15, [1] = 60 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 11, [1] = 59 })[R[5]], ({ [0] = 15, [1] = 60 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 5, [1] = 53 })[R[5]], ({ [0] = 12, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 61 })[R[5]], ({ [0] = 12, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 14, [1] = 62 })[R[5]], ({ [0] = 6, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 61 })[R[5]], ({ [0] = 16, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 63 })[R[5]], ({ [0] = 15, [1] = 60 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[15] == 5 or R[15] == 6 or R[15] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 5, [1] = 53 }, [6] = { [0] = 14, [1] = 62 }, [7] = { [0] = 5, [1] = 53 } })[R[15]][R[5]], ({ [0] = 16, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 13, [1] = 61 }, [6] = { [0] = 5, [1] = 53 }, [7] = { [0] = 13, [1] = 61 } })[R[15]][R[5]], ({ [5] = { [0] = 10, [1] = 55 }, [6] = { [0] = 15, [1] = 60 }, [7] = { [0] = 15, [1] = 60 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[15] == 5 or R[15] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 13, [1] = 61 }, [7] = { [0] = 6, [1] = 54 } })[R[15]][R[5]], ({ [0] = 6, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      if R[15] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[15] == 7 then
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
        unseen("R[15]", R[15])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 8, [1] = 56 }, [7] = { [0] = 10, [1] = 58 } })[R[15]][R[5]], ({ [0] = 6, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      if R[15] == 5 then
      elseif R[15] == 7 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 11, [1] = 59 })[R[5]], ({ [0] = 12, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[15]", R[15])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [5] = { [0] = 12, [1] = 57 }, [7] = { [0] = 9, [1] = 54 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 9, [1] = 57 })[R[5]], ({ [5] = { [0] = 11, [1] = 56 }, [7] = { [0] = 10, [1] = 55 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 9, [1] = 57 }, [7] = { [0] = 14, [1] = 62 } })[R[15]][R[5]], ({ [5] = { [0] = 13, [1] = 58 }, [7] = { [0] = 10, [1] = 55 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[15] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 5, [1] = 53 })[R[5]], ({ [0] = 12, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 5, [1] = 53 })[R[5]], ({ [0] = 9, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 10, [1] = 58 })[R[5]], ({ [0] = 7, [1] = 52 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      unseen("R[15]", R[15])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 15, [1] = 63 }, [6] = { [0] = 12, [1] = 60 }, [7] = { [0] = 8, [1] = 56 } })[R[15]][R[5]], ({ [5] = { [0] = 8, [1] = 53 }, [6] = { [0] = 9, [1] = 54 }, [7] = { [0] = 7, [1] = 52 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[15] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 63 })[R[5]], ({ [0] = 8, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[15] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 9, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 9, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 7, [1] = 55 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 16, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[15] == 7 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 7, [1] = 52 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[15]", R[15])
    end
  else
    unseen("R[15]", R[15])
  end
  U[#U]:set_lights(true)
  if R[15] == 0 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 4, [1] = 52 })[R[5]], ({ [0] = 8, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 4, [1] = 52 })[R[5]], ({ [0] = 8, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[15] == 1 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 63 })[R[5]], ({ [0] = 13, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 5, [1] = 53 })[R[5]], ({ [0] = 12, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 5, [1] = 53 })[R[5]], ({ [0] = 12, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[15] == 2 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 7, [1] = 55 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 9, [1] = 57 })[R[5]], ({ [0] = 8, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 9, [1] = 57 })[R[5]], ({ [0] = 8, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[15] == 3 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 7, [1] = 55 })[R[5]], ({ [0] = 13, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 9, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 9, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[15] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 7, [1] = 55 })[R[5]], ({ [0] = 9, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 4, [1] = 52 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[15] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 63 })[R[5]], ({ [0] = 8, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 63 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[15] == 6 then
    if LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 10, [1] = 58 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 10, [1] = 55 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 9, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 7, [1] = 55 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 16, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 10, [1] = 58 })[R[5]], ({ [0] = 17, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 10, [1] = 55 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[15] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 7, [1] = 52 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 63 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[15]", R[15])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[15]], player = players[2], at = { ({ [0] = { [0] = 5, [1] = 53 }, [1] = { [0] = 4, [1] = 52 }, [2] = { [0] = 10, [1] = 58 }, [3] = { [0] = 9, [1] = 57 }, [4] = { [0] = 7, [1] = 55 }, [5] = { [0] = 14, [1] = 62 }, [6] = { [0] = 9, [1] = 57 }, [7] = { [0] = 14, [1] = 62 } })[R[15]][R[5]], ({ [0] = { [0] = 9, [1] = 54 }, [1] = { [0] = 11, [1] = 56 }, [2] = { [0] = 7, [1] = 52 }, [3] = { [0] = 8, [1] = 53 }, [4] = { [0] = 17, [1] = 62 }, [5] = { [0] = 12, [1] = 57 }, [6] = { [0] = 11, [1] = 56 }, [7] = { [0] = 17, [1] = 62 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[15]], player = players[2], at = { ({ [0] = { [0] = 6, [1] = 54 }, [1] = { [0] = 6, [1] = 54 }, [2] = { [0] = 9, [1] = 57 }, [3] = { [0] = 8, [1] = 56 }, [4] = { [0] = 8, [1] = 56 }, [5] = { [0] = 15, [1] = 63 }, [6] = { [0] = 10, [1] = 58 }, [7] = { [0] = 15, [1] = 63 } })[R[15]][R[5]], ({ [0] = { [0] = 9, [1] = 54 }, [1] = { [0] = 10, [1] = 55 }, [2] = { [0] = 6, [1] = 51 }, [3] = { [0] = 7, [1] = 52 }, [4] = { [0] = 16, [1] = 61 }, [5] = { [0] = 11, [1] = 56 }, [6] = { [0] = 10, [1] = 55 }, [7] = { [0] = 17, [1] = 62 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[15] == 0 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[16] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 4, [1] = 52 }, [1] = { [0] = 9, [1] = 57 }, [2] = { [0] = 14, [1] = 62 } })[R[16]][R[5]], ({ [0] = { [0] = 5, [1] = 50 }, [1] = { [0] = 8, [1] = 53 }, [2] = { [0] = 14, [1] = 59 } })[R[16]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[15] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 8, [1] = 56 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] })
      for i = 1, game.initial_units() do
        R[17] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 4, [1] = 52 }, [1] = { [0] = 8, [1] = 56 }, [2] = { [0] = 11, [1] = 59 } })[R[17]][R[5]], ({ [0] = { [0] = 15, [1] = 60 }, [1] = { [0] = 9, [1] = 54 }, [2] = { [0] = 5, [1] = 50 } })[R[17]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[15] == 2 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 9, [1] = 57 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 9, [1] = 57 })[R[5]], ({ [0] = 15, [1] = 60 })[R[5]] })
      game.create_tube({ ({ [0] = 10, [1] = 58 })[R[5]], ({ [0] = 15, [1] = 60 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 9, [1] = 57 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 9, [1] = 57 })[R[5]], ({ [0] = 15, [1] = 60 })[R[5]] })
      game.create_tube({ ({ [0] = 10, [1] = 58 })[R[5]], ({ [0] = 15, [1] = 60 })[R[5]] })
      for i = 1, game.initial_units() do
        R[18] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 61 }, [1] = { [0] = 5, [1] = 53 }, [2] = { [0] = 9, [1] = 57 } })[R[18]][R[5]], ({ [0] = { [0] = 5, [1] = 50 }, [1] = { [0] = 10, [1] = 55 }, [2] = { [0] = 15, [1] = 60 } })[R[18]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[15] == 3 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 6, [1] = 54 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 9, [1] = 57 })[R[5]], ({ [0] = 11, [1] = 56 })[R[5]] })
      game.create_tube({ ({ [0] = 10, [1] = 58 })[R[5]], ({ [0] = 11, [1] = 56 })[R[5]] })
      game.create_tube({ ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 15, [1] = 60 })[R[5]] })
      for i = 1, game.initial_units() do
        R[19] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 62 }, [1] = { [0] = 10, [1] = 58 }, [2] = { [0] = 6, [1] = 54 } })[R[19]][R[5]], ({ [0] = { [0] = 16, [1] = 61 }, [1] = { [0] = 10, [1] = 55 }, [2] = { [0] = 5, [1] = 50 } })[R[19]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 6, [1] = 54 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 9, [1] = 57 })[R[5]], ({ [0] = 11, [1] = 56 })[R[5]] })
      game.create_tube({ ({ [0] = 10, [1] = 58 })[R[5]], ({ [0] = 11, [1] = 56 })[R[5]] })
      game.create_tube({ ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 14, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 12, [1] = 60 })[R[5]], ({ [0] = 15, [1] = 60 })[R[5]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[15] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 5, [1] = 53 })[R[5]], ({ [0] = 13, [1] = 58 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 5, [1] = 53 })[R[5]], ({ [0] = 13, [1] = 58 })[R[5]] })
      for i = 1, game.initial_units() do
        R[20] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 61 }, [1] = { [0] = 14, [1] = 62 }, [2] = { [0] = 10, [1] = 58 } })[R[20]][R[5]], ({ [0] = { [0] = 5, [1] = 50 }, [1] = { [0] = 11, [1] = 56 }, [2] = { [0] = 15, [1] = 60 } })[R[20]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[15] == 5 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[21] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 10, [1] = 58 }, [1] = { [0] = 4, [1] = 52 }, [2] = { [0] = 4, [1] = 52 } })[R[21]][R[5]], ({ [0] = { [0] = 16, [1] = 61 }, [1] = { [0] = 11, [1] = 56 }, [2] = { [0] = 6, [1] = 51 } })[R[21]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[15] == 6 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[22] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 62 }, [1] = { [0] = 13, [1] = 61 }, [2] = { [0] = 10, [1] = 58 } })[R[22]][R[5]], ({ [0] = { [0] = 6, [1] = 51 }, [1] = { [0] = 12, [1] = 57 }, [2] = { [0] = 13, [1] = 58 } })[R[22]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[15] == 7 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[23] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 8, [1] = 56 }, [1] = { [0] = 4, [1] = 52 }, [2] = { [0] = 14, [1] = 62 } })[R[23]][R[5]], ({ [0] = { [0] = 15, [1] = 60 }, [1] = { [0] = 11, [1] = 56 }, [2] = { [0] = 6, [1] = 51 } })[R[23]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[15]", R[15])
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

  -- The win.
  mission.last_one_standing("Eliminate your opponents.")
  if game.disasters_enabled() then
    trigger.time{min = 24000, max = 54000, one_shot = false, on = Meteor}  -- after 240 to 540 marks
    trigger.time{min = 6000, max = 24000, one_shot = false, on = Storm}  -- after 60 to 240 marks
  end
  return true
end
