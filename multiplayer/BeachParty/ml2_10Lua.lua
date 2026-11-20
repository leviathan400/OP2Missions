-- ml2_10Lua.lua  -  2 Player, LastOne, 'Beach Party' map. (Lua)
--
-- Converted by op2dll from ml2_10.dll ("2 Player, LastOne, 'Beach Party' map."): its setup replayed. `on_init` makes the original's
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
local Meteors

function Meteors(t)
  local r1 = game.rand(127)
  local r2 = game.rand(128)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function on_init()
  local n = game.num_players()
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 62, 99 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 76, 103 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 66, 119 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 49, 117 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 103, 53 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 13, 39 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 27, 22 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 116, 17 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 81, 23 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 44, 10 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 50, 53 } }
  pick(2, 2, { 0, 1 })
  R[2] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 101, [1] = 20 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 111, [1] = 28 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 103, [1] = 25 }, [6] = { [0] = 106, [1] = 25 }, [7] = { [0] = 104, [1] = 24 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 101, [1] = 96 }, [2] = { [0] = 91, [1] = 86 }, [3] = { [0] = 104, [1] = 94 }, [4] = { [0] = 101, [1] = 89 }, [5] = { [0] = 101, [1] = 90 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 103, [1] = 92 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  players[1]:center_view({ ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 101, [1] = 20 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 111, [1] = 28 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 103, [1] = 25 }, [6] = { [0] = 106, [1] = 25 }, [7] = { [0] = 104, [1] = 24 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 101, [1] = 96 }, [2] = { [0] = 91, [1] = 86 }, [3] = { [0] = 104, [1] = 94 }, [4] = { [0] = 101, [1] = 89 }, [5] = { [0] = 101, [1] = 90 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 103, [1] = 92 } })[R[2]][R[1]] })
  U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 111, [1] = 30 }, [2] = { [0] = 100, [1] = 22 }, [3] = { [0] = 119, [1] = 36 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 103, [1] = 25 }, [6] = { [0] = 115, [1] = 34 }, [7] = { [0] = 97, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 94, [1] = 86 }, [1] = { [0] = 88, [1] = 83 }, [2] = { [0] = 96, [1] = 91 }, [3] = { [0] = 108, [1] = 98 }, [4] = { [0] = 109, [1] = 97 }, [5] = { [0] = 107, [1] = 96 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 109, [1] = 98 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  if R[2] == 0 or R[2] == 1 or R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 122, [1] = 47 }, [1] = { [0] = 112, [1] = 31 }, [2] = { [0] = 103, [1] = 25 }, [5] = { [0] = 113, [1] = 35 }, [6] = { [0] = 116, [1] = 35 }, [7] = { [0] = 97, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 95, [1] = 90 }, [2] = { [0] = 102, [1] = 97 }, [5] = { [0] = 106, [1] = 95 }, [6] = { [0] = 98, [1] = 87 }, [7] = { [0] = 96, [1] = 85 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 99, [1] = 24 })[R[1]], ({ [0] = 101, [1] = 93 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 99, [1] = 24 })[R[1]], ({ [0] = 101, [1] = 93 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 99, [1] = 24 })[R[1]], ({ [0] = 101, [1] = 93 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 112, [1] = 31 })[R[1]], ({ [0] = 105, [1] = 100 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 112, [1] = 31 })[R[1]], ({ [0] = 105, [1] = 100 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 112, [1] = 31 })[R[1]], ({ [0] = 105, [1] = 100 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 2 then
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
    elseif R[2] == 5 then
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
    elseif R[2] == 6 then
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
    elseif R[2] == 7 then
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
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 111, [1] = 30 }, [2] = { [0] = 112, [1] = 34 }, [5] = { [0] = 113, [1] = 35 }, [6] = { [0] = 124, [1] = 43 }, [7] = { [0] = 112, [1] = 32 } })[R[2]][R[1]], ({ [0] = { [0] = 108, [1] = 100 }, [1] = { [0] = 113, [1] = 108 }, [2] = { [0] = 96, [1] = 91 }, [5] = { [0] = 99, [1] = 88 }, [6] = { [0] = 98, [1] = 87 }, [7] = { [0] = 96, [1] = 85 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [2] = { [0] = 112, [1] = 34 }, [5] = { [0] = 103, [1] = 25 }, [6] = { [0] = 107, [1] = 26 }, [7] = { [0] = 113, [1] = 33 } })[R[2]][R[1]], ({ [2] = { [0] = 102, [1] = 97 }, [5] = { [0] = 94, [1] = 83 }, [6] = { [0] = 98, [1] = 87 }, [7] = { [0] = 108, [1] = 97 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 0 or R[2] == 1 then
    else
      unseen("R[2]", R[2])
    end
  elseif R[2] == 3 or R[2] == 4 then
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 103, [1] = 20 }, [4] = { [0] = 107, [1] = 27 } })[R[2]][R[1]], ({ [3] = { [0] = 108, [1] = 98 }, [4] = { [0] = 93, [1] = 81 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 118, [1] = 38 })[R[1]], ({ [0] = 95, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 3 then
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 106, [1] = 23 }, [4] = { [0] = 118, [1] = 38 } })[R[2]][R[1]], ({ [3] = { [0] = 97, [1] = 87 }, [4] = { [0] = 105, [1] = 93 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 3 then
      if LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 117, [1] = 34 })[R[1]], ({ [0] = 97, [1] = 87 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 117, [1] = 34 })[R[1]], ({ [0] = 97, [1] = 87 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 117, [1] = 34 })[R[1]], ({ [0] = 97, [1] = 87 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 4 then
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
      unseen("R[2]", R[2])
    end
  else
    unseen("R[2]", R[2])
  end
  U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 101, [1] = 26 }, [1] = { [0] = 102, [1] = 21 }, [2] = { [0] = 120, [1] = 42 }, [3] = { [0] = 112, [1] = 29 }, [4] = { [0] = 99, [1] = 19 }, [5] = { [0] = 93, [1] = 15 }, [6] = { [0] = 99, [1] = 18 }, [7] = { [0] = 105, [1] = 25 } })[R[2]][R[1]], ({ [0] = { [0] = 108, [1] = 100 }, [1] = { [0] = 110, [1] = 105 }, [2] = { [0] = 96, [1] = 91 }, [3] = { [0] = 91, [1] = 81 }, [4] = { [0] = 97, [1] = 85 }, [5] = { [0] = 101, [1] = 90 }, [6] = { [0] = 98, [1] = 87 }, [7] = { [0] = 112, [1] = 101 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 106, [1] = 31 }, [1] = { [0] = 101, [1] = 20 }, [2] = { [0] = 116, [1] = 38 }, [3] = { [0] = 101, [1] = 18 }, [4] = { [0] = 117, [1] = 37 }, [5] = { [0] = 111, [1] = 33 }, [6] = { [0] = 106, [1] = 25 }, [7] = { [0] = 115, [1] = 35 } })[R[2]][R[1]], ({ [0] = { [0] = 97, [1] = 89 }, [1] = { [0] = 96, [1] = 91 }, [2] = { [0] = 100, [1] = 95 }, [3] = { [0] = 98, [1] = 88 }, [4] = { [0] = 101, [1] = 89 }, [5] = { [0] = 92, [1] = 81 }, [6] = { [0] = 103, [1] = 92 }, [7] = { [0] = 103, [1] = 92 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 104, [1] = 29 }, [1] = { [0] = 101, [1] = 20 }, [2] = { [0] = 116, [1] = 38 }, [3] = { [0] = 104, [1] = 21 }, [4] = { [0] = 119, [1] = 39 }, [5] = { [0] = 111, [1] = 33 }, [6] = { [0] = 104, [1] = 23 }, [7] = { [0] = 115, [1] = 35 } })[R[2]][R[1]], ({ [0] = { [0] = 97, [1] = 89 }, [1] = { [0] = 94, [1] = 89 }, [2] = { [0] = 98, [1] = 93 }, [3] = { [0] = 94, [1] = 84 }, [4] = { [0] = 101, [1] = 89 }, [5] = { [0] = 94, [1] = 83 }, [6] = { [0] = 103, [1] = 92 }, [7] = { [0] = 105, [1] = 94 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if LEVEL_OF[players[1].difficulty] == 0 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 40 }, [1] = { [0] = 104, [1] = 23 }, [2] = { [0] = 98, [1] = 20 }, [3] = { [0] = 121, [1] = 38 }, [4] = { [0] = 111, [1] = 31 }, [5] = { [0] = 99, [1] = 21 }, [6] = { [0] = 119, [1] = 38 }, [7] = { [0] = 114, [1] = 34 } })[R[2]][R[1]], ({ [0] = { [0] = 103, [1] = 95 }, [1] = { [0] = 96, [1] = 91 }, [2] = { [0] = 101, [1] = 96 }, [3] = { [0] = 98, [1] = 88 }, [4] = { [0] = 109, [1] = 97 }, [5] = { [0] = 102, [1] = 91 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 97, [1] = 86 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 40 }, [1] = { [0] = 104, [1] = 23 }, [2] = { [0] = 98, [1] = 20 }, [3] = { [0] = 119, [1] = 36 }, [4] = { [0] = 111, [1] = 31 }, [5] = { [0] = 99, [1] = 21 }, [6] = { [0] = 119, [1] = 38 }, [7] = { [0] = 114, [1] = 34 } })[R[2]][R[1]], ({ [0] = { [0] = 103, [1] = 95 }, [1] = { [0] = 96, [1] = 91 }, [2] = { [0] = 101, [1] = 96 }, [3] = { [0] = 94, [1] = 84 }, [4] = { [0] = 109, [1] = 97 }, [5] = { [0] = 102, [1] = 91 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 97, [1] = 86 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 115, [1] = 40 }, [1] = { [0] = 104, [1] = 23 }, [2] = { [0] = 98, [1] = 20 }, [3] = { [0] = 107, [1] = 24 }, [4] = { [0] = 111, [1] = 31 }, [5] = { [0] = 99, [1] = 21 }, [6] = { [0] = 119, [1] = 38 }, [7] = { [0] = 114, [1] = 34 } })[R[2]][R[1]], ({ [0] = { [0] = 103, [1] = 95 }, [1] = { [0] = 96, [1] = 91 }, [2] = { [0] = 101, [1] = 96 }, [3] = { [0] = 109, [1] = 99 }, [4] = { [0] = 109, [1] = 97 }, [5] = { [0] = 102, [1] = 91 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 97, [1] = 86 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 101, [1] = 26 }, [1] = { [0] = 104, [1] = 23 }, [2] = { [0] = 116, [1] = 38 }, [3] = { [0] = 107, [1] = 24 }, [4] = { [0] = 112, [1] = 32 }, [5] = { [0] = 98, [1] = 20 }, [6] = { [0] = 111, [1] = 30 }, [7] = { [0] = 99, [1] = 19 } })[R[2]][R[1]], ({ [0] = { [0] = 97, [1] = 89 }, [1] = { [0] = 90, [1] = 85 }, [2] = { [0] = 104, [1] = 99 }, [3] = { [0] = 109, [1] = 99 }, [4] = { [0] = 105, [1] = 93 }, [5] = { [0] = 91, [1] = 80 }, [6] = { [0] = 100, [1] = 89 }, [7] = { [0] = 103, [1] = 92 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 101, [1] = 26 }, [1] = { [0] = 107, [1] = 26 }, [2] = { [0] = 112, [1] = 34 }, [3] = { [0] = 107, [1] = 24 }, [4] = { [0] = 114, [1] = 34 }, [5] = { [0] = 107, [1] = 29 }, [6] = { [0] = 120, [1] = 39 }, [7] = { [0] = 94, [1] = 14 } })[R[2]][R[1]], ({ [0] = { [0] = 94, [1] = 86 }, [1] = { [0] = 87, [1] = 82 }, [2] = { [0] = 105, [1] = 100 }, [3] = { [0] = 109, [1] = 99 }, [4] = { [0] = 96, [1] = 84 }, [5] = { [0] = 99, [1] = 88 }, [6] = { [0] = 97, [1] = 86 }, [7] = { [0] = 100, [1] = 89 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[1].difficulty] == 2 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 40 }, [1] = { [0] = 104, [1] = 23 }, [2] = { [0] = 98, [1] = 20 }, [3] = { [0] = 121, [1] = 38 }, [4] = { [0] = 111, [1] = 31 }, [5] = { [0] = 99, [1] = 21 }, [6] = { [0] = 119, [1] = 38 }, [7] = { [0] = 114, [1] = 34 } })[R[2]][R[1]], ({ [0] = { [0] = 103, [1] = 95 }, [1] = { [0] = 96, [1] = 91 }, [2] = { [0] = 101, [1] = 96 }, [3] = { [0] = 98, [1] = 88 }, [4] = { [0] = 109, [1] = 97 }, [5] = { [0] = 102, [1] = 91 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 97, [1] = 86 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = { [0] = 101, [1] = 26 }, [1] = { [0] = 104, [1] = 23 }, [2] = { [0] = 116, [1] = 38 }, [3] = { [0] = 119, [1] = 36 }, [4] = { [0] = 112, [1] = 32 }, [5] = { [0] = 98, [1] = 20 }, [6] = { [0] = 111, [1] = 30 }, [7] = { [0] = 99, [1] = 19 } })[R[2]][R[1]], ({ [0] = { [0] = 97, [1] = 89 }, [1] = { [0] = 90, [1] = 85 }, [2] = { [0] = 104, [1] = 99 }, [3] = { [0] = 94, [1] = 84 }, [4] = { [0] = 105, [1] = 93 }, [5] = { [0] = 91, [1] = 80 }, [6] = { [0] = 100, [1] = 89 }, [7] = { [0] = 103, [1] = 92 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 101, [1] = 26 }, [1] = { [0] = 107, [1] = 26 }, [2] = { [0] = 112, [1] = 34 }, [3] = { [0] = 107, [1] = 24 }, [4] = { [0] = 114, [1] = 34 }, [5] = { [0] = 107, [1] = 29 }, [6] = { [0] = 120, [1] = 39 }, [7] = { [0] = 94, [1] = 14 } })[R[2]][R[1]], ({ [0] = { [0] = 94, [1] = 86 }, [1] = { [0] = 87, [1] = 82 }, [2] = { [0] = 105, [1] = 100 }, [3] = { [0] = 109, [1] = 99 }, [4] = { [0] = 96, [1] = 84 }, [5] = { [0] = 99, [1] = 88 }, [6] = { [0] = 97, [1] = 86 }, [7] = { [0] = 100, [1] = 89 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[1].difficulty] == 1 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 40 }, [1] = { [0] = 104, [1] = 23 }, [2] = { [0] = 98, [1] = 20 }, [3] = { [0] = 121, [1] = 38 }, [4] = { [0] = 111, [1] = 31 }, [5] = { [0] = 99, [1] = 21 }, [6] = { [0] = 119, [1] = 38 }, [7] = { [0] = 114, [1] = 34 } })[R[2]][R[1]], ({ [0] = { [0] = 103, [1] = 95 }, [1] = { [0] = 96, [1] = 91 }, [2] = { [0] = 101, [1] = 96 }, [3] = { [0] = 98, [1] = 88 }, [4] = { [0] = 109, [1] = 97 }, [5] = { [0] = 102, [1] = 91 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 97, [1] = 86 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 40 }, [1] = { [0] = 104, [1] = 23 }, [2] = { [0] = 98, [1] = 20 }, [3] = { [0] = 119, [1] = 36 }, [4] = { [0] = 111, [1] = 31 }, [5] = { [0] = 99, [1] = 21 }, [6] = { [0] = 119, [1] = 38 }, [7] = { [0] = 114, [1] = 34 } })[R[2]][R[1]], ({ [0] = { [0] = 103, [1] = 95 }, [1] = { [0] = 96, [1] = 91 }, [2] = { [0] = 101, [1] = 96 }, [3] = { [0] = 94, [1] = 84 }, [4] = { [0] = 109, [1] = 97 }, [5] = { [0] = 102, [1] = 91 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 97, [1] = 86 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 101, [1] = 26 }, [1] = { [0] = 104, [1] = 23 }, [2] = { [0] = 116, [1] = 38 }, [3] = { [0] = 107, [1] = 24 }, [4] = { [0] = 112, [1] = 32 }, [5] = { [0] = 98, [1] = 20 }, [6] = { [0] = 111, [1] = 30 }, [7] = { [0] = 99, [1] = 19 } })[R[2]][R[1]], ({ [0] = { [0] = 97, [1] = 89 }, [1] = { [0] = 90, [1] = 85 }, [2] = { [0] = 104, [1] = 99 }, [3] = { [0] = 109, [1] = 99 }, [4] = { [0] = 105, [1] = 93 }, [5] = { [0] = 91, [1] = 80 }, [6] = { [0] = 100, [1] = 89 }, [7] = { [0] = 103, [1] = 92 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 101, [1] = 26 }, [1] = { [0] = 107, [1] = 26 }, [2] = { [0] = 112, [1] = 34 }, [3] = { [0] = 107, [1] = 24 }, [4] = { [0] = 114, [1] = 34 }, [5] = { [0] = 107, [1] = 29 }, [6] = { [0] = 120, [1] = 39 }, [7] = { [0] = 94, [1] = 14 } })[R[2]][R[1]], ({ [0] = { [0] = 94, [1] = 86 }, [1] = { [0] = 87, [1] = 82 }, [2] = { [0] = 105, [1] = 100 }, [3] = { [0] = 109, [1] = 99 }, [4] = { [0] = 96, [1] = 84 }, [5] = { [0] = 99, [1] = 88 }, [6] = { [0] = 97, [1] = 86 }, [7] = { [0] = 100, [1] = 89 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 122, [1] = 47 }, [1] = { [0] = 110, [1] = 29 }, [2] = { [0] = 108, [1] = 30 }, [3] = { [0] = 111, [1] = 28 }, [4] = { [0] = 120, [1] = 40 }, [5] = { [0] = 99, [1] = 21 }, [6] = { [0] = 120, [1] = 39 }, [7] = { [0] = 108, [1] = 28 } })[R[2]][R[1]], ({ [0] = { [0] = 105, [1] = 97 }, [1] = { [0] = 100, [1] = 95 }, [2] = { [0] = 98, [1] = 93 }, [3] = { [0] = 95, [1] = 85 }, [4] = { [0] = 92, [1] = 80 }, [5] = { [0] = 108, [1] = 97 }, [6] = { [0] = 100, [1] = 89 }, [7] = { [0] = 102, [1] = 91 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  game.create_tube({ ({ [0] = { [0] = 102, [1] = 27 }, [1] = { [0] = 104, [1] = 23 }, [2] = { [0] = 103, [1] = 25 }, [3] = { [0] = 103, [1] = 20 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 103, [1] = 25 }, [6] = { [0] = 106, [1] = 25 }, [7] = { [0] = 97, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 101, [1] = 96 }, [2] = { [0] = 96, [1] = 91 }, [3] = { [0] = 104, [1] = 94 }, [4] = { [0] = 95, [1] = 83 }, [5] = { [0] = 97, [1] = 86 }, [6] = { [0] = 92, [1] = 81 }, [7] = { [0] = 99, [1] = 88 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 103, [1] = 28 }, [1] = { [0] = 105, [1] = 24 }, [2] = { [0] = 104, [1] = 26 }, [3] = { [0] = 103, [1] = 20 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 103, [1] = 25 }, [6] = { [0] = 106, [1] = 25 }, [7] = { [0] = 97, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 101, [1] = 96 }, [2] = { [0] = 96, [1] = 91 }, [3] = { [0] = 105, [1] = 95 }, [4] = { [0] = 96, [1] = 84 }, [5] = { [0] = 98, [1] = 87 }, [6] = { [0] = 93, [1] = 82 }, [7] = { [0] = 100, [1] = 89 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 104, [1] = 29 }, [1] = { [0] = 106, [1] = 25 }, [2] = { [0] = 105, [1] = 27 }, [3] = { [0] = 103, [1] = 20 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 103, [1] = 25 }, [6] = { [0] = 106, [1] = 25 }, [7] = { [0] = 97, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 101, [1] = 96 }, [2] = { [0] = 96, [1] = 91 }, [3] = { [0] = 106, [1] = 96 }, [4] = { [0] = 97, [1] = 85 }, [5] = { [0] = 99, [1] = 88 }, [6] = { [0] = 94, [1] = 83 }, [7] = { [0] = 101, [1] = 90 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 105, [1] = 30 }, [1] = { [0] = 107, [1] = 26 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 104, [1] = 21 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 103, [1] = 25 }, [6] = { [0] = 106, [1] = 25 }, [7] = { [0] = 97, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 101, [1] = 96 }, [2] = { [0] = 93, [1] = 88 }, [3] = { [0] = 104, [1] = 94 }, [4] = { [0] = 98, [1] = 86 }, [5] = { [0] = 103, [1] = 92 }, [6] = { [0] = 95, [1] = 84 }, [7] = { [0] = 102, [1] = 91 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 106, [1] = 31 }, [1] = { [0] = 108, [1] = 27 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 105, [1] = 22 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 103, [1] = 25 }, [6] = { [0] = 106, [1] = 25 }, [7] = { [0] = 97, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 101, [1] = 96 }, [2] = { [0] = 94, [1] = 89 }, [3] = { [0] = 100, [1] = 90 }, [4] = { [0] = 99, [1] = 87 }, [5] = { [0] = 104, [1] = 93 }, [6] = { [0] = 96, [1] = 85 }, [7] = { [0] = 103, [1] = 92 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 107, [1] = 32 }, [1] = { [0] = 109, [1] = 28 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 105, [1] = 22 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 103, [1] = 25 }, [6] = { [0] = 109, [1] = 28 }, [7] = { [0] = 97, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 101, [1] = 96 }, [2] = { [0] = 95, [1] = 90 }, [3] = { [0] = 101, [1] = 91 }, [4] = { [0] = 103, [1] = 91 }, [5] = { [0] = 105, [1] = 94 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 104, [1] = 93 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 108, [1] = 33 }, [1] = { [0] = 110, [1] = 29 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 105, [1] = 22 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 106, [1] = 28 }, [6] = { [0] = 110, [1] = 29 }, [7] = { [0] = 97, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 101, [1] = 96 }, [2] = { [0] = 96, [1] = 91 }, [3] = { [0] = 102, [1] = 92 }, [4] = { [0] = 104, [1] = 92 }, [5] = { [0] = 101, [1] = 90 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 105, [1] = 94 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 111, [1] = 30 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 105, [1] = 22 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 106, [1] = 28 }, [6] = { [0] = 110, [1] = 29 }, [7] = { [0] = 97, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 96, [1] = 88 }, [1] = { [0] = 90, [1] = 85 }, [2] = { [0] = 97, [1] = 92 }, [3] = { [0] = 103, [1] = 93 }, [4] = { [0] = 105, [1] = 93 }, [5] = { [0] = 107, [1] = 96 }, [6] = { [0] = 98, [1] = 87 }, [7] = { [0] = 106, [1] = 95 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 111, [1] = 30 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 105, [1] = 22 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 107, [1] = 29 }, [6] = { [0] = 111, [1] = 30 }, [7] = { [0] = 97, [1] = 17 } })[R[2]][R[1]], ({ [0] = { [0] = 97, [1] = 89 }, [1] = { [0] = 91, [1] = 86 }, [2] = { [0] = 98, [1] = 93 }, [3] = { [0] = 104, [1] = 94 }, [4] = { [0] = 106, [1] = 94 }, [5] = { [0] = 101, [1] = 90 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 107, [1] = 96 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 111, [1] = 30 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 106, [1] = 23 }, [4] = { [0] = 107, [1] = 27 }, [5] = { [0] = 107, [1] = 29 }, [6] = { [0] = 111, [1] = 30 }, [7] = { [0] = 100, [1] = 20 } })[R[2]][R[1]], ({ [0] = { [0] = 98, [1] = 90 }, [1] = { [0] = 92, [1] = 87 }, [2] = { [0] = 99, [1] = 94 }, [3] = { [0] = 100, [1] = 90 }, [4] = { [0] = 107, [1] = 95 }, [5] = { [0] = 107, [1] = 96 }, [6] = { [0] = 98, [1] = 87 }, [7] = { [0] = 96, [1] = 85 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 111, [1] = 30 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 106, [1] = 23 }, [4] = { [0] = 110, [1] = 30 }, [5] = { [0] = 108, [1] = 30 }, [6] = { [0] = 112, [1] = 31 }, [7] = { [0] = 100, [1] = 20 } })[R[2]][R[1]], ({ [0] = { [0] = 99, [1] = 91 }, [1] = { [0] = 93, [1] = 88 }, [2] = { [0] = 100, [1] = 95 }, [3] = { [0] = 104, [1] = 94 }, [4] = { [0] = 93, [1] = 81 }, [5] = { [0] = 101, [1] = 90 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 109, [1] = 98 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 111, [1] = 30 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 107, [1] = 24 }, [4] = { [0] = 110, [1] = 30 }, [5] = { [0] = 108, [1] = 30 }, [6] = { [0] = 112, [1] = 31 }, [7] = { [0] = 101, [1] = 21 } })[R[2]][R[1]], ({ [0] = { [0] = 103, [1] = 95 }, [1] = { [0] = 101, [1] = 96 }, [2] = { [0] = 101, [1] = 96 }, [3] = { [0] = 104, [1] = 94 }, [4] = { [0] = 101, [1] = 89 }, [5] = { [0] = 107, [1] = 96 }, [6] = { [0] = 98, [1] = 87 }, [7] = { [0] = 96, [1] = 85 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 112, [1] = 31 }, [2] = { [0] = 106, [1] = 28 }, [3] = { [0] = 108, [1] = 25 }, [4] = { [0] = 110, [1] = 30 }, [5] = { [0] = 109, [1] = 31 }, [6] = { [0] = 113, [1] = 32 }, [7] = { [0] = 101, [1] = 21 } })[R[2]][R[1]], ({ [0] = { [0] = 104, [1] = 96 }, [1] = { [0] = 98, [1] = 93 }, [2] = { [0] = 102, [1] = 97 }, [3] = { [0] = 104, [1] = 94 }, [4] = { [0] = 109, [1] = 97 }, [5] = { [0] = 101, [1] = 90 }, [6] = { [0] = 90, [1] = 79 }, [7] = { [0] = 109, [1] = 98 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 112, [1] = 31 }, [2] = { [0] = 107, [1] = 29 }, [3] = { [0] = 109, [1] = 26 }, [4] = { [0] = 111, [1] = 31 }, [5] = { [0] = 109, [1] = 31 }, [6] = { [0] = 113, [1] = 32 }, [7] = { [0] = 102, [1] = 22 } })[R[2]][R[1]], ({ [0] = { [0] = 105, [1] = 97 }, [1] = { [0] = 99, [1] = 94 }, [2] = { [0] = 96, [1] = 91 }, [3] = { [0] = 97, [1] = 87 }, [4] = { [0] = 93, [1] = 81 }, [5] = { [0] = 107, [1] = 96 }, [6] = { [0] = 98, [1] = 87 }, [7] = { [0] = 96, [1] = 85 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 110, [1] = 35 }, [1] = { [0] = 112, [1] = 31 }, [2] = { [0] = 107, [1] = 29 }, [3] = { [0] = 109, [1] = 26 }, [4] = { [0] = 111, [1] = 31 }, [5] = { [0] = 110, [1] = 32 }, [6] = { [0] = 115, [1] = 34 }, [7] = { [0] = 102, [1] = 22 } })[R[2]][R[1]], ({ [0] = { [0] = 106, [1] = 98 }, [1] = { [0] = 100, [1] = 95 }, [2] = { [0] = 102, [1] = 97 }, [3] = { [0] = 104, [1] = 94 }, [4] = { [0] = 101, [1] = 89 }, [5] = { [0] = 101, [1] = 90 }, [6] = { [0] = 92, [1] = 81 }, [7] = { [0] = 109, [1] = 98 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 113, [1] = 38 }, [1] = { [0] = 112, [1] = 31 }, [2] = { [0] = 108, [1] = 30 }, [3] = { [0] = 110, [1] = 27 }, [4] = { [0] = 111, [1] = 31 }, [5] = { [0] = 110, [1] = 32 }, [6] = { [0] = 115, [1] = 34 }, [7] = { [0] = 103, [1] = 23 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 101, [1] = 96 }, [2] = { [0] = 96, [1] = 91 }, [3] = { [0] = 97, [1] = 87 }, [4] = { [0] = 109, [1] = 97 }, [5] = { [0] = 107, [1] = 96 }, [6] = { [0] = 93, [1] = 82 }, [7] = { [0] = 96, [1] = 85 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 39 }, [1] = { [0] = 112, [1] = 31 }, [2] = { [0] = 108, [1] = 30 }, [3] = { [0] = 111, [1] = 28 }, [4] = { [0] = 112, [1] = 32 }, [5] = { [0] = 111, [1] = 33 }, [6] = { [0] = 115, [1] = 34 }, [7] = { [0] = 103, [1] = 23 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 102, [1] = 97 }, [2] = { [0] = 102, [1] = 97 }, [3] = { [0] = 97, [1] = 87 }, [4] = { [0] = 93, [1] = 81 }, [5] = { [0] = 101, [1] = 90 }, [6] = { [0] = 94, [1] = 83 }, [7] = { [0] = 109, [1] = 98 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 115, [1] = 40 }, [1] = { [0] = 112, [1] = 31 }, [2] = { [0] = 109, [1] = 31 }, [3] = { [0] = 112, [1] = 29 }, [4] = { [0] = 112, [1] = 32 }, [5] = { [0] = 112, [1] = 34 }, [6] = { [0] = 115, [1] = 34 }, [7] = { [0] = 104, [1] = 24 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 103, [1] = 98 }, [2] = { [0] = 96, [1] = 91 }, [3] = { [0] = 97, [1] = 87 }, [4] = { [0] = 94, [1] = 82 }, [5] = { [0] = 101, [1] = 90 }, [6] = { [0] = 95, [1] = 84 }, [7] = { [0] = 96, [1] = 85 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 116, [1] = 41 }, [1] = { [0] = 112, [1] = 31 }, [2] = { [0] = 109, [1] = 31 }, [3] = { [0] = 113, [1] = 30 }, [4] = { [0] = 112, [1] = 32 }, [5] = { [0] = 113, [1] = 35 }, [6] = { [0] = 115, [1] = 34 }, [7] = { [0] = 104, [1] = 24 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 108, [1] = 103 }, [2] = { [0] = 102, [1] = 97 }, [3] = { [0] = 97, [1] = 87 }, [4] = { [0] = 101, [1] = 89 }, [5] = { [0] = 101, [1] = 90 }, [6] = { [0] = 96, [1] = 85 }, [7] = { [0] = 97, [1] = 86 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 117, [1] = 42 }, [1] = { [0] = 112, [1] = 31 }, [2] = { [0] = 110, [1] = 32 }, [3] = { [0] = 114, [1] = 31 }, [4] = { [0] = 112, [1] = 32 }, [5] = { [0] = 113, [1] = 35 }, [6] = { [0] = 119, [1] = 38 }, [7] = { [0] = 104, [1] = 24 } })[R[2]][R[1]], ({ [0] = { [0] = 101, [1] = 93 }, [1] = { [0] = 109, [1] = 104 }, [2] = { [0] = 96, [1] = 91 }, [3] = { [0] = 97, [1] = 87 }, [4] = { [0] = 109, [1] = 97 }, [5] = { [0] = 102, [1] = 91 }, [6] = { [0] = 98, [1] = 87 }, [7] = { [0] = 98, [1] = 87 } })[R[2]][R[1]] })
  if R[2] == 0 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 118, [1] = 43 })[R[1]], ({ [0] = 101, [1] = 93 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 44 })[R[1]], ({ [0] = 101, [1] = 93 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 118, [1] = 43 })[R[1]], ({ [0] = 101, [1] = 93 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 44 })[R[1]], ({ [0] = 101, [1] = 93 })[R[1]] })
      for i = 1, game.initial_units() do
        R[3] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 116, [1] = 41 }, [1] = { [0] = 118, [1] = 43 }, [2] = { [0] = 105, [1] = 30 } })[R[3]][R[1]], ({ [0] = { [0] = 95, [1] = 87 }, [1] = { [0] = 95, [1] = 87 }, [2] = { [0] = 106, [1] = 98 } })[R[3]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 112, [1] = 31 })[R[1]], ({ [0] = 110, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 31 })[R[1]], ({ [0] = 110, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 31 })[R[1]], ({ [0] = 111, [1] = 106 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 112, [1] = 31 })[R[1]], ({ [0] = 110, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 31 })[R[1]], ({ [0] = 110, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 31 })[R[1]], ({ [0] = 111, [1] = 106 })[R[1]] })
      for i = 1, game.initial_units() do
        R[4] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 22 }, [1] = { [0] = 105, [1] = 24 }, [2] = { [0] = 107, [1] = 26 } })[R[4]][R[1]], ({ [0] = { [0] = 105, [1] = 100 }, [1] = { [0] = 114, [1] = 109 }, [2] = { [0] = 99, [1] = 94 } })[R[4]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 2 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[5] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 101, [1] = 23 }, [1] = { [0] = 111, [1] = 33 }, [2] = { [0] = 106, [1] = 28 } })[R[5]][R[1]], ({ [0] = { [0] = 90, [1] = 85 }, [1] = { [0] = 90, [1] = 85 }, [2] = { [0] = 106, [1] = 101 } })[R[5]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 3 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 114, [1] = 31 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 32 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 33 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 34 })[R[1]], ({ [0] = 100, [1] = 90 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 34 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 35 })[R[1]], ({ [0] = 100, [1] = 90 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 35 })[R[1]], ({ [0] = 101, [1] = 91 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 35 })[R[1]], ({ [0] = 102, [1] = 92 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 35 })[R[1]], ({ [0] = 103, [1] = 93 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 35 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 36 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 36 })[R[1]], ({ [0] = 105, [1] = 95 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 36 })[R[1]], ({ [0] = 106, [1] = 96 })[R[1]] })
      for i = 1, game.initial_units() do
        R[6] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 111, [1] = 28 }, [1] = { [0] = 113, [1] = 30 }, [2] = { [0] = 100, [1] = 17 } })[R[6]][R[1]], ({ [0] = { [0] = 100, [1] = 90 }, [1] = { [0] = 107, [1] = 97 }, [2] = { [0] = 104, [1] = 94 } })[R[6]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 114, [1] = 31 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 32 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 33 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 34 })[R[1]], ({ [0] = 100, [1] = 90 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 34 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 35 })[R[1]], ({ [0] = 100, [1] = 90 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 35 })[R[1]], ({ [0] = 101, [1] = 91 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 35 })[R[1]], ({ [0] = 102, [1] = 92 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 35 })[R[1]], ({ [0] = 103, [1] = 93 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 35 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 36 })[R[1]], ({ [0] = 104, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 36 })[R[1]], ({ [0] = 105, [1] = 95 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 36 })[R[1]], ({ [0] = 106, [1] = 96 })[R[1]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 113, [1] = 33 })[R[1]], ({ [0] = 94, [1] = 82 })[R[1]] })
      game.create_tube({ ({ [0] = 113, [1] = 33 })[R[1]], ({ [0] = 95, [1] = 83 })[R[1]] })
      game.create_tube({ ({ [0] = 113, [1] = 33 })[R[1]], ({ [0] = 101, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 113, [1] = 33 })[R[1]], ({ [0] = 109, [1] = 97 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 34 })[R[1]], ({ [0] = 95, [1] = 83 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 34 })[R[1]], ({ [0] = 101, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 34 })[R[1]], ({ [0] = 109, [1] = 97 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 35 })[R[1]], ({ [0] = 95, [1] = 83 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 35 })[R[1]], ({ [0] = 101, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 35 })[R[1]], ({ [0] = 109, [1] = 97 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 100, [1] = 88 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 101, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 102, [1] = 90 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 103, [1] = 91 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 108, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 109, [1] = 97 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 37 })[R[1]], ({ [0] = 100, [1] = 88 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 37 })[R[1]], ({ [0] = 108, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 38 })[R[1]], ({ [0] = 98, [1] = 86 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 38 })[R[1]], ({ [0] = 99, [1] = 87 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 38 })[R[1]], ({ [0] = 100, [1] = 88 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 38 })[R[1]], ({ [0] = 108, [1] = 96 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 113, [1] = 33 })[R[1]], ({ [0] = 94, [1] = 82 })[R[1]] })
      game.create_tube({ ({ [0] = 113, [1] = 33 })[R[1]], ({ [0] = 95, [1] = 83 })[R[1]] })
      game.create_tube({ ({ [0] = 113, [1] = 33 })[R[1]], ({ [0] = 101, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 113, [1] = 33 })[R[1]], ({ [0] = 109, [1] = 97 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 34 })[R[1]], ({ [0] = 95, [1] = 83 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 34 })[R[1]], ({ [0] = 101, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 34 })[R[1]], ({ [0] = 109, [1] = 97 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 35 })[R[1]], ({ [0] = 95, [1] = 83 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 35 })[R[1]], ({ [0] = 101, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 35 })[R[1]], ({ [0] = 109, [1] = 97 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 100, [1] = 88 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 101, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 102, [1] = 90 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 103, [1] = 91 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 108, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 36 })[R[1]], ({ [0] = 109, [1] = 97 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 37 })[R[1]], ({ [0] = 100, [1] = 88 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 37 })[R[1]], ({ [0] = 108, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 38 })[R[1]], ({ [0] = 98, [1] = 86 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 38 })[R[1]], ({ [0] = 99, [1] = 87 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 38 })[R[1]], ({ [0] = 100, [1] = 88 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 38 })[R[1]], ({ [0] = 108, [1] = 96 })[R[1]] })
      for i = 1, game.initial_units() do
        R[7] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 111, [1] = 31 }, [1] = { [0] = 104, [1] = 24 }, [2] = { [0] = 100, [1] = 20 } })[R[7]][R[1]], ({ [0] = { [0] = 92, [1] = 80 }, [1] = { [0] = 92, [1] = 80 }, [2] = { [0] = 101, [1] = 89 } })[R[7]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 5 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 113, [1] = 35 })[R[1]], ({ [0] = 103, [1] = 92 })[R[1]] })
      game.create_tube({ ({ [0] = 113, [1] = 35 })[R[1]], ({ [0] = 104, [1] = 93 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 113, [1] = 35 })[R[1]], ({ [0] = 103, [1] = 92 })[R[1]] })
      game.create_tube({ ({ [0] = 113, [1] = 35 })[R[1]], ({ [0] = 104, [1] = 93 })[R[1]] })
      for i = 1, game.initial_units() do
        R[8] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 109, [1] = 31 }, [1] = { [0] = 114, [1] = 36 }, [2] = { [0] = 92, [1] = 14 } })[R[8]][R[1]], ({ [0] = { [0] = 110, [1] = 99 }, [1] = { [0] = 110, [1] = 99 }, [2] = { [0] = 97, [1] = 86 } })[R[8]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 6 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 120, [1] = 39 })[R[1]], ({ [0] = 98, [1] = 87 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 40 })[R[1]], ({ [0] = 98, [1] = 87 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 41 })[R[1]], ({ [0] = 98, [1] = 87 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 120, [1] = 39 })[R[1]], ({ [0] = 98, [1] = 87 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 40 })[R[1]], ({ [0] = 98, [1] = 87 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 41 })[R[1]], ({ [0] = 98, [1] = 87 })[R[1]] })
      for i = 1, game.initial_units() do
        R[9] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 101, [1] = 20 }, [1] = { [0] = 106, [1] = 25 }, [2] = { [0] = 129, [1] = 48 } })[R[9]][R[1]], ({ [0] = { [0] = 88, [1] = 77 }, [1] = { [0] = 86, [1] = 75 }, [2] = { [0] = 99, [1] = 88 } })[R[9]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 7 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 99, [1] = 88 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 100, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 101, [1] = 90 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 105, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 106, [1] = 95 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 107, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 108, [1] = 97 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 105, [1] = 25 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 105, [1] = 25 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 106, [1] = 26 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 106, [1] = 26 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 107, [1] = 27 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 107, [1] = 27 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 108, [1] = 28 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 108, [1] = 28 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 109, [1] = 29 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 109, [1] = 29 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 110, [1] = 30 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 110, [1] = 30 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 98, [1] = 87 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 99, [1] = 88 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 100, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 101, [1] = 90 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 102, [1] = 91 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 103, [1] = 92 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 104, [1] = 93 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 105, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 106, [1] = 95 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 99, [1] = 88 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 100, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 101, [1] = 90 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 105, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 106, [1] = 95 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 107, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 108, [1] = 97 })[R[1]] })
      game.create_tube({ ({ [0] = 104, [1] = 24 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 105, [1] = 25 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 105, [1] = 25 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 106, [1] = 26 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 106, [1] = 26 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 107, [1] = 27 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 107, [1] = 27 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 108, [1] = 28 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 108, [1] = 28 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 109, [1] = 29 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 109, [1] = 29 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 110, [1] = 30 })[R[1]], ({ [0] = 96, [1] = 85 })[R[1]] })
      game.create_tube({ ({ [0] = 110, [1] = 30 })[R[1]], ({ [0] = 109, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 98, [1] = 87 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 99, [1] = 88 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 100, [1] = 89 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 101, [1] = 90 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 102, [1] = 91 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 103, [1] = 92 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 104, [1] = 93 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 105, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 112, [1] = 32 })[R[1]], ({ [0] = 106, [1] = 95 })[R[1]] })
      for i = 1, game.initial_units() do
        R[10] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 102, [1] = 22 }, [1] = { [0] = 108, [1] = 28 }, [2] = { [0] = 98, [1] = 18 } })[R[10]][R[1]], ({ [0] = { [0] = 92, [1] = 81 }, [1] = { [0] = 92, [1] = 81 }, [2] = { [0] = 113, [1] = 102 } })[R[10]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[2]", R[2])
  end
  R[11] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 20, [1] = 101 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 28, [1] = 111 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 25, [1] = 103 }, [6] = { [0] = 25, [1] = 106 }, [7] = { [0] = 24, [1] = 104 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 96, [1] = 101 }, [2] = { [0] = 86, [1] = 91 }, [3] = { [0] = 94, [1] = 104 }, [4] = { [0] = 89, [1] = 101 }, [5] = { [0] = 90, [1] = 101 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 92, [1] = 103 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  players[2]:center_view({ ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 20, [1] = 101 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 28, [1] = 111 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 25, [1] = 103 }, [6] = { [0] = 25, [1] = 106 }, [7] = { [0] = 24, [1] = 104 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 96, [1] = 101 }, [2] = { [0] = 86, [1] = 91 }, [3] = { [0] = 94, [1] = 104 }, [4] = { [0] = 89, [1] = 101 }, [5] = { [0] = 90, [1] = 101 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 92, [1] = 103 } })[R[11]][R[1]] })
  U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 30, [1] = 111 }, [2] = { [0] = 22, [1] = 100 }, [3] = { [0] = 36, [1] = 119 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 25, [1] = 103 }, [6] = { [0] = 34, [1] = 115 }, [7] = { [0] = 17, [1] = 97 } })[R[11]][R[1]], ({ [0] = { [0] = 86, [1] = 94 }, [1] = { [0] = 83, [1] = 88 }, [2] = { [0] = 91, [1] = 96 }, [3] = { [0] = 98, [1] = 108 }, [4] = { [0] = 97, [1] = 109 }, [5] = { [0] = 96, [1] = 107 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 98, [1] = 109 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  if R[11] == 0 or R[11] == 1 or R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 47, [1] = 122 }, [1] = { [0] = 31, [1] = 112 }, [2] = { [0] = 25, [1] = 103 }, [5] = { [0] = 35, [1] = 113 }, [6] = { [0] = 35, [1] = 116 }, [7] = { [0] = 17, [1] = 97 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 90, [1] = 95 }, [2] = { [0] = 97, [1] = 102 }, [5] = { [0] = 95, [1] = 106 }, [6] = { [0] = 87, [1] = 98 }, [7] = { [0] = 85, [1] = 96 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 0 then
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
    elseif R[11] == 1 then
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
    elseif R[11] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 34, [1] = 112 })[R[1]], ({ [0] = 91, [1] = 96 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 34, [1] = 112 })[R[1]], ({ [0] = 91, [1] = 96 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 34, [1] = 112 })[R[1]], ({ [0] = 91, [1] = 96 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 35, [1] = 113 })[R[1]], ({ [0] = 88, [1] = 99 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 35, [1] = 113 })[R[1]], ({ [0] = 88, [1] = 99 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 35, [1] = 113 })[R[1]], ({ [0] = 88, [1] = 99 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 43, [1] = 124 })[R[1]], ({ [0] = 87, [1] = 98 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 43, [1] = 124 })[R[1]], ({ [0] = 87, [1] = 98 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 43, [1] = 124 })[R[1]], ({ [0] = 87, [1] = 98 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 7 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 99 }, [1] = { [0] = 31, [1] = 112 }, [2] = { [0] = 34, [1] = 112 }, [5] = { [0] = 25, [1] = 103 }, [6] = { [0] = 26, [1] = 107 }, [7] = { [0] = 33, [1] = 113 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 100, [1] = 105 }, [2] = { [0] = 97, [1] = 102 }, [5] = { [0] = 83, [1] = 94 }, [6] = { [0] = 87, [1] = 98 }, [7] = { [0] = 97, [1] = 108 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
    elseif R[11] == 0 or R[11] == 1 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 30, [1] = 111 } })[R[11]][R[1]], ({ [0] = { [0] = 100, [1] = 108 }, [1] = { [0] = 108, [1] = 113 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
  elseif R[11] == 3 or R[11] == 4 then
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 20, [1] = 103 }, [4] = { [0] = 27, [1] = 107 } })[R[11]][R[1]], ({ [3] = { [0] = 98, [1] = 108 }, [4] = { [0] = 81, [1] = 93 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 38, [1] = 118 })[R[1]], ({ [0] = 83, [1] = 95 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 38, [1] = 118 })[R[1]], ({ [0] = 93, [1] = 105 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
    elseif R[11] == 3 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 23, [1] = 106 })[R[1]], ({ [0] = 87, [1] = 97 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 34, [1] = 117 })[R[1]], ({ [0] = 87, [1] = 97 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
  else
    unseen("R[11]", R[11])
  end
  U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 101 }, [1] = { [0] = 21, [1] = 102 }, [2] = { [0] = 42, [1] = 120 }, [3] = { [0] = 29, [1] = 112 }, [4] = { [0] = 19, [1] = 99 }, [5] = { [0] = 15, [1] = 93 }, [6] = { [0] = 18, [1] = 99 }, [7] = { [0] = 25, [1] = 105 } })[R[11]][R[1]], ({ [0] = { [0] = 100, [1] = 108 }, [1] = { [0] = 105, [1] = 110 }, [2] = { [0] = 91, [1] = 96 }, [3] = { [0] = 81, [1] = 91 }, [4] = { [0] = 85, [1] = 97 }, [5] = { [0] = 90, [1] = 101 }, [6] = { [0] = 87, [1] = 98 }, [7] = { [0] = 101, [1] = 112 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 106 }, [1] = { [0] = 20, [1] = 101 }, [2] = { [0] = 38, [1] = 116 }, [3] = { [0] = 18, [1] = 101 }, [4] = { [0] = 37, [1] = 117 }, [5] = { [0] = 33, [1] = 111 }, [6] = { [0] = 25, [1] = 106 }, [7] = { [0] = 35, [1] = 115 } })[R[11]][R[1]], ({ [0] = { [0] = 89, [1] = 97 }, [1] = { [0] = 91, [1] = 96 }, [2] = { [0] = 95, [1] = 100 }, [3] = { [0] = 88, [1] = 98 }, [4] = { [0] = 89, [1] = 101 }, [5] = { [0] = 81, [1] = 92 }, [6] = { [0] = 92, [1] = 103 }, [7] = { [0] = 92, [1] = 103 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 104 }, [1] = { [0] = 20, [1] = 101 }, [2] = { [0] = 38, [1] = 116 }, [3] = { [0] = 21, [1] = 104 }, [4] = { [0] = 39, [1] = 119 }, [5] = { [0] = 33, [1] = 111 }, [6] = { [0] = 23, [1] = 104 }, [7] = { [0] = 35, [1] = 115 } })[R[11]][R[1]], ({ [0] = { [0] = 89, [1] = 97 }, [1] = { [0] = 89, [1] = 94 }, [2] = { [0] = 93, [1] = 98 }, [3] = { [0] = 84, [1] = 94 }, [4] = { [0] = 89, [1] = 101 }, [5] = { [0] = 83, [1] = 94 }, [6] = { [0] = 92, [1] = 103 }, [7] = { [0] = 94, [1] = 105 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if LEVEL_OF[players[2].difficulty] == 0 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 40, [1] = 115 }, [1] = { [0] = 23, [1] = 104 }, [2] = { [0] = 20, [1] = 98 }, [3] = { [0] = 38, [1] = 121 }, [4] = { [0] = 31, [1] = 111 }, [5] = { [0] = 21, [1] = 99 }, [6] = { [0] = 38, [1] = 119 }, [7] = { [0] = 34, [1] = 114 } })[R[11]][R[1]], ({ [0] = { [0] = 95, [1] = 103 }, [1] = { [0] = 91, [1] = 96 }, [2] = { [0] = 96, [1] = 101 }, [3] = { [0] = 88, [1] = 98 }, [4] = { [0] = 97, [1] = 109 }, [5] = { [0] = 91, [1] = 102 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 86, [1] = 97 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 40, [1] = 115 }, [1] = { [0] = 23, [1] = 104 }, [2] = { [0] = 20, [1] = 98 }, [3] = { [0] = 36, [1] = 119 }, [4] = { [0] = 31, [1] = 111 }, [5] = { [0] = 21, [1] = 99 }, [6] = { [0] = 38, [1] = 119 }, [7] = { [0] = 34, [1] = 114 } })[R[11]][R[1]], ({ [0] = { [0] = 95, [1] = 103 }, [1] = { [0] = 91, [1] = 96 }, [2] = { [0] = 96, [1] = 101 }, [3] = { [0] = 84, [1] = 94 }, [4] = { [0] = 97, [1] = 109 }, [5] = { [0] = 91, [1] = 102 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 86, [1] = 97 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 40, [1] = 115 }, [1] = { [0] = 23, [1] = 104 }, [2] = { [0] = 20, [1] = 98 }, [3] = { [0] = 24, [1] = 107 }, [4] = { [0] = 31, [1] = 111 }, [5] = { [0] = 21, [1] = 99 }, [6] = { [0] = 38, [1] = 119 }, [7] = { [0] = 34, [1] = 114 } })[R[11]][R[1]], ({ [0] = { [0] = 95, [1] = 103 }, [1] = { [0] = 91, [1] = 96 }, [2] = { [0] = 96, [1] = 101 }, [3] = { [0] = 99, [1] = 109 }, [4] = { [0] = 97, [1] = 109 }, [5] = { [0] = 91, [1] = 102 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 86, [1] = 97 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 101 }, [1] = { [0] = 23, [1] = 104 }, [2] = { [0] = 38, [1] = 116 }, [3] = { [0] = 24, [1] = 107 }, [4] = { [0] = 32, [1] = 112 }, [5] = { [0] = 20, [1] = 98 }, [6] = { [0] = 30, [1] = 111 }, [7] = { [0] = 19, [1] = 99 } })[R[11]][R[1]], ({ [0] = { [0] = 89, [1] = 97 }, [1] = { [0] = 85, [1] = 90 }, [2] = { [0] = 99, [1] = 104 }, [3] = { [0] = 99, [1] = 109 }, [4] = { [0] = 93, [1] = 105 }, [5] = { [0] = 80, [1] = 91 }, [6] = { [0] = 89, [1] = 100 }, [7] = { [0] = 92, [1] = 103 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 101 }, [1] = { [0] = 26, [1] = 107 }, [2] = { [0] = 34, [1] = 112 }, [3] = { [0] = 24, [1] = 107 }, [4] = { [0] = 34, [1] = 114 }, [5] = { [0] = 29, [1] = 107 }, [6] = { [0] = 39, [1] = 120 }, [7] = { [0] = 14, [1] = 94 } })[R[11]][R[1]], ({ [0] = { [0] = 86, [1] = 94 }, [1] = { [0] = 82, [1] = 87 }, [2] = { [0] = 100, [1] = 105 }, [3] = { [0] = 99, [1] = 109 }, [4] = { [0] = 84, [1] = 96 }, [5] = { [0] = 88, [1] = 99 }, [6] = { [0] = 86, [1] = 97 }, [7] = { [0] = 89, [1] = 100 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[2].difficulty] == 2 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 40, [1] = 115 }, [1] = { [0] = 23, [1] = 104 }, [2] = { [0] = 20, [1] = 98 }, [3] = { [0] = 38, [1] = 121 }, [4] = { [0] = 31, [1] = 111 }, [5] = { [0] = 21, [1] = 99 }, [6] = { [0] = 38, [1] = 119 }, [7] = { [0] = 34, [1] = 114 } })[R[11]][R[1]], ({ [0] = { [0] = 95, [1] = 103 }, [1] = { [0] = 91, [1] = 96 }, [2] = { [0] = 96, [1] = 101 }, [3] = { [0] = 88, [1] = 98 }, [4] = { [0] = 97, [1] = 109 }, [5] = { [0] = 91, [1] = 102 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 86, [1] = 97 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 101 }, [1] = { [0] = 23, [1] = 104 }, [2] = { [0] = 38, [1] = 116 }, [3] = { [0] = 36, [1] = 119 }, [4] = { [0] = 32, [1] = 112 }, [5] = { [0] = 20, [1] = 98 }, [6] = { [0] = 30, [1] = 111 }, [7] = { [0] = 19, [1] = 99 } })[R[11]][R[1]], ({ [0] = { [0] = 89, [1] = 97 }, [1] = { [0] = 85, [1] = 90 }, [2] = { [0] = 99, [1] = 104 }, [3] = { [0] = 84, [1] = 94 }, [4] = { [0] = 93, [1] = 105 }, [5] = { [0] = 80, [1] = 91 }, [6] = { [0] = 89, [1] = 100 }, [7] = { [0] = 92, [1] = 103 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 101 }, [1] = { [0] = 26, [1] = 107 }, [2] = { [0] = 34, [1] = 112 }, [3] = { [0] = 24, [1] = 107 }, [4] = { [0] = 34, [1] = 114 }, [5] = { [0] = 29, [1] = 107 }, [6] = { [0] = 39, [1] = 120 }, [7] = { [0] = 14, [1] = 94 } })[R[11]][R[1]], ({ [0] = { [0] = 86, [1] = 94 }, [1] = { [0] = 82, [1] = 87 }, [2] = { [0] = 100, [1] = 105 }, [3] = { [0] = 99, [1] = 109 }, [4] = { [0] = 84, [1] = 96 }, [5] = { [0] = 88, [1] = 99 }, [6] = { [0] = 86, [1] = 97 }, [7] = { [0] = 89, [1] = 100 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[2].difficulty] == 1 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 40, [1] = 115 }, [1] = { [0] = 23, [1] = 104 }, [2] = { [0] = 20, [1] = 98 }, [3] = { [0] = 38, [1] = 121 }, [4] = { [0] = 31, [1] = 111 }, [5] = { [0] = 21, [1] = 99 }, [6] = { [0] = 38, [1] = 119 }, [7] = { [0] = 34, [1] = 114 } })[R[11]][R[1]], ({ [0] = { [0] = 95, [1] = 103 }, [1] = { [0] = 91, [1] = 96 }, [2] = { [0] = 96, [1] = 101 }, [3] = { [0] = 88, [1] = 98 }, [4] = { [0] = 97, [1] = 109 }, [5] = { [0] = 91, [1] = 102 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 86, [1] = 97 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 40, [1] = 115 }, [1] = { [0] = 23, [1] = 104 }, [2] = { [0] = 20, [1] = 98 }, [3] = { [0] = 36, [1] = 119 }, [4] = { [0] = 31, [1] = 111 }, [5] = { [0] = 21, [1] = 99 }, [6] = { [0] = 38, [1] = 119 }, [7] = { [0] = 34, [1] = 114 } })[R[11]][R[1]], ({ [0] = { [0] = 95, [1] = 103 }, [1] = { [0] = 91, [1] = 96 }, [2] = { [0] = 96, [1] = 101 }, [3] = { [0] = 84, [1] = 94 }, [4] = { [0] = 97, [1] = 109 }, [5] = { [0] = 91, [1] = 102 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 86, [1] = 97 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 101 }, [1] = { [0] = 23, [1] = 104 }, [2] = { [0] = 38, [1] = 116 }, [3] = { [0] = 24, [1] = 107 }, [4] = { [0] = 32, [1] = 112 }, [5] = { [0] = 20, [1] = 98 }, [6] = { [0] = 30, [1] = 111 }, [7] = { [0] = 19, [1] = 99 } })[R[11]][R[1]], ({ [0] = { [0] = 89, [1] = 97 }, [1] = { [0] = 85, [1] = 90 }, [2] = { [0] = 99, [1] = 104 }, [3] = { [0] = 99, [1] = 109 }, [4] = { [0] = 93, [1] = 105 }, [5] = { [0] = 80, [1] = 91 }, [6] = { [0] = 89, [1] = 100 }, [7] = { [0] = 92, [1] = 103 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 26, [1] = 101 }, [1] = { [0] = 26, [1] = 107 }, [2] = { [0] = 34, [1] = 112 }, [3] = { [0] = 24, [1] = 107 }, [4] = { [0] = 34, [1] = 114 }, [5] = { [0] = 29, [1] = 107 }, [6] = { [0] = 39, [1] = 120 }, [7] = { [0] = 14, [1] = 94 } })[R[11]][R[1]], ({ [0] = { [0] = 86, [1] = 94 }, [1] = { [0] = 82, [1] = 87 }, [2] = { [0] = 100, [1] = 105 }, [3] = { [0] = 99, [1] = 109 }, [4] = { [0] = 84, [1] = 96 }, [5] = { [0] = 88, [1] = 99 }, [6] = { [0] = 86, [1] = 97 }, [7] = { [0] = 89, [1] = 100 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 47, [1] = 122 }, [1] = { [0] = 29, [1] = 110 }, [2] = { [0] = 30, [1] = 108 }, [3] = { [0] = 28, [1] = 111 }, [4] = { [0] = 40, [1] = 120 }, [5] = { [0] = 21, [1] = 99 }, [6] = { [0] = 39, [1] = 120 }, [7] = { [0] = 28, [1] = 108 } })[R[11]][R[1]], ({ [0] = { [0] = 97, [1] = 105 }, [1] = { [0] = 95, [1] = 100 }, [2] = { [0] = 93, [1] = 98 }, [3] = { [0] = 85, [1] = 95 }, [4] = { [0] = 80, [1] = 92 }, [5] = { [0] = 97, [1] = 108 }, [6] = { [0] = 89, [1] = 100 }, [7] = { [0] = 91, [1] = 102 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  game.create_tube({ ({ [0] = { [0] = 27, [1] = 102 }, [1] = { [0] = 23, [1] = 104 }, [2] = { [0] = 25, [1] = 103 }, [3] = { [0] = 20, [1] = 103 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 25, [1] = 103 }, [6] = { [0] = 25, [1] = 106 }, [7] = { [0] = 17, [1] = 97 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 96, [1] = 101 }, [2] = { [0] = 91, [1] = 96 }, [3] = { [0] = 94, [1] = 104 }, [4] = { [0] = 83, [1] = 95 }, [5] = { [0] = 86, [1] = 97 }, [6] = { [0] = 81, [1] = 92 }, [7] = { [0] = 88, [1] = 99 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 28, [1] = 103 }, [1] = { [0] = 24, [1] = 105 }, [2] = { [0] = 26, [1] = 104 }, [3] = { [0] = 20, [1] = 103 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 25, [1] = 103 }, [6] = { [0] = 25, [1] = 106 }, [7] = { [0] = 17, [1] = 97 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 96, [1] = 101 }, [2] = { [0] = 91, [1] = 96 }, [3] = { [0] = 95, [1] = 105 }, [4] = { [0] = 84, [1] = 96 }, [5] = { [0] = 87, [1] = 98 }, [6] = { [0] = 82, [1] = 93 }, [7] = { [0] = 89, [1] = 100 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 29, [1] = 104 }, [1] = { [0] = 25, [1] = 106 }, [2] = { [0] = 27, [1] = 105 }, [3] = { [0] = 20, [1] = 103 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 25, [1] = 103 }, [6] = { [0] = 25, [1] = 106 }, [7] = { [0] = 17, [1] = 97 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 96, [1] = 101 }, [2] = { [0] = 91, [1] = 96 }, [3] = { [0] = 96, [1] = 106 }, [4] = { [0] = 85, [1] = 97 }, [5] = { [0] = 88, [1] = 99 }, [6] = { [0] = 83, [1] = 94 }, [7] = { [0] = 90, [1] = 101 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 30, [1] = 105 }, [1] = { [0] = 26, [1] = 107 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 21, [1] = 104 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 25, [1] = 103 }, [6] = { [0] = 25, [1] = 106 }, [7] = { [0] = 17, [1] = 97 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 96, [1] = 101 }, [2] = { [0] = 88, [1] = 93 }, [3] = { [0] = 94, [1] = 104 }, [4] = { [0] = 86, [1] = 98 }, [5] = { [0] = 92, [1] = 103 }, [6] = { [0] = 84, [1] = 95 }, [7] = { [0] = 91, [1] = 102 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 31, [1] = 106 }, [1] = { [0] = 27, [1] = 108 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 22, [1] = 105 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 25, [1] = 103 }, [6] = { [0] = 25, [1] = 106 }, [7] = { [0] = 17, [1] = 97 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 96, [1] = 101 }, [2] = { [0] = 89, [1] = 94 }, [3] = { [0] = 90, [1] = 100 }, [4] = { [0] = 87, [1] = 99 }, [5] = { [0] = 93, [1] = 104 }, [6] = { [0] = 85, [1] = 96 }, [7] = { [0] = 92, [1] = 103 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 32, [1] = 107 }, [1] = { [0] = 28, [1] = 109 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 22, [1] = 105 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 25, [1] = 103 }, [6] = { [0] = 28, [1] = 109 }, [7] = { [0] = 17, [1] = 97 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 96, [1] = 101 }, [2] = { [0] = 90, [1] = 95 }, [3] = { [0] = 91, [1] = 101 }, [4] = { [0] = 91, [1] = 103 }, [5] = { [0] = 94, [1] = 105 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 93, [1] = 104 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 33, [1] = 108 }, [1] = { [0] = 29, [1] = 110 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 22, [1] = 105 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 28, [1] = 106 }, [6] = { [0] = 29, [1] = 110 }, [7] = { [0] = 17, [1] = 97 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 96, [1] = 101 }, [2] = { [0] = 91, [1] = 96 }, [3] = { [0] = 92, [1] = 102 }, [4] = { [0] = 92, [1] = 104 }, [5] = { [0] = 90, [1] = 101 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 94, [1] = 105 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 30, [1] = 111 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 22, [1] = 105 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 28, [1] = 106 }, [6] = { [0] = 29, [1] = 110 }, [7] = { [0] = 17, [1] = 97 } })[R[11]][R[1]], ({ [0] = { [0] = 88, [1] = 96 }, [1] = { [0] = 85, [1] = 90 }, [2] = { [0] = 92, [1] = 97 }, [3] = { [0] = 93, [1] = 103 }, [4] = { [0] = 93, [1] = 105 }, [5] = { [0] = 96, [1] = 107 }, [6] = { [0] = 87, [1] = 98 }, [7] = { [0] = 95, [1] = 106 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 30, [1] = 111 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 22, [1] = 105 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 29, [1] = 107 }, [6] = { [0] = 30, [1] = 111 }, [7] = { [0] = 17, [1] = 97 } })[R[11]][R[1]], ({ [0] = { [0] = 89, [1] = 97 }, [1] = { [0] = 86, [1] = 91 }, [2] = { [0] = 93, [1] = 98 }, [3] = { [0] = 94, [1] = 104 }, [4] = { [0] = 94, [1] = 106 }, [5] = { [0] = 90, [1] = 101 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 96, [1] = 107 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 30, [1] = 111 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 23, [1] = 106 }, [4] = { [0] = 27, [1] = 107 }, [5] = { [0] = 29, [1] = 107 }, [6] = { [0] = 30, [1] = 111 }, [7] = { [0] = 20, [1] = 100 } })[R[11]][R[1]], ({ [0] = { [0] = 90, [1] = 98 }, [1] = { [0] = 87, [1] = 92 }, [2] = { [0] = 94, [1] = 99 }, [3] = { [0] = 90, [1] = 100 }, [4] = { [0] = 95, [1] = 107 }, [5] = { [0] = 96, [1] = 107 }, [6] = { [0] = 87, [1] = 98 }, [7] = { [0] = 85, [1] = 96 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 30, [1] = 111 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 23, [1] = 106 }, [4] = { [0] = 30, [1] = 110 }, [5] = { [0] = 30, [1] = 108 }, [6] = { [0] = 31, [1] = 112 }, [7] = { [0] = 20, [1] = 100 } })[R[11]][R[1]], ({ [0] = { [0] = 91, [1] = 99 }, [1] = { [0] = 88, [1] = 93 }, [2] = { [0] = 95, [1] = 100 }, [3] = { [0] = 94, [1] = 104 }, [4] = { [0] = 81, [1] = 93 }, [5] = { [0] = 90, [1] = 101 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 98, [1] = 109 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 30, [1] = 111 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 24, [1] = 107 }, [4] = { [0] = 30, [1] = 110 }, [5] = { [0] = 30, [1] = 108 }, [6] = { [0] = 31, [1] = 112 }, [7] = { [0] = 21, [1] = 101 } })[R[11]][R[1]], ({ [0] = { [0] = 95, [1] = 103 }, [1] = { [0] = 96, [1] = 101 }, [2] = { [0] = 96, [1] = 101 }, [3] = { [0] = 94, [1] = 104 }, [4] = { [0] = 89, [1] = 101 }, [5] = { [0] = 96, [1] = 107 }, [6] = { [0] = 87, [1] = 98 }, [7] = { [0] = 85, [1] = 96 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 31, [1] = 112 }, [2] = { [0] = 28, [1] = 106 }, [3] = { [0] = 25, [1] = 108 }, [4] = { [0] = 30, [1] = 110 }, [5] = { [0] = 31, [1] = 109 }, [6] = { [0] = 32, [1] = 113 }, [7] = { [0] = 21, [1] = 101 } })[R[11]][R[1]], ({ [0] = { [0] = 96, [1] = 104 }, [1] = { [0] = 93, [1] = 98 }, [2] = { [0] = 97, [1] = 102 }, [3] = { [0] = 94, [1] = 104 }, [4] = { [0] = 97, [1] = 109 }, [5] = { [0] = 90, [1] = 101 }, [6] = { [0] = 79, [1] = 90 }, [7] = { [0] = 98, [1] = 109 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 31, [1] = 112 }, [2] = { [0] = 29, [1] = 107 }, [3] = { [0] = 26, [1] = 109 }, [4] = { [0] = 31, [1] = 111 }, [5] = { [0] = 31, [1] = 109 }, [6] = { [0] = 32, [1] = 113 }, [7] = { [0] = 22, [1] = 102 } })[R[11]][R[1]], ({ [0] = { [0] = 97, [1] = 105 }, [1] = { [0] = 94, [1] = 99 }, [2] = { [0] = 91, [1] = 96 }, [3] = { [0] = 87, [1] = 97 }, [4] = { [0] = 81, [1] = 93 }, [5] = { [0] = 96, [1] = 107 }, [6] = { [0] = 87, [1] = 98 }, [7] = { [0] = 85, [1] = 96 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 35, [1] = 110 }, [1] = { [0] = 31, [1] = 112 }, [2] = { [0] = 29, [1] = 107 }, [3] = { [0] = 26, [1] = 109 }, [4] = { [0] = 31, [1] = 111 }, [5] = { [0] = 32, [1] = 110 }, [6] = { [0] = 34, [1] = 115 }, [7] = { [0] = 22, [1] = 102 } })[R[11]][R[1]], ({ [0] = { [0] = 98, [1] = 106 }, [1] = { [0] = 95, [1] = 100 }, [2] = { [0] = 97, [1] = 102 }, [3] = { [0] = 94, [1] = 104 }, [4] = { [0] = 89, [1] = 101 }, [5] = { [0] = 90, [1] = 101 }, [6] = { [0] = 81, [1] = 92 }, [7] = { [0] = 98, [1] = 109 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 38, [1] = 113 }, [1] = { [0] = 31, [1] = 112 }, [2] = { [0] = 30, [1] = 108 }, [3] = { [0] = 27, [1] = 110 }, [4] = { [0] = 31, [1] = 111 }, [5] = { [0] = 32, [1] = 110 }, [6] = { [0] = 34, [1] = 115 }, [7] = { [0] = 23, [1] = 103 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 96, [1] = 101 }, [2] = { [0] = 91, [1] = 96 }, [3] = { [0] = 87, [1] = 97 }, [4] = { [0] = 97, [1] = 109 }, [5] = { [0] = 96, [1] = 107 }, [6] = { [0] = 82, [1] = 93 }, [7] = { [0] = 85, [1] = 96 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 39, [1] = 114 }, [1] = { [0] = 31, [1] = 112 }, [2] = { [0] = 30, [1] = 108 }, [3] = { [0] = 28, [1] = 111 }, [4] = { [0] = 32, [1] = 112 }, [5] = { [0] = 33, [1] = 111 }, [6] = { [0] = 34, [1] = 115 }, [7] = { [0] = 23, [1] = 103 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 97, [1] = 102 }, [2] = { [0] = 97, [1] = 102 }, [3] = { [0] = 87, [1] = 97 }, [4] = { [0] = 81, [1] = 93 }, [5] = { [0] = 90, [1] = 101 }, [6] = { [0] = 83, [1] = 94 }, [7] = { [0] = 98, [1] = 109 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 40, [1] = 115 }, [1] = { [0] = 31, [1] = 112 }, [2] = { [0] = 31, [1] = 109 }, [3] = { [0] = 29, [1] = 112 }, [4] = { [0] = 32, [1] = 112 }, [5] = { [0] = 34, [1] = 112 }, [6] = { [0] = 34, [1] = 115 }, [7] = { [0] = 24, [1] = 104 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 98, [1] = 103 }, [2] = { [0] = 91, [1] = 96 }, [3] = { [0] = 87, [1] = 97 }, [4] = { [0] = 82, [1] = 94 }, [5] = { [0] = 90, [1] = 101 }, [6] = { [0] = 84, [1] = 95 }, [7] = { [0] = 85, [1] = 96 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 41, [1] = 116 }, [1] = { [0] = 31, [1] = 112 }, [2] = { [0] = 31, [1] = 109 }, [3] = { [0] = 30, [1] = 113 }, [4] = { [0] = 32, [1] = 112 }, [5] = { [0] = 35, [1] = 113 }, [6] = { [0] = 34, [1] = 115 }, [7] = { [0] = 24, [1] = 104 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 103, [1] = 108 }, [2] = { [0] = 97, [1] = 102 }, [3] = { [0] = 87, [1] = 97 }, [4] = { [0] = 89, [1] = 101 }, [5] = { [0] = 90, [1] = 101 }, [6] = { [0] = 85, [1] = 96 }, [7] = { [0] = 86, [1] = 97 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 42, [1] = 117 }, [1] = { [0] = 31, [1] = 112 }, [2] = { [0] = 32, [1] = 110 }, [3] = { [0] = 31, [1] = 114 }, [4] = { [0] = 32, [1] = 112 }, [5] = { [0] = 35, [1] = 113 }, [6] = { [0] = 38, [1] = 119 }, [7] = { [0] = 24, [1] = 104 } })[R[11]][R[1]], ({ [0] = { [0] = 93, [1] = 101 }, [1] = { [0] = 104, [1] = 109 }, [2] = { [0] = 91, [1] = 96 }, [3] = { [0] = 87, [1] = 97 }, [4] = { [0] = 97, [1] = 109 }, [5] = { [0] = 91, [1] = 102 }, [6] = { [0] = 87, [1] = 98 }, [7] = { [0] = 87, [1] = 98 } })[R[11]][R[1]] })
  if R[11] == 0 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 43, [1] = 118 })[R[1]], ({ [0] = 93, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 44, [1] = 119 })[R[1]], ({ [0] = 93, [1] = 101 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 43, [1] = 118 })[R[1]], ({ [0] = 93, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 44, [1] = 119 })[R[1]], ({ [0] = 93, [1] = 101 })[R[1]] })
      for i = 1, game.initial_units() do
        R[12] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 41, [1] = 116 }, [1] = { [0] = 43, [1] = 118 }, [2] = { [0] = 30, [1] = 105 } })[R[12]][R[1]], ({ [0] = { [0] = 87, [1] = 95 }, [1] = { [0] = 87, [1] = 95 }, [2] = { [0] = 98, [1] = 106 } })[R[12]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 31, [1] = 112 })[R[1]], ({ [0] = 105, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 31, [1] = 112 })[R[1]], ({ [0] = 105, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 31, [1] = 112 })[R[1]], ({ [0] = 106, [1] = 111 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 31, [1] = 112 })[R[1]], ({ [0] = 105, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 31, [1] = 112 })[R[1]], ({ [0] = 105, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 31, [1] = 112 })[R[1]], ({ [0] = 106, [1] = 111 })[R[1]] })
      for i = 1, game.initial_units() do
        R[13] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 103 }, [1] = { [0] = 24, [1] = 105 }, [2] = { [0] = 26, [1] = 107 } })[R[13]][R[1]], ({ [0] = { [0] = 100, [1] = 105 }, [1] = { [0] = 109, [1] = 114 }, [2] = { [0] = 94, [1] = 99 } })[R[13]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 2 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[14] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 101 }, [1] = { [0] = 33, [1] = 111 }, [2] = { [0] = 28, [1] = 106 } })[R[14]][R[1]], ({ [0] = { [0] = 85, [1] = 90 }, [1] = { [0] = 85, [1] = 90 }, [2] = { [0] = 101, [1] = 106 } })[R[14]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 3 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 31, [1] = 114 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 115 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 116 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 34, [1] = 117 })[R[1]], ({ [0] = 90, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 34, [1] = 117 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 118 })[R[1]], ({ [0] = 90, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 118 })[R[1]], ({ [0] = 91, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 118 })[R[1]], ({ [0] = 92, [1] = 102 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 118 })[R[1]], ({ [0] = 93, [1] = 103 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 118 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 119 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 119 })[R[1]], ({ [0] = 95, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 119 })[R[1]], ({ [0] = 96, [1] = 106 })[R[1]] })
      for i = 1, game.initial_units() do
        R[15] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 111 }, [1] = { [0] = 30, [1] = 113 }, [2] = { [0] = 17, [1] = 100 } })[R[15]][R[1]], ({ [0] = { [0] = 90, [1] = 100 }, [1] = { [0] = 97, [1] = 107 }, [2] = { [0] = 94, [1] = 104 } })[R[15]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 31, [1] = 114 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 115 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 116 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 34, [1] = 117 })[R[1]], ({ [0] = 90, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 34, [1] = 117 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 118 })[R[1]], ({ [0] = 90, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 118 })[R[1]], ({ [0] = 91, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 118 })[R[1]], ({ [0] = 92, [1] = 102 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 118 })[R[1]], ({ [0] = 93, [1] = 103 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 118 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 119 })[R[1]], ({ [0] = 94, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 119 })[R[1]], ({ [0] = 95, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 119 })[R[1]], ({ [0] = 96, [1] = 106 })[R[1]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 33, [1] = 113 })[R[1]], ({ [0] = 82, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 113 })[R[1]], ({ [0] = 83, [1] = 95 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 113 })[R[1]], ({ [0] = 89, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 113 })[R[1]], ({ [0] = 97, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 34, [1] = 114 })[R[1]], ({ [0] = 83, [1] = 95 })[R[1]] })
      game.create_tube({ ({ [0] = 34, [1] = 114 })[R[1]], ({ [0] = 89, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 34, [1] = 114 })[R[1]], ({ [0] = 97, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 115 })[R[1]], ({ [0] = 83, [1] = 95 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 115 })[R[1]], ({ [0] = 89, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 115 })[R[1]], ({ [0] = 97, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 88, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 89, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 90, [1] = 102 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 91, [1] = 103 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 96, [1] = 108 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 97, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 37, [1] = 117 })[R[1]], ({ [0] = 88, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 37, [1] = 117 })[R[1]], ({ [0] = 96, [1] = 108 })[R[1]] })
      game.create_tube({ ({ [0] = 38, [1] = 118 })[R[1]], ({ [0] = 86, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 38, [1] = 118 })[R[1]], ({ [0] = 87, [1] = 99 })[R[1]] })
      game.create_tube({ ({ [0] = 38, [1] = 118 })[R[1]], ({ [0] = 88, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 38, [1] = 118 })[R[1]], ({ [0] = 96, [1] = 108 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 33, [1] = 113 })[R[1]], ({ [0] = 82, [1] = 94 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 113 })[R[1]], ({ [0] = 83, [1] = 95 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 113 })[R[1]], ({ [0] = 89, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 113 })[R[1]], ({ [0] = 97, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 34, [1] = 114 })[R[1]], ({ [0] = 83, [1] = 95 })[R[1]] })
      game.create_tube({ ({ [0] = 34, [1] = 114 })[R[1]], ({ [0] = 89, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 34, [1] = 114 })[R[1]], ({ [0] = 97, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 115 })[R[1]], ({ [0] = 83, [1] = 95 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 115 })[R[1]], ({ [0] = 89, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 115 })[R[1]], ({ [0] = 97, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 88, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 89, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 90, [1] = 102 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 91, [1] = 103 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 96, [1] = 108 })[R[1]] })
      game.create_tube({ ({ [0] = 36, [1] = 116 })[R[1]], ({ [0] = 97, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 37, [1] = 117 })[R[1]], ({ [0] = 88, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 37, [1] = 117 })[R[1]], ({ [0] = 96, [1] = 108 })[R[1]] })
      game.create_tube({ ({ [0] = 38, [1] = 118 })[R[1]], ({ [0] = 86, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 38, [1] = 118 })[R[1]], ({ [0] = 87, [1] = 99 })[R[1]] })
      game.create_tube({ ({ [0] = 38, [1] = 118 })[R[1]], ({ [0] = 88, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 38, [1] = 118 })[R[1]], ({ [0] = 96, [1] = 108 })[R[1]] })
      for i = 1, game.initial_units() do
        R[16] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 111 }, [1] = { [0] = 24, [1] = 104 }, [2] = { [0] = 20, [1] = 100 } })[R[16]][R[1]], ({ [0] = { [0] = 80, [1] = 92 }, [1] = { [0] = 80, [1] = 92 }, [2] = { [0] = 89, [1] = 101 } })[R[16]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 5 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 35, [1] = 113 })[R[1]], ({ [0] = 92, [1] = 103 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 113 })[R[1]], ({ [0] = 93, [1] = 104 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 35, [1] = 113 })[R[1]], ({ [0] = 92, [1] = 103 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 113 })[R[1]], ({ [0] = 93, [1] = 104 })[R[1]] })
      for i = 1, game.initial_units() do
        R[17] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 109 }, [1] = { [0] = 36, [1] = 114 }, [2] = { [0] = 14, [1] = 92 } })[R[17]][R[1]], ({ [0] = { [0] = 99, [1] = 110 }, [1] = { [0] = 99, [1] = 110 }, [2] = { [0] = 86, [1] = 97 } })[R[17]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 6 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 39, [1] = 120 })[R[1]], ({ [0] = 87, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 40, [1] = 121 })[R[1]], ({ [0] = 87, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 41, [1] = 122 })[R[1]], ({ [0] = 87, [1] = 98 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 39, [1] = 120 })[R[1]], ({ [0] = 87, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 40, [1] = 121 })[R[1]], ({ [0] = 87, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 41, [1] = 122 })[R[1]], ({ [0] = 87, [1] = 98 })[R[1]] })
      for i = 1, game.initial_units() do
        R[18] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 101 }, [1] = { [0] = 25, [1] = 106 }, [2] = { [0] = 48, [1] = 129 } })[R[18]][R[1]], ({ [0] = { [0] = 77, [1] = 88 }, [1] = { [0] = 75, [1] = 86 }, [2] = { [0] = 88, [1] = 99 } })[R[18]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 7 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 88, [1] = 99 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 89, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 90, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 94, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 95, [1] = 106 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 96, [1] = 107 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 97, [1] = 108 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 105 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 105 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 106 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 106 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 27, [1] = 107 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 27, [1] = 107 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 28, [1] = 108 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 28, [1] = 108 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 29, [1] = 109 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 29, [1] = 109 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 30, [1] = 110 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 30, [1] = 110 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 87, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 88, [1] = 99 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 89, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 90, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 91, [1] = 102 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 92, [1] = 103 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 93, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 94, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 95, [1] = 106 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 88, [1] = 99 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 89, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 90, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 94, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 95, [1] = 106 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 96, [1] = 107 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 97, [1] = 108 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 104 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 105 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 105 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 106 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 106 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 27, [1] = 107 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 27, [1] = 107 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 28, [1] = 108 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 28, [1] = 108 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 29, [1] = 109 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 29, [1] = 109 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 30, [1] = 110 })[R[1]], ({ [0] = 85, [1] = 96 })[R[1]] })
      game.create_tube({ ({ [0] = 30, [1] = 110 })[R[1]], ({ [0] = 98, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 87, [1] = 98 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 88, [1] = 99 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 89, [1] = 100 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 90, [1] = 101 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 91, [1] = 102 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 92, [1] = 103 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 93, [1] = 104 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 94, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 112 })[R[1]], ({ [0] = 95, [1] = 106 })[R[1]] })
      for i = 1, game.initial_units() do
        R[19] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 102 }, [1] = { [0] = 28, [1] = 108 }, [2] = { [0] = 18, [1] = 98 } })[R[19]][R[1]], ({ [0] = { [0] = 81, [1] = 92 }, [1] = { [0] = 81, [1] = 92 }, [2] = { [0] = 102, [1] = 113 } })[R[19]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[11]", R[11])
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
    trigger.time{min = 3600, max = 7200, one_shot = false, on = Meteors}  -- after 36 to 72 marks
  end
  return true
end
