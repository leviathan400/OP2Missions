-- ml2_02Lua.lua  -  2 Player, LastOne, 'Great Divide' map. (Lua)
--
-- Converted by op2dll from ml2_02.dll ("2 Player, LastOne, 'Great Divide' map."): its setup replayed. `on_init` makes the original's
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
local BigQuake, Meteor

function BigQuake(t)
  game.create_earthquake({ 57, 21 }, 4)
end

function Meteor(t)
  local r1 = game.rand(62)
  local r2 = game.rand(128)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function on_init()
  local n = game.num_players()
  pick(7, 2, { 0, 1 })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 20, [1] = 31, [2] = 41, [3] = 47, [4] = 56, [5] = 67, [6] = 86 })[R[0]], ({ [0] = 22, [1] = 8, [2] = 50, [3] = 33, [4] = 41, [5] = 46, [6] = 56 })[R[0]] } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 20, [1] = 31, [2] = 41, [3] = 47, [4] = 56, [5] = 67, [6] = 86 })[R[1]], ({ [0] = 22, [1] = 8, [2] = 50, [3] = 33, [4] = 41, [5] = 46, [6] = 56 })[R[1]] } }
  pick(7, 2, { 2, 3 })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 75, [1] = 74, [2] = 113, [3] = 61, [4] = 71, [5] = 100, [6] = 80 })[R[2]], ({ [0] = 29, [1] = 48, [2] = 56, [3] = 7, [4] = 19, [5] = 25, [6] = 8 })[R[2]] } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 75, [1] = 74, [2] = 113, [3] = 61, [4] = 71, [5] = 100, [6] = 80 })[R[3]], ({ [0] = 29, [1] = 48, [2] = 56, [3] = 7, [4] = 19, [5] = 25, [6] = 8 })[R[3]] } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 105, 5 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 5, 34 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 108, 22 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 25, 57 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 8, 32 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 95, 18 } }
  game.set_cell_type({ 14, 57 }, 5)
  game.initial_set_tile({ 14, 57 }, 448)
  game.set_cell_type({ 15, 57 }, 5)
  game.initial_set_tile({ 15, 57 }, 441)
  game.set_cell_type({ 15, 59 }, 5)
  game.initial_set_tile({ 15, 59 }, 441)
  game.set_cell_type({ 15, 60 }, 5)
  game.initial_set_tile({ 15, 60 }, 448)
  game.set_cell_type({ 15, 61 }, 5)
  game.initial_set_tile({ 15, 61 }, 441)
  game.set_cell_type({ 16, 57 }, 5)
  game.initial_set_tile({ 16, 57 }, 448)
  game.set_cell_type({ 16, 59 }, 5)
  game.initial_set_tile({ 16, 59 }, 448)
  game.set_cell_type({ 16, 60 }, 5)
  game.initial_set_tile({ 16, 60 }, 441)
  game.set_cell_type({ 16, 61 }, 5)
  game.initial_set_tile({ 16, 61 }, 441)
  game.set_cell_type({ 17, 57 }, 5)
  game.initial_set_tile({ 17, 57 }, 441)
  game.set_cell_type({ 17, 59 }, 5)
  game.initial_set_tile({ 17, 59 }, 441)
  game.set_cell_type({ 17, 60 }, 5)
  game.initial_set_tile({ 17, 60 }, 448)
  game.set_cell_type({ 17, 61 }, 5)
  game.initial_set_tile({ 17, 61 }, 441)
  game.initial_set_tile({ 113, 20 }, 442)
  game.initial_set_tile({ 113, 21 }, 440)
  game.initial_set_tile({ 114, 20 }, 440)
  game.initial_set_tile({ 114, 21 }, 442)
  game.set_cell_type({ 116, 10 }, 5)
  game.initial_set_tile({ 116, 10 }, 450)
  game.set_cell_type({ 116, 11 }, 5)
  game.initial_set_tile({ 116, 11 }, 450)
  game.set_cell_type({ 116, 12 }, 5)
  game.initial_set_tile({ 116, 12 }, 442)
  game.set_cell_type({ 117, 10 }, 5)
  game.initial_set_tile({ 117, 10 }, 442)
  game.set_cell_type({ 117, 11 }, 5)
  game.initial_set_tile({ 117, 11 }, 441)
  game.set_cell_type({ 117, 12 }, 5)
  game.initial_set_tile({ 117, 12 }, 450)
  game.set_cell_type({ 117, 13 }, 5)
  game.initial_set_tile({ 117, 13 }, 442)
  game.set_cell_type({ 118, 10 }, 5)
  game.initial_set_tile({ 118, 10 }, 442)
  game.set_cell_type({ 118, 11 }, 5)
  game.initial_set_tile({ 118, 11 }, 450)
  game.set_cell_type({ 118, 12 }, 5)
  game.initial_set_tile({ 118, 12 }, 441)
  game.set_cell_type({ 118, 13 }, 5)
  game.initial_set_tile({ 118, 13 }, 440)
  game.set_cell_type({ 122, 15 }, 5)
  game.initial_set_tile({ 122, 15 }, 450)
  game.set_cell_type({ 123, 15 }, 5)
  game.initial_set_tile({ 123, 15 }, 442)
  game.set_cell_type({ 124, 15 }, 5)
  game.initial_set_tile({ 124, 15 }, 441)
  game.set_cell_type({ 125, 15 }, 5)
  game.initial_set_tile({ 125, 15 }, 442)
  game.set_cell_type({ 126, 11 }, 5)
  game.initial_set_tile({ 126, 11 }, 450)
  game.set_cell_type({ 126, 12 }, 5)
  game.initial_set_tile({ 126, 12 }, 440)
  game.set_cell_type({ 126, 13 }, 5)
  game.initial_set_tile({ 126, 13 }, 450)
  game.set_cell_type({ 126, 15 }, 5)
  game.initial_set_tile({ 126, 15 }, 450)
  game.set_cell_type({ 127, 11 }, 5)
  game.initial_set_tile({ 127, 11 }, 441)
  game.set_cell_type({ 127, 12 }, 5)
  game.initial_set_tile({ 127, 12 }, 442)
  game.set_cell_type({ 127, 13 }, 5)
  game.initial_set_tile({ 127, 13 }, 440)
  game.set_cell_type({ 127, 18 }, 5)
  game.initial_set_tile({ 127, 18 }, 442)
  game.set_cell_type({ 128, 11 }, 5)
  game.initial_set_tile({ 128, 11 }, 440)
  game.set_cell_type({ 128, 12 }, 5)
  game.initial_set_tile({ 128, 12 }, 450)
  game.set_cell_type({ 128, 13 }, 5)
  game.initial_set_tile({ 128, 13 }, 440)
  pick(2, 2, { 4, 5 })
  R[6] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 121 }, [1] = { [0] = 17, [1] = 125 }, [2] = { [0] = 17, [1] = 125 }, [3] = { [0] = 9, [1] = 117 }, [4] = { [0] = 13, [1] = 121 }, [5] = { [0] = 12, [1] = 120 }, [6] = { [0] = 9, [1] = 117 }, [7] = { [0] = 15, [1] = 123 } })[R[6]][R[5]], ({ [0] = { [0] = 57, [1] = 17 }, [1] = { [0] = 53, [1] = 13 }, [2] = { [0] = 57, [1] = 17 }, [3] = { [0] = 53, [1] = 13 }, [4] = { [0] = 56, [1] = 16 }, [5] = { [0] = 54, [1] = 14 }, [6] = { [0] = 51, [1] = 11 }, [7] = { [0] = 54, [1] = 14 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  players[1]:center_view({ ({ [0] = { [0] = 13, [1] = 121 }, [1] = { [0] = 17, [1] = 125 }, [2] = { [0] = 17, [1] = 125 }, [3] = { [0] = 9, [1] = 117 }, [4] = { [0] = 13, [1] = 121 }, [5] = { [0] = 12, [1] = 120 }, [6] = { [0] = 9, [1] = 117 }, [7] = { [0] = 15, [1] = 123 } })[R[6]][R[5]], ({ [0] = { [0] = 57, [1] = 17 }, [1] = { [0] = 53, [1] = 13 }, [2] = { [0] = 57, [1] = 17 }, [3] = { [0] = 53, [1] = 13 }, [4] = { [0] = 56, [1] = 16 }, [5] = { [0] = 54, [1] = 14 }, [6] = { [0] = 51, [1] = 11 }, [7] = { [0] = 54, [1] = 14 } })[R[6]][R[5]] })
  if R[6] == 5 or R[6] == 6 or R[6] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 9, [1] = 117 }, [6] = { [0] = 18, [1] = 126 }, [7] = { [0] = 9, [1] = 117 } })[R[6]][R[5]], ({ [0] = 61, [1] = 21 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 17, [1] = 125 }, [6] = { [0] = 9, [1] = 117 }, [7] = { [0] = 17, [1] = 125 } })[R[6]][R[5]], ({ [5] = { [0] = 55, [1] = 15 }, [6] = { [0] = 60, [1] = 20 }, [7] = { [0] = 60, [1] = 20 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[6] == 5 or R[6] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 17, [1] = 125 }, [7] = { [0] = 10, [1] = 118 } })[R[6]][R[5]], ({ [0] = 51, [1] = 11 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      if R[6] == 5 then
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
      elseif R[6] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 14, [1] = 122 })[R[5]], ({ [0] = 51, [1] = 11 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 14, [1] = 122 })[R[5]], ({ [0] = 51, [1] = 11 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 14, [1] = 122 })[R[5]], ({ [0] = 51, [1] = 11 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[6]", R[6])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 16, [1] = 124 }, [7] = { [0] = 15, [1] = 123 } })[R[6]][R[5]], ({ [5] = { [0] = 59, [1] = 19 }, [7] = { [0] = 57, [1] = 17 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      if R[6] == 7 then
      elseif R[6] == 5 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 51, [1] = 11 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[6]", R[6])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [5] = { [0] = 57, [1] = 17 }, [7] = { [0] = 54, [1] = 14 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 13, [1] = 121 })[R[5]], ({ [5] = { [0] = 56, [1] = 16 }, [7] = { [0] = 55, [1] = 15 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 13, [1] = 121 }, [7] = { [0] = 18, [1] = 126 } })[R[6]][R[5]], ({ [5] = { [0] = 58, [1] = 18 }, [7] = { [0] = 55, [1] = 15 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[6] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 9, [1] = 117 })[R[5]], ({ [0] = 57, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 9, [1] = 117 })[R[5]], ({ [0] = 54, [1] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 14, [1] = 122 })[R[5]], ({ [0] = 52, [1] = 12 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 127 }, [6] = { [0] = 16, [1] = 124 }, [7] = { [0] = 12, [1] = 120 } })[R[6]][R[5]], ({ [5] = { [0] = 53, [1] = 13 }, [6] = { [0] = 54, [1] = 14 }, [7] = { [0] = 52, [1] = 12 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[6] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 19, [1] = 127 })[R[5]], ({ [0] = 53, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[6] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 124 })[R[5]], ({ [0] = 54, [1] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 124 })[R[5]], ({ [0] = 54, [1] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 11, [1] = 119 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 61, [1] = 21 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[6] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 52, [1] = 12 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[6]", R[6])
    end
  elseif R[6] == 1 or R[6] == 2 or R[6] == 3 or R[6] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 17, [1] = 125 }, [2] = { [0] = 10, [1] = 118 }, [3] = { [0] = 14, [1] = 122 }, [4] = { [0] = 10, [1] = 118 } })[R[6]][R[5]], ({ [0] = 60, [1] = 20 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[6] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 9, [1] = 117 })[R[5]], ({ [0] = 61, [1] = 21 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 16, [1] = 124 })[R[5]], ({ [0] = 57, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 10, [1] = 118 })[R[5]], ({ [0] = 56, [1] = 16 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 18, [1] = 126 })[R[5]], ({ [0] = 51, [1] = 11 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 123 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 1 or R[6] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 8, [1] = 116 }, [2] = { [0] = 9, [1] = 117 } })[R[6]][R[5]], ({ [0] = 51, [1] = 11 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 17, [1] = 125 })[R[5]], ({ [1] = { [0] = 56, [1] = 16 }, [2] = { [0] = 60, [1] = 20 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 12, [1] = 120 }, [2] = { [0] = 13, [1] = 121 } })[R[6]][R[5]], ({ [1] = { [0] = 61, [1] = 21 }, [2] = { [0] = 57, [1] = 17 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 12, [1] = 120 }, [2] = { [0] = 17, [1] = 125 } })[R[6]][R[5]], ({ [1] = { [0] = 57, [1] = 17 }, [2] = { [0] = 54, [1] = 14 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 126 }, [2] = { [0] = 16, [1] = 124 } })[R[6]][R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 10, [1] = 118 })[R[5]], ({ [0] = 52, [1] = 12 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 14, [1] = 122 })[R[5]], ({ [0] = 53, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 9, [1] = 117 })[R[5]], ({ [0] = 56, [1] = 16 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 18, [1] = 126 })[R[5]], ({ [0] = 61, [1] = 21 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 50, [1] = 10 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[6]", R[6])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[6]], player = players[1], at = { ({ [1] = { [0] = 19, [1] = 127 }, [2] = { [0] = 18, [1] = 126 }, [3] = { [0] = 16, [1] = 124 }, [4] = { [0] = 13, [1] = 121 } })[R[6]][R[5]], ({ [1] = { [0] = 61, [1] = 21 }, [2] = { [0] = 62, [1] = 22 }, [3] = { [0] = 61, [1] = 21 }, [4] = { [0] = 51, [1] = 11 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[6]], player = players[1], at = { ({ [1] = { [0] = 16, [1] = 124 }, [2] = { [0] = 14, [1] = 122 }, [3] = { [0] = 17, [1] = 125 }, [4] = { [0] = 7, [1] = 115 } })[R[6]][R[5]], ({ [1] = { [0] = 62, [1] = 22 }, [2] = { [0] = 61, [1] = 21 }, [3] = { [0] = 62, [1] = 22 }, [4] = { [0] = 58, [1] = 18 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 19, [1] = 127 }, [2] = { [0] = 11, [1] = 119 }, [3] = { [0] = 11, [1] = 119 }, [4] = { [0] = 11, [1] = 119 } })[R[6]][R[5]], ({ [1] = { [0] = 58, [1] = 18 }, [2] = { [0] = 62, [1] = 22 }, [3] = { [0] = 58, [1] = 18 }, [4] = { [0] = 54, [1] = 14 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[6] == 1 then
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 19, [1] = 127 })[R[5]], ({ [0] = 58, [1] = 18 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 2 then
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 119 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 3 then
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 119 })[R[5]], ({ [0] = 58, [1] = 18 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[6] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 119 })[R[5]], ({ [0] = 54, [1] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[6]", R[6])
    end
  elseif R[6] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 10, [1] = 118 })[R[5]], ({ [0] = 60, [1] = 20 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 15, [1] = 123 })[R[5]], ({ [0] = 60, [1] = 20 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 9, [1] = 117 })[R[5]], ({ [0] = 57, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 17, [1] = 125 })[R[5]], ({ [0] = 57, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 18, [1] = 126 })[R[5]], ({ [0] = 51, [1] = 11 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 124 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 125 })[R[5]], ({ [0] = 61, [1] = 21 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 127 })[R[5]], ({ [0] = 60, [1] = 20 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[6]", R[6])
  end
  U[#U]:set_lights(true)
  if R[6] == 0 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 8, [1] = 116 })[R[5]], ({ [0] = 53, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 8, [1] = 116 })[R[5]], ({ [0] = 53, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[6] == 1 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 19, [1] = 127 })[R[5]], ({ [0] = 58, [1] = 18 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 9, [1] = 117 })[R[5]], ({ [0] = 57, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 9, [1] = 117 })[R[5]], ({ [0] = 57, [1] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[6] == 2 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 119 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 121 })[R[5]], ({ [0] = 53, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 121 })[R[5]], ({ [0] = 53, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[6] == 3 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 119 })[R[5]], ({ [0] = 58, [1] = 18 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 54, [1] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 54, [1] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[6] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 119 })[R[5]], ({ [0] = 54, [1] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 8, [1] = 116 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[6] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 19, [1] = 127 })[R[5]], ({ [0] = 53, [1] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 127 })[R[5]], ({ [0] = 59, [1] = 19 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[6] == 6 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 16, [1] = 124 })[R[5]], ({ [0] = 54, [1] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 11, [1] = 119 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 61, [1] = 21 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 122 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 55, [1] = 15 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 122 })[R[5]], ({ [0] = 62, [1] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 55, [1] = 15 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[6] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 52, [1] = 12 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 19, [1] = 127 })[R[5]], ({ [0] = 59, [1] = 19 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[6]", R[6])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[6]], player = players[1], at = { ({ [0] = { [0] = 9, [1] = 117 }, [1] = { [0] = 8, [1] = 116 }, [2] = { [0] = 14, [1] = 122 }, [3] = { [0] = 13, [1] = 121 }, [4] = { [0] = 11, [1] = 119 }, [5] = { [0] = 18, [1] = 126 }, [6] = { [0] = 13, [1] = 121 }, [7] = { [0] = 18, [1] = 126 } })[R[6]][R[5]], ({ [0] = { [0] = 54, [1] = 14 }, [1] = { [0] = 56, [1] = 16 }, [2] = { [0] = 52, [1] = 12 }, [3] = { [0] = 53, [1] = 13 }, [4] = { [0] = 62, [1] = 22 }, [5] = { [0] = 57, [1] = 17 }, [6] = { [0] = 56, [1] = 16 }, [7] = { [0] = 62, [1] = 22 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[6]], player = players[1], at = { ({ [0] = { [0] = 10, [1] = 118 }, [1] = { [0] = 10, [1] = 118 }, [2] = { [0] = 13, [1] = 121 }, [3] = { [0] = 12, [1] = 120 }, [4] = { [0] = 12, [1] = 120 }, [5] = { [0] = 19, [1] = 127 }, [6] = { [0] = 14, [1] = 122 }, [7] = { [0] = 19, [1] = 127 } })[R[6]][R[5]], ({ [0] = { [0] = 54, [1] = 14 }, [1] = { [0] = 55, [1] = 15 }, [2] = { [0] = 51, [1] = 11 }, [3] = { [0] = 52, [1] = 12 }, [4] = { [0] = 61, [1] = 21 }, [5] = { [0] = 56, [1] = 16 }, [6] = { [0] = 55, [1] = 15 }, [7] = { [0] = 62, [1] = 22 } })[R[6]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[6] == 0 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[7] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 8, [1] = 116 }, [1] = { [0] = 13, [1] = 121 }, [2] = { [0] = 18, [1] = 126 } })[R[7]][R[5]], ({ [0] = { [0] = 50, [1] = 10 }, [1] = { [0] = 53, [1] = 13 }, [2] = { [0] = 59, [1] = 19 } })[R[7]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 1 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 59, [1] = 19 })[R[5]] })
      for i = 1, game.initial_units() do
        R[8] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 8, [1] = 116 }, [1] = { [0] = 12, [1] = 120 }, [2] = { [0] = 15, [1] = 123 } })[R[8]][R[5]], ({ [0] = { [0] = 60, [1] = 20 }, [1] = { [0] = 54, [1] = 14 }, [2] = { [0] = 50, [1] = 10 } })[R[8]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 12, [1] = 120 })[R[5]], ({ [0] = 59, [1] = 19 })[R[5]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 2 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 13, [1] = 121 })[R[5]], ({ [0] = 59, [1] = 19 })[R[5]] })
      game.create_tube({ ({ [0] = 13, [1] = 121 })[R[5]], ({ [0] = 60, [1] = 20 })[R[5]] })
      game.create_tube({ ({ [0] = 14, [1] = 122 })[R[5]], ({ [0] = 60, [1] = 20 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 13, [1] = 121 })[R[5]], ({ [0] = 59, [1] = 19 })[R[5]] })
      game.create_tube({ ({ [0] = 13, [1] = 121 })[R[5]], ({ [0] = 60, [1] = 20 })[R[5]] })
      game.create_tube({ ({ [0] = 14, [1] = 122 })[R[5]], ({ [0] = 60, [1] = 20 })[R[5]] })
      for i = 1, game.initial_units() do
        R[9] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 125 }, [1] = { [0] = 9, [1] = 117 }, [2] = { [0] = 13, [1] = 121 } })[R[9]][R[5]], ({ [0] = { [0] = 50, [1] = 10 }, [1] = { [0] = 55, [1] = 15 }, [2] = { [0] = 60, [1] = 20 } })[R[9]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 3 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 10, [1] = 118 })[R[5]], ({ [0] = 59, [1] = 19 })[R[5]] })
      game.create_tube({ ({ [0] = 13, [1] = 121 })[R[5]], ({ [0] = 56, [1] = 16 })[R[5]] })
      game.create_tube({ ({ [0] = 14, [1] = 122 })[R[5]], ({ [0] = 56, [1] = 16 })[R[5]] })
      game.create_tube({ ({ [0] = 16, [1] = 124 })[R[5]], ({ [0] = 59, [1] = 19 })[R[5]] })
      game.create_tube({ ({ [0] = 16, [1] = 124 })[R[5]], ({ [0] = 60, [1] = 20 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 10, [1] = 118 })[R[5]], ({ [0] = 59, [1] = 19 })[R[5]] })
      game.create_tube({ ({ [0] = 13, [1] = 121 })[R[5]], ({ [0] = 56, [1] = 16 })[R[5]] })
      game.create_tube({ ({ [0] = 14, [1] = 122 })[R[5]], ({ [0] = 56, [1] = 16 })[R[5]] })
      game.create_tube({ ({ [0] = 16, [1] = 124 })[R[5]], ({ [0] = 59, [1] = 19 })[R[5]] })
      game.create_tube({ ({ [0] = 16, [1] = 124 })[R[5]], ({ [0] = 60, [1] = 20 })[R[5]] })
      for i = 1, game.initial_units() do
        R[10] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 126 }, [1] = { [0] = 14, [1] = 122 }, [2] = { [0] = 10, [1] = 118 } })[R[10]][R[5]], ({ [0] = { [0] = 61, [1] = 21 }, [1] = { [0] = 55, [1] = 15 }, [2] = { [0] = 50, [1] = 10 } })[R[10]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 4 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 9, [1] = 117 })[R[5]], ({ [0] = 58, [1] = 18 })[R[5]] })
      for i = 1, game.initial_units() do
        R[11] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 125 }, [1] = { [0] = 18, [1] = 126 }, [2] = { [0] = 14, [1] = 122 } })[R[11]][R[5]], ({ [0] = { [0] = 50, [1] = 10 }, [1] = { [0] = 56, [1] = 16 }, [2] = { [0] = 60, [1] = 20 } })[R[11]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 9, [1] = 117 })[R[5]], ({ [0] = 58, [1] = 18 })[R[5]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[6] == 5 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[12] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 122 }, [1] = { [0] = 8, [1] = 116 }, [2] = { [0] = 8, [1] = 116 } })[R[12]][R[5]], ({ [0] = { [0] = 61, [1] = 21 }, [1] = { [0] = 56, [1] = 16 }, [2] = { [0] = 51, [1] = 11 } })[R[12]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 126 }, [1] = { [0] = 17, [1] = 125 }, [2] = { [0] = 14, [1] = 122 } })[R[13]][R[5]], ({ [0] = { [0] = 51, [1] = 11 }, [1] = { [0] = 57, [1] = 17 }, [2] = { [0] = 58, [1] = 18 } })[R[13]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 120 }, [1] = { [0] = 8, [1] = 116 }, [2] = { [0] = 18, [1] = 126 } })[R[14]][R[5]], ({ [0] = { [0] = 60, [1] = 20 }, [1] = { [0] = 56, [1] = 16 }, [2] = { [0] = 51, [1] = 11 } })[R[14]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[6]", R[6])
  end
  R[15] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 121, [1] = 13 }, [1] = { [0] = 125, [1] = 17 }, [2] = { [0] = 125, [1] = 17 }, [3] = { [0] = 117, [1] = 9 }, [4] = { [0] = 121, [1] = 13 }, [5] = { [0] = 120, [1] = 12 }, [6] = { [0] = 117, [1] = 9 }, [7] = { [0] = 123, [1] = 15 } })[R[15]][R[5]], ({ [0] = { [0] = 17, [1] = 57 }, [1] = { [0] = 13, [1] = 53 }, [2] = { [0] = 17, [1] = 57 }, [3] = { [0] = 13, [1] = 53 }, [4] = { [0] = 16, [1] = 56 }, [5] = { [0] = 14, [1] = 54 }, [6] = { [0] = 11, [1] = 51 }, [7] = { [0] = 14, [1] = 54 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  players[2]:center_view({ ({ [0] = { [0] = 121, [1] = 13 }, [1] = { [0] = 125, [1] = 17 }, [2] = { [0] = 125, [1] = 17 }, [3] = { [0] = 117, [1] = 9 }, [4] = { [0] = 121, [1] = 13 }, [5] = { [0] = 120, [1] = 12 }, [6] = { [0] = 117, [1] = 9 }, [7] = { [0] = 123, [1] = 15 } })[R[15]][R[5]], ({ [0] = { [0] = 17, [1] = 57 }, [1] = { [0] = 13, [1] = 53 }, [2] = { [0] = 17, [1] = 57 }, [3] = { [0] = 13, [1] = 53 }, [4] = { [0] = 16, [1] = 56 }, [5] = { [0] = 14, [1] = 54 }, [6] = { [0] = 11, [1] = 51 }, [7] = { [0] = 14, [1] = 54 } })[R[15]][R[5]] })
  if R[15] == 5 or R[15] == 6 or R[15] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 117, [1] = 9 }, [6] = { [0] = 126, [1] = 18 }, [7] = { [0] = 117, [1] = 9 } })[R[15]][R[5]], ({ [0] = 21, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 125, [1] = 17 }, [6] = { [0] = 117, [1] = 9 }, [7] = { [0] = 125, [1] = 17 } })[R[15]][R[5]], ({ [5] = { [0] = 15, [1] = 55 }, [6] = { [0] = 20, [1] = 60 }, [7] = { [0] = 20, [1] = 60 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[15] == 5 or R[15] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 125, [1] = 17 }, [7] = { [0] = 118, [1] = 10 } })[R[15]][R[5]], ({ [0] = 11, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      if R[15] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 120, [1] = 12 }, [7] = { [0] = 122, [1] = 14 } })[R[15]][R[5]], ({ [0] = 11, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      if R[15] == 7 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 123, [1] = 15 })[R[5]], ({ [0] = 17, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[15] == 5 then
      else
        unseen("R[15]", R[15])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [5] = { [0] = 17, [1] = 57 }, [7] = { [0] = 14, [1] = 54 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 121, [1] = 13 })[R[5]], ({ [5] = { [0] = 16, [1] = 56 }, [7] = { [0] = 15, [1] = 55 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 121, [1] = 13 }, [7] = { [0] = 126, [1] = 18 } })[R[15]][R[5]], ({ [5] = { [0] = 18, [1] = 58 }, [7] = { [0] = 15, [1] = 55 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[15] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 117, [1] = 9 })[R[5]], ({ [0] = 17, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 117, [1] = 9 })[R[5]], ({ [0] = 14, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 122, [1] = 14 })[R[5]], ({ [0] = 12, [1] = 52 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      unseen("R[15]", R[15])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 127, [1] = 19 }, [6] = { [0] = 124, [1] = 16 }, [7] = { [0] = 120, [1] = 12 } })[R[15]][R[5]], ({ [5] = { [0] = 13, [1] = 53 }, [6] = { [0] = 14, [1] = 54 }, [7] = { [0] = 12, [1] = 52 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[15] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 127, [1] = 19 })[R[5]], ({ [0] = 13, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[15] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 14, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 14, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 119, [1] = 11 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 21, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[15] == 7 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 12, [1] = 52 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[15]", R[15])
    end
  elseif R[15] == 1 or R[15] == 2 or R[15] == 3 or R[15] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 125, [1] = 17 }, [2] = { [0] = 118, [1] = 10 }, [3] = { [0] = 122, [1] = 14 }, [4] = { [0] = 118, [1] = 10 } })[R[15]][R[5]], ({ [0] = 20, [1] = 60 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    if R[15] == 1 or R[15] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 116, [1] = 8 }, [2] = { [0] = 117, [1] = 9 } })[R[15]][R[5]], ({ [0] = 11, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 125, [1] = 17 })[R[5]], ({ [1] = { [0] = 16, [1] = 56 }, [2] = { [0] = 20, [1] = 60 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 120, [1] = 12 }, [2] = { [0] = 121, [1] = 13 } })[R[15]][R[5]], ({ [1] = { [0] = 21, [1] = 61 }, [2] = { [0] = 17, [1] = 57 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 120, [1] = 12 }, [2] = { [0] = 125, [1] = 17 } })[R[15]][R[5]], ({ [1] = { [0] = 17, [1] = 57 }, [2] = { [0] = 14, [1] = 54 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 126, [1] = 18 }, [2] = { [0] = 124, [1] = 16 } })[R[15]][R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 127, [1] = 19 }, [2] = { [0] = 126, [1] = 18 } })[R[15]][R[5]], ({ [1] = { [0] = 21, [1] = 61 }, [2] = { [0] = 22, [1] = 62 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 117, [1] = 9 })[R[5]], ({ [0] = 21, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 17, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 118, [1] = 10 })[R[5]], ({ [0] = 16, [1] = 56 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 126, [1] = 18 })[R[5]], ({ [0] = 11, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 123, [1] = 15 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 21, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 118, [1] = 10 })[R[5]], ({ [0] = 12, [1] = 52 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 122, [1] = 14 })[R[5]], ({ [0] = 13, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 117, [1] = 9 })[R[5]], ({ [0] = 16, [1] = 56 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 126, [1] = 18 })[R[5]], ({ [0] = 21, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 10, [1] = 50 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 121, [1] = 13 })[R[5]], ({ [0] = 11, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[15]", R[15])
    end
    U[#U]:set_lights(true)
    if R[15] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 122, [1] = 14 })[R[5]], ({ [0] = 21, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 3 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 125, [1] = 17 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 115, [1] = 7 })[R[5]], ({ [0] = 18, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 121, [1] = 13 })[R[5]], ({ [0] = 11, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[15]", R[15])
    end
    U[#U]:set_lights(true)
    if R[15] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 127, [1] = 19 })[R[5]], ({ [0] = 18, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 2 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 119, [1] = 11 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 119, [1] = 11 })[R[5]], ({ [0] = 18, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[15] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 119, [1] = 11 })[R[5]], ({ [0] = 14, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 115, [1] = 7 })[R[5]], ({ [0] = 18, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[15]", R[15])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 127, [1] = 19 }, [2] = { [0] = 119, [1] = 11 }, [3] = { [0] = 119, [1] = 11 }, [4] = { [0] = 119, [1] = 11 } })[R[15]][R[5]], ({ [1] = { [0] = 18, [1] = 58 }, [2] = { [0] = 22, [1] = 62 }, [3] = { [0] = 18, [1] = 58 }, [4] = { [0] = 14, [1] = 54 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[15] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 118, [1] = 10 })[R[5]], ({ [0] = 20, [1] = 60 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 123, [1] = 15 })[R[5]], ({ [0] = 20, [1] = 60 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 117, [1] = 9 })[R[5]], ({ [0] = 17, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 125, [1] = 17 })[R[5]], ({ [0] = 17, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 126, [1] = 18 })[R[5]], ({ [0] = 11, [1] = 51 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 125, [1] = 17 })[R[5]], ({ [0] = 21, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 127, [1] = 19 })[R[5]], ({ [0] = 20, [1] = 60 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[15]", R[15])
  end
  U[#U]:set_lights(true)
  if R[15] == 0 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 116, [1] = 8 })[R[5]], ({ [0] = 13, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 116, [1] = 8 })[R[5]], ({ [0] = 13, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[15] == 1 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 127, [1] = 19 })[R[5]], ({ [0] = 18, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 117, [1] = 9 })[R[5]], ({ [0] = 17, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 117, [1] = 9 })[R[5]], ({ [0] = 17, [1] = 57 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[15] == 2 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 119, [1] = 11 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 121, [1] = 13 })[R[5]], ({ [0] = 13, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 121, [1] = 13 })[R[5]], ({ [0] = 13, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[15] == 3 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 119, [1] = 11 })[R[5]], ({ [0] = 18, [1] = 58 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 14, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 14, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[15] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 119, [1] = 11 })[R[5]], ({ [0] = 14, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 116, [1] = 8 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[15] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 127, [1] = 19 })[R[5]], ({ [0] = 13, [1] = 53 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 127, [1] = 19 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[15] == 6 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 14, [1] = 54 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 119, [1] = 11 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 21, [1] = 61 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 122, [1] = 14 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 15, [1] = 55 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 122, [1] = 14 })[R[5]], ({ [0] = 22, [1] = 62 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 15, [1] = 55 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[15] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 12, [1] = 52 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 127, [1] = 19 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[15]", R[15])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[15]], player = players[2], at = { ({ [0] = { [0] = 117, [1] = 9 }, [1] = { [0] = 116, [1] = 8 }, [2] = { [0] = 122, [1] = 14 }, [3] = { [0] = 121, [1] = 13 }, [4] = { [0] = 119, [1] = 11 }, [5] = { [0] = 126, [1] = 18 }, [6] = { [0] = 121, [1] = 13 }, [7] = { [0] = 126, [1] = 18 } })[R[15]][R[5]], ({ [0] = { [0] = 14, [1] = 54 }, [1] = { [0] = 16, [1] = 56 }, [2] = { [0] = 12, [1] = 52 }, [3] = { [0] = 13, [1] = 53 }, [4] = { [0] = 22, [1] = 62 }, [5] = { [0] = 17, [1] = 57 }, [6] = { [0] = 16, [1] = 56 }, [7] = { [0] = 22, [1] = 62 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[15]], player = players[2], at = { ({ [0] = { [0] = 118, [1] = 10 }, [1] = { [0] = 118, [1] = 10 }, [2] = { [0] = 121, [1] = 13 }, [3] = { [0] = 120, [1] = 12 }, [4] = { [0] = 120, [1] = 12 }, [5] = { [0] = 127, [1] = 19 }, [6] = { [0] = 122, [1] = 14 }, [7] = { [0] = 127, [1] = 19 } })[R[15]][R[5]], ({ [0] = { [0] = 14, [1] = 54 }, [1] = { [0] = 15, [1] = 55 }, [2] = { [0] = 11, [1] = 51 }, [3] = { [0] = 12, [1] = 52 }, [4] = { [0] = 21, [1] = 61 }, [5] = { [0] = 16, [1] = 56 }, [6] = { [0] = 15, [1] = 55 }, [7] = { [0] = 22, [1] = 62 } })[R[15]][R[5]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[15] == 0 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[16] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 116, [1] = 8 }, [1] = { [0] = 121, [1] = 13 }, [2] = { [0] = 126, [1] = 18 } })[R[16]][R[5]], ({ [0] = { [0] = 10, [1] = 50 }, [1] = { [0] = 13, [1] = 53 }, [2] = { [0] = 19, [1] = 59 } })[R[16]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[15] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 120, [1] = 12 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] })
      for i = 1, game.initial_units() do
        R[17] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 116, [1] = 8 }, [1] = { [0] = 120, [1] = 12 }, [2] = { [0] = 123, [1] = 15 } })[R[17]][R[5]], ({ [0] = { [0] = 20, [1] = 60 }, [1] = { [0] = 14, [1] = 54 }, [2] = { [0] = 10, [1] = 50 } })[R[17]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[15] == 2 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 121, [1] = 13 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 121, [1] = 13 })[R[5]], ({ [0] = 20, [1] = 60 })[R[5]] })
      game.create_tube({ ({ [0] = 122, [1] = 14 })[R[5]], ({ [0] = 20, [1] = 60 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 121, [1] = 13 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 121, [1] = 13 })[R[5]], ({ [0] = 20, [1] = 60 })[R[5]] })
      game.create_tube({ ({ [0] = 122, [1] = 14 })[R[5]], ({ [0] = 20, [1] = 60 })[R[5]] })
      for i = 1, game.initial_units() do
        R[18] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 17 }, [1] = { [0] = 117, [1] = 9 }, [2] = { [0] = 121, [1] = 13 } })[R[18]][R[5]], ({ [0] = { [0] = 10, [1] = 50 }, [1] = { [0] = 15, [1] = 55 }, [2] = { [0] = 20, [1] = 60 } })[R[18]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[15] == 3 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 118, [1] = 10 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 121, [1] = 13 })[R[5]], ({ [0] = 16, [1] = 56 })[R[5]] })
      game.create_tube({ ({ [0] = 122, [1] = 14 })[R[5]], ({ [0] = 16, [1] = 56 })[R[5]] })
      game.create_tube({ ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 20, [1] = 60 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 118, [1] = 10 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 121, [1] = 13 })[R[5]], ({ [0] = 16, [1] = 56 })[R[5]] })
      game.create_tube({ ({ [0] = 122, [1] = 14 })[R[5]], ({ [0] = 16, [1] = 56 })[R[5]] })
      game.create_tube({ ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 19, [1] = 59 })[R[5]] })
      game.create_tube({ ({ [0] = 124, [1] = 16 })[R[5]], ({ [0] = 20, [1] = 60 })[R[5]] })
      for i = 1, game.initial_units() do
        R[19] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 18 }, [1] = { [0] = 122, [1] = 14 }, [2] = { [0] = 118, [1] = 10 } })[R[19]][R[5]], ({ [0] = { [0] = 21, [1] = 61 }, [1] = { [0] = 15, [1] = 55 }, [2] = { [0] = 10, [1] = 50 } })[R[19]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[15] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 117, [1] = 9 })[R[5]], ({ [0] = 18, [1] = 58 })[R[5]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 117, [1] = 9 })[R[5]], ({ [0] = 18, [1] = 58 })[R[5]] })
      for i = 1, game.initial_units() do
        R[20] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 17 }, [1] = { [0] = 126, [1] = 18 }, [2] = { [0] = 122, [1] = 14 } })[R[20]][R[5]], ({ [0] = { [0] = 10, [1] = 50 }, [1] = { [0] = 16, [1] = 56 }, [2] = { [0] = 20, [1] = 60 } })[R[20]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 122, [1] = 14 }, [1] = { [0] = 116, [1] = 8 }, [2] = { [0] = 116, [1] = 8 } })[R[21]][R[5]], ({ [0] = { [0] = 21, [1] = 61 }, [1] = { [0] = 16, [1] = 56 }, [2] = { [0] = 11, [1] = 51 } })[R[21]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 18 }, [1] = { [0] = 125, [1] = 17 }, [2] = { [0] = 122, [1] = 14 } })[R[22]][R[5]], ({ [0] = { [0] = 11, [1] = 51 }, [1] = { [0] = 17, [1] = 57 }, [2] = { [0] = 18, [1] = 58 } })[R[22]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 12 }, [1] = { [0] = 116, [1] = 8 }, [2] = { [0] = 126, [1] = 18 } })[R[23]][R[5]], ({ [0] = { [0] = 20, [1] = 60 }, [1] = { [0] = 16, [1] = 56 }, [2] = { [0] = 11, [1] = 51 } })[R[23]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    trigger.time{min = 18000, max = 36000, one_shot = false, on = Meteor}  -- after 180 to 360 marks
    trigger.time{min = 18000, max = 30000, on = BigQuake}  -- after 180 to 300 marks
  end
  return true
end
