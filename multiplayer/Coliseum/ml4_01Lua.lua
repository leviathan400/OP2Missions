-- ml4_01Lua.lua  -  4 Player, LastOne, 'Coliseum' map. (Lua)
--
-- Converted by op2dll from ml4_01.dll ("4 Player, LastOne, 'Coliseum' map."): its setup replayed. `on_init` makes the original's
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
  local r1 = game.rand(120)
  local r2 = game.rand(120)
  game.create_meteor({ r2 + 4, r1 + 4 }, -1)
end

function Storm(t)
  local r1 = game.rand(4)
  local r2 = game.rand(7)
  local r3 = game.rand(120)
  if r1 == 0 then
    game.create_lightning({ 4, r3 + 1 }, nil, r2 + 10)
  elseif r1 == 1 then
    game.create_lightning({ 127, r3 + 1 }, nil, r2 + 10)
  elseif r1 == 2 then
    game.create_lightning({ r3 + 4, 4 }, nil, r2 + 10)
  else
    game.create_lightning({ r3 + 4, 121 }, nil, r2 + 10)
  end
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 64, 16 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 38, 102 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 23, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 91, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 118, 59 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 40, 32 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 126 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 126 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 111, 33 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 36, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 71, 32 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 79, 37 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 94, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 99, 66 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 92, 75 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 91, 90 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 87, 111 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 74, 112 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 46, 95 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 46, 83 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 39, 73 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 50, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 48, 49 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 60, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 68, 47 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 63, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 70, 94 } }
    R[0] = game.rand(4)
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 19, [1] = 25, [2] = 93, [3] = 125 })[R[0]], ({ [0] = 26, [1] = 88, [2] = 118, [3] = 34 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[0] == 3 then
    elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 48, [1] = 46, [2] = 90 })[R[0]], ({ [0] = 7, [1] = 118, [2] = 105 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      if R[0] == 0 then
      elseif R[0] == 1 or R[0] == 2 then
        U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [1] = 7, [2] = 116 })[R[0]], ({ [1] = 71, [2] = 85 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        if R[0] == 1 then
        elseif R[0] == 2 then
          U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { 99, 93 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[0]", R[0])
        end
      else
        unseen("R[0]", R[0])
      end
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 9, [1] = 20, [2] = 126, [3] = 95 })[R[0]], ({ [0] = 42, [1] = 80, [2] = 83, [3] = 13 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] })
    if R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [6] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [7] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[1]][R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[1]][R[0]], ({ [5] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [6] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [7] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[1] == 5 or R[1] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [7] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[1]][R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[1] == 7 then
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
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [7] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[1]][R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[1] == 5 then
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[1]][R[0]], ({ [5] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [7] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 } })[R[1]][R[0]], ({ [5] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [6] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [7] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 1 or R[1] == 2 or R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [3] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [4] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[1]][R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 6, [1] = 112, [2] = 110, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 1 or R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[1]][R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[0]], ({ [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[1]][R[0]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[1]][R[0]], ({ [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 } })[R[1]][R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[1]][R[0]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [3] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 } })[R[1]][R[0]], ({ [1] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [3] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [4] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [3] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [5] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [6] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[1]][R[0]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [6] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [1] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [3] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [4] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [7] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 } })[R[1]][R[0]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [3] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [4] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [6] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[2] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[2]][R[0]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 15, [1] = 121, [2] = 119, [3] = 18 } })[R[2]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        for i = 1, game.initial_units() do
          R[3] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[3]][R[0]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[3]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        for i = 1, game.initial_units() do
          R[4] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[4]][R[0]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[4]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        for i = 1, game.initial_units() do
          R[5] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[5]][R[0]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[5]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] })
        for i = 1, game.initial_units() do
          R[6] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[6]][R[0]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[6]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[7] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 } })[R[7]][R[0]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[7]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[8] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[8]][R[0]], ({ [0] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 } })[R[8]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[9] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[9]][R[0]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[9]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 93, [1] = 125, [2] = 19, [3] = 25 })[R[0]], ({ [0] = 118, [1] = 34, [2] = 26, [3] = 88 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 2 or R[0] == 3 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 90, [2] = 48, [3] = 46 })[R[0]], ({ [0] = 105, [2] = 7, [3] = 118 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      if R[0] == 0 or R[0] == 3 then
        U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 116, [3] = 7 })[R[0]], ({ [0] = 85, [3] = 71 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        if R[0] == 3 then
        elseif R[0] == 0 then
          U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { 99, 93 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[0]", R[0])
        end
      elseif R[0] == 2 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 1 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 126, [1] = 95, [2] = 9, [3] = 20 })[R[0]], ({ [0] = 83, [1] = 13, [2] = 42, [3] = 80 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 }, [1] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 }, [2] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 }, [3] = { [0] = 115, [1] = 112, [2] = 15, [3] = 18 }, [4] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 }, [5] = { [0] = 118, [1] = 115, [2] = 18, [3] = 21 }, [6] = { [0] = 115, [1] = 112, [2] = 15, [3] = 18 }, [7] = { [0] = 121, [1] = 118, [2] = 21, [3] = 24 } })[R[10]][R[0]], ({ [0] = { [0] = 117, [1] = 16, [2] = 13, [3] = 119 }, [1] = { [0] = 113, [1] = 12, [2] = 9, [3] = 115 }, [2] = { [0] = 117, [1] = 16, [2] = 13, [3] = 119 }, [3] = { [0] = 113, [1] = 12, [2] = 9, [3] = 115 }, [4] = { [0] = 116, [1] = 15, [2] = 12, [3] = 118 }, [5] = { [0] = 114, [1] = 13, [2] = 10, [3] = 116 }, [6] = { [0] = 111, [1] = 10, [2] = 7, [3] = 113 }, [7] = { [0] = 114, [1] = 13, [2] = 10, [3] = 116 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 }, [1] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 }, [2] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 }, [3] = { [0] = 115, [1] = 112, [2] = 15, [3] = 18 }, [4] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 }, [5] = { [0] = 118, [1] = 115, [2] = 18, [3] = 21 }, [6] = { [0] = 115, [1] = 112, [2] = 15, [3] = 18 }, [7] = { [0] = 121, [1] = 118, [2] = 21, [3] = 24 } })[R[10]][R[0]], ({ [0] = { [0] = 117, [1] = 16, [2] = 13, [3] = 119 }, [1] = { [0] = 113, [1] = 12, [2] = 9, [3] = 115 }, [2] = { [0] = 117, [1] = 16, [2] = 13, [3] = 119 }, [3] = { [0] = 113, [1] = 12, [2] = 9, [3] = 115 }, [4] = { [0] = 116, [1] = 15, [2] = 12, [3] = 118 }, [5] = { [0] = 114, [1] = 13, [2] = 10, [3] = 116 }, [6] = { [0] = 111, [1] = 10, [2] = 7, [3] = 113 }, [7] = { [0] = 114, [1] = 13, [2] = 10, [3] = 116 } })[R[10]][R[0]] })
    if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 }, [2] = { [0] = 116, [1] = 113, [2] = 16, [3] = 19 }, [3] = { [0] = 120, [1] = 117, [2] = 20, [3] = 23 }, [4] = { [0] = 116, [1] = 113, [2] = 16, [3] = 19 } })[R[10]][R[0]], ({ [0] = 120, [1] = 19, [2] = 16, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 116, [1] = 113, [2] = 16, [3] = 19 })[R[0]], ({ [0] = 112, [1] = 11, [2] = 8, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 120, [1] = 117, [2] = 20, [3] = 23 })[R[0]], ({ [0] = 113, [1] = 12, [2] = 9, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 115, [1] = 112, [2] = 15, [3] = 18 })[R[0]], ({ [0] = 116, [1] = 15, [2] = 12, [3] = 118 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 124, [1] = 121, [2] = 24, [3] = 27 })[R[0]], ({ [0] = 121, [1] = 20, [2] = 17, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 110, [1] = 9, [2] = 6, [3] = 112 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 1 or R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 114, [1] = 111, [2] = 14, [3] = 17 }, [2] = { [0] = 115, [1] = 112, [2] = 15, [3] = 18 } })[R[10]][R[0]], ({ [0] = 111, [1] = 10, [2] = 7, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 123, [1] = 120, [2] = 23, [3] = 26 })[R[0]], ({ [1] = { [0] = 116, [1] = 15, [2] = 12, [3] = 118 }, [2] = { [0] = 120, [1] = 19, [2] = 16, [3] = 122 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 118, [1] = 115, [2] = 18, [3] = 21 }, [2] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 } })[R[10]][R[0]], ({ [1] = { [0] = 121, [1] = 20, [2] = 17, [3] = 123 }, [2] = { [0] = 117, [1] = 16, [2] = 13, [3] = 119 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 118, [1] = 115, [2] = 18, [3] = 21 }, [2] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 } })[R[10]][R[0]], ({ [1] = { [0] = 117, [1] = 16, [2] = 13, [3] = 119 }, [2] = { [0] = 114, [1] = 13, [2] = 10, [3] = 116 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 124, [1] = 121, [2] = 24, [3] = 27 }, [2] = { [0] = 122, [1] = 119, [2] = 22, [3] = 25 } })[R[10]][R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 115, [1] = 112, [2] = 15, [3] = 18 })[R[0]], ({ [0] = 121, [1] = 20, [2] = 17, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 117, [1] = 16, [2] = 13, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 116, [1] = 113, [2] = 16, [3] = 19 })[R[0]], ({ [0] = 116, [1] = 15, [2] = 12, [3] = 118 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 124, [1] = 121, [2] = 24, [3] = 27 })[R[0]], ({ [0] = 111, [1] = 10, [2] = 7, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 121, [1] = 118, [2] = 21, [3] = 24 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [1] = { [0] = 125, [1] = 122, [2] = 25, [3] = 28 }, [2] = { [0] = 124, [1] = 121, [2] = 24, [3] = 27 }, [3] = { [0] = 122, [1] = 119, [2] = 22, [3] = 25 }, [4] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 } })[R[10]][R[0]], ({ [1] = { [0] = 121, [1] = 20, [2] = 17, [3] = 123 }, [2] = { [0] = 122, [1] = 21, [2] = 18, [3] = 124 }, [3] = { [0] = 121, [1] = 20, [2] = 17, [3] = 123 }, [4] = { [0] = 111, [1] = 10, [2] = 7, [3] = 113 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[10]], player = players[2], at = { ({ [1] = { [0] = 122, [1] = 119, [2] = 22, [3] = 25 }, [2] = { [0] = 120, [1] = 117, [2] = 20, [3] = 23 }, [3] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 }, [4] = { [0] = 113, [1] = 110, [2] = 13, [3] = 16 } })[R[10]][R[0]], ({ [1] = { [0] = 122, [1] = 21, [2] = 18, [3] = 124 }, [2] = { [0] = 121, [1] = 20, [2] = 17, [3] = 123 }, [3] = { [0] = 122, [1] = 21, [2] = 18, [3] = 124 }, [4] = { [0] = 118, [1] = 17, [2] = 14, [3] = 120 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 125, [1] = 122, [2] = 25, [3] = 28 }, [2] = { [0] = 117, [1] = 114, [2] = 17, [3] = 20 }, [3] = { [0] = 117, [1] = 114, [2] = 17, [3] = 20 }, [4] = { [0] = 117, [1] = 114, [2] = 17, [3] = 20 } })[R[10]][R[0]], ({ [1] = { [0] = 118, [1] = 17, [2] = 14, [3] = 120 }, [2] = { [0] = 122, [1] = 21, [2] = 18, [3] = 124 }, [3] = { [0] = 118, [1] = 17, [2] = 14, [3] = 120 }, [4] = { [0] = 114, [1] = 13, [2] = 10, [3] = 116 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 125, [1] = 122, [2] = 25, [3] = 28 })[R[0]], ({ [0] = 118, [1] = 17, [2] = 14, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 117, [1] = 114, [2] = 17, [3] = 20 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 117, [1] = 114, [2] = 17, [3] = 20 })[R[0]], ({ [0] = 118, [1] = 17, [2] = 14, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 117, [1] = 114, [2] = 17, [3] = 20 })[R[0]], ({ [0] = 114, [1] = 13, [2] = 10, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 116, [1] = 113, [2] = 16, [3] = 19 })[R[0]], ({ [0] = 120, [1] = 19, [2] = 16, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 121, [1] = 118, [2] = 21, [3] = 24 })[R[0]], ({ [0] = 120, [1] = 19, [2] = 16, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 115, [1] = 112, [2] = 15, [3] = 18 })[R[0]], ({ [0] = 117, [1] = 16, [2] = 13, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 123, [1] = 120, [2] = 23, [3] = 26 })[R[0]], ({ [0] = 117, [1] = 16, [2] = 13, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 124, [1] = 121, [2] = 24, [3] = 27 })[R[0]], ({ [0] = 111, [1] = 10, [2] = 7, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 123, [1] = 120, [2] = 23, [3] = 26 })[R[0]], ({ [0] = 121, [1] = 20, [2] = 17, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 125, [1] = 122, [2] = 25, [3] = 28 })[R[0]], ({ [0] = 120, [1] = 19, [2] = 16, [3] = 122 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 115, [1] = 112, [2] = 15, [3] = 18 }, [6] = { [0] = 124, [1] = 121, [2] = 24, [3] = 27 }, [7] = { [0] = 115, [1] = 112, [2] = 15, [3] = 18 } })[R[10]][R[0]], ({ [0] = 121, [1] = 20, [2] = 17, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 }, [6] = { [0] = 115, [1] = 112, [2] = 15, [3] = 18 }, [7] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 } })[R[10]][R[0]], ({ [5] = { [0] = 115, [1] = 14, [2] = 11, [3] = 117 }, [6] = { [0] = 120, [1] = 19, [2] = 16, [3] = 122 }, [7] = { [0] = 120, [1] = 19, [2] = 16, [3] = 122 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 115, [1] = 112, [2] = 15, [3] = 18 })[R[0]], ({ [0] = 117, [1] = 16, [2] = 13, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 115, [1] = 112, [2] = 15, [3] = 18 })[R[0]], ({ [0] = 114, [1] = 13, [2] = 10, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 120, [1] = 117, [2] = 20, [3] = 23 })[R[0]], ({ [0] = 112, [1] = 11, [2] = 8, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[10] == 5 or R[10] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 }, [7] = { [0] = 116, [1] = 113, [2] = 16, [3] = 19 } })[R[10]][R[0]], ({ [0] = 111, [1] = 10, [2] = 7, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[10] == 7 then
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
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 118, [1] = 115, [2] = 18, [3] = 21 }, [7] = { [0] = 120, [1] = 117, [2] = 20, [3] = 23 } })[R[10]][R[0]], ({ [0] = 111, [1] = 10, [2] = 7, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
        elseif R[10] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 121, [1] = 118, [2] = 21, [3] = 24 })[R[0]], ({ [0] = 117, [1] = 16, [2] = 13, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [5] = { [0] = 117, [1] = 16, [2] = 13, [3] = 119 }, [7] = { [0] = 114, [1] = 13, [2] = 10, [3] = 116 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 119, [1] = 116, [2] = 19, [3] = 22 })[R[0]], ({ [5] = { [0] = 116, [1] = 15, [2] = 12, [3] = 118 }, [7] = { [0] = 115, [1] = 14, [2] = 11, [3] = 117 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 }, [7] = { [0] = 124, [1] = 121, [2] = 24, [3] = 27 } })[R[10]][R[0]], ({ [5] = { [0] = 118, [1] = 17, [2] = 14, [3] = 120 }, [7] = { [0] = 115, [1] = 14, [2] = 11, [3] = 117 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 125, [1] = 122, [2] = 25, [3] = 28 }, [6] = { [0] = 122, [1] = 119, [2] = 22, [3] = 25 }, [7] = { [0] = 118, [1] = 115, [2] = 18, [3] = 21 } })[R[10]][R[0]], ({ [5] = { [0] = 113, [1] = 12, [2] = 9, [3] = 115 }, [6] = { [0] = 114, [1] = 13, [2] = 10, [3] = 116 }, [7] = { [0] = 112, [1] = 11, [2] = 8, [3] = 114 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 125, [1] = 122, [2] = 25, [3] = 28 })[R[0]], ({ [0] = 113, [1] = 12, [2] = 9, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 114, [1] = 13, [2] = 10, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 114, [1] = 13, [2] = 10, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 117, [1] = 114, [2] = 17, [3] = 20 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 121, [1] = 20, [2] = 17, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 112, [1] = 11, [2] = 8, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 114, [1] = 111, [2] = 14, [3] = 17 })[R[0]], ({ [0] = 113, [1] = 12, [2] = 9, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 114, [1] = 111, [2] = 14, [3] = 17 })[R[0]], ({ [0] = 113, [1] = 12, [2] = 9, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 125, [1] = 122, [2] = 25, [3] = 28 })[R[0]], ({ [0] = 118, [1] = 17, [2] = 14, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 115, [1] = 112, [2] = 15, [3] = 18 })[R[0]], ({ [0] = 117, [1] = 16, [2] = 13, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 115, [1] = 112, [2] = 15, [3] = 18 })[R[0]], ({ [0] = 117, [1] = 16, [2] = 13, [3] = 119 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 117, [1] = 114, [2] = 17, [3] = 20 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 119, [1] = 116, [2] = 19, [3] = 22 })[R[0]], ({ [0] = 113, [1] = 12, [2] = 9, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 119, [1] = 116, [2] = 19, [3] = 22 })[R[0]], ({ [0] = 113, [1] = 12, [2] = 9, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 117, [1] = 114, [2] = 17, [3] = 20 })[R[0]], ({ [0] = 118, [1] = 17, [2] = 14, [3] = 120 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 114, [1] = 13, [2] = 10, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 114, [1] = 13, [2] = 10, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 117, [1] = 114, [2] = 17, [3] = 20 })[R[0]], ({ [0] = 114, [1] = 13, [2] = 10, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 114, [1] = 111, [2] = 14, [3] = 17 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 125, [1] = 122, [2] = 25, [3] = 28 })[R[0]], ({ [0] = 113, [1] = 12, [2] = 9, [3] = 115 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 125, [1] = 122, [2] = 25, [3] = 28 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 114, [1] = 13, [2] = 10, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 117, [1] = 114, [2] = 17, [3] = 20 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 121, [1] = 20, [2] = 17, [3] = 123 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 120, [1] = 117, [2] = 20, [3] = 23 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 115, [1] = 14, [2] = 11, [3] = 117 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 120, [1] = 117, [2] = 20, [3] = 23 })[R[0]], ({ [0] = 122, [1] = 21, [2] = 18, [3] = 124 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 115, [1] = 14, [2] = 11, [3] = 117 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 112, [1] = 11, [2] = 8, [3] = 114 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 125, [1] = 122, [2] = 25, [3] = 28 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 115, [1] = 112, [2] = 15, [3] = 18 }, [1] = { [0] = 114, [1] = 111, [2] = 14, [3] = 17 }, [2] = { [0] = 120, [1] = 117, [2] = 20, [3] = 23 }, [3] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 }, [4] = { [0] = 117, [1] = 114, [2] = 17, [3] = 20 }, [5] = { [0] = 124, [1] = 121, [2] = 24, [3] = 27 }, [6] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 }, [7] = { [0] = 124, [1] = 121, [2] = 24, [3] = 27 } })[R[10]][R[0]], ({ [0] = { [0] = 114, [1] = 13, [2] = 10, [3] = 116 }, [1] = { [0] = 116, [1] = 15, [2] = 12, [3] = 118 }, [2] = { [0] = 112, [1] = 11, [2] = 8, [3] = 114 }, [3] = { [0] = 113, [1] = 12, [2] = 9, [3] = 115 }, [4] = { [0] = 122, [1] = 21, [2] = 18, [3] = 124 }, [5] = { [0] = 117, [1] = 16, [2] = 13, [3] = 119 }, [6] = { [0] = 116, [1] = 15, [2] = 12, [3] = 118 }, [7] = { [0] = 122, [1] = 21, [2] = 18, [3] = 124 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 116, [1] = 113, [2] = 16, [3] = 19 }, [1] = { [0] = 116, [1] = 113, [2] = 16, [3] = 19 }, [2] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 }, [3] = { [0] = 118, [1] = 115, [2] = 18, [3] = 21 }, [4] = { [0] = 118, [1] = 115, [2] = 18, [3] = 21 }, [5] = { [0] = 125, [1] = 122, [2] = 25, [3] = 28 }, [6] = { [0] = 120, [1] = 117, [2] = 20, [3] = 23 }, [7] = { [0] = 125, [1] = 122, [2] = 25, [3] = 28 } })[R[10]][R[0]], ({ [0] = { [0] = 114, [1] = 13, [2] = 10, [3] = 116 }, [1] = { [0] = 115, [1] = 14, [2] = 11, [3] = 117 }, [2] = { [0] = 111, [1] = 10, [2] = 7, [3] = 113 }, [3] = { [0] = 112, [1] = 11, [2] = 8, [3] = 114 }, [4] = { [0] = 121, [1] = 20, [2] = 17, [3] = 123 }, [5] = { [0] = 116, [1] = 15, [2] = 12, [3] = 118 }, [6] = { [0] = 115, [1] = 14, [2] = 11, [3] = 117 }, [7] = { [0] = 122, [1] = 21, [2] = 18, [3] = 124 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[11] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 114, [1] = 111, [2] = 14, [3] = 17 }, [1] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 }, [2] = { [0] = 124, [1] = 121, [2] = 24, [3] = 27 } })[R[11]][R[0]], ({ [0] = { [0] = 110, [1] = 9, [2] = 6, [3] = 112 }, [1] = { [0] = 113, [1] = 12, [2] = 9, [3] = 115 }, [2] = { [0] = 119, [1] = 18, [2] = 15, [3] = 121 } })[R[11]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 118, [1] = 115, [2] = 18, [3] = 21 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] })
        for i = 1, game.initial_units() do
          R[12] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 114, [1] = 111, [2] = 14, [3] = 17 }, [1] = { [0] = 118, [1] = 115, [2] = 18, [3] = 21 }, [2] = { [0] = 121, [1] = 118, [2] = 21, [3] = 24 } })[R[12]][R[0]], ({ [0] = { [0] = 120, [1] = 19, [2] = 16, [3] = 122 }, [1] = { [0] = 114, [1] = 13, [2] = 10, [3] = 116 }, [2] = { [0] = 110, [1] = 9, [2] = 6, [3] = 112 } })[R[12]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 119, [1] = 116, [2] = 19, [3] = 22 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 116, [2] = 19, [3] = 22 })[R[0]], ({ [0] = 120, [1] = 19, [2] = 16, [3] = 122 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 117, [2] = 20, [3] = 23 })[R[0]], ({ [0] = 120, [1] = 19, [2] = 16, [3] = 122 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 119, [1] = 116, [2] = 19, [3] = 22 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 116, [2] = 19, [3] = 22 })[R[0]], ({ [0] = 120, [1] = 19, [2] = 16, [3] = 122 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 117, [2] = 20, [3] = 23 })[R[0]], ({ [0] = 120, [1] = 19, [2] = 16, [3] = 122 })[R[0]] })
        for i = 1, game.initial_units() do
          R[13] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 }, [1] = { [0] = 115, [1] = 112, [2] = 15, [3] = 18 }, [2] = { [0] = 119, [1] = 116, [2] = 19, [3] = 22 } })[R[13]][R[0]], ({ [0] = { [0] = 110, [1] = 9, [2] = 6, [3] = 112 }, [1] = { [0] = 115, [1] = 14, [2] = 11, [3] = 117 }, [2] = { [0] = 120, [1] = 19, [2] = 16, [3] = 122 } })[R[13]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 116, [1] = 113, [2] = 16, [3] = 19 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 116, [2] = 19, [3] = 22 })[R[0]], ({ [0] = 116, [1] = 15, [2] = 12, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 117, [2] = 20, [3] = 23 })[R[0]], ({ [0] = 116, [1] = 15, [2] = 12, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 120, [1] = 19, [2] = 16, [3] = 122 })[R[0]] })
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 124, [1] = 121, [2] = 24, [3] = 27 }, [1] = { [0] = 120, [1] = 117, [2] = 20, [3] = 23 }, [2] = { [0] = 116, [1] = 113, [2] = 16, [3] = 19 } })[R[14]][R[0]], ({ [0] = { [0] = 121, [1] = 20, [2] = 17, [3] = 123 }, [1] = { [0] = 115, [1] = 14, [2] = 11, [3] = 117 }, [2] = { [0] = 110, [1] = 9, [2] = 6, [3] = 112 } })[R[14]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 116, [1] = 113, [2] = 16, [3] = 19 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 116, [2] = 19, [3] = 22 })[R[0]], ({ [0] = 116, [1] = 15, [2] = 12, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 117, [2] = 20, [3] = 23 })[R[0]], ({ [0] = 116, [1] = 15, [2] = 12, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 119, [1] = 18, [2] = 15, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 119, [2] = 22, [3] = 25 })[R[0]], ({ [0] = 120, [1] = 19, [2] = 16, [3] = 122 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 115, [1] = 112, [2] = 15, [3] = 18 })[R[0]], ({ [0] = 118, [1] = 17, [2] = 14, [3] = 120 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 115, [1] = 112, [2] = 15, [3] = 18 })[R[0]], ({ [0] = 118, [1] = 17, [2] = 14, [3] = 120 })[R[0]] })
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 }, [1] = { [0] = 124, [1] = 121, [2] = 24, [3] = 27 }, [2] = { [0] = 120, [1] = 117, [2] = 20, [3] = 23 } })[R[15]][R[0]], ({ [0] = { [0] = 110, [1] = 9, [2] = 6, [3] = 112 }, [1] = { [0] = 116, [1] = 15, [2] = 12, [3] = 118 }, [2] = { [0] = 120, [1] = 19, [2] = 16, [3] = 122 } })[R[15]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[16] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 120, [1] = 117, [2] = 20, [3] = 23 }, [1] = { [0] = 114, [1] = 111, [2] = 14, [3] = 17 }, [2] = { [0] = 114, [1] = 111, [2] = 14, [3] = 17 } })[R[16]][R[0]], ({ [0] = { [0] = 121, [1] = 20, [2] = 17, [3] = 123 }, [1] = { [0] = 116, [1] = 15, [2] = 12, [3] = 118 }, [2] = { [0] = 111, [1] = 10, [2] = 7, [3] = 113 } })[R[16]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[17] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 124, [1] = 121, [2] = 24, [3] = 27 }, [1] = { [0] = 123, [1] = 120, [2] = 23, [3] = 26 }, [2] = { [0] = 120, [1] = 117, [2] = 20, [3] = 23 } })[R[17]][R[0]], ({ [0] = { [0] = 111, [1] = 10, [2] = 7, [3] = 113 }, [1] = { [0] = 117, [1] = 16, [2] = 13, [3] = 119 }, [2] = { [0] = 118, [1] = 17, [2] = 14, [3] = 120 } })[R[17]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 115, [2] = 18, [3] = 21 }, [1] = { [0] = 114, [1] = 111, [2] = 14, [3] = 17 }, [2] = { [0] = 124, [1] = 121, [2] = 24, [3] = 27 } })[R[18]][R[0]], ({ [0] = { [0] = 120, [1] = 19, [2] = 16, [3] = 122 }, [1] = { [0] = 116, [1] = 15, [2] = 12, [3] = 118 }, [2] = { [0] = 111, [1] = 10, [2] = 7, [3] = 113 } })[R[18]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
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
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 64, 16 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 38, 102 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 23, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 91, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 118, 59 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 40, 32 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 126 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 126 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 111, 33 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 36, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 71, 32 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 79, 37 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 94, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 99, 66 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 92, 75 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 91, 90 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 87, 111 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 74, 112 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 46, 95 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 46, 83 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 39, 73 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 50, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 48, 49 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 60, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 68, 47 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 63, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 70, 94 } }
    pick(4, 3, { 0, 19, 20 })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 19, [1] = 25, [2] = 93, [3] = 125 })[R[0]], ({ [0] = 26, [1] = 88, [2] = 118, [3] = 34 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 1 or R[0] == 2 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 48, [1] = 46, [2] = 90 })[R[0]], ({ [0] = 7, [1] = 118, [2] = 105 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      if R[0] == 1 or R[0] == 2 then
        U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [1] = 7, [2] = 116 })[R[0]], ({ [1] = 71, [2] = 85 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        if R[0] == 1 then
        elseif R[0] == 2 then
          U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { 99, 93 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[0]", R[0])
        end
      elseif R[0] == 0 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 3 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 9, [1] = 20, [2] = 126, [3] = 95 })[R[0]], ({ [0] = 42, [1] = 80, [2] = 83, [3] = 13 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] })
    if R[1] == 1 or R[1] == 2 or R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [3] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [4] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[1]][R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 1 or R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[1]][R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[0]], ({ [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[1]][R[0]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[1]][R[0]], ({ [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 } })[R[1]][R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[1]][R[0]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 6, [1] = 112, [2] = 110, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [3] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 } })[R[1]][R[0]], ({ [1] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [3] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [4] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [6] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [7] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[1]][R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[1]][R[0]], ({ [5] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [6] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [7] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 or R[1] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [7] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[1]][R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
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
        elseif R[1] == 7 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[1]][R[0]], ({ [5] = { [0] = 15, [1] = 121, [2] = 119, [3] = 18 }, [7] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[1] == 7 then
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[1]][R[0]], ({ [5] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[1] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [7] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 } })[R[1]][R[0]], ({ [5] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [6] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [7] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 6 then
      if LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [3] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [5] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [6] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[1]][R[0]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [6] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [1] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [3] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [4] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [7] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 } })[R[1]][R[0]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [3] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [4] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [6] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[21]][R[0]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 15, [1] = 121, [2] = 119, [3] = 18 } })[R[21]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[22]][R[0]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[22]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[23]][R[0]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[23]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[24]][R[0]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[24]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[25]][R[0]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[25]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 } })[R[26]][R[0]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[26]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[27]][R[0]], ({ [0] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 } })[R[27]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[28]][R[0]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[28]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 19, [1] = 25, [2] = 93, [3] = 125 })[R[19]], ({ [0] = 26, [1] = 88, [2] = 118, [3] = 34 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[19] == 3 then
    elseif R[19] == 0 or R[19] == 1 or R[19] == 2 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 48, [1] = 46, [2] = 90 })[R[19]], ({ [0] = 7, [1] = 118, [2] = 105 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      if R[19] == 1 or R[19] == 2 then
        U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [1] = 7, [2] = 116 })[R[19]], ({ [1] = 71, [2] = 85 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        if R[19] == 2 then
          U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { 99, 93 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        elseif R[19] == 1 then
        else
          unseen("R[19]", R[19])
        end
      elseif R[19] == 0 then
      else
        unseen("R[19]", R[19])
      end
    else
      unseen("R[19]", R[19])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 9, [1] = 20, [2] = 126, [3] = 95 })[R[19]], ({ [0] = 42, [1] = 80, [2] = 83, [3] = 13 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 23, [2] = 23, [3] = 15, [4] = 19, [5] = 18, [6] = 15, [7] = 21 }, [1] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 }, [2] = { [0] = 119, [1] = 123, [2] = 123, [3] = 115, [4] = 119, [5] = 118, [6] = 115, [7] = 121 }, [3] = { [0] = 116, [1] = 120, [2] = 120, [3] = 112, [4] = 116, [5] = 115, [6] = 112, [7] = 118 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 9, [2] = 13, [3] = 9, [4] = 12, [5] = 10, [6] = 7, [7] = 10 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 117, [1] = 113, [2] = 117, [3] = 113, [4] = 116, [5] = 114, [6] = 111, [7] = 114 }, [3] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 19, [1] = 23, [2] = 23, [3] = 15, [4] = 19, [5] = 18, [6] = 15, [7] = 21 }, [1] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 }, [2] = { [0] = 119, [1] = 123, [2] = 123, [3] = 115, [4] = 119, [5] = 118, [6] = 115, [7] = 121 }, [3] = { [0] = 116, [1] = 120, [2] = 120, [3] = 112, [4] = 116, [5] = 115, [6] = 112, [7] = 118 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 9, [2] = 13, [3] = 9, [4] = 12, [5] = 10, [6] = 7, [7] = 10 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 117, [1] = 113, [2] = 117, [3] = 113, [4] = 116, [5] = 114, [6] = 111, [7] = 114 }, [3] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 } })[R[19]][R[10]] })
    if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 23, [2] = 16, [3] = 20, [4] = 16 }, [1] = { [1] = 26, [2] = 19, [3] = 23, [4] = 19 }, [2] = { [1] = 123, [2] = 116, [3] = 120, [4] = 116 }, [3] = { [1] = 120, [2] = 113, [3] = 117, [4] = 113 } })[R[19]][R[10]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 or R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 14, [2] = 15 }, [1] = { [1] = 17, [2] = 18 }, [2] = { [1] = 114, [2] = 115 }, [3] = { [1] = 111, [2] = 112 } })[R[19]][R[10]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[19]], ({ [0] = { [1] = 12, [2] = 16 }, [1] = { [1] = 118, [2] = 122 }, [2] = { [1] = 116, [2] = 120 }, [3] = { [1] = 15, [2] = 19 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 18, [2] = 19 }, [1] = { [1] = 21, [2] = 22 }, [2] = { [1] = 118, [2] = 119 }, [3] = { [1] = 115, [2] = 116 } })[R[19]][R[10]], ({ [0] = { [1] = 17, [2] = 13 }, [1] = { [1] = 123, [2] = 119 }, [2] = { [1] = 121, [2] = 117 }, [3] = { [1] = 20, [2] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 18, [2] = 23 }, [1] = { [1] = 21, [2] = 26 }, [2] = { [1] = 118, [2] = 123 }, [3] = { [1] = 115, [2] = 120 } })[R[19]][R[10]], ({ [0] = { [1] = 13, [2] = 10 }, [1] = { [1] = 119, [2] = 116 }, [2] = { [1] = 117, [2] = 114 }, [3] = { [1] = 16, [2] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 24, [2] = 22 }, [1] = { [1] = 27, [2] = 25 }, [2] = { [1] = 124, [2] = 122 }, [3] = { [1] = 121, [2] = 119 } })[R[19]][R[10]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 25, [2] = 24 }, [1] = { [1] = 28, [2] = 27 }, [2] = { [1] = 125, [2] = 124 }, [3] = { [1] = 122, [2] = 121 } })[R[19]][R[10]], ({ [0] = { [1] = 17, [2] = 18 }, [1] = { [1] = 123, [2] = 124 }, [2] = { [1] = 121, [2] = 122 }, [3] = { [1] = 20, [2] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[19]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 6, [1] = 112, [2] = 110, [3] = 9 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 25, [2] = 17, [3] = 17, [4] = 17 }, [1] = { [1] = 28, [2] = 20, [3] = 20, [4] = 20 }, [2] = { [1] = 125, [2] = 117, [3] = 117, [4] = 117 }, [3] = { [1] = 122, [2] = 114, [3] = 114, [4] = 114 } })[R[19]][R[10]], ({ [0] = { [1] = 14, [2] = 18, [3] = 14, [4] = 10 }, [1] = { [1] = 120, [2] = 124, [3] = 120, [4] = 116 }, [2] = { [1] = 118, [2] = 122, [3] = 118, [4] = 114 }, [3] = { [1] = 17, [2] = 21, [3] = 17, [4] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 15, [6] = 24, [7] = 15 }, [1] = { [5] = 18, [6] = 27, [7] = 18 }, [2] = { [5] = 115, [6] = 124, [7] = 115 }, [3] = { [5] = 112, [6] = 121, [7] = 112 } })[R[19]][R[10]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 23, [6] = 15, [7] = 23 }, [1] = { [5] = 26, [6] = 18, [7] = 26 }, [2] = { [5] = 123, [6] = 115, [7] = 123 }, [3] = { [5] = 120, [6] = 112, [7] = 120 } })[R[19]][R[10]], ({ [0] = { [5] = 11, [6] = 16, [7] = 16 }, [1] = { [5] = 117, [6] = 122, [7] = 122 }, [2] = { [5] = 115, [6] = 120, [7] = 120 }, [3] = { [5] = 14, [6] = 19, [7] = 19 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 or R[10] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 23, [7] = 16 }, [1] = { [5] = 26, [7] = 19 }, [2] = { [5] = 123, [7] = 116 }, [3] = { [5] = 120, [7] = 113 } })[R[19]][R[10]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
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
        elseif R[10] == 7 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [5] = 22, [7] = 21 }, [1] = { [5] = 25, [7] = 24 }, [2] = { [5] = 122, [7] = 121 }, [3] = { [5] = 119, [7] = 118 } })[R[19]][R[10]], ({ [0] = { [5] = 15, [7] = 13 }, [1] = { [5] = 121, [7] = 119 }, [2] = { [5] = 119, [7] = 117 }, [3] = { [5] = 18, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 7 then
        elseif R[10] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = { [5] = 13, [7] = 10 }, [1] = { [5] = 119, [7] = 116 }, [2] = { [5] = 117, [7] = 114 }, [3] = { [5] = 16, [7] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = { [5] = 12, [7] = 11 }, [1] = { [5] = 118, [7] = 117 }, [2] = { [5] = 116, [7] = 115 }, [3] = { [5] = 15, [7] = 14 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 19, [7] = 24 }, [1] = { [5] = 22, [7] = 27 }, [2] = { [5] = 119, [7] = 124 }, [3] = { [5] = 116, [7] = 121 } })[R[19]][R[10]], ({ [0] = { [5] = 14, [7] = 11 }, [1] = { [5] = 120, [7] = 117 }, [2] = { [5] = 118, [7] = 115 }, [3] = { [5] = 17, [7] = 14 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 25, [6] = 22, [7] = 18 }, [1] = { [5] = 28, [6] = 25, [7] = 21 }, [2] = { [5] = 125, [6] = 122, [7] = 118 }, [3] = { [5] = 122, [6] = 119, [7] = 115 } })[R[19]][R[10]], ({ [0] = { [5] = 9, [6] = 10, [7] = 8 }, [1] = { [5] = 115, [6] = 116, [7] = 114 }, [2] = { [5] = 113, [6] = 114, [7] = 112 }, [3] = { [5] = 12, [6] = 13, [7] = 11 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 15, [1] = 14, [2] = 20, [3] = 19, [4] = 17, [5] = 24, [6] = 19, [7] = 24 }, [1] = { [0] = 18, [1] = 17, [2] = 23, [3] = 22, [4] = 20, [5] = 27, [6] = 22, [7] = 27 }, [2] = { [0] = 115, [1] = 114, [2] = 120, [3] = 119, [4] = 117, [5] = 124, [6] = 119, [7] = 124 }, [3] = { [0] = 112, [1] = 111, [2] = 117, [3] = 116, [4] = 114, [5] = 121, [6] = 116, [7] = 121 } })[R[19]][R[10]], ({ [0] = { [0] = 10, [1] = 12, [2] = 8, [3] = 9, [4] = 18, [5] = 13, [6] = 12, [7] = 18 }, [1] = { [0] = 116, [1] = 118, [2] = 114, [3] = 115, [4] = 124, [5] = 119, [6] = 118, [7] = 124 }, [2] = { [0] = 114, [1] = 116, [2] = 112, [3] = 113, [4] = 122, [5] = 117, [6] = 116, [7] = 122 }, [3] = { [0] = 13, [1] = 15, [2] = 11, [3] = 12, [4] = 21, [5] = 16, [6] = 15, [7] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 16, [1] = 16, [2] = 19, [3] = 18, [4] = 18, [5] = 25, [6] = 20, [7] = 25 }, [1] = { [0] = 19, [1] = 19, [2] = 22, [3] = 21, [4] = 21, [5] = 28, [6] = 23, [7] = 28 }, [2] = { [0] = 116, [1] = 116, [2] = 119, [3] = 118, [4] = 118, [5] = 125, [6] = 120, [7] = 125 }, [3] = { [0] = 113, [1] = 113, [2] = 116, [3] = 115, [4] = 115, [5] = 122, [6] = 117, [7] = 122 } })[R[19]][R[10]], ({ [0] = { [0] = 10, [1] = 11, [2] = 7, [3] = 8, [4] = 17, [5] = 12, [6] = 11, [7] = 18 }, [1] = { [0] = 116, [1] = 117, [2] = 113, [3] = 114, [4] = 123, [5] = 118, [6] = 117, [7] = 124 }, [2] = { [0] = 114, [1] = 115, [2] = 111, [3] = 112, [4] = 121, [5] = 116, [6] = 115, [7] = 122 }, [3] = { [0] = 13, [1] = 14, [2] = 10, [3] = 11, [4] = 20, [5] = 15, [6] = 14, [7] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[29]][R[19]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 15, [1] = 121, [2] = 119, [3] = 18 } })[R[29]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[30]][R[19]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[30]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[31]][R[19]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[31]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[32]][R[19]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[32]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[33]][R[19]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[33]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 } })[R[34]][R[19]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[34]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[35] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[35]][R[19]], ({ [0] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 } })[R[35]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[36]][R[19]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[36]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 19, [1] = 25, [2] = 93, [3] = 125 })[R[20]], ({ [0] = 26, [1] = 88, [2] = 118, [3] = 34 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[20] == 0 or R[20] == 1 or R[20] == 2 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 48, [1] = 46, [2] = 90 })[R[20]], ({ [0] = 7, [1] = 118, [2] = 105 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      if R[20] == 0 then
      elseif R[20] == 1 or R[20] == 2 then
        U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [1] = 7, [2] = 116 })[R[20]], ({ [1] = 71, [2] = 85 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        if R[20] == 2 then
          U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { 99, 93 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        elseif R[20] == 1 then
        else
          unseen("R[20]", R[20])
        end
      else
        unseen("R[20]", R[20])
      end
    elseif R[20] == 3 then
    else
      unseen("R[20]", R[20])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 9, [1] = 20, [2] = 126, [3] = 95 })[R[20]], ({ [0] = 42, [1] = 80, [2] = 83, [3] = 13 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[37]][R[20]] })
    if R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [6] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [7] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[37]][R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[37]][R[20]], ({ [5] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [6] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [7] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 or R[37] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [7] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[37]][R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 5 then
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
        elseif R[37] == 7 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [5] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[37]][R[20]], ({ [5] = { [0] = 15, [1] = 121, [2] = 119, [3] = 18 }, [7] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[37] == 7 then
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[37]][R[20]], ({ [5] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[37] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [7] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 } })[R[37]][R[20]], ({ [5] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [6] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [7] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 1 or R[37] == 2 or R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [3] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [4] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[37]][R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[20]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 6, [1] = 112, [2] = 110, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 1 or R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[37]][R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[20]], ({ [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[37]][R[20]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[37]][R[20]], ({ [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 } })[R[37]][R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[37]][R[20]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [3] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 } })[R[37]][R[20]], ({ [1] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [3] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [4] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [3] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [5] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [6] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[37]][R[20]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [6] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [1] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [3] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [4] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [7] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 } })[R[37]][R[20]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [3] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [4] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [6] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[38]][R[20]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 15, [1] = 121, [2] = 119, [3] = 18 } })[R[38]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[39]][R[20]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[39]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[40]][R[20]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[40]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[41]][R[20]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[41]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[42]][R[20]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[42]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 } })[R[43]][R[20]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[43]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[44]][R[20]], ({ [0] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 } })[R[44]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[45]][R[20]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[45]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
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
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 64, 16 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 38, 102 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 23, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 91, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 118, 59 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 40, 32 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 126 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 126 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 111, 33 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 36, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 71, 32 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 79, 37 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 94, 61 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 99, 66 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 92, 75 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 91, 90 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 87, 111 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 74, 112 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 46, 95 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 46, 83 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 39, 73 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 50, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 48, 49 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 60, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 68, 47 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 63, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 70, 94 } }
    pick(4, 4, { 0, 19, 20, 46 })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 19, [1] = 25, [2] = 93, [3] = 125 })[R[0]], ({ [0] = 26, [1] = 88, [2] = 118, [3] = 34 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 1 or R[0] == 2 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 48, [1] = 46, [2] = 90 })[R[0]], ({ [0] = 7, [1] = 118, [2] = 105 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      if R[0] == 1 or R[0] == 2 then
        U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [1] = 7, [2] = 116 })[R[0]], ({ [1] = 71, [2] = 85 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        if R[0] == 1 then
        elseif R[0] == 2 then
          U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { 99, 93 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[0]", R[0])
        end
      elseif R[0] == 0 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 3 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 9, [1] = 20, [2] = 126, [3] = 95 })[R[0]], ({ [0] = 42, [1] = 80, [2] = 83, [3] = 13 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] })
    if R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [6] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [7] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[1]][R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[1]][R[0]], ({ [5] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [6] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [7] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 or R[1] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [7] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[1]][R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[1] == 7 then
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
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [7] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[1]][R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[1] == 5 then
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[1]][R[0]], ({ [5] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[1] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [7] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 } })[R[1]][R[0]], ({ [5] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [6] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [7] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 1 or R[1] == 2 or R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [3] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [4] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[1]][R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 6, [1] = 112, [2] = 110, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 1 or R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[1]][R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[0]], ({ [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[1]][R[0]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[1]][R[0]], ({ [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 } })[R[1]][R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [3] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[1]][R[0]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [3] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [4] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[1]], player = players[1], at = { ({ [1] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [3] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [4] = { [0] = 13, [1] = 16, [2] = 113, [3] = 110 } })[R[1]][R[0]], ({ [1] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [2] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [3] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [4] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [3] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 } })[R[1]][R[0]], ({ [1] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [3] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [4] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [3] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [5] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [6] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[1]][R[0]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [6] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [1] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [3] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [4] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [7] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 } })[R[1]][R[0]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [3] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [4] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [6] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[47]][R[0]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 15, [1] = 121, [2] = 119, [3] = 18 } })[R[47]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[48]][R[0]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[48]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[49]][R[0]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[49]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[0]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[0]] })
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[50]][R[0]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[50]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[0]] })
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[51]][R[0]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[51]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 } })[R[52]][R[0]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[52]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[53]][R[0]], ({ [0] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 } })[R[53]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[54]][R[0]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[54]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 19, [1] = 25, [2] = 93, [3] = 125 })[R[19]], ({ [0] = 26, [1] = 88, [2] = 118, [3] = 34 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[19] == 0 or R[19] == 1 or R[19] == 2 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 48, [1] = 46, [2] = 90 })[R[19]], ({ [0] = 7, [1] = 118, [2] = 105 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      if R[19] == 0 then
      elseif R[19] == 1 or R[19] == 2 then
        U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [1] = 7, [2] = 116 })[R[19]], ({ [1] = 71, [2] = 85 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        if R[19] == 2 then
          U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { 99, 93 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        elseif R[19] == 1 then
        else
          unseen("R[19]", R[19])
        end
      else
        unseen("R[19]", R[19])
      end
    elseif R[19] == 3 then
    else
      unseen("R[19]", R[19])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 9, [1] = 20, [2] = 126, [3] = 95 })[R[19]], ({ [0] = 42, [1] = 80, [2] = 83, [3] = 13 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 23, [2] = 23, [3] = 15, [4] = 19, [5] = 18, [6] = 15, [7] = 21 }, [1] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 }, [2] = { [0] = 119, [1] = 123, [2] = 123, [3] = 115, [4] = 119, [5] = 118, [6] = 115, [7] = 121 }, [3] = { [0] = 116, [1] = 120, [2] = 120, [3] = 112, [4] = 116, [5] = 115, [6] = 112, [7] = 118 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 9, [2] = 13, [3] = 9, [4] = 12, [5] = 10, [6] = 7, [7] = 10 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 117, [1] = 113, [2] = 117, [3] = 113, [4] = 116, [5] = 114, [6] = 111, [7] = 114 }, [3] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 19, [1] = 23, [2] = 23, [3] = 15, [4] = 19, [5] = 18, [6] = 15, [7] = 21 }, [1] = { [0] = 22, [1] = 26, [2] = 26, [3] = 18, [4] = 22, [5] = 21, [6] = 18, [7] = 24 }, [2] = { [0] = 119, [1] = 123, [2] = 123, [3] = 115, [4] = 119, [5] = 118, [6] = 115, [7] = 121 }, [3] = { [0] = 116, [1] = 120, [2] = 120, [3] = 112, [4] = 116, [5] = 115, [6] = 112, [7] = 118 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 9, [2] = 13, [3] = 9, [4] = 12, [5] = 10, [6] = 7, [7] = 10 }, [1] = { [0] = 119, [1] = 115, [2] = 119, [3] = 115, [4] = 118, [5] = 116, [6] = 113, [7] = 116 }, [2] = { [0] = 117, [1] = 113, [2] = 117, [3] = 113, [4] = 116, [5] = 114, [6] = 111, [7] = 114 }, [3] = { [0] = 16, [1] = 12, [2] = 16, [3] = 12, [4] = 15, [5] = 13, [6] = 10, [7] = 13 } })[R[19]][R[10]] })
    if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 23, [2] = 16, [3] = 20, [4] = 16 }, [1] = { [1] = 26, [2] = 19, [3] = 23, [4] = 19 }, [2] = { [1] = 123, [2] = 116, [3] = 120, [4] = 116 }, [3] = { [1] = 120, [2] = 113, [3] = 117, [4] = 113 } })[R[19]][R[10]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[19]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 6, [1] = 112, [2] = 110, [3] = 9 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 1 or R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 14, [2] = 15 }, [1] = { [1] = 17, [2] = 18 }, [2] = { [1] = 114, [2] = 115 }, [3] = { [1] = 111, [2] = 112 } })[R[19]][R[10]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[19]], ({ [0] = { [1] = 12, [2] = 16 }, [1] = { [1] = 118, [2] = 122 }, [2] = { [1] = 116, [2] = 120 }, [3] = { [1] = 15, [2] = 19 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 18, [2] = 19 }, [1] = { [1] = 21, [2] = 22 }, [2] = { [1] = 118, [2] = 119 }, [3] = { [1] = 115, [2] = 116 } })[R[19]][R[10]], ({ [0] = { [1] = 17, [2] = 13 }, [1] = { [1] = 123, [2] = 119 }, [2] = { [1] = 121, [2] = 117 }, [3] = { [1] = 20, [2] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 18, [2] = 23 }, [1] = { [1] = 21, [2] = 26 }, [2] = { [1] = 118, [2] = 123 }, [3] = { [1] = 115, [2] = 120 } })[R[19]][R[10]], ({ [0] = { [1] = 13, [2] = 10 }, [1] = { [1] = 119, [2] = 116 }, [2] = { [1] = 117, [2] = 114 }, [3] = { [1] = 16, [2] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 24, [2] = 22 }, [1] = { [1] = 27, [2] = 25 }, [2] = { [1] = 124, [2] = 122 }, [3] = { [1] = 121, [2] = 119 } })[R[19]][R[10]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 25, [2] = 24 }, [1] = { [1] = 28, [2] = 27 }, [2] = { [1] = 125, [2] = 124 }, [3] = { [1] = 122, [2] = 121 } })[R[19]][R[10]], ({ [0] = { [1] = 17, [2] = 18 }, [1] = { [1] = 123, [2] = 124 }, [2] = { [1] = 121, [2] = 122 }, [3] = { [1] = 20, [2] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 25, [2] = 17, [3] = 17, [4] = 17 }, [1] = { [1] = 28, [2] = 20, [3] = 20, [4] = 20 }, [2] = { [1] = 125, [2] = 117, [3] = 117, [4] = 117 }, [3] = { [1] = 122, [2] = 114, [3] = 114, [4] = 114 } })[R[19]][R[10]], ({ [0] = { [1] = 14, [2] = 18, [3] = 14, [4] = 10 }, [1] = { [1] = 120, [2] = 124, [3] = 120, [4] = 116 }, [2] = { [1] = 118, [2] = 122, [3] = 118, [4] = 114 }, [3] = { [1] = 17, [2] = 21, [3] = 17, [4] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 15, [6] = 24, [7] = 15 }, [1] = { [5] = 18, [6] = 27, [7] = 18 }, [2] = { [5] = 115, [6] = 124, [7] = 115 }, [3] = { [5] = 112, [6] = 121, [7] = 112 } })[R[19]][R[10]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 23, [6] = 15, [7] = 23 }, [1] = { [5] = 26, [6] = 18, [7] = 26 }, [2] = { [5] = 123, [6] = 115, [7] = 123 }, [3] = { [5] = 120, [6] = 112, [7] = 120 } })[R[19]][R[10]], ({ [0] = { [5] = 11, [6] = 16, [7] = 16 }, [1] = { [5] = 117, [6] = 122, [7] = 122 }, [2] = { [5] = 115, [6] = 120, [7] = 120 }, [3] = { [5] = 14, [6] = 19, [7] = 19 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 or R[10] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 23, [7] = 16 }, [1] = { [5] = 26, [7] = 19 }, [2] = { [5] = 123, [7] = 116 }, [3] = { [5] = 120, [7] = 113 } })[R[19]][R[10]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
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
        elseif R[10] == 7 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [5] = 22, [7] = 21 }, [1] = { [5] = 25, [7] = 24 }, [2] = { [5] = 122, [7] = 121 }, [3] = { [5] = 119, [7] = 118 } })[R[19]][R[10]], ({ [0] = { [5] = 15, [7] = 13 }, [1] = { [5] = 121, [7] = 119 }, [2] = { [5] = 119, [7] = 117 }, [3] = { [5] = 18, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 7 then
        elseif R[10] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = { [5] = 13, [7] = 10 }, [1] = { [5] = 119, [7] = 116 }, [2] = { [5] = 117, [7] = 114 }, [3] = { [5] = 16, [7] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = { [5] = 12, [7] = 11 }, [1] = { [5] = 118, [7] = 117 }, [2] = { [5] = 116, [7] = 115 }, [3] = { [5] = 15, [7] = 14 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 19, [7] = 24 }, [1] = { [5] = 22, [7] = 27 }, [2] = { [5] = 119, [7] = 124 }, [3] = { [5] = 116, [7] = 121 } })[R[19]][R[10]], ({ [0] = { [5] = 14, [7] = 11 }, [1] = { [5] = 120, [7] = 117 }, [2] = { [5] = 118, [7] = 115 }, [3] = { [5] = 17, [7] = 14 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 25, [6] = 22, [7] = 18 }, [1] = { [5] = 28, [6] = 25, [7] = 21 }, [2] = { [5] = 125, [6] = 122, [7] = 118 }, [3] = { [5] = 122, [6] = 119, [7] = 115 } })[R[19]][R[10]], ({ [0] = { [5] = 9, [6] = 10, [7] = 8 }, [1] = { [5] = 115, [6] = 116, [7] = 114 }, [2] = { [5] = 113, [6] = 114, [7] = 112 }, [3] = { [5] = 12, [6] = 13, [7] = 11 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[19]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 15, [1] = 14, [2] = 20, [3] = 19, [4] = 17, [5] = 24, [6] = 19, [7] = 24 }, [1] = { [0] = 18, [1] = 17, [2] = 23, [3] = 22, [4] = 20, [5] = 27, [6] = 22, [7] = 27 }, [2] = { [0] = 115, [1] = 114, [2] = 120, [3] = 119, [4] = 117, [5] = 124, [6] = 119, [7] = 124 }, [3] = { [0] = 112, [1] = 111, [2] = 117, [3] = 116, [4] = 114, [5] = 121, [6] = 116, [7] = 121 } })[R[19]][R[10]], ({ [0] = { [0] = 10, [1] = 12, [2] = 8, [3] = 9, [4] = 18, [5] = 13, [6] = 12, [7] = 18 }, [1] = { [0] = 116, [1] = 118, [2] = 114, [3] = 115, [4] = 124, [5] = 119, [6] = 118, [7] = 124 }, [2] = { [0] = 114, [1] = 116, [2] = 112, [3] = 113, [4] = 122, [5] = 117, [6] = 116, [7] = 122 }, [3] = { [0] = 13, [1] = 15, [2] = 11, [3] = 12, [4] = 21, [5] = 16, [6] = 15, [7] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 16, [1] = 16, [2] = 19, [3] = 18, [4] = 18, [5] = 25, [6] = 20, [7] = 25 }, [1] = { [0] = 19, [1] = 19, [2] = 22, [3] = 21, [4] = 21, [5] = 28, [6] = 23, [7] = 28 }, [2] = { [0] = 116, [1] = 116, [2] = 119, [3] = 118, [4] = 118, [5] = 125, [6] = 120, [7] = 125 }, [3] = { [0] = 113, [1] = 113, [2] = 116, [3] = 115, [4] = 115, [5] = 122, [6] = 117, [7] = 122 } })[R[19]][R[10]], ({ [0] = { [0] = 10, [1] = 11, [2] = 7, [3] = 8, [4] = 17, [5] = 12, [6] = 11, [7] = 18 }, [1] = { [0] = 116, [1] = 117, [2] = 113, [3] = 114, [4] = 123, [5] = 118, [6] = 117, [7] = 124 }, [2] = { [0] = 114, [1] = 115, [2] = 111, [3] = 112, [4] = 121, [5] = 116, [6] = 115, [7] = 122 }, [3] = { [0] = 13, [1] = 14, [2] = 10, [3] = 11, [4] = 20, [5] = 15, [6] = 14, [7] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[55]][R[19]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 15, [1] = 121, [2] = 119, [3] = 18 } })[R[55]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[56]][R[19]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[56]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[57]][R[19]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[57]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[19]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[19]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[58]][R[19]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[58]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[19]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[19]] })
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[59]][R[19]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[59]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 } })[R[60]][R[19]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[60]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[61]][R[19]], ({ [0] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 } })[R[61]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[62] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[62]][R[19]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[62]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 19, [1] = 25, [2] = 93, [3] = 125 })[R[20]], ({ [0] = 26, [1] = 88, [2] = 118, [3] = 34 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[20] == 3 then
    elseif R[20] == 0 or R[20] == 1 or R[20] == 2 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 48, [1] = 46, [2] = 90 })[R[20]], ({ [0] = 7, [1] = 118, [2] = 105 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      if R[20] == 1 or R[20] == 2 then
        U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [1] = 7, [2] = 116 })[R[20]], ({ [1] = 71, [2] = 85 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        if R[20] == 1 then
        elseif R[20] == 2 then
          U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { 99, 93 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[20]", R[20])
        end
      elseif R[20] == 0 then
      else
        unseen("R[20]", R[20])
      end
    else
      unseen("R[20]", R[20])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 9, [1] = 20, [2] = 126, [3] = 95 })[R[20]], ({ [0] = 42, [1] = 80, [2] = 83, [3] = 13 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[37]][R[20]] })
    if R[37] == 1 or R[37] == 2 or R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [3] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [4] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[37]][R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[20]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 6, [1] = 112, [2] = 110, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 1 or R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[37]][R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[20]], ({ [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[37]][R[20]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[37]][R[20]], ({ [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 } })[R[37]][R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[37]][R[20]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 13, [1] = 16, [2] = 113, [3] = 110 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [3] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 } })[R[37]][R[20]], ({ [1] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [3] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [4] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [6] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [7] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[37]][R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[37]][R[20]], ({ [5] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [6] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [7] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[37] == 5 or R[37] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [7] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[37]][R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 5 then
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
        elseif R[37] == 7 then
          if LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [5] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[37]][R[20]], ({ [5] = { [0] = 15, [1] = 121, [2] = 119, [3] = 18 }, [7] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[37] == 7 then
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[37]][R[20]], ({ [5] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [7] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 } })[R[37]][R[20]], ({ [5] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [6] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [7] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[20]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [3] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [5] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [6] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[37]][R[20]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [6] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [1] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [3] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [4] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [7] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 } })[R[37]][R[20]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [3] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [4] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [6] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[63]][R[20]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 15, [1] = 121, [2] = 119, [3] = 18 } })[R[63]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[64]][R[20]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[64]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[65]][R[20]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[65]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[20]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[20]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[66]][R[20]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[66]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[20]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[67]][R[20]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[67]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 } })[R[68]][R[20]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[68]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[69]][R[20]], ({ [0] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 } })[R[69]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[70]][R[20]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[70]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 19, [1] = 25, [2] = 93, [3] = 125 })[R[46]], ({ [0] = 26, [1] = 88, [2] = 118, [3] = 34 })[R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[46] == 0 or R[46] == 1 or R[46] == 2 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 48, [1] = 46, [2] = 90 })[R[46]], ({ [0] = 7, [1] = 118, [2] = 105 })[R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
      if R[46] == 1 or R[46] == 2 then
        U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [1] = 7, [2] = 116 })[R[46]], ({ [1] = 71, [2] = 85 })[R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        if R[46] == 2 then
          U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { 99, 93 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        elseif R[46] == 1 then
        else
          unseen("R[46]", R[46])
        end
      elseif R[46] == 0 then
      else
        unseen("R[46]", R[46])
      end
    elseif R[46] == 3 then
    else
      unseen("R[46]", R[46])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 9, [1] = 20, [2] = 126, [3] = 95 })[R[46]], ({ [0] = 42, [1] = 80, [2] = 83, [3] = 13 })[R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[71] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [3] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [5] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [6] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[71]][R[46]] })
    if R[71] == 5 or R[71] == 6 or R[71] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [5] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [6] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [7] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[71]][R[46]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [6] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [7] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[71]][R[46]], ({ [5] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [6] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [7] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[46]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[46]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[46]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[71] == 5 or R[71] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [5] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [7] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[71]][R[46]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        if R[71] == 5 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[71] == 7 then
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
          unseen("R[71]", R[71])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [5] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [7] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[71]][R[46]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        if R[71] == 5 then
        elseif R[71] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[46]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[71]", R[71])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [7] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[46]], ({ [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [5] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[71]][R[46]], ({ [5] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [7] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[71]", R[71])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [7] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 } })[R[71]][R[46]], ({ [5] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [6] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [7] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[46]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
    elseif R[71] == 1 or R[71] == 2 or R[71] == 3 or R[71] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [3] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [4] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[71]][R[46]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[46]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[46]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[46]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 6, [1] = 112, [2] = 110, [3] = 9 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 1 or R[71] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 } })[R[71]][R[46]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[46]], ({ [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[71]][R[46]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 } })[R[71]][R[46]], ({ [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 } })[R[71]][R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[46]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[46]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[71]", R[71])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[71]], player = players[4], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [3] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [4] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[71]][R[46]], ({ [1] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [3] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [4] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[71]], player = players[4], at = { ({ [1] = { [0] = 22, [1] = 25, [2] = 122, [3] = 119 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [3] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [4] = { [0] = 13, [1] = 16, [2] = 113, [3] = 110 } })[R[71]][R[46]], ({ [1] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [2] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [3] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [4] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [1] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [2] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [3] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 } })[R[71]][R[46]], ({ [1] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [2] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [3] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 }, [4] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[46]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[46]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[46]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
    elseif R[71] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[46]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 21, [1] = 24, [2] = 121, [3] = 118 })[R[46]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[46]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[46]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 24, [1] = 27, [2] = 124, [3] = 121 })[R[46]], ({ [0] = 7, [1] = 113, [2] = 111, [3] = 10 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 23, [1] = 26, [2] = 123, [3] = 120 })[R[46]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[46]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[71]", R[71])
    end
    U[#U]:set_lights(true)
    if R[71] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[46]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[46]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 1 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[46]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[46]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[46]], ({ [0] = 13, [1] = 119, [2] = 117, [3] = 16 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 2 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[46]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[46]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 3 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[46]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[46]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 14, [1] = 17, [2] = 114, [3] = 111 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[71] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[46]], ({ [0] = 9, [1] = 115, [2] = 113, [3] = 12 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[71] == 6 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 10, [1] = 116, [2] = 114, [3] = 13 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 17, [1] = 20, [2] = 117, [3] = 114 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 17, [1] = 123, [2] = 121, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[46]], ({ [0] = 18, [1] = 124, [2] = 122, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 11, [1] = 117, [2] = 115, [3] = 14 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 8, [1] = 114, [2] = 112, [3] = 11 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 25, [1] = 28, [2] = 125, [3] = 122 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[71]", R[71])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [3] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [4] = { [0] = 17, [1] = 20, [2] = 117, [3] = 114 }, [5] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [6] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [7] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[71]][R[46]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [3] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 }, [5] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [6] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [1] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [3] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [4] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [5] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 }, [6] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [7] = { [0] = 25, [1] = 28, [2] = 125, [3] = 122 } })[R[71]][R[46]], ({ [0] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [3] = { [0] = 8, [1] = 114, [2] = 112, [3] = 11 }, [4] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [5] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [6] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [7] = { [0] = 18, [1] = 124, [2] = 122, [3] = 21 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[71] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[72]][R[46]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 9, [1] = 115, [2] = 113, [3] = 12 }, [2] = { [0] = 15, [1] = 121, [2] = 119, [3] = 18 } })[R[72]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 21, [2] = 118, [3] = 115 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] })
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [1] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [2] = { [0] = 21, [1] = 24, [2] = 121, [3] = 118 } })[R[73]][R[46]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 10, [1] = 116, [2] = 114, [3] = 13 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[73]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[46]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[46]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[46]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[46]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[46]] })
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 15, [1] = 18, [2] = 115, [3] = 112 }, [2] = { [0] = 19, [1] = 22, [2] = 119, [3] = 116 } })[R[74]][R[46]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[74]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[46]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [2] = { [0] = 16, [1] = 19, [2] = 116, [3] = 113 } })[R[75]][R[46]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 11, [1] = 117, [2] = 115, [3] = 14 }, [2] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 } })[R[75]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 19, [2] = 116, [3] = 113 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 22, [2] = 119, [3] = 116 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 23, [2] = 120, [3] = 117 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 116, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 15, [1] = 121, [2] = 119, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 25, [2] = 122, [3] = 119 })[R[46]], ({ [0] = 16, [1] = 122, [2] = 120, [3] = 19 })[R[46]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[46]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 18, [2] = 115, [3] = 112 })[R[46]], ({ [0] = 14, [1] = 120, [2] = 118, [3] = 17 })[R[46]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [1] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[76]][R[46]], ({ [0] = { [0] = 6, [1] = 112, [2] = 110, [3] = 9 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 } })[R[76]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[77] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 } })[R[77]][R[46]], ({ [0] = { [0] = 17, [1] = 123, [2] = 121, [3] = 20 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[77]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[78] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 }, [1] = { [0] = 23, [1] = 26, [2] = 123, [3] = 120 }, [2] = { [0] = 20, [1] = 23, [2] = 120, [3] = 117 } })[R[78]][R[46]], ({ [0] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 }, [1] = { [0] = 13, [1] = 119, [2] = 117, [3] = 16 }, [2] = { [0] = 14, [1] = 120, [2] = 118, [3] = 17 } })[R[78]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 118, [3] = 115 }, [1] = { [0] = 14, [1] = 17, [2] = 114, [3] = 111 }, [2] = { [0] = 24, [1] = 27, [2] = 124, [3] = 121 } })[R[79]][R[46]], ({ [0] = { [0] = 16, [1] = 122, [2] = 120, [3] = 19 }, [1] = { [0] = 12, [1] = 118, [2] = 116, [3] = 15 }, [2] = { [0] = 7, [1] = 113, [2] = 111, [3] = 10 } })[R[79]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[71]", R[71])
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
    trigger.time{min = 18000, max = 20000, one_shot = false, on = Meteor}  -- after 180 to 200 marks
    trigger.time{min = 12000, max = 18000, one_shot = false, on = Storm}  -- after 120 to 180 marks
  end
  return true
end
