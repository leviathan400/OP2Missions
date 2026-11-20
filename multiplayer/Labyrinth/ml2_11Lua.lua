-- ml2_11Lua.lua  -  2 Player, LastOne, 'Labyrinth' map. (Lua)
--
-- Converted by op2dll from ml2_11.dll ("2 Player, LastOne, 'Labyrinth' map."): its setup replayed. `on_init` makes the original's
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
local Meteor, Tornado

function Meteor(t)
  local r1 = game.rand(128)
  local r2 = game.rand(128)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function Tornado(t)
  local r1 = game.rand(128)
  local r2 = game.rand(128)
  local r3 = game.rand(17)
  local r4 = game.rand(128)
  local r5 = game.rand(128)
  game.create_tornado({ r5 + 1, r4 + 2 }, { r2 + 1, r1 + 2 }, r3 + 1)
end

function on_init()
  local n = game.num_players()
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 37, 5 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 89, 123 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 34, 113 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 10, 71 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 55, 64 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 116, 34 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 96, 16 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 65, 88 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 117 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 73, 15 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 52, 51 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 90, 66 } }
  pick(2, 2, { 0, 1 })
  R[2] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 6, [1] = 104 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 15, [1] = 113 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 16, [1] = 114 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 16, [1] = 114 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 9, [1] = 105 }, [3] = { [0] = 20, [1] = 116 }, [4] = { [0] = 17, [1] = 113 }, [5] = { [0] = 16, [1] = 112 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 16, [1] = 112 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  players[1]:center_view({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 6, [1] = 104 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 15, [1] = 113 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 16, [1] = 114 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 16, [1] = 114 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 9, [1] = 105 }, [3] = { [0] = 20, [1] = 116 }, [4] = { [0] = 17, [1] = 113 }, [5] = { [0] = 16, [1] = 112 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 16, [1] = 112 } })[R[2]][R[1]] })
  U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 16, [1] = 114 }, [2] = { [0] = 8, [1] = 106 }, [3] = { [0] = 23, [1] = 121 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 16, [1] = 114 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 9, [1] = 107 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 107 }, [1] = { [0] = 3, [1] = 99 }, [2] = { [0] = 14, [1] = 110 }, [3] = { [0] = 24, [1] = 120 }, [4] = { [0] = 25, [1] = 121 }, [5] = { [0] = 22, [1] = 118 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 22, [1] = 118 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  if R[2] == 0 or R[2] == 1 or R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 126 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 11, [1] = 109 }, [5] = { [0] = 26, [1] = 124 }, [6] = { [0] = 20, [1] = 118 }, [7] = { [0] = 9, [1] = 107 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 10, [1] = 106 }, [2] = { [0] = 20, [1] = 116 }, [5] = { [0] = 21, [1] = 117 }, [6] = { [0] = 20, [1] = 116 }, [7] = { [0] = 9, [1] = 105 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 0 then
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
    elseif R[2] == 1 then
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
    elseif R[2] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 118 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 118 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 118 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 126 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 126 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 28, [1] = 126 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 5, [1] = 103 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 20, [1] = 118 }, [5] = { [0] = 16, [1] = 114 }, [6] = { [0] = 11, [1] = 109 }, [7] = { [0] = 25, [1] = 123 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 20, [1] = 116 }, [2] = { [0] = 20, [1] = 116 }, [5] = { [0] = 9, [1] = 105 }, [6] = { [0] = 20, [1] = 116 }, [7] = { [0] = 21, [1] = 117 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
    elseif R[2] == 0 or R[2] == 1 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = { [0] = 25, [1] = 121 }, [1] = { [0] = 28, [1] = 124 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
  elseif R[2] == 3 or R[2] == 4 then
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 7, [1] = 105 }, [4] = { [0] = 15, [1] = 113 } })[R[2]][R[1]], ({ [3] = { [0] = 24, [1] = 120 }, [4] = { [0] = 9, [1] = 105 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 11, [1] = 107 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 3 then
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 10, [1] = 108 }, [4] = { [0] = 26, [1] = 124 } })[R[2]][R[1]], ({ [3] = { [0] = 13, [1] = 109 }, [4] = { [0] = 21, [1] = 117 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 3 then
      if LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 13, [1] = 109 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 13, [1] = 109 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 13, [1] = 109 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
  U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 5, [1] = 103 }, [1] = { [0] = 7, [1] = 105 }, [2] = { [0] = 28, [1] = 126 }, [3] = { [0] = 18, [1] = 116 }, [4] = { [0] = 7, [1] = 105 }, [5] = { [0] = 6, [1] = 104 }, [6] = { [0] = 3, [1] = 101 }, [7] = { [0] = 17, [1] = 115 } })[R[2]][R[1]], ({ [0] = { [0] = 27, [1] = 123 }, [1] = { [0] = 25, [1] = 121 }, [2] = { [0] = 14, [1] = 110 }, [3] = { [0] = 7, [1] = 103 }, [4] = { [0] = 13, [1] = 109 }, [5] = { [0] = 16, [1] = 112 }, [6] = { [0] = 20, [1] = 116 }, [7] = { [0] = 25, [1] = 121 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 110 }, [1] = { [0] = 6, [1] = 104 }, [2] = { [0] = 24, [1] = 122 }, [3] = { [0] = 5, [1] = 103 }, [4] = { [0] = 25, [1] = 123 }, [5] = { [0] = 24, [1] = 122 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 27, [1] = 125 } })[R[2]][R[1]], ({ [0] = { [0] = 14, [1] = 110 }, [1] = { [0] = 11, [1] = 107 }, [2] = { [0] = 18, [1] = 114 }, [3] = { [0] = 14, [1] = 110 }, [4] = { [0] = 17, [1] = 113 }, [5] = { [0] = 7, [1] = 103 }, [6] = { [0] = 25, [1] = 121 }, [7] = { [0] = 16, [1] = 112 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 10, [1] = 108 }, [1] = { [0] = 6, [1] = 104 }, [2] = { [0] = 24, [1] = 122 }, [3] = { [0] = 8, [1] = 106 }, [4] = { [0] = 27, [1] = 125 }, [5] = { [0] = 24, [1] = 122 }, [6] = { [0] = 8, [1] = 106 }, [7] = { [0] = 27, [1] = 125 } })[R[2]][R[1]], ({ [0] = { [0] = 14, [1] = 110 }, [1] = { [0] = 9, [1] = 105 }, [2] = { [0] = 16, [1] = 112 }, [3] = { [0] = 10, [1] = 106 }, [4] = { [0] = 17, [1] = 113 }, [5] = { [0] = 9, [1] = 105 }, [6] = { [0] = 25, [1] = 121 }, [7] = { [0] = 18, [1] = 114 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if LEVEL_OF[players[1].difficulty] == 0 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 6, [1] = 104 }, [3] = { [0] = 25, [1] = 123 }, [4] = { [0] = 19, [1] = 117 }, [5] = { [0] = 12, [1] = 110 }, [6] = { [0] = 23, [1] = 121 }, [7] = { [0] = 26, [1] = 124 } })[R[2]][R[1]], ({ [0] = { [0] = 20, [1] = 116 }, [1] = { [0] = 11, [1] = 107 }, [2] = { [0] = 19, [1] = 115 }, [3] = { [0] = 14, [1] = 110 }, [4] = { [0] = 25, [1] = 121 }, [5] = { [0] = 17, [1] = 113 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 10, [1] = 106 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 6, [1] = 104 }, [3] = { [0] = 23, [1] = 121 }, [4] = { [0] = 19, [1] = 117 }, [5] = { [0] = 12, [1] = 110 }, [6] = { [0] = 23, [1] = 121 }, [7] = { [0] = 26, [1] = 124 } })[R[2]][R[1]], ({ [0] = { [0] = 20, [1] = 116 }, [1] = { [0] = 11, [1] = 107 }, [2] = { [0] = 19, [1] = 115 }, [3] = { [0] = 10, [1] = 106 }, [4] = { [0] = 25, [1] = 121 }, [5] = { [0] = 17, [1] = 113 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 10, [1] = 106 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 6, [1] = 104 }, [3] = { [0] = 11, [1] = 109 }, [4] = { [0] = 19, [1] = 117 }, [5] = { [0] = 12, [1] = 110 }, [6] = { [0] = 23, [1] = 121 }, [7] = { [0] = 26, [1] = 124 } })[R[2]][R[1]], ({ [0] = { [0] = 20, [1] = 116 }, [1] = { [0] = 11, [1] = 107 }, [2] = { [0] = 19, [1] = 115 }, [3] = { [0] = 25, [1] = 121 }, [4] = { [0] = 25, [1] = 121 }, [5] = { [0] = 17, [1] = 113 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 10, [1] = 106 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 24, [1] = 122 }, [3] = { [0] = 11, [1] = 109 }, [4] = { [0] = 20, [1] = 118 }, [5] = { [0] = 11, [1] = 109 }, [6] = { [0] = 15, [1] = 113 }, [7] = { [0] = 11, [1] = 109 } })[R[2]][R[1]], ({ [0] = { [0] = 14, [1] = 110 }, [1] = { [0] = 5, [1] = 101 }, [2] = { [0] = 22, [1] = 118 }, [3] = { [0] = 25, [1] = 121 }, [4] = { [0] = 21, [1] = 117 }, [5] = { [0] = 6, [1] = 102 }, [6] = { [0] = 22, [1] = 118 }, [7] = { [0] = 16, [1] = 112 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 12, [1] = 110 }, [2] = { [0] = 20, [1] = 118 }, [3] = { [0] = 11, [1] = 109 }, [4] = { [0] = 22, [1] = 120 }, [5] = { [0] = 20, [1] = 118 }, [6] = { [0] = 24, [1] = 122 }, [7] = { [0] = 6, [1] = 104 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 107 }, [1] = { [0] = 2, [1] = 98 }, [2] = { [0] = 23, [1] = 119 }, [3] = { [0] = 25, [1] = 121 }, [4] = { [0] = 12, [1] = 108 }, [5] = { [0] = 14, [1] = 110 }, [6] = { [0] = 19, [1] = 115 }, [7] = { [0] = 13, [1] = 109 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[1].difficulty] == 2 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 6, [1] = 104 }, [3] = { [0] = 25, [1] = 123 }, [4] = { [0] = 19, [1] = 117 }, [5] = { [0] = 12, [1] = 110 }, [6] = { [0] = 23, [1] = 121 }, [7] = { [0] = 26, [1] = 124 } })[R[2]][R[1]], ({ [0] = { [0] = 20, [1] = 116 }, [1] = { [0] = 11, [1] = 107 }, [2] = { [0] = 19, [1] = 115 }, [3] = { [0] = 14, [1] = 110 }, [4] = { [0] = 25, [1] = 121 }, [5] = { [0] = 17, [1] = 113 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 10, [1] = 106 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 24, [1] = 122 }, [3] = { [0] = 23, [1] = 121 }, [4] = { [0] = 20, [1] = 118 }, [5] = { [0] = 11, [1] = 109 }, [6] = { [0] = 15, [1] = 113 }, [7] = { [0] = 11, [1] = 109 } })[R[2]][R[1]], ({ [0] = { [0] = 14, [1] = 110 }, [1] = { [0] = 5, [1] = 101 }, [2] = { [0] = 22, [1] = 118 }, [3] = { [0] = 10, [1] = 106 }, [4] = { [0] = 21, [1] = 117 }, [5] = { [0] = 6, [1] = 102 }, [6] = { [0] = 22, [1] = 118 }, [7] = { [0] = 16, [1] = 112 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 12, [1] = 110 }, [2] = { [0] = 20, [1] = 118 }, [3] = { [0] = 11, [1] = 109 }, [4] = { [0] = 22, [1] = 120 }, [5] = { [0] = 20, [1] = 118 }, [6] = { [0] = 24, [1] = 122 }, [7] = { [0] = 6, [1] = 104 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 107 }, [1] = { [0] = 2, [1] = 98 }, [2] = { [0] = 23, [1] = 119 }, [3] = { [0] = 25, [1] = 121 }, [4] = { [0] = 12, [1] = 108 }, [5] = { [0] = 14, [1] = 110 }, [6] = { [0] = 19, [1] = 115 }, [7] = { [0] = 13, [1] = 109 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[1].difficulty] == 1 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 6, [1] = 104 }, [3] = { [0] = 25, [1] = 123 }, [4] = { [0] = 19, [1] = 117 }, [5] = { [0] = 12, [1] = 110 }, [6] = { [0] = 23, [1] = 121 }, [7] = { [0] = 26, [1] = 124 } })[R[2]][R[1]], ({ [0] = { [0] = 20, [1] = 116 }, [1] = { [0] = 11, [1] = 107 }, [2] = { [0] = 19, [1] = 115 }, [3] = { [0] = 14, [1] = 110 }, [4] = { [0] = 25, [1] = 121 }, [5] = { [0] = 17, [1] = 113 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 10, [1] = 106 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 6, [1] = 104 }, [3] = { [0] = 23, [1] = 121 }, [4] = { [0] = 19, [1] = 117 }, [5] = { [0] = 12, [1] = 110 }, [6] = { [0] = 23, [1] = 121 }, [7] = { [0] = 26, [1] = 124 } })[R[2]][R[1]], ({ [0] = { [0] = 20, [1] = 116 }, [1] = { [0] = 11, [1] = 107 }, [2] = { [0] = 19, [1] = 115 }, [3] = { [0] = 10, [1] = 106 }, [4] = { [0] = 25, [1] = 121 }, [5] = { [0] = 17, [1] = 113 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 10, [1] = 106 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 24, [1] = 122 }, [3] = { [0] = 11, [1] = 109 }, [4] = { [0] = 20, [1] = 118 }, [5] = { [0] = 11, [1] = 109 }, [6] = { [0] = 15, [1] = 113 }, [7] = { [0] = 11, [1] = 109 } })[R[2]][R[1]], ({ [0] = { [0] = 14, [1] = 110 }, [1] = { [0] = 5, [1] = 101 }, [2] = { [0] = 22, [1] = 118 }, [3] = { [0] = 25, [1] = 121 }, [4] = { [0] = 21, [1] = 117 }, [5] = { [0] = 6, [1] = 102 }, [6] = { [0] = 22, [1] = 118 }, [7] = { [0] = 16, [1] = 112 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 12, [1] = 110 }, [2] = { [0] = 20, [1] = 118 }, [3] = { [0] = 11, [1] = 109 }, [4] = { [0] = 22, [1] = 120 }, [5] = { [0] = 20, [1] = 118 }, [6] = { [0] = 24, [1] = 122 }, [7] = { [0] = 6, [1] = 104 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 107 }, [1] = { [0] = 2, [1] = 98 }, [2] = { [0] = 23, [1] = 119 }, [3] = { [0] = 25, [1] = 121 }, [4] = { [0] = 12, [1] = 108 }, [5] = { [0] = 14, [1] = 110 }, [6] = { [0] = 19, [1] = 115 }, [7] = { [0] = 13, [1] = 109 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 126 }, [1] = { [0] = 15, [1] = 113 }, [2] = { [0] = 16, [1] = 114 }, [3] = { [0] = 15, [1] = 113 }, [4] = { [0] = 28, [1] = 126 }, [5] = { [0] = 12, [1] = 110 }, [6] = { [0] = 24, [1] = 122 }, [7] = { [0] = 20, [1] = 118 } })[R[2]][R[1]], ({ [0] = { [0] = 22, [1] = 118 }, [1] = { [0] = 15, [1] = 111 }, [2] = { [0] = 16, [1] = 112 }, [3] = { [0] = 11, [1] = 107 }, [4] = { [0] = 8, [1] = 104 }, [5] = { [0] = 23, [1] = 119 }, [6] = { [0] = 22, [1] = 118 }, [7] = { [0] = 15, [1] = 111 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  game.create_tube({ ({ [0] = { [0] = 8, [1] = 106 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 11, [1] = 109 }, [3] = { [0] = 7, [1] = 105 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 16, [1] = 114 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 9, [1] = 107 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 14, [1] = 110 }, [3] = { [0] = 20, [1] = 116 }, [4] = { [0] = 11, [1] = 107 }, [5] = { [0] = 12, [1] = 108 }, [6] = { [0] = 14, [1] = 110 }, [7] = { [0] = 12, [1] = 108 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 9, [1] = 107 }, [1] = { [0] = 10, [1] = 108 }, [2] = { [0] = 12, [1] = 110 }, [3] = { [0] = 7, [1] = 105 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 16, [1] = 114 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 9, [1] = 107 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 14, [1] = 110 }, [3] = { [0] = 21, [1] = 117 }, [4] = { [0] = 12, [1] = 108 }, [5] = { [0] = 13, [1] = 109 }, [6] = { [0] = 15, [1] = 111 }, [7] = { [0] = 13, [1] = 109 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 10, [1] = 108 }, [1] = { [0] = 11, [1] = 109 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 7, [1] = 105 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 16, [1] = 114 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 9, [1] = 107 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 14, [1] = 110 }, [3] = { [0] = 22, [1] = 118 }, [4] = { [0] = 13, [1] = 109 }, [5] = { [0] = 14, [1] = 110 }, [6] = { [0] = 16, [1] = 112 }, [7] = { [0] = 14, [1] = 110 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 11, [1] = 109 }, [1] = { [0] = 12, [1] = 110 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 8, [1] = 106 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 16, [1] = 114 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 9, [1] = 107 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 11, [1] = 107 }, [3] = { [0] = 20, [1] = 116 }, [4] = { [0] = 14, [1] = 110 }, [5] = { [0] = 18, [1] = 114 }, [6] = { [0] = 17, [1] = 113 }, [7] = { [0] = 15, [1] = 111 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 12, [1] = 110 }, [1] = { [0] = 13, [1] = 111 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 9, [1] = 107 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 16, [1] = 114 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 9, [1] = 107 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 12, [1] = 108 }, [3] = { [0] = 16, [1] = 112 }, [4] = { [0] = 15, [1] = 111 }, [5] = { [0] = 19, [1] = 115 }, [6] = { [0] = 18, [1] = 114 }, [7] = { [0] = 16, [1] = 112 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 13, [1] = 111 }, [1] = { [0] = 14, [1] = 112 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 9, [1] = 107 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 16, [1] = 114 }, [6] = { [0] = 13, [1] = 111 }, [7] = { [0] = 9, [1] = 107 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 13, [1] = 109 }, [3] = { [0] = 17, [1] = 113 }, [4] = { [0] = 19, [1] = 115 }, [5] = { [0] = 20, [1] = 116 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 17, [1] = 113 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 14, [1] = 112 }, [1] = { [0] = 15, [1] = 113 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 9, [1] = 107 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 19, [1] = 117 }, [6] = { [0] = 14, [1] = 112 }, [7] = { [0] = 9, [1] = 107 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 14, [1] = 110 }, [3] = { [0] = 18, [1] = 114 }, [4] = { [0] = 20, [1] = 116 }, [5] = { [0] = 16, [1] = 112 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 18, [1] = 114 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 16, [1] = 114 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 9, [1] = 107 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 19, [1] = 117 }, [6] = { [0] = 14, [1] = 112 }, [7] = { [0] = 9, [1] = 107 } })[R[2]][R[1]], ({ [0] = { [0] = 13, [1] = 109 }, [1] = { [0] = 5, [1] = 101 }, [2] = { [0] = 15, [1] = 111 }, [3] = { [0] = 19, [1] = 115 }, [4] = { [0] = 21, [1] = 117 }, [5] = { [0] = 22, [1] = 118 }, [6] = { [0] = 20, [1] = 116 }, [7] = { [0] = 19, [1] = 115 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 16, [1] = 114 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 9, [1] = 107 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 20, [1] = 118 }, [6] = { [0] = 15, [1] = 113 }, [7] = { [0] = 9, [1] = 107 } })[R[2]][R[1]], ({ [0] = { [0] = 14, [1] = 110 }, [1] = { [0] = 6, [1] = 102 }, [2] = { [0] = 16, [1] = 112 }, [3] = { [0] = 20, [1] = 116 }, [4] = { [0] = 22, [1] = 118 }, [5] = { [0] = 16, [1] = 112 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 20, [1] = 116 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 16, [1] = 114 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 10, [1] = 108 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 20, [1] = 118 }, [6] = { [0] = 15, [1] = 113 }, [7] = { [0] = 12, [1] = 110 } })[R[2]][R[1]], ({ [0] = { [0] = 15, [1] = 111 }, [1] = { [0] = 7, [1] = 103 }, [2] = { [0] = 17, [1] = 113 }, [3] = { [0] = 16, [1] = 112 }, [4] = { [0] = 23, [1] = 119 }, [5] = { [0] = 22, [1] = 118 }, [6] = { [0] = 20, [1] = 116 }, [7] = { [0] = 9, [1] = 105 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 16, [1] = 114 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 10, [1] = 108 }, [4] = { [0] = 18, [1] = 116 }, [5] = { [0] = 21, [1] = 119 }, [6] = { [0] = 16, [1] = 114 }, [7] = { [0] = 12, [1] = 110 } })[R[2]][R[1]], ({ [0] = { [0] = 16, [1] = 112 }, [1] = { [0] = 8, [1] = 104 }, [2] = { [0] = 18, [1] = 114 }, [3] = { [0] = 20, [1] = 116 }, [4] = { [0] = 9, [1] = 105 }, [5] = { [0] = 16, [1] = 112 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 22, [1] = 118 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 16, [1] = 114 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 11, [1] = 109 }, [4] = { [0] = 18, [1] = 116 }, [5] = { [0] = 21, [1] = 119 }, [6] = { [0] = 16, [1] = 114 }, [7] = { [0] = 13, [1] = 111 } })[R[2]][R[1]], ({ [0] = { [0] = 20, [1] = 116 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 19, [1] = 115 }, [3] = { [0] = 20, [1] = 116 }, [4] = { [0] = 17, [1] = 113 }, [5] = { [0] = 22, [1] = 118 }, [6] = { [0] = 20, [1] = 116 }, [7] = { [0] = 9, [1] = 105 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 12, [1] = 110 }, [4] = { [0] = 18, [1] = 116 }, [5] = { [0] = 22, [1] = 120 }, [6] = { [0] = 17, [1] = 115 }, [7] = { [0] = 13, [1] = 111 } })[R[2]][R[1]], ({ [0] = { [0] = 21, [1] = 117 }, [1] = { [0] = 13, [1] = 109 }, [2] = { [0] = 20, [1] = 116 }, [3] = { [0] = 20, [1] = 116 }, [4] = { [0] = 25, [1] = 121 }, [5] = { [0] = 16, [1] = 112 }, [6] = { [0] = 12, [1] = 108 }, [7] = { [0] = 22, [1] = 118 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 15, [1] = 113 }, [3] = { [0] = 13, [1] = 111 }, [4] = { [0] = 19, [1] = 117 }, [5] = { [0] = 22, [1] = 120 }, [6] = { [0] = 17, [1] = 115 }, [7] = { [0] = 14, [1] = 112 } })[R[2]][R[1]], ({ [0] = { [0] = 22, [1] = 118 }, [1] = { [0] = 14, [1] = 110 }, [2] = { [0] = 14, [1] = 110 }, [3] = { [0] = 13, [1] = 109 }, [4] = { [0] = 9, [1] = 105 }, [5] = { [0] = 22, [1] = 118 }, [6] = { [0] = 20, [1] = 116 }, [7] = { [0] = 9, [1] = 105 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 15, [1] = 113 }, [3] = { [0] = 13, [1] = 111 }, [4] = { [0] = 19, [1] = 117 }, [5] = { [0] = 23, [1] = 121 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 14, [1] = 112 } })[R[2]][R[1]], ({ [0] = { [0] = 23, [1] = 119 }, [1] = { [0] = 15, [1] = 111 }, [2] = { [0] = 20, [1] = 116 }, [3] = { [0] = 20, [1] = 116 }, [4] = { [0] = 17, [1] = 113 }, [5] = { [0] = 16, [1] = 112 }, [6] = { [0] = 14, [1] = 110 }, [7] = { [0] = 22, [1] = 118 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 19, [1] = 117 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 16, [1] = 114 }, [3] = { [0] = 14, [1] = 112 }, [4] = { [0] = 19, [1] = 117 }, [5] = { [0] = 23, [1] = 121 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 15, [1] = 113 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 14, [1] = 110 }, [3] = { [0] = 13, [1] = 109 }, [4] = { [0] = 25, [1] = 121 }, [5] = { [0] = 22, [1] = 118 }, [6] = { [0] = 15, [1] = 111 }, [7] = { [0] = 9, [1] = 105 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 20, [1] = 118 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 16, [1] = 114 }, [3] = { [0] = 15, [1] = 113 }, [4] = { [0] = 20, [1] = 118 }, [5] = { [0] = 24, [1] = 122 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 15, [1] = 113 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 17, [1] = 113 }, [2] = { [0] = 20, [1] = 116 }, [3] = { [0] = 13, [1] = 109 }, [4] = { [0] = 9, [1] = 105 }, [5] = { [0] = 16, [1] = 112 }, [6] = { [0] = 16, [1] = 112 }, [7] = { [0] = 22, [1] = 118 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 17, [1] = 115 }, [3] = { [0] = 16, [1] = 114 }, [4] = { [0] = 20, [1] = 118 }, [5] = { [0] = 25, [1] = 123 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 16, [1] = 114 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 18, [1] = 114 }, [2] = { [0] = 14, [1] = 110 }, [3] = { [0] = 13, [1] = 109 }, [4] = { [0] = 10, [1] = 106 }, [5] = { [0] = 16, [1] = 112 }, [6] = { [0] = 17, [1] = 113 }, [7] = { [0] = 9, [1] = 105 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 22, [1] = 120 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 17, [1] = 115 }, [3] = { [0] = 17, [1] = 115 }, [4] = { [0] = 20, [1] = 118 }, [5] = { [0] = 26, [1] = 124 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 16, [1] = 114 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 23, [1] = 119 }, [2] = { [0] = 20, [1] = 116 }, [3] = { [0] = 13, [1] = 109 }, [4] = { [0] = 17, [1] = 113 }, [5] = { [0] = 16, [1] = 112 }, [6] = { [0] = 18, [1] = 114 }, [7] = { [0] = 10, [1] = 106 } })[R[2]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 23, [1] = 121 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 18, [1] = 116 }, [3] = { [0] = 18, [1] = 116 }, [4] = { [0] = 20, [1] = 118 }, [5] = { [0] = 26, [1] = 124 }, [6] = { [0] = 23, [1] = 121 }, [7] = { [0] = 16, [1] = 114 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 114 }, [1] = { [0] = 24, [1] = 120 }, [2] = { [0] = 14, [1] = 110 }, [3] = { [0] = 13, [1] = 109 }, [4] = { [0] = 25, [1] = 121 }, [5] = { [0] = 17, [1] = 113 }, [6] = { [0] = 20, [1] = 116 }, [7] = { [0] = 11, [1] = 107 } })[R[2]][R[1]] })
  if R[2] == 0 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      for i = 1, game.initial_units() do
        R[3] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 120 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 21, [1] = 119 } })[R[3]][R[1]], ({ [0] = { [0] = 12, [1] = 108 }, [1] = { [0] = 21, [1] = 117 }, [2] = { [0] = 24, [1] = 120 } })[R[3]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], ({ [0] = 26, [1] = 122 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], ({ [0] = 26, [1] = 122 })[R[1]] })
      for i = 1, game.initial_units() do
        R[4] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 8, [1] = 106 }, [1] = { [0] = 10, [1] = 108 }, [2] = { [0] = 12, [1] = 110 } })[R[4]][R[1]], ({ [0] = { [0] = 20, [1] = 116 }, [1] = { [0] = 29, [1] = 125 }, [2] = { [0] = 14, [1] = 110 } })[R[4]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 9, [1] = 107 }, [1] = { [0] = 19, [1] = 117 }, [2] = { [0] = 27, [1] = 125 } })[R[5]][R[1]], ({ [0] = { [0] = 8, [1] = 104 }, [1] = { [0] = 8, [1] = 104 }, [2] = { [0] = 17, [1] = 113 } })[R[5]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 3 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 19, [1] = 115 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 21, [1] = 117 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      for i = 1, game.initial_units() do
        R[6] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 4, [1] = 102 } })[R[6]][R[1]], ({ [0] = { [0] = 16, [1] = 112 }, [1] = { [0] = 23, [1] = 119 }, [2] = { [0] = 22, [1] = 118 } })[R[6]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 19, [1] = 115 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 21, [1] = 117 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 10, [1] = 106 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 11, [1] = 107 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 11, [1] = 107 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 11, [1] = 107 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 19, [1] = 115 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 24, [1] = 120 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], ({ [0] = 24, [1] = 120 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 15, [1] = 111 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 24, [1] = 120 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 10, [1] = 106 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 11, [1] = 107 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 11, [1] = 107 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 11, [1] = 107 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 19, [1] = 115 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 24, [1] = 120 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 25, [1] = 121 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], ({ [0] = 24, [1] = 120 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 15, [1] = 111 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 24, [1] = 120 })[R[1]] })
      for i = 1, game.initial_units() do
        R[7] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 117 }, [1] = { [0] = 10, [1] = 108 }, [2] = { [0] = 12, [1] = 110 } })[R[7]][R[1]], ({ [0] = { [0] = 8, [1] = 104 }, [1] = { [0] = 16, [1] = 112 }, [2] = { [0] = 8, [1] = 104 } })[R[7]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 5 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 19, [1] = 115 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 19, [1] = 115 })[R[1]] })
      for i = 1, game.initial_units() do
        R[8] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 22, [1] = 120 }, [1] = { [0] = 5, [1] = 103 }, [2] = { [0] = 27, [1] = 125 } })[R[8]][R[1]], ({ [0] = { [0] = 25, [1] = 121 }, [1] = { [0] = 12, [1] = 108 }, [2] = { [0] = 25, [1] = 121 } })[R[8]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 6 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      for i = 1, game.initial_units() do
        R[9] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 5, [1] = 103 }, [1] = { [0] = 29, [1] = 127 }, [2] = { [0] = 33, [1] = 131 } })[R[9]][R[1]], ({ [0] = { [0] = 10, [1] = 106 }, [1] = { [0] = 23, [1] = 119 }, [2] = { [0] = 21, [1] = 117 } })[R[9]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 7 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 12, [1] = 108 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 13, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 19, [1] = 115 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 21, [1] = 117 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 11, [1] = 107 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 12, [1] = 108 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 13, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 15, [1] = 111 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 19, [1] = 115 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 12, [1] = 108 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 13, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 19, [1] = 115 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 20, [1] = 116 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 21, [1] = 117 })[R[1]] })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 9, [1] = 105 })[R[1]] })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], ({ [0] = 22, [1] = 118 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 11, [1] = 107 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 12, [1] = 108 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 13, [1] = 109 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 14, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 15, [1] = 111 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 16, [1] = 112 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 17, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 18, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], ({ [0] = 19, [1] = 115 })[R[1]] })
      for i = 1, game.initial_units() do
        R[10] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 112 }, [1] = { [0] = 20, [1] = 118 }, [2] = { [0] = 10, [1] = 108 } })[R[10]][R[1]], ({ [0] = { [0] = 5, [1] = 101 }, [1] = { [0] = 5, [1] = 101 }, [2] = { [0] = 26, [1] = 122 } })[R[10]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[2]", R[2])
  end
  R[11] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 104, [1] = 6 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 113, [1] = 15 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 114, [1] = 16 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 114, [1] = 16 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 105, [1] = 9 }, [3] = { [0] = 116, [1] = 20 }, [4] = { [0] = 113, [1] = 17 }, [5] = { [0] = 112, [1] = 16 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 112, [1] = 16 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  players[2]:center_view({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 104, [1] = 6 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 113, [1] = 15 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 114, [1] = 16 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 114, [1] = 16 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 105, [1] = 9 }, [3] = { [0] = 116, [1] = 20 }, [4] = { [0] = 113, [1] = 17 }, [5] = { [0] = 112, [1] = 16 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 112, [1] = 16 } })[R[11]][R[1]] })
  U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 106, [1] = 8 }, [3] = { [0] = 121, [1] = 23 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 114, [1] = 16 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 107, [1] = 9 } })[R[11]][R[1]], ({ [0] = { [0] = 107, [1] = 11 }, [1] = { [0] = 99, [1] = 3 }, [2] = { [0] = 110, [1] = 14 }, [3] = { [0] = 120, [1] = 24 }, [4] = { [0] = 121, [1] = 25 }, [5] = { [0] = 118, [1] = 22 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 118, [1] = 22 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  if R[11] == 3 or R[11] == 4 then
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 105, [1] = 7 }, [4] = { [0] = 113, [1] = 15 } })[R[11]][R[1]], ({ [3] = { [0] = 120, [1] = 24 }, [4] = { [0] = 105, [1] = 9 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 107, [1] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 3 then
    else
      unseen("R[11]", R[11])
    end
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [3] = { [0] = 108, [1] = 10 }, [4] = { [0] = 124, [1] = 26 } })[R[11]][R[1]], ({ [3] = { [0] = 109, [1] = 13 }, [4] = { [0] = 117, [1] = 21 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 3 then
      if LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 109, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 109, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 109, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 4 then
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
      unseen("R[11]", R[11])
    end
  elseif R[11] == 0 or R[11] == 1 or R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 28 }, [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 109, [1] = 11 }, [5] = { [0] = 124, [1] = 26 }, [6] = { [0] = 118, [1] = 20 }, [7] = { [0] = 107, [1] = 9 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 106, [1] = 10 }, [2] = { [0] = 116, [1] = 20 }, [5] = { [0] = 117, [1] = 21 }, [6] = { [0] = 116, [1] = 20 }, [7] = { [0] = 105, [1] = 9 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 103, [1] = 5 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 103, [1] = 5 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 103, [1] = 5 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 2 then
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
    elseif R[11] == 5 then
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
    elseif R[11] == 6 then
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
    elseif R[11] == 7 then
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
      unseen("R[11]", R[11])
    end
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 118, [1] = 20 }, [5] = { [0] = 124, [1] = 26 }, [6] = { [0] = 126, [1] = 28 }, [7] = { [0] = 122, [1] = 24 } })[R[11]][R[1]], ({ [0] = { [0] = 121, [1] = 25 }, [1] = { [0] = 124, [1] = 28 }, [2] = { [0] = 110, [1] = 14 }, [5] = { [0] = 110, [1] = 14 }, [6] = { [0] = 116, [1] = 20 }, [7] = { [0] = 105, [1] = 9 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 0 or R[11] == 1 then
    elseif R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [2] = { [0] = 118, [1] = 20 }, [5] = { [0] = 114, [1] = 16 }, [6] = { [0] = 109, [1] = 11 }, [7] = { [0] = 123, [1] = 25 } })[R[11]][R[1]], ({ [2] = { [0] = 116, [1] = 20 }, [5] = { [0] = 105, [1] = 9 }, [6] = { [0] = 116, [1] = 20 }, [7] = { [0] = 117, [1] = 21 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
  else
    unseen("R[11]", R[11])
  end
  U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 103, [1] = 5 }, [1] = { [0] = 105, [1] = 7 }, [2] = { [0] = 126, [1] = 28 }, [3] = { [0] = 116, [1] = 18 }, [4] = { [0] = 105, [1] = 7 }, [5] = { [0] = 104, [1] = 6 }, [6] = { [0] = 101, [1] = 3 }, [7] = { [0] = 115, [1] = 17 } })[R[11]][R[1]], ({ [0] = { [0] = 123, [1] = 27 }, [1] = { [0] = 121, [1] = 25 }, [2] = { [0] = 110, [1] = 14 }, [3] = { [0] = 103, [1] = 7 }, [4] = { [0] = 109, [1] = 13 }, [5] = { [0] = 112, [1] = 16 }, [6] = { [0] = 116, [1] = 20 }, [7] = { [0] = 121, [1] = 25 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 110, [1] = 12 }, [1] = { [0] = 104, [1] = 6 }, [2] = { [0] = 122, [1] = 24 }, [3] = { [0] = 103, [1] = 5 }, [4] = { [0] = 123, [1] = 25 }, [5] = { [0] = 122, [1] = 24 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 125, [1] = 27 } })[R[11]][R[1]], ({ [0] = { [0] = 110, [1] = 14 }, [1] = { [0] = 107, [1] = 11 }, [2] = { [0] = 114, [1] = 18 }, [3] = { [0] = 110, [1] = 14 }, [4] = { [0] = 113, [1] = 17 }, [5] = { [0] = 103, [1] = 7 }, [6] = { [0] = 121, [1] = 25 }, [7] = { [0] = 112, [1] = 16 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 108, [1] = 10 }, [1] = { [0] = 104, [1] = 6 }, [2] = { [0] = 122, [1] = 24 }, [3] = { [0] = 106, [1] = 8 }, [4] = { [0] = 125, [1] = 27 }, [5] = { [0] = 122, [1] = 24 }, [6] = { [0] = 106, [1] = 8 }, [7] = { [0] = 125, [1] = 27 } })[R[11]][R[1]], ({ [0] = { [0] = 110, [1] = 14 }, [1] = { [0] = 105, [1] = 9 }, [2] = { [0] = 112, [1] = 16 }, [3] = { [0] = 106, [1] = 10 }, [4] = { [0] = 113, [1] = 17 }, [5] = { [0] = 105, [1] = 9 }, [6] = { [0] = 121, [1] = 25 }, [7] = { [0] = 114, [1] = 18 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if LEVEL_OF[players[2].difficulty] == 0 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 104, [1] = 6 }, [3] = { [0] = 123, [1] = 25 }, [4] = { [0] = 117, [1] = 19 }, [5] = { [0] = 110, [1] = 12 }, [6] = { [0] = 121, [1] = 23 }, [7] = { [0] = 124, [1] = 26 } })[R[11]][R[1]], ({ [0] = { [0] = 116, [1] = 20 }, [1] = { [0] = 107, [1] = 11 }, [2] = { [0] = 115, [1] = 19 }, [3] = { [0] = 110, [1] = 14 }, [4] = { [0] = 121, [1] = 25 }, [5] = { [0] = 113, [1] = 17 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 106, [1] = 10 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 104, [1] = 6 }, [3] = { [0] = 121, [1] = 23 }, [4] = { [0] = 117, [1] = 19 }, [5] = { [0] = 110, [1] = 12 }, [6] = { [0] = 121, [1] = 23 }, [7] = { [0] = 124, [1] = 26 } })[R[11]][R[1]], ({ [0] = { [0] = 116, [1] = 20 }, [1] = { [0] = 107, [1] = 11 }, [2] = { [0] = 115, [1] = 19 }, [3] = { [0] = 106, [1] = 10 }, [4] = { [0] = 121, [1] = 25 }, [5] = { [0] = 113, [1] = 17 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 106, [1] = 10 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 104, [1] = 6 }, [3] = { [0] = 109, [1] = 11 }, [4] = { [0] = 117, [1] = 19 }, [5] = { [0] = 110, [1] = 12 }, [6] = { [0] = 121, [1] = 23 }, [7] = { [0] = 124, [1] = 26 } })[R[11]][R[1]], ({ [0] = { [0] = 116, [1] = 20 }, [1] = { [0] = 107, [1] = 11 }, [2] = { [0] = 115, [1] = 19 }, [3] = { [0] = 121, [1] = 25 }, [4] = { [0] = 121, [1] = 25 }, [5] = { [0] = 113, [1] = 17 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 106, [1] = 10 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 122, [1] = 24 }, [3] = { [0] = 109, [1] = 11 }, [4] = { [0] = 118, [1] = 20 }, [5] = { [0] = 109, [1] = 11 }, [6] = { [0] = 113, [1] = 15 }, [7] = { [0] = 109, [1] = 11 } })[R[11]][R[1]], ({ [0] = { [0] = 110, [1] = 14 }, [1] = { [0] = 101, [1] = 5 }, [2] = { [0] = 118, [1] = 22 }, [3] = { [0] = 121, [1] = 25 }, [4] = { [0] = 117, [1] = 21 }, [5] = { [0] = 102, [1] = 6 }, [6] = { [0] = 118, [1] = 22 }, [7] = { [0] = 112, [1] = 16 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 110, [1] = 12 }, [2] = { [0] = 118, [1] = 20 }, [3] = { [0] = 109, [1] = 11 }, [4] = { [0] = 120, [1] = 22 }, [5] = { [0] = 118, [1] = 20 }, [6] = { [0] = 122, [1] = 24 }, [7] = { [0] = 104, [1] = 6 } })[R[11]][R[1]], ({ [0] = { [0] = 107, [1] = 11 }, [1] = { [0] = 98, [1] = 2 }, [2] = { [0] = 119, [1] = 23 }, [3] = { [0] = 121, [1] = 25 }, [4] = { [0] = 108, [1] = 12 }, [5] = { [0] = 110, [1] = 14 }, [6] = { [0] = 115, [1] = 19 }, [7] = { [0] = 109, [1] = 13 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[2].difficulty] == 2 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 104, [1] = 6 }, [3] = { [0] = 123, [1] = 25 }, [4] = { [0] = 117, [1] = 19 }, [5] = { [0] = 110, [1] = 12 }, [6] = { [0] = 121, [1] = 23 }, [7] = { [0] = 124, [1] = 26 } })[R[11]][R[1]], ({ [0] = { [0] = 116, [1] = 20 }, [1] = { [0] = 107, [1] = 11 }, [2] = { [0] = 115, [1] = 19 }, [3] = { [0] = 110, [1] = 14 }, [4] = { [0] = 121, [1] = 25 }, [5] = { [0] = 113, [1] = 17 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 106, [1] = 10 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 122, [1] = 24 }, [3] = { [0] = 121, [1] = 23 }, [4] = { [0] = 118, [1] = 20 }, [5] = { [0] = 109, [1] = 11 }, [6] = { [0] = 113, [1] = 15 }, [7] = { [0] = 109, [1] = 11 } })[R[11]][R[1]], ({ [0] = { [0] = 110, [1] = 14 }, [1] = { [0] = 101, [1] = 5 }, [2] = { [0] = 118, [1] = 22 }, [3] = { [0] = 106, [1] = 10 }, [4] = { [0] = 117, [1] = 21 }, [5] = { [0] = 102, [1] = 6 }, [6] = { [0] = 118, [1] = 22 }, [7] = { [0] = 112, [1] = 16 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 110, [1] = 12 }, [2] = { [0] = 118, [1] = 20 }, [3] = { [0] = 109, [1] = 11 }, [4] = { [0] = 120, [1] = 22 }, [5] = { [0] = 118, [1] = 20 }, [6] = { [0] = 122, [1] = 24 }, [7] = { [0] = 104, [1] = 6 } })[R[11]][R[1]], ({ [0] = { [0] = 107, [1] = 11 }, [1] = { [0] = 98, [1] = 2 }, [2] = { [0] = 119, [1] = 23 }, [3] = { [0] = 121, [1] = 25 }, [4] = { [0] = 108, [1] = 12 }, [5] = { [0] = 110, [1] = 14 }, [6] = { [0] = 115, [1] = 19 }, [7] = { [0] = 109, [1] = 13 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[2].difficulty] == 1 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 104, [1] = 6 }, [3] = { [0] = 123, [1] = 25 }, [4] = { [0] = 117, [1] = 19 }, [5] = { [0] = 110, [1] = 12 }, [6] = { [0] = 121, [1] = 23 }, [7] = { [0] = 124, [1] = 26 } })[R[11]][R[1]], ({ [0] = { [0] = 116, [1] = 20 }, [1] = { [0] = 107, [1] = 11 }, [2] = { [0] = 115, [1] = 19 }, [3] = { [0] = 110, [1] = 14 }, [4] = { [0] = 121, [1] = 25 }, [5] = { [0] = 113, [1] = 17 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 106, [1] = 10 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 104, [1] = 6 }, [3] = { [0] = 121, [1] = 23 }, [4] = { [0] = 117, [1] = 19 }, [5] = { [0] = 110, [1] = 12 }, [6] = { [0] = 121, [1] = 23 }, [7] = { [0] = 124, [1] = 26 } })[R[11]][R[1]], ({ [0] = { [0] = 116, [1] = 20 }, [1] = { [0] = 107, [1] = 11 }, [2] = { [0] = 115, [1] = 19 }, [3] = { [0] = 106, [1] = 10 }, [4] = { [0] = 121, [1] = 25 }, [5] = { [0] = 113, [1] = 17 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 106, [1] = 10 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 122, [1] = 24 }, [3] = { [0] = 109, [1] = 11 }, [4] = { [0] = 118, [1] = 20 }, [5] = { [0] = 109, [1] = 11 }, [6] = { [0] = 113, [1] = 15 }, [7] = { [0] = 109, [1] = 11 } })[R[11]][R[1]], ({ [0] = { [0] = 110, [1] = 14 }, [1] = { [0] = 101, [1] = 5 }, [2] = { [0] = 118, [1] = 22 }, [3] = { [0] = 121, [1] = 25 }, [4] = { [0] = 117, [1] = 21 }, [5] = { [0] = 102, [1] = 6 }, [6] = { [0] = 118, [1] = 22 }, [7] = { [0] = 112, [1] = 16 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 110, [1] = 12 }, [2] = { [0] = 118, [1] = 20 }, [3] = { [0] = 109, [1] = 11 }, [4] = { [0] = 120, [1] = 22 }, [5] = { [0] = 118, [1] = 20 }, [6] = { [0] = 122, [1] = 24 }, [7] = { [0] = 104, [1] = 6 } })[R[11]][R[1]], ({ [0] = { [0] = 107, [1] = 11 }, [1] = { [0] = 98, [1] = 2 }, [2] = { [0] = 119, [1] = 23 }, [3] = { [0] = 121, [1] = 25 }, [4] = { [0] = 108, [1] = 12 }, [5] = { [0] = 110, [1] = 14 }, [6] = { [0] = 115, [1] = 19 }, [7] = { [0] = 109, [1] = 13 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 28 }, [1] = { [0] = 113, [1] = 15 }, [2] = { [0] = 114, [1] = 16 }, [3] = { [0] = 113, [1] = 15 }, [4] = { [0] = 126, [1] = 28 }, [5] = { [0] = 110, [1] = 12 }, [6] = { [0] = 122, [1] = 24 }, [7] = { [0] = 118, [1] = 20 } })[R[11]][R[1]], ({ [0] = { [0] = 118, [1] = 22 }, [1] = { [0] = 111, [1] = 15 }, [2] = { [0] = 112, [1] = 16 }, [3] = { [0] = 107, [1] = 11 }, [4] = { [0] = 104, [1] = 8 }, [5] = { [0] = 119, [1] = 23 }, [6] = { [0] = 118, [1] = 22 }, [7] = { [0] = 111, [1] = 15 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  game.create_tube({ ({ [0] = { [0] = 106, [1] = 8 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 109, [1] = 11 }, [3] = { [0] = 105, [1] = 7 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 114, [1] = 16 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 107, [1] = 9 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 110, [1] = 14 }, [3] = { [0] = 116, [1] = 20 }, [4] = { [0] = 107, [1] = 11 }, [5] = { [0] = 108, [1] = 12 }, [6] = { [0] = 110, [1] = 14 }, [7] = { [0] = 108, [1] = 12 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 107, [1] = 9 }, [1] = { [0] = 108, [1] = 10 }, [2] = { [0] = 110, [1] = 12 }, [3] = { [0] = 105, [1] = 7 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 114, [1] = 16 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 107, [1] = 9 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 110, [1] = 14 }, [3] = { [0] = 117, [1] = 21 }, [4] = { [0] = 108, [1] = 12 }, [5] = { [0] = 109, [1] = 13 }, [6] = { [0] = 111, [1] = 15 }, [7] = { [0] = 109, [1] = 13 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 108, [1] = 10 }, [1] = { [0] = 109, [1] = 11 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 105, [1] = 7 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 114, [1] = 16 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 107, [1] = 9 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 110, [1] = 14 }, [3] = { [0] = 118, [1] = 22 }, [4] = { [0] = 109, [1] = 13 }, [5] = { [0] = 110, [1] = 14 }, [6] = { [0] = 112, [1] = 16 }, [7] = { [0] = 110, [1] = 14 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 109, [1] = 11 }, [1] = { [0] = 110, [1] = 12 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 106, [1] = 8 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 114, [1] = 16 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 107, [1] = 9 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 107, [1] = 11 }, [3] = { [0] = 116, [1] = 20 }, [4] = { [0] = 110, [1] = 14 }, [5] = { [0] = 114, [1] = 18 }, [6] = { [0] = 113, [1] = 17 }, [7] = { [0] = 111, [1] = 15 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 110, [1] = 12 }, [1] = { [0] = 111, [1] = 13 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 107, [1] = 9 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 114, [1] = 16 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 107, [1] = 9 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 108, [1] = 12 }, [3] = { [0] = 112, [1] = 16 }, [4] = { [0] = 111, [1] = 15 }, [5] = { [0] = 115, [1] = 19 }, [6] = { [0] = 114, [1] = 18 }, [7] = { [0] = 112, [1] = 16 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 111, [1] = 13 }, [1] = { [0] = 112, [1] = 14 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 107, [1] = 9 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 114, [1] = 16 }, [6] = { [0] = 111, [1] = 13 }, [7] = { [0] = 107, [1] = 9 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 109, [1] = 13 }, [3] = { [0] = 113, [1] = 17 }, [4] = { [0] = 115, [1] = 19 }, [5] = { [0] = 116, [1] = 20 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 113, [1] = 17 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 112, [1] = 14 }, [1] = { [0] = 113, [1] = 15 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 107, [1] = 9 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 117, [1] = 19 }, [6] = { [0] = 112, [1] = 14 }, [7] = { [0] = 107, [1] = 9 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 110, [1] = 14 }, [3] = { [0] = 114, [1] = 18 }, [4] = { [0] = 116, [1] = 20 }, [5] = { [0] = 112, [1] = 16 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 114, [1] = 18 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 107, [1] = 9 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 117, [1] = 19 }, [6] = { [0] = 112, [1] = 14 }, [7] = { [0] = 107, [1] = 9 } })[R[11]][R[1]], ({ [0] = { [0] = 109, [1] = 13 }, [1] = { [0] = 101, [1] = 5 }, [2] = { [0] = 111, [1] = 15 }, [3] = { [0] = 115, [1] = 19 }, [4] = { [0] = 117, [1] = 21 }, [5] = { [0] = 118, [1] = 22 }, [6] = { [0] = 116, [1] = 20 }, [7] = { [0] = 115, [1] = 19 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 107, [1] = 9 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 118, [1] = 20 }, [6] = { [0] = 113, [1] = 15 }, [7] = { [0] = 107, [1] = 9 } })[R[11]][R[1]], ({ [0] = { [0] = 110, [1] = 14 }, [1] = { [0] = 102, [1] = 6 }, [2] = { [0] = 112, [1] = 16 }, [3] = { [0] = 116, [1] = 20 }, [4] = { [0] = 118, [1] = 22 }, [5] = { [0] = 112, [1] = 16 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 116, [1] = 20 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 108, [1] = 10 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 118, [1] = 20 }, [6] = { [0] = 113, [1] = 15 }, [7] = { [0] = 110, [1] = 12 } })[R[11]][R[1]], ({ [0] = { [0] = 111, [1] = 15 }, [1] = { [0] = 103, [1] = 7 }, [2] = { [0] = 113, [1] = 17 }, [3] = { [0] = 112, [1] = 16 }, [4] = { [0] = 119, [1] = 23 }, [5] = { [0] = 118, [1] = 22 }, [6] = { [0] = 116, [1] = 20 }, [7] = { [0] = 105, [1] = 9 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 108, [1] = 10 }, [4] = { [0] = 116, [1] = 18 }, [5] = { [0] = 119, [1] = 21 }, [6] = { [0] = 114, [1] = 16 }, [7] = { [0] = 110, [1] = 12 } })[R[11]][R[1]], ({ [0] = { [0] = 112, [1] = 16 }, [1] = { [0] = 104, [1] = 8 }, [2] = { [0] = 114, [1] = 18 }, [3] = { [0] = 116, [1] = 20 }, [4] = { [0] = 105, [1] = 9 }, [5] = { [0] = 112, [1] = 16 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 118, [1] = 22 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 109, [1] = 11 }, [4] = { [0] = 116, [1] = 18 }, [5] = { [0] = 119, [1] = 21 }, [6] = { [0] = 114, [1] = 16 }, [7] = { [0] = 111, [1] = 13 } })[R[11]][R[1]], ({ [0] = { [0] = 116, [1] = 20 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 115, [1] = 19 }, [3] = { [0] = 116, [1] = 20 }, [4] = { [0] = 113, [1] = 17 }, [5] = { [0] = 118, [1] = 22 }, [6] = { [0] = 116, [1] = 20 }, [7] = { [0] = 105, [1] = 9 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 110, [1] = 12 }, [4] = { [0] = 116, [1] = 18 }, [5] = { [0] = 120, [1] = 22 }, [6] = { [0] = 115, [1] = 17 }, [7] = { [0] = 111, [1] = 13 } })[R[11]][R[1]], ({ [0] = { [0] = 117, [1] = 21 }, [1] = { [0] = 109, [1] = 13 }, [2] = { [0] = 116, [1] = 20 }, [3] = { [0] = 116, [1] = 20 }, [4] = { [0] = 121, [1] = 25 }, [5] = { [0] = 112, [1] = 16 }, [6] = { [0] = 108, [1] = 12 }, [7] = { [0] = 118, [1] = 22 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 113, [1] = 15 }, [3] = { [0] = 111, [1] = 13 }, [4] = { [0] = 117, [1] = 19 }, [5] = { [0] = 120, [1] = 22 }, [6] = { [0] = 115, [1] = 17 }, [7] = { [0] = 112, [1] = 14 } })[R[11]][R[1]], ({ [0] = { [0] = 118, [1] = 22 }, [1] = { [0] = 110, [1] = 14 }, [2] = { [0] = 110, [1] = 14 }, [3] = { [0] = 109, [1] = 13 }, [4] = { [0] = 105, [1] = 9 }, [5] = { [0] = 118, [1] = 22 }, [6] = { [0] = 116, [1] = 20 }, [7] = { [0] = 105, [1] = 9 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 113, [1] = 15 }, [3] = { [0] = 111, [1] = 13 }, [4] = { [0] = 117, [1] = 19 }, [5] = { [0] = 121, [1] = 23 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 112, [1] = 14 } })[R[11]][R[1]], ({ [0] = { [0] = 119, [1] = 23 }, [1] = { [0] = 111, [1] = 15 }, [2] = { [0] = 116, [1] = 20 }, [3] = { [0] = 116, [1] = 20 }, [4] = { [0] = 113, [1] = 17 }, [5] = { [0] = 112, [1] = 16 }, [6] = { [0] = 110, [1] = 14 }, [7] = { [0] = 118, [1] = 22 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 117, [1] = 19 }, [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 114, [1] = 16 }, [3] = { [0] = 112, [1] = 14 }, [4] = { [0] = 117, [1] = 19 }, [5] = { [0] = 121, [1] = 23 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 113, [1] = 15 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 110, [1] = 14 }, [3] = { [0] = 109, [1] = 13 }, [4] = { [0] = 121, [1] = 25 }, [5] = { [0] = 118, [1] = 22 }, [6] = { [0] = 111, [1] = 15 }, [7] = { [0] = 105, [1] = 9 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 118, [1] = 20 }, [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 114, [1] = 16 }, [3] = { [0] = 113, [1] = 15 }, [4] = { [0] = 118, [1] = 20 }, [5] = { [0] = 122, [1] = 24 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 113, [1] = 15 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 113, [1] = 17 }, [2] = { [0] = 116, [1] = 20 }, [3] = { [0] = 109, [1] = 13 }, [4] = { [0] = 105, [1] = 9 }, [5] = { [0] = 112, [1] = 16 }, [6] = { [0] = 112, [1] = 16 }, [7] = { [0] = 118, [1] = 22 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 115, [1] = 17 }, [3] = { [0] = 114, [1] = 16 }, [4] = { [0] = 118, [1] = 20 }, [5] = { [0] = 123, [1] = 25 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 114, [1] = 16 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 114, [1] = 18 }, [2] = { [0] = 110, [1] = 14 }, [3] = { [0] = 109, [1] = 13 }, [4] = { [0] = 106, [1] = 10 }, [5] = { [0] = 112, [1] = 16 }, [6] = { [0] = 113, [1] = 17 }, [7] = { [0] = 105, [1] = 9 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 120, [1] = 22 }, [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 115, [1] = 17 }, [3] = { [0] = 115, [1] = 17 }, [4] = { [0] = 118, [1] = 20 }, [5] = { [0] = 124, [1] = 26 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 114, [1] = 16 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 119, [1] = 23 }, [2] = { [0] = 116, [1] = 20 }, [3] = { [0] = 109, [1] = 13 }, [4] = { [0] = 113, [1] = 17 }, [5] = { [0] = 112, [1] = 16 }, [6] = { [0] = 114, [1] = 18 }, [7] = { [0] = 106, [1] = 10 } })[R[11]][R[1]] })
  game.create_tube({ ({ [0] = { [0] = 121, [1] = 23 }, [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 116, [1] = 18 }, [3] = { [0] = 116, [1] = 18 }, [4] = { [0] = 118, [1] = 20 }, [5] = { [0] = 124, [1] = 26 }, [6] = { [0] = 121, [1] = 23 }, [7] = { [0] = 114, [1] = 16 } })[R[11]][R[1]], ({ [0] = { [0] = 114, [1] = 18 }, [1] = { [0] = 120, [1] = 24 }, [2] = { [0] = 110, [1] = 14 }, [3] = { [0] = 109, [1] = 13 }, [4] = { [0] = 121, [1] = 25 }, [5] = { [0] = 113, [1] = 17 }, [6] = { [0] = 116, [1] = 20 }, [7] = { [0] = 107, [1] = 11 } })[R[11]][R[1]] })
  if R[11] == 0 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      for i = 1, game.initial_units() do
        R[12] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 22 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 119, [1] = 21 } })[R[12]][R[1]], ({ [0] = { [0] = 108, [1] = 12 }, [1] = { [0] = 117, [1] = 21 }, [2] = { [0] = 120, [1] = 24 } })[R[12]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 122, [1] = 26 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 122, [1] = 26 })[R[1]] })
      for i = 1, game.initial_units() do
        R[13] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 106, [1] = 8 }, [1] = { [0] = 108, [1] = 10 }, [2] = { [0] = 110, [1] = 12 } })[R[13]][R[1]], ({ [0] = { [0] = 116, [1] = 20 }, [1] = { [0] = 125, [1] = 29 }, [2] = { [0] = 110, [1] = 14 } })[R[13]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 2 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[14] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 107, [1] = 9 }, [1] = { [0] = 117, [1] = 19 }, [2] = { [0] = 125, [1] = 27 } })[R[14]][R[1]], ({ [0] = { [0] = 104, [1] = 8 }, [1] = { [0] = 104, [1] = 8 }, [2] = { [0] = 113, [1] = 17 } })[R[14]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 3 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 115, [1] = 19 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 117, [1] = 21 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      for i = 1, game.initial_units() do
        R[15] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 102, [1] = 4 } })[R[15]][R[1]], ({ [0] = { [0] = 112, [1] = 16 }, [1] = { [0] = 119, [1] = 23 }, [2] = { [0] = 118, [1] = 22 } })[R[15]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 115, [1] = 19 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 117, [1] = 21 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 106, [1] = 10 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 107, [1] = 11 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 107, [1] = 11 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 107, [1] = 11 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 115, [1] = 19 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 120, [1] = 24 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], ({ [0] = 120, [1] = 24 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 110, [1] = 14 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 111, [1] = 15 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 120, [1] = 24 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 106, [1] = 10 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 107, [1] = 11 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 107, [1] = 11 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 107, [1] = 11 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 115, [1] = 19 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 120, [1] = 24 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 121, [1] = 25 })[R[1]] })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], ({ [0] = 120, [1] = 24 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 110, [1] = 14 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 111, [1] = 15 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 120, [1] = 24 })[R[1]] })
      for i = 1, game.initial_units() do
        R[16] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 19 }, [1] = { [0] = 108, [1] = 10 }, [2] = { [0] = 110, [1] = 12 } })[R[16]][R[1]], ({ [0] = { [0] = 104, [1] = 8 }, [1] = { [0] = 112, [1] = 16 }, [2] = { [0] = 104, [1] = 8 } })[R[16]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 5 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 115, [1] = 19 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 115, [1] = 19 })[R[1]] })
      for i = 1, game.initial_units() do
        R[17] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 22 }, [1] = { [0] = 103, [1] = 5 }, [2] = { [0] = 125, [1] = 27 } })[R[17]][R[1]], ({ [0] = { [0] = 121, [1] = 25 }, [1] = { [0] = 108, [1] = 12 }, [2] = { [0] = 121, [1] = 25 } })[R[17]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 6 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      for i = 1, game.initial_units() do
        R[18] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 103, [1] = 5 }, [1] = { [0] = 127, [1] = 29 }, [2] = { [0] = 131, [1] = 33 } })[R[18]][R[1]], ({ [0] = { [0] = 106, [1] = 10 }, [1] = { [0] = 119, [1] = 23 }, [2] = { [0] = 117, [1] = 21 } })[R[18]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 7 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 108, [1] = 12 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 109, [1] = 13 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 110, [1] = 14 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 115, [1] = 19 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 117, [1] = 21 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 107, [1] = 11 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 108, [1] = 12 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 109, [1] = 13 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 110, [1] = 14 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 111, [1] = 15 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 115, [1] = 19 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 108, [1] = 12 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 109, [1] = 13 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 110, [1] = 14 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 115, [1] = 19 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 116, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 117, [1] = 21 })[R[1]] })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 105, [1] = 9 })[R[1]] })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], ({ [0] = 118, [1] = 22 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 107, [1] = 11 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 108, [1] = 12 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 109, [1] = 13 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 110, [1] = 14 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 111, [1] = 15 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 112, [1] = 16 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 113, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 114, [1] = 18 })[R[1]] })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], ({ [0] = 115, [1] = 19 })[R[1]] })
      for i = 1, game.initial_units() do
        R[19] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 112, [1] = 14 }, [1] = { [0] = 118, [1] = 20 }, [2] = { [0] = 108, [1] = 10 } })[R[19]][R[1]], ({ [0] = { [0] = 101, [1] = 5 }, [1] = { [0] = 101, [1] = 5 }, [2] = { [0] = 122, [1] = 26 } })[R[19]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    trigger.time{min = 18000, max = 36000, one_shot = false, on = Meteor}  -- after 180 to 360 marks
    trigger.resource{resource = "Ore", compare = ">=", amount = 10000, one_shot = true, on = Tornado}
    trigger.resource{resource = "Ore", compare = ">=", amount = 15000, one_shot = true, on = Tornado}
    trigger.resource{resource = "Ore", compare = ">=", amount = 20000, one_shot = true, on = Tornado}
    trigger.resource{resource = "Ore", compare = ">=", amount = 40000, one_shot = true, on = Tornado}
  end
  return true
end
