-- mm4_01Lua.lua  -  4 Player, Midas, 'Coliseum' map. (Lua)
--
-- Converted by op2dll from mm4_01.dll ("4 Player, Midas, 'Coliseum' map."): its setup replayed. `on_init` makes the original's
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
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 103, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 126 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 126 } }
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 67, 65 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 69, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 81, 95 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 38, 43 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 111, 46 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 113, 35 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 17, 39 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 52, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 84, 16 } }
    R[0] = game.rand(4)
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 8, [1] = 12, [2] = 106, [3] = 107 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 5, [1] = 101, [2] = 101, [3] = 7 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[1] == 0 or R[1] == 1 or R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 23, [1] = 23, [2] = 115, [3] = 117 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 12, [1] = 108, [2] = 108, [3] = 14 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 20, [1] = 117, [2] = 118, [3] = 19 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 0 then
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
      elseif R[1] == 1 then
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
      elseif R[1] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[0]], ({ [0] = 11, [1] = 112, [2] = 111, [3] = 8 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[0]], ({ [0] = 11, [1] = 112, [2] = 111, [3] = 8 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[0]], ({ [0] = 11, [1] = 112, [2] = 111, [3] = 8 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 31, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 31, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 31, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 16, [2] = 100, [3] = 100 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 14, [1] = 14, [2] = 106, [3] = 108 }, [7] = { [0] = 26, [1] = 26, [2] = 118, [3] = 126 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 22, [1] = 118, [2] = 118, [3] = 24 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 18, [1] = 118, [2] = 120, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 0 or R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 123, [2] = 122, [3] = 20 }, [1] = { [0] = 30, [1] = 126, [2] = 126, [3] = 32 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 } })[R[1]][R[0]], ({ [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
      else
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 25, [1] = 31, [2] = 123, [3] = 125 } })[R[1]][R[0]], ({ [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 3 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 4 then
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
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 16, [2] = 100, [3] = 100 }, [1] = { [0] = 4, [1] = 15, [2] = 101, [3] = 111 }, [2] = { [0] = 28, [1] = 32, [2] = 126, [3] = 127 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 6, [1] = 12, [2] = 104, [3] = 106 }, [5] = { [0] = 4, [1] = 6, [2] = 98, [3] = 100 }, [6] = { [0] = 6, [1] = 6, [2] = 98, [3] = 100 }, [7] = { [0] = 18, [1] = 18, [2] = 110, [3] = 118 } })[R[1]][R[0]], ({ [0] = { [0] = 20, [1] = 125, [2] = 124, [3] = 22 }, [1] = { [0] = 27, [1] = 123, [2] = 123, [3] = 29 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 4, [1] = 107, [2] = 102, [3] = 5 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 22, [1] = 122, [2] = 124, [3] = 25 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 24, [1] = 30, [2] = 122, [3] = 124 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 6, [1] = 103, [2] = 104, [3] = 5 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 11, [1] = 107, [2] = 107, [3] = 13 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 25, [1] = 33, [2] = 123, [3] = 128 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 9, [1] = 11, [2] = 103, [3] = 105 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 12, [1] = 12, [2] = 104, [3] = 112 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 19, [1] = 120, [2] = 119, [3] = 16 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 5, [1] = 102, [2] = 103, [3] = 4 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 21, [1] = 27, [2] = 119, [3] = 121 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 7, [1] = 7, [2] = 99, [3] = 107 } })[R[1]][R[0]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 4, [1] = 100, [2] = 100, [3] = 6 }, [2] = { [0] = 20, [1] = 121, [2] = 120, [3] = 17 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 11, [1] = 117, [2] = 111, [3] = 11 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 25, [1] = 33, [2] = 123, [3] = 128 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 9, [1] = 11, [2] = 103, [3] = 105 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 12, [1] = 12, [2] = 104, [3] = 112 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 19, [1] = 120, [2] = 119, [3] = 16 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 5, [1] = 102, [2] = 103, [3] = 4 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 21, [1] = 27, [2] = 119, [3] = 121 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 7, [1] = 7, [2] = 99, [3] = 107 } })[R[1]][R[0]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 4, [1] = 100, [2] = 100, [3] = 6 }, [2] = { [0] = 20, [1] = 121, [2] = 120, [3] = 17 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 11, [1] = 117, [2] = 111, [3] = 11 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 25, [1] = 33, [2] = 123, [3] = 128 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 9, [1] = 11, [2] = 103, [3] = 105 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 12, [1] = 12, [2] = 104, [3] = 112 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 19, [1] = 120, [2] = 119, [3] = 16 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 5, [1] = 102, [2] = 103, [3] = 4 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 21, [1] = 27, [2] = 119, [3] = 121 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 7, [1] = 7, [2] = 99, [3] = 107 } })[R[1]][R[0]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 4, [1] = 100, [2] = 100, [3] = 6 }, [2] = { [0] = 20, [1] = 121, [2] = 120, [3] = 17 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 11, [1] = 117, [2] = 111, [3] = 11 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 27, [1] = 33, [2] = 125, [3] = 127 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 } })[R[1]][R[0]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 8, [1] = 111, [2] = 106, [3] = 9 }, [4] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [5] = { [0] = 22, [1] = 119, [2] = 120, [3] = 21 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 19, [2] = 103, [3] = 103 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 }, [5] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 9, [1] = 109, [2] = 111, [3] = 12 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 12, [1] = 16, [2] = 110, [3] = 111 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 18, [1] = 121, [2] = 116, [3] = 19 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 12, [1] = 109, [2] = 110, [3] = 11 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 8, [1] = 19, [2] = 105, [3] = 115 }, [2] = { [0] = 13, [1] = 17, [2] = 111, [3] = 112 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 19, [1] = 122, [2] = 117, [3] = 20 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 11, [1] = 111, [2] = 113, [3] = 14 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 22, [2] = 106, [3] = 106 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 8, [1] = 109, [2] = 108, [3] = 5 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 10, [1] = 114, [2] = 108, [3] = 11 }, [5] = { [0] = 17, [1] = 114, [2] = 115, [3] = 16 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 10, [1] = 21, [2] = 107, [3] = 117 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 9, [1] = 110, [2] = 109, [3] = 6 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 11, [1] = 115, [2] = 109, [3] = 12 }, [5] = { [0] = 18, [1] = 115, [2] = 116, [3] = 17 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 24, [2] = 108, [3] = 108 }, [1] = { [0] = 11, [1] = 22, [2] = 108, [3] = 118 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 16, [1] = 16, [2] = 108, [3] = 110 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 10, [1] = 111, [2] = 110, [3] = 7 }, [3] = { [0] = 14, [1] = 117, [2] = 112, [3] = 15 }, [4] = { [0] = 15, [1] = 119, [2] = 113, [3] = 16 }, [5] = { [0] = 19, [1] = 116, [2] = 117, [3] = 18 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 14, [1] = 114, [2] = 116, [3] = 17 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 25, [2] = 109, [3] = 109 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 15, [1] = 118, [2] = 113, [3] = 16 }, [4] = { [0] = 16, [1] = 120, [2] = 114, [3] = 17 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 6, [1] = 111, [2] = 110, [3] = 8 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 12, [1] = 113, [2] = 112, [3] = 9 }, [3] = { [0] = 16, [1] = 119, [2] = 114, [3] = 17 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 16, [1] = 116, [2] = 118, [3] = 19 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 8, [1] = 104, [2] = 104, [3] = 10 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 18, [1] = 122, [2] = 116, [3] = 19 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 17, [1] = 117, [2] = 119, [3] = 20 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[1]][R[0]], ({ [0] = { [0] = 8, [1] = 113, [2] = 112, [3] = 10 }, [1] = { [0] = 9, [1] = 105, [2] = 105, [3] = 11 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 19, [1] = 123, [2] = 117, [3] = 20 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 114, [2] = 113, [3] = 11 }, [1] = { [0] = 10, [1] = 106, [2] = 106, [3] = 12 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 12, [1] = 20, [2] = 110, [3] = 115 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[1]][R[0]], ({ [0] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [1] = { [0] = 15, [1] = 111, [2] = 111, [3] = 17 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[1]][R[0]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 121, [2] = 120, [3] = 18 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 30, [2] = 114, [3] = 114 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 14, [1] = 22, [2] = 112, [3] = 117 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 31, [2] = 115, [3] = 115 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 19, [1] = 115, [2] = 115, [3] = 21 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 23, [1] = 25, [2] = 117, [3] = 119 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 20, [1] = 116, [2] = 116, [3] = 22 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 6, [1] = 110, [2] = 104, [3] = 7 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 25, [1] = 121, [2] = 121, [3] = 27 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 34, [2] = 118, [3] = 118 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 18, [1] = 22, [2] = 116, [3] = 117 }, [3] = { [0] = 18, [1] = 26, [2] = 116, [3] = 121 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 26, [1] = 122, [2] = 122, [3] = 28 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 8, [1] = 108, [2] = 110, [3] = 11 } })[R[1]][R[0]] })
    if R[1] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
        for i = 1, game.initial_units() do
          R[2] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [2] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 } })[R[2]][R[0]], ({ [0] = { [0] = 5, [1] = 110, [2] = 109, [3] = 7 }, [1] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [2] = { [0] = 17, [1] = 122, [2] = 121, [3] = 19 } })[R[2]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[0]] })
        for i = 1, game.initial_units() do
          R[3] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 5, [1] = 16, [2] = 102, [3] = 112 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 } })[R[3]][R[0]], ({ [0] = { [0] = 22, [1] = 118, [2] = 118, [3] = 24 }, [1] = { [0] = 24, [1] = 120, [2] = 120, [3] = 26 }, [2] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 } })[R[3]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[4] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 9, [1] = 13, [2] = 107, [3] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [2] = { [0] = 27, [1] = 31, [2] = 125, [3] = 126 } })[R[4]][R[0]], ({ [0] = { [0] = 5, [1] = 106, [2] = 105, [3] = 2 }, [1] = { [0] = 21, [1] = 122, [2] = 121, [3] = 18 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 } })[R[4]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[0]] })
        for i = 1, game.initial_units() do
          R[5] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [1] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [2] = { [0] = 4, [1] = 12, [2] = 102, [3] = 107 } })[R[5]][R[0]], ({ [0] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 123, [2] = 118, [3] = 21 }, [2] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 } })[R[5]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        for i = 1, game.initial_units() do
          R[6] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [1] = { [0] = 9, [1] = 15, [2] = 107, [3] = 109 }, [2] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 } })[R[6]][R[0]], ({ [0] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [1] = { [0] = 12, [1] = 116, [2] = 110, [3] = 13 }, [2] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 } })[R[6]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[0]] })
        for i = 1, game.initial_units() do
          R[7] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [1] = { [0] = 3, [1] = 5, [2] = 97, [3] = 99 }, [2] = { [0] = 25, [1] = 27, [2] = 119, [3] = 121 } })[R[7]][R[0]], ({ [0] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 }, [1] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [2] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 } })[R[7]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        for i = 1, game.initial_units() do
          R[8] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 8, [1] = 8, [2] = 100, [3] = 102 }, [1] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [2] = { [0] = 34, [1] = 34, [2] = 126, [3] = 128 } })[R[8]][R[0]], ({ [0] = { [0] = 2, [1] = 108, [2] = 102, [3] = 2 }, [1] = { [0] = 0, [1] = 106, [2] = 100, [3] = 0 }, [2] = { [0] = 15, [1] = 121, [2] = 115, [3] = 15 } })[R[8]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
        for i = 1, game.initial_units() do
          R[9] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 }, [1] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 }, [2] = { [0] = 9, [1] = 9, [2] = 101, [3] = 109 } })[R[9]][R[0]], ({ [0] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [1] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [2] = { [0] = 23, [1] = 123, [2] = 125, [3] = 26 } })[R[9]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 100, [1] = 110, [2] = 3, [3] = 14 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 113, [1] = 118, [2] = 15, [3] = 23 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 108, [1] = 110, [2] = 14, [3] = 16 }, [6] = { [0] = 105, [1] = 107, [2] = 13, [3] = 13 }, [7] = { [0] = 109, [1] = 117, [2] = 17, [3] = 17 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 114, [1] = 20, [2] = 18, [3] = 114 }, [2] = { [0] = 106, [1] = 3, [2] = 6, [3] = 107 }, [3] = { [0] = 115, [1] = 18, [2] = 17, [3] = 120 }, [4] = { [0] = 111, [1] = 14, [2] = 13, [3] = 117 }, [5] = { [0] = 113, [1] = 14, [2] = 15, [3] = 112 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 115, [1] = 16, [2] = 13, [3] = 113 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 100, [1] = 110, [2] = 3, [3] = 14 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 113, [1] = 118, [2] = 15, [3] = 23 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 108, [1] = 110, [2] = 14, [3] = 16 }, [6] = { [0] = 105, [1] = 107, [2] = 13, [3] = 13 }, [7] = { [0] = 109, [1] = 117, [2] = 17, [3] = 17 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 114, [1] = 20, [2] = 18, [3] = 114 }, [2] = { [0] = 106, [1] = 3, [2] = 6, [3] = 107 }, [3] = { [0] = 115, [1] = 18, [2] = 17, [3] = 120 }, [4] = { [0] = 111, [1] = 14, [2] = 13, [3] = 117 }, [5] = { [0] = 113, [1] = 14, [2] = 15, [3] = 112 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 115, [1] = 16, [2] = 13, [3] = 113 } })[R[10]][R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 110, [1] = 120, [2] = 13, [3] = 24 }, [2] = { [0] = 106, [1] = 107, [2] = 8, [3] = 12 }, [3] = { [0] = 121, [1] = 126, [2] = 23, [3] = 31 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 108, [1] = 110, [2] = 14, [3] = 16 }, [6] = { [0] = 114, [1] = 116, [2] = 22, [3] = 22 }, [7] = { [0] = 102, [1] = 110, [2] = 10, [3] = 10 } })[R[10]][R[0]], ({ [0] = { [0] = 108, [1] = 6, [2] = 4, [3] = 109 }, [1] = { [0] = 101, [1] = 7, [2] = 5, [3] = 101 }, [2] = { [0] = 111, [1] = 8, [2] = 11, [3] = 112 }, [3] = { [0] = 119, [1] = 22, [2] = 21, [3] = 124 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 119, [1] = 20, [2] = 21, [3] = 118 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 121, [1] = 22, [2] = 19, [3] = 119 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 123, [1] = 123, [2] = 35, [3] = 39 }, [1] = { [0] = 111, [1] = 121, [2] = 14, [3] = 25 }, [2] = { [0] = 109, [1] = 110, [2] = 11, [3] = 15 }, [5] = { [0] = 118, [1] = 120, [2] = 24, [3] = 26 }, [6] = { [0] = 115, [1] = 117, [2] = 23, [3] = 23 }, [7] = { [0] = 102, [1] = 110, [2] = 10, [3] = 10 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 108, [1] = 14, [2] = 12, [3] = 108 }, [2] = { [0] = 117, [1] = 14, [2] = 17, [3] = 118 }, [5] = { [0] = 118, [1] = 19, [2] = 20, [3] = 117 }, [6] = { [0] = 112, [1] = 12, [2] = 12, [3] = 118 }, [7] = { [0] = 108, [1] = 9, [2] = 6, [3] = 106 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 0 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 100, [1] = 100, [2] = 12, [3] = 16 })[R[0]], ({ [0] = 115, [1] = 13, [2] = 11, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 100, [1] = 100, [2] = 12, [3] = 16 })[R[0]], ({ [0] = 115, [1] = 13, [2] = 11, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 100, [1] = 100, [2] = 12, [3] = 16 })[R[0]], ({ [0] = 115, [1] = 13, [2] = 11, [3] = 116 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 1 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 111, [1] = 121, [2] = 14, [3] = 25 })[R[0]], ({ [0] = 118, [1] = 24, [2] = 22, [3] = 118 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 111, [1] = 121, [2] = 14, [3] = 25 })[R[0]], ({ [0] = 118, [1] = 24, [2] = 22, [3] = 118 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 111, [1] = 121, [2] = 14, [3] = 25 })[R[0]], ({ [0] = 118, [1] = 24, [2] = 22, [3] = 118 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 2 then
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
      elseif R[10] == 5 then
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
      elseif R[10] == 6 then
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
      elseif R[10] == 7 then
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
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 110, [1] = 120, [2] = 13, [3] = 24 }, [2] = { [0] = 118, [1] = 119, [2] = 20, [3] = 24 }, [5] = { [0] = 118, [1] = 120, [2] = 24, [3] = 26 }, [6] = { [0] = 123, [1] = 125, [2] = 31, [3] = 31 }, [7] = { [0] = 117, [1] = 125, [2] = 25, [3] = 25 } })[R[10]][R[0]], ({ [0] = { [0] = 122, [1] = 20, [2] = 18, [3] = 123 }, [1] = { [0] = 126, [1] = 32, [2] = 30, [3] = 126 }, [2] = { [0] = 111, [1] = 8, [2] = 11, [3] = 112 }, [5] = { [0] = 111, [1] = 12, [2] = 13, [3] = 110 }, [6] = { [0] = 112, [1] = 12, [2] = 12, [3] = 118 }, [7] = { [0] = 108, [1] = 9, [2] = 6, [3] = 106 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [2] = { [0] = 118, [1] = 119, [2] = 20, [3] = 24 }, [5] = { [0] = 108, [1] = 110, [2] = 14, [3] = 16 }, [6] = { [0] = 106, [1] = 108, [2] = 14, [3] = 14 }, [7] = { [0] = 118, [1] = 126, [2] = 26, [3] = 26 } })[R[10]][R[0]], ({ [2] = { [0] = 117, [1] = 14, [2] = 17, [3] = 118 }, [5] = { [0] = 106, [1] = 7, [2] = 8, [3] = 105 }, [6] = { [0] = 112, [1] = 12, [2] = 12, [3] = 118 }, [7] = { [0] = 120, [1] = 21, [2] = 18, [3] = 118 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 0 or R[10] == 1 then
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 105, [1] = 110, [2] = 7, [3] = 15 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 } })[R[10]][R[0]], ({ [3] = { [0] = 119, [1] = 22, [2] = 21, [3] = 124 }, [4] = { [0] = 103, [1] = 6, [2] = 5, [3] = 109 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 108, [1] = 113, [2] = 10, [3] = 18 })[R[0]], ({ [0] = 108, [1] = 11, [2] = 10, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 119, [1] = 124, [2] = 21, [3] = 29 })[R[0]], ({ [0] = 108, [1] = 11, [2] = 10, [3] = 113 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 123, [1] = 125, [2] = 25, [3] = 31 })[R[0]], ({ [0] = 105, [1] = 8, [2] = 7, [3] = 111 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 123, [1] = 125, [2] = 25, [3] = 31 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 121 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 100, [1] = 100, [2] = 12, [3] = 16 }, [1] = { [0] = 101, [1] = 111, [2] = 4, [3] = 15 }, [2] = { [0] = 126, [1] = 127, [2] = 28, [3] = 32 }, [3] = { [0] = 114, [1] = 119, [2] = 16, [3] = 24 }, [4] = { [0] = 104, [1] = 106, [2] = 6, [3] = 12 }, [5] = { [0] = 98, [1] = 100, [2] = 4, [3] = 6 }, [6] = { [0] = 98, [1] = 100, [2] = 6, [3] = 6 }, [7] = { [0] = 110, [1] = 118, [2] = 18, [3] = 18 } })[R[10]][R[0]], ({ [0] = { [0] = 124, [1] = 22, [2] = 20, [3] = 125 }, [1] = { [0] = 123, [1] = 29, [2] = 27, [3] = 123 }, [2] = { [0] = 111, [1] = 8, [2] = 11, [3] = 112 }, [3] = { [0] = 102, [1] = 5, [2] = 4, [3] = 107 }, [4] = { [0] = 107, [1] = 10, [2] = 9, [3] = 113 }, [5] = { [0] = 113, [1] = 14, [2] = 15, [3] = 112 }, [6] = { [0] = 112, [1] = 12, [2] = 12, [3] = 118 }, [7] = { [0] = 124, [1] = 25, [2] = 22, [3] = 122 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 107, [1] = 107, [2] = 19, [3] = 23 }, [1] = { [0] = 100, [1] = 110, [2] = 3, [3] = 14 }, [2] = { [0] = 122, [1] = 123, [2] = 24, [3] = 28 }, [3] = { [0] = 103, [1] = 108, [2] = 5, [3] = 13 }, [4] = { [0] = 122, [1] = 124, [2] = 24, [3] = 30 }, [5] = { [0] = 116, [1] = 118, [2] = 22, [3] = 24 }, [6] = { [0] = 105, [1] = 107, [2] = 13, [3] = 13 }, [7] = { [0] = 120, [1] = 128, [2] = 28, [3] = 28 } })[R[10]][R[0]], ({ [0] = { [0] = 111, [1] = 9, [2] = 7, [3] = 112 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 115, [1] = 12, [2] = 15, [3] = 116 }, [3] = { [0] = 109, [1] = 12, [2] = 11, [3] = 114 }, [4] = { [0] = 111, [1] = 14, [2] = 13, [3] = 117 }, [5] = { [0] = 104, [1] = 5, [2] = 6, [3] = 103 }, [6] = { [0] = 117, [1] = 17, [2] = 17, [3] = 123 }, [7] = { [0] = 115, [1] = 16, [2] = 13, [3] = 113 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 105, [1] = 105, [2] = 17, [3] = 21 }, [1] = { [0] = 100, [1] = 110, [2] = 3, [3] = 14 }, [2] = { [0] = 122, [1] = 123, [2] = 24, [3] = 28 }, [3] = { [0] = 106, [1] = 111, [2] = 8, [3] = 16 }, [4] = { [0] = 124, [1] = 126, [2] = 26, [3] = 32 }, [5] = { [0] = 116, [1] = 118, [2] = 22, [3] = 24 }, [6] = { [0] = 103, [1] = 105, [2] = 11, [3] = 11 }, [7] = { [0] = 120, [1] = 128, [2] = 28, [3] = 28 } })[R[10]][R[0]], ({ [0] = { [0] = 111, [1] = 9, [2] = 7, [3] = 112 }, [1] = { [0] = 107, [1] = 13, [2] = 11, [3] = 107 }, [2] = { [0] = 113, [1] = 10, [2] = 13, [3] = 114 }, [3] = { [0] = 105, [1] = 8, [2] = 7, [3] = 110 }, [4] = { [0] = 111, [1] = 14, [2] = 13, [3] = 117 }, [5] = { [0] = 106, [1] = 7, [2] = 8, [3] = 105 }, [6] = { [0] = 117, [1] = 17, [2] = 17, [3] = 123 }, [7] = { [0] = 117, [1] = 18, [2] = 15, [3] = 115 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 116, [1] = 116, [2] = 28, [3] = 32 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 104, [1] = 105, [2] = 6, [3] = 10 }, [3] = { [0] = 123, [1] = 128, [2] = 25, [3] = 33 }, [4] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [5] = { [0] = 104, [1] = 106, [2] = 10, [3] = 12 }, [6] = { [0] = 118, [1] = 120, [2] = 26, [3] = 26 }, [7] = { [0] = 119, [1] = 127, [2] = 27, [3] = 27 } })[R[10]][R[0]], ({ [0] = { [0] = 117, [1] = 15, [2] = 13, [3] = 118 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 116, [1] = 13, [2] = 16, [3] = 117 }, [3] = { [0] = 109, [1] = 12, [2] = 11, [3] = 114 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 114, [1] = 15, [2] = 16, [3] = 113 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 109, [1] = 10, [2] = 7, [3] = 107 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 116, [1] = 116, [2] = 28, [3] = 32 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 104, [1] = 105, [2] = 6, [3] = 10 }, [3] = { [0] = 121, [1] = 126, [2] = 23, [3] = 31 }, [4] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [5] = { [0] = 104, [1] = 106, [2] = 10, [3] = 12 }, [6] = { [0] = 118, [1] = 120, [2] = 26, [3] = 26 }, [7] = { [0] = 119, [1] = 127, [2] = 27, [3] = 27 } })[R[10]][R[0]], ({ [0] = { [0] = 117, [1] = 15, [2] = 13, [3] = 118 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 116, [1] = 13, [2] = 16, [3] = 117 }, [3] = { [0] = 105, [1] = 8, [2] = 7, [3] = 110 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 114, [1] = 15, [2] = 16, [3] = 113 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 109, [1] = 10, [2] = 7, [3] = 107 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 105, [1] = 105, [2] = 17, [3] = 21 }, [1] = { [0] = 100, [1] = 110, [2] = 3, [3] = 14 }, [2] = { [0] = 122, [1] = 123, [2] = 24, [3] = 28 }, [3] = { [0] = 109, [1] = 114, [2] = 11, [3] = 19 }, [4] = { [0] = 124, [1] = 126, [2] = 26, [3] = 32 }, [5] = { [0] = 116, [1] = 118, [2] = 22, [3] = 24 }, [6] = { [0] = 103, [1] = 105, [2] = 11, [3] = 11 }, [7] = { [0] = 120, [1] = 128, [2] = 28, [3] = 28 } })[R[10]][R[0]], ({ [0] = { [0] = 111, [1] = 9, [2] = 7, [3] = 112 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 113, [1] = 10, [2] = 13, [3] = 114 }, [3] = { [0] = 120, [1] = 23, [2] = 22, [3] = 125 }, [4] = { [0] = 111, [1] = 14, [2] = 13, [3] = 117 }, [5] = { [0] = 106, [1] = 7, [2] = 8, [3] = 105 }, [6] = { [0] = 117, [1] = 17, [2] = 17, [3] = 123 }, [7] = { [0] = 117, [1] = 18, [2] = 15, [3] = 115 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 105, [1] = 105, [2] = 17, [3] = 21 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 122, [1] = 123, [2] = 24, [3] = 28 }, [3] = { [0] = 109, [1] = 114, [2] = 11, [3] = 19 }, [4] = { [0] = 124, [1] = 126, [2] = 26, [3] = 32 }, [5] = { [0] = 116, [1] = 118, [2] = 22, [3] = 24 }, [6] = { [0] = 103, [1] = 105, [2] = 11, [3] = 11 }, [7] = { [0] = 120, [1] = 128, [2] = 28, [3] = 28 } })[R[10]][R[0]], ({ [0] = { [0] = 111, [1] = 9, [2] = 7, [3] = 112 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 113, [1] = 10, [2] = 13, [3] = 114 }, [3] = { [0] = 120, [1] = 23, [2] = 22, [3] = 125 }, [4] = { [0] = 111, [1] = 14, [2] = 13, [3] = 117 }, [5] = { [0] = 106, [1] = 7, [2] = 8, [3] = 105 }, [6] = { [0] = 117, [1] = 17, [2] = 17, [3] = 123 }, [7] = { [0] = 117, [1] = 18, [2] = 15, [3] = 115 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 116, [1] = 116, [2] = 28, [3] = 32 }, [1] = { [0] = 100, [1] = 110, [2] = 3, [3] = 14 }, [2] = { [0] = 104, [1] = 105, [2] = 6, [3] = 10 }, [3] = { [0] = 103, [1] = 108, [2] = 5, [3] = 13 }, [4] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [5] = { [0] = 104, [1] = 106, [2] = 10, [3] = 12 }, [6] = { [0] = 118, [1] = 120, [2] = 26, [3] = 26 }, [7] = { [0] = 119, [1] = 127, [2] = 27, [3] = 27 } })[R[10]][R[0]], ({ [0] = { [0] = 117, [1] = 15, [2] = 13, [3] = 118 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 116, [1] = 13, [2] = 16, [3] = 117 }, [3] = { [0] = 109, [1] = 12, [2] = 11, [3] = 114 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 114, [1] = 15, [2] = 16, [3] = 113 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 109, [1] = 10, [2] = 7, [3] = 107 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 102, [1] = 102, [2] = 14, [3] = 18 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 122, [1] = 123, [2] = 24, [3] = 28 }, [3] = { [0] = 103, [1] = 108, [2] = 5, [3] = 13 }, [4] = { [0] = 117, [1] = 119, [2] = 19, [3] = 25 }, [5] = { [0] = 103, [1] = 105, [2] = 9, [3] = 11 }, [6] = { [0] = 110, [1] = 112, [2] = 18, [3] = 18 }, [7] = { [0] = 104, [1] = 112, [2] = 12, [3] = 12 } })[R[10]][R[0]], ({ [0] = { [0] = 111, [1] = 9, [2] = 7, [3] = 112 }, [1] = { [0] = 103, [1] = 9, [2] = 7, [3] = 103 }, [2] = { [0] = 119, [1] = 16, [2] = 19, [3] = 120 }, [3] = { [0] = 109, [1] = 12, [2] = 11, [3] = 114 }, [4] = { [0] = 115, [1] = 18, [2] = 17, [3] = 121 }, [5] = { [0] = 103, [1] = 4, [2] = 5, [3] = 102 }, [6] = { [0] = 114, [1] = 14, [2] = 14, [3] = 120 }, [7] = { [0] = 115, [1] = 16, [2] = 13, [3] = 113 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 102, [1] = 102, [2] = 14, [3] = 18 }, [1] = { [0] = 106, [1] = 116, [2] = 9, [3] = 20 }, [2] = { [0] = 118, [1] = 119, [2] = 20, [3] = 24 }, [3] = { [0] = 109, [1] = 114, [2] = 11, [3] = 19 }, [4] = { [0] = 119, [1] = 121, [2] = 21, [3] = 27 }, [5] = { [0] = 112, [1] = 114, [2] = 18, [3] = 20 }, [6] = { [0] = 119, [1] = 121, [2] = 27, [3] = 27 }, [7] = { [0] = 99, [1] = 107, [2] = 7, [3] = 7 } })[R[10]][R[0]], ({ [0] = { [0] = 108, [1] = 6, [2] = 4, [3] = 109 }, [1] = { [0] = 100, [1] = 6, [2] = 4, [3] = 100 }, [2] = { [0] = 120, [1] = 17, [2] = 20, [3] = 121 }, [3] = { [0] = 120, [1] = 23, [2] = 22, [3] = 125 }, [4] = { [0] = 106, [1] = 9, [2] = 8, [3] = 112 }, [5] = { [0] = 111, [1] = 12, [2] = 13, [3] = 110 }, [6] = { [0] = 111, [1] = 11, [2] = 11, [3] = 117 }, [7] = { [0] = 112, [1] = 13, [2] = 10, [3] = 110 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 116, [1] = 116, [2] = 28, [3] = 32 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 104, [1] = 105, [2] = 6, [3] = 10 }, [3] = { [0] = 123, [1] = 128, [2] = 25, [3] = 33 }, [4] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [5] = { [0] = 104, [1] = 106, [2] = 10, [3] = 12 }, [6] = { [0] = 118, [1] = 120, [2] = 26, [3] = 26 }, [7] = { [0] = 119, [1] = 127, [2] = 27, [3] = 27 } })[R[10]][R[0]], ({ [0] = { [0] = 117, [1] = 15, [2] = 13, [3] = 118 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 116, [1] = 13, [2] = 16, [3] = 117 }, [3] = { [0] = 109, [1] = 12, [2] = 11, [3] = 114 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 114, [1] = 15, [2] = 16, [3] = 113 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 109, [1] = 10, [2] = 7, [3] = 107 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 116, [1] = 116, [2] = 28, [3] = 32 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 104, [1] = 105, [2] = 6, [3] = 10 }, [3] = { [0] = 121, [1] = 126, [2] = 23, [3] = 31 }, [4] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [5] = { [0] = 104, [1] = 106, [2] = 10, [3] = 12 }, [6] = { [0] = 118, [1] = 120, [2] = 26, [3] = 26 }, [7] = { [0] = 119, [1] = 127, [2] = 27, [3] = 27 } })[R[10]][R[0]], ({ [0] = { [0] = 117, [1] = 15, [2] = 13, [3] = 118 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 116, [1] = 13, [2] = 16, [3] = 117 }, [3] = { [0] = 105, [1] = 8, [2] = 7, [3] = 110 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 114, [1] = 15, [2] = 16, [3] = 113 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 109, [1] = 10, [2] = 7, [3] = 107 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 102, [1] = 102, [2] = 14, [3] = 18 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 122, [1] = 123, [2] = 24, [3] = 28 }, [3] = { [0] = 109, [1] = 114, [2] = 11, [3] = 19 }, [4] = { [0] = 117, [1] = 119, [2] = 19, [3] = 25 }, [5] = { [0] = 103, [1] = 105, [2] = 9, [3] = 11 }, [6] = { [0] = 110, [1] = 112, [2] = 18, [3] = 18 }, [7] = { [0] = 104, [1] = 112, [2] = 12, [3] = 12 } })[R[10]][R[0]], ({ [0] = { [0] = 111, [1] = 9, [2] = 7, [3] = 112 }, [1] = { [0] = 103, [1] = 9, [2] = 7, [3] = 103 }, [2] = { [0] = 119, [1] = 16, [2] = 19, [3] = 120 }, [3] = { [0] = 120, [1] = 23, [2] = 22, [3] = 125 }, [4] = { [0] = 115, [1] = 18, [2] = 17, [3] = 121 }, [5] = { [0] = 103, [1] = 4, [2] = 5, [3] = 102 }, [6] = { [0] = 114, [1] = 14, [2] = 14, [3] = 120 }, [7] = { [0] = 115, [1] = 16, [2] = 13, [3] = 113 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 102, [1] = 102, [2] = 14, [3] = 18 }, [1] = { [0] = 106, [1] = 116, [2] = 9, [3] = 20 }, [2] = { [0] = 118, [1] = 119, [2] = 20, [3] = 24 }, [3] = { [0] = 109, [1] = 114, [2] = 11, [3] = 19 }, [4] = { [0] = 119, [1] = 121, [2] = 21, [3] = 27 }, [5] = { [0] = 112, [1] = 114, [2] = 18, [3] = 20 }, [6] = { [0] = 119, [1] = 121, [2] = 27, [3] = 27 }, [7] = { [0] = 99, [1] = 107, [2] = 7, [3] = 7 } })[R[10]][R[0]], ({ [0] = { [0] = 108, [1] = 6, [2] = 4, [3] = 109 }, [1] = { [0] = 100, [1] = 6, [2] = 4, [3] = 100 }, [2] = { [0] = 120, [1] = 17, [2] = 20, [3] = 121 }, [3] = { [0] = 120, [1] = 23, [2] = 22, [3] = 125 }, [4] = { [0] = 106, [1] = 9, [2] = 8, [3] = 112 }, [5] = { [0] = 111, [1] = 12, [2] = 13, [3] = 110 }, [6] = { [0] = 111, [1] = 11, [2] = 11, [3] = 117 }, [7] = { [0] = 112, [1] = 13, [2] = 10, [3] = 110 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 116, [1] = 116, [2] = 28, [3] = 32 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 104, [1] = 105, [2] = 6, [3] = 10 }, [3] = { [0] = 123, [1] = 128, [2] = 25, [3] = 33 }, [4] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [5] = { [0] = 104, [1] = 106, [2] = 10, [3] = 12 }, [6] = { [0] = 118, [1] = 120, [2] = 26, [3] = 26 }, [7] = { [0] = 119, [1] = 127, [2] = 27, [3] = 27 } })[R[10]][R[0]], ({ [0] = { [0] = 117, [1] = 15, [2] = 13, [3] = 118 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 116, [1] = 13, [2] = 16, [3] = 117 }, [3] = { [0] = 109, [1] = 12, [2] = 11, [3] = 114 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 114, [1] = 15, [2] = 16, [3] = 113 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 109, [1] = 10, [2] = 7, [3] = 107 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 116, [1] = 116, [2] = 28, [3] = 32 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 104, [1] = 105, [2] = 6, [3] = 10 }, [3] = { [0] = 121, [1] = 126, [2] = 23, [3] = 31 }, [4] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [5] = { [0] = 104, [1] = 106, [2] = 10, [3] = 12 }, [6] = { [0] = 118, [1] = 120, [2] = 26, [3] = 26 }, [7] = { [0] = 119, [1] = 127, [2] = 27, [3] = 27 } })[R[10]][R[0]], ({ [0] = { [0] = 117, [1] = 15, [2] = 13, [3] = 118 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 116, [1] = 13, [2] = 16, [3] = 117 }, [3] = { [0] = 105, [1] = 8, [2] = 7, [3] = 110 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 114, [1] = 15, [2] = 16, [3] = 113 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 109, [1] = 10, [2] = 7, [3] = 107 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 105, [1] = 105, [2] = 17, [3] = 21 }, [1] = { [0] = 100, [1] = 110, [2] = 3, [3] = 14 }, [2] = { [0] = 122, [1] = 123, [2] = 24, [3] = 28 }, [3] = { [0] = 109, [1] = 114, [2] = 11, [3] = 19 }, [4] = { [0] = 124, [1] = 126, [2] = 26, [3] = 32 }, [5] = { [0] = 116, [1] = 118, [2] = 22, [3] = 24 }, [6] = { [0] = 103, [1] = 105, [2] = 11, [3] = 11 }, [7] = { [0] = 120, [1] = 128, [2] = 28, [3] = 28 } })[R[10]][R[0]], ({ [0] = { [0] = 111, [1] = 9, [2] = 7, [3] = 112 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 113, [1] = 10, [2] = 13, [3] = 114 }, [3] = { [0] = 120, [1] = 23, [2] = 22, [3] = 125 }, [4] = { [0] = 111, [1] = 14, [2] = 13, [3] = 117 }, [5] = { [0] = 106, [1] = 7, [2] = 8, [3] = 105 }, [6] = { [0] = 117, [1] = 17, [2] = 17, [3] = 123 }, [7] = { [0] = 117, [1] = 18, [2] = 15, [3] = 115 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 116, [1] = 116, [2] = 28, [3] = 32 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 104, [1] = 105, [2] = 6, [3] = 10 }, [3] = { [0] = 109, [1] = 114, [2] = 11, [3] = 19 }, [4] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [5] = { [0] = 104, [1] = 106, [2] = 10, [3] = 12 }, [6] = { [0] = 118, [1] = 120, [2] = 26, [3] = 26 }, [7] = { [0] = 119, [1] = 127, [2] = 27, [3] = 27 } })[R[10]][R[0]], ({ [0] = { [0] = 117, [1] = 15, [2] = 13, [3] = 118 }, [1] = { [0] = 109, [1] = 15, [2] = 13, [3] = 109 }, [2] = { [0] = 116, [1] = 13, [2] = 16, [3] = 117 }, [3] = { [0] = 120, [1] = 23, [2] = 22, [3] = 125 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 114, [1] = 15, [2] = 16, [3] = 113 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 109, [1] = 10, [2] = 7, [3] = 107 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 102, [1] = 102, [2] = 14, [3] = 18 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 122, [1] = 123, [2] = 24, [3] = 28 }, [3] = { [0] = 103, [1] = 108, [2] = 5, [3] = 13 }, [4] = { [0] = 117, [1] = 119, [2] = 19, [3] = 25 }, [5] = { [0] = 103, [1] = 105, [2] = 9, [3] = 11 }, [6] = { [0] = 110, [1] = 112, [2] = 18, [3] = 18 }, [7] = { [0] = 104, [1] = 112, [2] = 12, [3] = 12 } })[R[10]][R[0]], ({ [0] = { [0] = 111, [1] = 9, [2] = 7, [3] = 112 }, [1] = { [0] = 103, [1] = 9, [2] = 7, [3] = 103 }, [2] = { [0] = 119, [1] = 16, [2] = 19, [3] = 120 }, [3] = { [0] = 109, [1] = 12, [2] = 11, [3] = 114 }, [4] = { [0] = 115, [1] = 18, [2] = 17, [3] = 121 }, [5] = { [0] = 103, [1] = 4, [2] = 5, [3] = 102 }, [6] = { [0] = 114, [1] = 14, [2] = 14, [3] = 120 }, [7] = { [0] = 115, [1] = 16, [2] = 13, [3] = 113 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 102, [1] = 102, [2] = 14, [3] = 18 }, [1] = { [0] = 106, [1] = 116, [2] = 9, [3] = 20 }, [2] = { [0] = 118, [1] = 119, [2] = 20, [3] = 24 }, [3] = { [0] = 109, [1] = 114, [2] = 11, [3] = 19 }, [4] = { [0] = 119, [1] = 121, [2] = 21, [3] = 27 }, [5] = { [0] = 112, [1] = 114, [2] = 18, [3] = 20 }, [6] = { [0] = 119, [1] = 121, [2] = 27, [3] = 27 }, [7] = { [0] = 99, [1] = 107, [2] = 7, [3] = 7 } })[R[10]][R[0]], ({ [0] = { [0] = 108, [1] = 6, [2] = 4, [3] = 109 }, [1] = { [0] = 100, [1] = 6, [2] = 4, [3] = 100 }, [2] = { [0] = 120, [1] = 17, [2] = 20, [3] = 121 }, [3] = { [0] = 120, [1] = 23, [2] = 22, [3] = 125 }, [4] = { [0] = 106, [1] = 9, [2] = 8, [3] = 112 }, [5] = { [0] = 111, [1] = 12, [2] = 13, [3] = 110 }, [6] = { [0] = 111, [1] = 11, [2] = 11, [3] = 117 }, [7] = { [0] = 112, [1] = 13, [2] = 10, [3] = 110 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 123, [1] = 123, [2] = 35, [3] = 39 }, [1] = { [0] = 109, [1] = 119, [2] = 12, [3] = 23 }, [2] = { [0] = 114, [1] = 115, [2] = 16, [3] = 20 }, [3] = { [0] = 113, [1] = 118, [2] = 15, [3] = 23 }, [4] = { [0] = 125, [1] = 127, [2] = 27, [3] = 33 }, [5] = { [0] = 104, [1] = 106, [2] = 10, [3] = 12 }, [6] = { [0] = 119, [1] = 121, [2] = 27, [3] = 27 }, [7] = { [0] = 113, [1] = 121, [2] = 21, [3] = 21 } })[R[10]][R[0]], ({ [0] = { [0] = 119, [1] = 17, [2] = 15, [3] = 120 }, [1] = { [0] = 113, [1] = 19, [2] = 17, [3] = 113 }, [2] = { [0] = 113, [1] = 10, [2] = 13, [3] = 114 }, [3] = { [0] = 106, [1] = 9, [2] = 8, [3] = 111 }, [4] = { [0] = 102, [1] = 5, [2] = 4, [3] = 108 }, [5] = { [0] = 120, [1] = 21, [2] = 22, [3] = 119 }, [6] = { [0] = 114, [1] = 14, [2] = 14, [3] = 120 }, [7] = { [0] = 114, [1] = 15, [2] = 12, [3] = 112 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 103, [1] = 103, [2] = 15, [3] = 19 }, [1] = { [0] = 103, [1] = 113, [2] = 6, [3] = 17 }, [2] = { [0] = 109, [1] = 110, [2] = 11, [3] = 15 }, [3] = { [0] = 105, [1] = 110, [2] = 7, [3] = 15 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 108, [1] = 110, [2] = 14, [3] = 16 }, [6] = { [0] = 105, [1] = 107, [2] = 13, [3] = 13 }, [7] = { [0] = 102, [1] = 110, [2] = 10, [3] = 10 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 114, [1] = 20, [2] = 18, [3] = 114 }, [2] = { [0] = 111, [1] = 8, [2] = 11, [3] = 112 }, [3] = { [0] = 115, [1] = 18, [2] = 17, [3] = 120 }, [4] = { [0] = 105, [1] = 8, [2] = 7, [3] = 111 }, [5] = { [0] = 109, [1] = 10, [2] = 11, [3] = 108 }, [6] = { [0] = 106, [1] = 6, [2] = 6, [3] = 112 }, [7] = { [0] = 111, [1] = 12, [2] = 9, [3] = 109 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 104, [1] = 104, [2] = 16, [3] = 20 }, [1] = { [0] = 104, [1] = 114, [2] = 7, [3] = 18 }, [2] = { [0] = 110, [1] = 111, [2] = 12, [3] = 16 }, [3] = { [0] = 105, [1] = 110, [2] = 7, [3] = 15 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 108, [1] = 110, [2] = 14, [3] = 16 }, [6] = { [0] = 105, [1] = 107, [2] = 13, [3] = 13 }, [7] = { [0] = 102, [1] = 110, [2] = 10, [3] = 10 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 114, [1] = 20, [2] = 18, [3] = 114 }, [2] = { [0] = 111, [1] = 8, [2] = 11, [3] = 112 }, [3] = { [0] = 116, [1] = 19, [2] = 18, [3] = 121 }, [4] = { [0] = 106, [1] = 9, [2] = 8, [3] = 112 }, [5] = { [0] = 110, [1] = 11, [2] = 12, [3] = 109 }, [6] = { [0] = 107, [1] = 7, [2] = 7, [3] = 113 }, [7] = { [0] = 112, [1] = 13, [2] = 10, [3] = 110 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 105, [1] = 105, [2] = 17, [3] = 21 }, [1] = { [0] = 105, [1] = 115, [2] = 8, [3] = 19 }, [2] = { [0] = 111, [1] = 112, [2] = 13, [3] = 17 }, [3] = { [0] = 105, [1] = 110, [2] = 7, [3] = 15 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 108, [1] = 110, [2] = 14, [3] = 16 }, [6] = { [0] = 105, [1] = 107, [2] = 13, [3] = 13 }, [7] = { [0] = 102, [1] = 110, [2] = 10, [3] = 10 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 114, [1] = 20, [2] = 18, [3] = 114 }, [2] = { [0] = 111, [1] = 8, [2] = 11, [3] = 112 }, [3] = { [0] = 117, [1] = 20, [2] = 19, [3] = 122 }, [4] = { [0] = 107, [1] = 10, [2] = 9, [3] = 113 }, [5] = { [0] = 111, [1] = 12, [2] = 13, [3] = 110 }, [6] = { [0] = 108, [1] = 8, [2] = 8, [3] = 114 }, [7] = { [0] = 113, [1] = 14, [2] = 11, [3] = 111 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 106, [1] = 106, [2] = 18, [3] = 22 }, [1] = { [0] = 106, [1] = 116, [2] = 9, [3] = 20 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 106, [1] = 111, [2] = 8, [3] = 16 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 108, [1] = 110, [2] = 14, [3] = 16 }, [6] = { [0] = 105, [1] = 107, [2] = 13, [3] = 13 }, [7] = { [0] = 102, [1] = 110, [2] = 10, [3] = 10 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 114, [1] = 20, [2] = 18, [3] = 114 }, [2] = { [0] = 108, [1] = 5, [2] = 8, [3] = 109 }, [3] = { [0] = 115, [1] = 18, [2] = 17, [3] = 120 }, [4] = { [0] = 108, [1] = 11, [2] = 10, [3] = 114 }, [5] = { [0] = 115, [1] = 16, [2] = 17, [3] = 114 }, [6] = { [0] = 109, [1] = 9, [2] = 9, [3] = 115 }, [7] = { [0] = 114, [1] = 15, [2] = 12, [3] = 112 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 107, [1] = 107, [2] = 19, [3] = 23 }, [1] = { [0] = 107, [1] = 117, [2] = 10, [3] = 21 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 107, [1] = 112, [2] = 9, [3] = 17 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 108, [1] = 110, [2] = 14, [3] = 16 }, [6] = { [0] = 105, [1] = 107, [2] = 13, [3] = 13 }, [7] = { [0] = 102, [1] = 110, [2] = 10, [3] = 10 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 114, [1] = 20, [2] = 18, [3] = 114 }, [2] = { [0] = 109, [1] = 6, [2] = 9, [3] = 110 }, [3] = { [0] = 111, [1] = 14, [2] = 13, [3] = 116 }, [4] = { [0] = 109, [1] = 12, [2] = 11, [3] = 115 }, [5] = { [0] = 116, [1] = 17, [2] = 18, [3] = 115 }, [6] = { [0] = 110, [1] = 10, [2] = 10, [3] = 116 }, [7] = { [0] = 115, [1] = 16, [2] = 13, [3] = 113 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 108, [1] = 108, [2] = 20, [3] = 24 }, [1] = { [0] = 108, [1] = 118, [2] = 11, [3] = 22 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 107, [1] = 112, [2] = 9, [3] = 17 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 108, [1] = 110, [2] = 14, [3] = 16 }, [6] = { [0] = 108, [1] = 110, [2] = 16, [3] = 16 }, [7] = { [0] = 102, [1] = 110, [2] = 10, [3] = 10 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 114, [1] = 20, [2] = 18, [3] = 114 }, [2] = { [0] = 110, [1] = 7, [2] = 10, [3] = 111 }, [3] = { [0] = 112, [1] = 15, [2] = 14, [3] = 117 }, [4] = { [0] = 113, [1] = 16, [2] = 15, [3] = 119 }, [5] = { [0] = 117, [1] = 18, [2] = 19, [3] = 116 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 116, [1] = 17, [2] = 14, [3] = 114 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 109, [1] = 109, [2] = 21, [3] = 25 }, [1] = { [0] = 109, [1] = 119, [2] = 12, [3] = 23 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 107, [1] = 112, [2] = 9, [3] = 17 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 111, [1] = 113, [2] = 17, [3] = 19 }, [6] = { [0] = 109, [1] = 111, [2] = 17, [3] = 17 }, [7] = { [0] = 102, [1] = 110, [2] = 10, [3] = 10 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 114, [1] = 20, [2] = 18, [3] = 114 }, [2] = { [0] = 111, [1] = 8, [2] = 11, [3] = 112 }, [3] = { [0] = 113, [1] = 16, [2] = 15, [3] = 118 }, [4] = { [0] = 114, [1] = 17, [2] = 16, [3] = 120 }, [5] = { [0] = 113, [1] = 14, [2] = 15, [3] = 112 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 117, [1] = 18, [2] = 15, [3] = 115 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 110, [1] = 120, [2] = 13, [3] = 24 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 107, [1] = 112, [2] = 9, [3] = 17 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 111, [1] = 113, [2] = 17, [3] = 19 }, [6] = { [0] = 109, [1] = 111, [2] = 17, [3] = 17 }, [7] = { [0] = 102, [1] = 110, [2] = 10, [3] = 10 } })[R[10]][R[0]], ({ [0] = { [0] = 110, [1] = 8, [2] = 6, [3] = 111 }, [1] = { [0] = 103, [1] = 9, [2] = 7, [3] = 103 }, [2] = { [0] = 112, [1] = 9, [2] = 12, [3] = 113 }, [3] = { [0] = 114, [1] = 17, [2] = 16, [3] = 119 }, [4] = { [0] = 115, [1] = 18, [2] = 17, [3] = 121 }, [5] = { [0] = 119, [1] = 20, [2] = 21, [3] = 118 }, [6] = { [0] = 112, [1] = 12, [2] = 12, [3] = 118 }, [7] = { [0] = 118, [1] = 19, [2] = 16, [3] = 116 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 110, [1] = 120, [2] = 13, [3] = 24 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 107, [1] = 112, [2] = 9, [3] = 17 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 112, [1] = 114, [2] = 18, [3] = 20 }, [6] = { [0] = 110, [1] = 112, [2] = 18, [3] = 18 }, [7] = { [0] = 102, [1] = 110, [2] = 10, [3] = 10 } })[R[10]][R[0]], ({ [0] = { [0] = 111, [1] = 9, [2] = 7, [3] = 112 }, [1] = { [0] = 104, [1] = 10, [2] = 8, [3] = 104 }, [2] = { [0] = 113, [1] = 10, [2] = 13, [3] = 114 }, [3] = { [0] = 115, [1] = 18, [2] = 17, [3] = 120 }, [4] = { [0] = 116, [1] = 19, [2] = 18, [3] = 122 }, [5] = { [0] = 113, [1] = 14, [2] = 15, [3] = 112 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 119, [1] = 20, [2] = 17, [3] = 117 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 110, [1] = 120, [2] = 13, [3] = 24 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 108, [1] = 113, [2] = 10, [3] = 18 }, [4] = { [0] = 112, [1] = 114, [2] = 14, [3] = 20 }, [5] = { [0] = 112, [1] = 114, [2] = 18, [3] = 20 }, [6] = { [0] = 110, [1] = 112, [2] = 18, [3] = 18 }, [7] = { [0] = 105, [1] = 113, [2] = 13, [3] = 13 } })[R[10]][R[0]], ({ [0] = { [0] = 112, [1] = 10, [2] = 8, [3] = 113 }, [1] = { [0] = 105, [1] = 11, [2] = 9, [3] = 105 }, [2] = { [0] = 114, [1] = 11, [2] = 14, [3] = 115 }, [3] = { [0] = 111, [1] = 14, [2] = 13, [3] = 116 }, [4] = { [0] = 117, [1] = 20, [2] = 19, [3] = 123 }, [5] = { [0] = 119, [1] = 20, [2] = 21, [3] = 118 }, [6] = { [0] = 112, [1] = 12, [2] = 12, [3] = 118 }, [7] = { [0] = 108, [1] = 9, [2] = 6, [3] = 106 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 110, [1] = 120, [2] = 13, [3] = 24 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 108, [1] = 113, [2] = 10, [3] = 18 }, [4] = { [0] = 115, [1] = 117, [2] = 17, [3] = 23 }, [5] = { [0] = 113, [1] = 115, [2] = 19, [3] = 21 }, [6] = { [0] = 111, [1] = 113, [2] = 19, [3] = 19 }, [7] = { [0] = 105, [1] = 113, [2] = 13, [3] = 13 } })[R[10]][R[0]], ({ [0] = { [0] = 113, [1] = 11, [2] = 9, [3] = 114 }, [1] = { [0] = 106, [1] = 12, [2] = 10, [3] = 106 }, [2] = { [0] = 115, [1] = 12, [2] = 15, [3] = 116 }, [3] = { [0] = 115, [1] = 18, [2] = 17, [3] = 120 }, [4] = { [0] = 103, [1] = 6, [2] = 5, [3] = 109 }, [5] = { [0] = 113, [1] = 14, [2] = 15, [3] = 112 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 121, [1] = 22, [2] = 19, [3] = 119 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 110, [1] = 120, [2] = 13, [3] = 24 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 109, [1] = 114, [2] = 11, [3] = 19 }, [4] = { [0] = 115, [1] = 117, [2] = 17, [3] = 23 }, [5] = { [0] = 113, [1] = 115, [2] = 19, [3] = 21 }, [6] = { [0] = 111, [1] = 113, [2] = 19, [3] = 19 }, [7] = { [0] = 106, [1] = 114, [2] = 14, [3] = 14 } })[R[10]][R[0]], ({ [0] = { [0] = 117, [1] = 15, [2] = 13, [3] = 118 }, [1] = { [0] = 114, [1] = 20, [2] = 18, [3] = 114 }, [2] = { [0] = 116, [1] = 13, [2] = 16, [3] = 117 }, [3] = { [0] = 115, [1] = 18, [2] = 17, [3] = 120 }, [4] = { [0] = 111, [1] = 14, [2] = 13, [3] = 117 }, [5] = { [0] = 119, [1] = 20, [2] = 21, [3] = 118 }, [6] = { [0] = 112, [1] = 12, [2] = 12, [3] = 118 }, [7] = { [0] = 108, [1] = 9, [2] = 6, [3] = 106 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 111, [1] = 121, [2] = 14, [3] = 25 }, [2] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [3] = { [0] = 110, [1] = 115, [2] = 12, [3] = 20 }, [4] = { [0] = 115, [1] = 117, [2] = 17, [3] = 23 }, [5] = { [0] = 114, [1] = 116, [2] = 20, [3] = 22 }, [6] = { [0] = 112, [1] = 114, [2] = 20, [3] = 20 }, [7] = { [0] = 106, [1] = 114, [2] = 14, [3] = 14 } })[R[10]][R[0]], ({ [0] = { [0] = 118, [1] = 16, [2] = 14, [3] = 119 }, [1] = { [0] = 111, [1] = 17, [2] = 15, [3] = 111 }, [2] = { [0] = 117, [1] = 14, [2] = 17, [3] = 118 }, [3] = { [0] = 115, [1] = 18, [2] = 17, [3] = 120 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 113, [1] = 14, [2] = 15, [3] = 112 }, [6] = { [0] = 104, [1] = 4, [2] = 4, [3] = 110 }, [7] = { [0] = 121, [1] = 22, [2] = 19, [3] = 119 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 111, [1] = 121, [2] = 14, [3] = 25 }, [2] = { [0] = 113, [1] = 114, [2] = 15, [3] = 19 }, [3] = { [0] = 111, [1] = 116, [2] = 13, [3] = 21 }, [4] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [5] = { [0] = 114, [1] = 116, [2] = 20, [3] = 22 }, [6] = { [0] = 112, [1] = 114, [2] = 20, [3] = 20 }, [7] = { [0] = 107, [1] = 115, [2] = 15, [3] = 15 } })[R[10]][R[0]], ({ [0] = { [0] = 119, [1] = 17, [2] = 15, [3] = 120 }, [1] = { [0] = 112, [1] = 18, [2] = 16, [3] = 112 }, [2] = { [0] = 111, [1] = 8, [2] = 11, [3] = 112 }, [3] = { [0] = 108, [1] = 11, [2] = 10, [3] = 113 }, [4] = { [0] = 103, [1] = 6, [2] = 5, [3] = 109 }, [5] = { [0] = 119, [1] = 20, [2] = 21, [3] = 118 }, [6] = { [0] = 112, [1] = 12, [2] = 12, [3] = 118 }, [7] = { [0] = 108, [1] = 9, [2] = 6, [3] = 106 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 111, [1] = 111, [2] = 23, [3] = 27 }, [1] = { [0] = 111, [1] = 121, [2] = 14, [3] = 25 }, [2] = { [0] = 113, [1] = 114, [2] = 15, [3] = 19 }, [3] = { [0] = 111, [1] = 116, [2] = 13, [3] = 21 }, [4] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [5] = { [0] = 115, [1] = 117, [2] = 21, [3] = 23 }, [6] = { [0] = 114, [1] = 116, [2] = 22, [3] = 22 }, [7] = { [0] = 107, [1] = 115, [2] = 15, [3] = 15 } })[R[10]][R[0]], ({ [0] = { [0] = 120, [1] = 18, [2] = 16, [3] = 121 }, [1] = { [0] = 113, [1] = 19, [2] = 17, [3] = 113 }, [2] = { [0] = 117, [1] = 14, [2] = 17, [3] = 118 }, [3] = { [0] = 115, [1] = 18, [2] = 17, [3] = 120 }, [4] = { [0] = 111, [1] = 14, [2] = 13, [3] = 117 }, [5] = { [0] = 113, [1] = 14, [2] = 15, [3] = 112 }, [6] = { [0] = 106, [1] = 6, [2] = 6, [3] = 112 }, [7] = { [0] = 121, [1] = 22, [2] = 19, [3] = 119 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 114, [1] = 114, [2] = 26, [3] = 30 }, [1] = { [0] = 111, [1] = 121, [2] = 14, [3] = 25 }, [2] = { [0] = 114, [1] = 115, [2] = 16, [3] = 20 }, [3] = { [0] = 112, [1] = 117, [2] = 14, [3] = 22 }, [4] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [5] = { [0] = 115, [1] = 117, [2] = 21, [3] = 23 }, [6] = { [0] = 114, [1] = 116, [2] = 22, [3] = 22 }, [7] = { [0] = 108, [1] = 116, [2] = 16, [3] = 16 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 114, [1] = 20, [2] = 18, [3] = 114 }, [2] = { [0] = 111, [1] = 8, [2] = 11, [3] = 112 }, [3] = { [0] = 108, [1] = 11, [2] = 10, [3] = 113 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 119, [1] = 20, [2] = 21, [3] = 118 }, [6] = { [0] = 107, [1] = 7, [2] = 7, [3] = 113 }, [7] = { [0] = 108, [1] = 9, [2] = 6, [3] = 106 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 115, [1] = 115, [2] = 27, [3] = 31 }, [1] = { [0] = 111, [1] = 121, [2] = 14, [3] = 25 }, [2] = { [0] = 114, [1] = 115, [2] = 16, [3] = 20 }, [3] = { [0] = 113, [1] = 118, [2] = 15, [3] = 23 }, [4] = { [0] = 117, [1] = 119, [2] = 19, [3] = 25 }, [5] = { [0] = 116, [1] = 118, [2] = 22, [3] = 24 }, [6] = { [0] = 114, [1] = 116, [2] = 22, [3] = 22 }, [7] = { [0] = 108, [1] = 116, [2] = 16, [3] = 16 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 115, [1] = 21, [2] = 19, [3] = 115 }, [2] = { [0] = 117, [1] = 14, [2] = 17, [3] = 118 }, [3] = { [0] = 108, [1] = 11, [2] = 10, [3] = 113 }, [4] = { [0] = 103, [1] = 6, [2] = 5, [3] = 109 }, [5] = { [0] = 113, [1] = 14, [2] = 15, [3] = 112 }, [6] = { [0] = 108, [1] = 8, [2] = 8, [3] = 114 }, [7] = { [0] = 121, [1] = 22, [2] = 19, [3] = 119 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 116, [1] = 116, [2] = 28, [3] = 32 }, [1] = { [0] = 111, [1] = 121, [2] = 14, [3] = 25 }, [2] = { [0] = 115, [1] = 116, [2] = 17, [3] = 21 }, [3] = { [0] = 114, [1] = 119, [2] = 16, [3] = 24 }, [4] = { [0] = 117, [1] = 119, [2] = 19, [3] = 25 }, [5] = { [0] = 117, [1] = 119, [2] = 23, [3] = 25 }, [6] = { [0] = 114, [1] = 116, [2] = 22, [3] = 22 }, [7] = { [0] = 109, [1] = 117, [2] = 17, [3] = 17 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 116, [1] = 22, [2] = 20, [3] = 116 }, [2] = { [0] = 111, [1] = 8, [2] = 11, [3] = 112 }, [3] = { [0] = 108, [1] = 11, [2] = 10, [3] = 113 }, [4] = { [0] = 104, [1] = 7, [2] = 6, [3] = 110 }, [5] = { [0] = 113, [1] = 14, [2] = 15, [3] = 112 }, [6] = { [0] = 109, [1] = 9, [2] = 9, [3] = 115 }, [7] = { [0] = 108, [1] = 9, [2] = 6, [3] = 106 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 117, [1] = 117, [2] = 29, [3] = 33 }, [1] = { [0] = 111, [1] = 121, [2] = 14, [3] = 25 }, [2] = { [0] = 115, [1] = 116, [2] = 17, [3] = 21 }, [3] = { [0] = 115, [1] = 120, [2] = 17, [3] = 25 }, [4] = { [0] = 117, [1] = 119, [2] = 19, [3] = 25 }, [5] = { [0] = 118, [1] = 120, [2] = 24, [3] = 26 }, [6] = { [0] = 114, [1] = 116, [2] = 22, [3] = 22 }, [7] = { [0] = 109, [1] = 117, [2] = 17, [3] = 17 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 121, [1] = 27, [2] = 25, [3] = 121 }, [2] = { [0] = 117, [1] = 14, [2] = 17, [3] = 118 }, [3] = { [0] = 108, [1] = 11, [2] = 10, [3] = 113 }, [4] = { [0] = 111, [1] = 14, [2] = 13, [3] = 117 }, [5] = { [0] = 113, [1] = 14, [2] = 15, [3] = 112 }, [6] = { [0] = 110, [1] = 10, [2] = 10, [3] = 116 }, [7] = { [0] = 109, [1] = 10, [2] = 7, [3] = 107 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 118, [1] = 118, [2] = 30, [3] = 34 }, [1] = { [0] = 111, [1] = 121, [2] = 14, [3] = 25 }, [2] = { [0] = 116, [1] = 117, [2] = 18, [3] = 22 }, [3] = { [0] = 116, [1] = 121, [2] = 18, [3] = 26 }, [4] = { [0] = 117, [1] = 119, [2] = 19, [3] = 25 }, [5] = { [0] = 118, [1] = 120, [2] = 24, [3] = 26 }, [6] = { [0] = 118, [1] = 120, [2] = 26, [3] = 26 }, [7] = { [0] = 109, [1] = 117, [2] = 17, [3] = 17 } })[R[10]][R[0]], ({ [0] = { [0] = 115, [1] = 13, [2] = 11, [3] = 116 }, [1] = { [0] = 122, [1] = 28, [2] = 26, [3] = 122 }, [2] = { [0] = 111, [1] = 8, [2] = 11, [3] = 112 }, [3] = { [0] = 108, [1] = 11, [2] = 10, [3] = 113 }, [4] = { [0] = 119, [1] = 22, [2] = 21, [3] = 125 }, [5] = { [0] = 114, [1] = 15, [2] = 16, [3] = 113 }, [6] = { [0] = 112, [1] = 12, [2] = 12, [3] = 118 }, [7] = { [0] = 110, [1] = 11, [2] = 8, [3] = 108 } })[R[10]][R[0]] })
    if R[10] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 119, [1] = 119, [2] = 31, [3] = 35 })[R[0]], ({ [0] = 115, [1] = 13, [2] = 11, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 120, [2] = 32, [3] = 36 })[R[0]], ({ [0] = 115, [1] = 13, [2] = 11, [3] = 116 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 119, [1] = 119, [2] = 31, [3] = 35 })[R[0]], ({ [0] = 115, [1] = 13, [2] = 11, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 120, [2] = 32, [3] = 36 })[R[0]], ({ [0] = 115, [1] = 13, [2] = 11, [3] = 116 })[R[0]] })
        for i = 1, game.initial_units() do
          R[11] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 117, [2] = 29, [3] = 33 }, [1] = { [0] = 104, [1] = 104, [2] = 16, [3] = 20 }, [2] = { [0] = 116, [1] = 116, [2] = 28, [3] = 32 } })[R[11]][R[0]], ({ [0] = { [0] = 109, [1] = 7, [2] = 5, [3] = 110 }, [1] = { [0] = 118, [1] = 16, [2] = 14, [3] = 119 }, [2] = { [0] = 121, [1] = 19, [2] = 17, [3] = 122 } })[R[11]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 111, [1] = 121, [2] = 14, [3] = 25 })[R[0]], ({ [0] = 123, [1] = 29, [2] = 27, [3] = 123 })[R[0]] })
        game.create_tube({ ({ [0] = 111, [1] = 121, [2] = 14, [3] = 25 })[R[0]], ({ [0] = 123, [1] = 29, [2] = 27, [3] = 123 })[R[0]] })
        game.create_tube({ ({ [0] = 111, [1] = 121, [2] = 14, [3] = 25 })[R[0]], ({ [0] = 124, [1] = 30, [2] = 28, [3] = 124 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 111, [1] = 121, [2] = 14, [3] = 25 })[R[0]], ({ [0] = 123, [1] = 29, [2] = 27, [3] = 123 })[R[0]] })
        game.create_tube({ ({ [0] = 111, [1] = 121, [2] = 14, [3] = 25 })[R[0]], ({ [0] = 123, [1] = 29, [2] = 27, [3] = 123 })[R[0]] })
        game.create_tube({ ({ [0] = 111, [1] = 121, [2] = 14, [3] = 25 })[R[0]], ({ [0] = 124, [1] = 30, [2] = 28, [3] = 124 })[R[0]] })
        for i = 1, game.initial_units() do
          R[12] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 102, [1] = 112, [2] = 5, [3] = 16 }, [1] = { [0] = 104, [1] = 114, [2] = 7, [3] = 18 }, [2] = { [0] = 106, [1] = 116, [2] = 9, [3] = 20 } })[R[12]][R[0]], ({ [0] = { [0] = 118, [1] = 24, [2] = 22, [3] = 118 }, [1] = { [0] = 120, [1] = 26, [2] = 24, [3] = 120 }, [2] = { [0] = 112, [1] = 18, [2] = 16, [3] = 112 } })[R[12]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[13] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 107, [1] = 108, [2] = 9, [3] = 13 }, [1] = { [0] = 112, [1] = 113, [2] = 14, [3] = 18 }, [2] = { [0] = 125, [1] = 126, [2] = 27, [3] = 31 } })[R[13]][R[0]], ({ [0] = { [0] = 105, [1] = 2, [2] = 5, [3] = 106 }, [1] = { [0] = 121, [1] = 18, [2] = 21, [3] = 122 }, [2] = { [0] = 114, [1] = 11, [2] = 14, [3] = 115 } })[R[13]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 116, [1] = 121, [2] = 18, [3] = 26 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 19, [3] = 27 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 123, [2] = 20, [3] = 28 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 124, [2] = 21, [3] = 29 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 124, [2] = 21, [3] = 29 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 125, [2] = 22, [3] = 30 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 125, [2] = 22, [3] = 30 })[R[0]], ({ [0] = 112, [1] = 15, [2] = 14, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 125, [2] = 22, [3] = 30 })[R[0]], ({ [0] = 113, [1] = 16, [2] = 15, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 125, [2] = 22, [3] = 30 })[R[0]], ({ [0] = 114, [1] = 17, [2] = 16, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 125, [2] = 22, [3] = 30 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 126, [2] = 23, [3] = 31 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 126, [2] = 23, [3] = 31 })[R[0]], ({ [0] = 116, [1] = 19, [2] = 18, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 126, [2] = 23, [3] = 31 })[R[0]], ({ [0] = 117, [1] = 20, [2] = 19, [3] = 122 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 116, [1] = 121, [2] = 18, [3] = 26 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 19, [3] = 27 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 123, [2] = 20, [3] = 28 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 124, [2] = 21, [3] = 29 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 124, [2] = 21, [3] = 29 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 125, [2] = 22, [3] = 30 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 125, [2] = 22, [3] = 30 })[R[0]], ({ [0] = 112, [1] = 15, [2] = 14, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 125, [2] = 22, [3] = 30 })[R[0]], ({ [0] = 113, [1] = 16, [2] = 15, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 125, [2] = 22, [3] = 30 })[R[0]], ({ [0] = 114, [1] = 17, [2] = 16, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 125, [2] = 22, [3] = 30 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 126, [2] = 23, [3] = 31 })[R[0]], ({ [0] = 115, [1] = 18, [2] = 17, [3] = 120 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 126, [2] = 23, [3] = 31 })[R[0]], ({ [0] = 116, [1] = 19, [2] = 18, [3] = 121 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 126, [2] = 23, [3] = 31 })[R[0]], ({ [0] = 117, [1] = 20, [2] = 19, [3] = 122 })[R[0]] })
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 114, [1] = 119, [2] = 16, [3] = 24 }, [1] = { [0] = 115, [1] = 120, [2] = 17, [3] = 25 }, [2] = { [0] = 102, [1] = 107, [2] = 4, [3] = 12 } })[R[14]][R[0]], ({ [0] = { [0] = 111, [1] = 14, [2] = 13, [3] = 116 }, [1] = { [0] = 118, [1] = 21, [2] = 20, [3] = 123 }, [2] = { [0] = 115, [1] = 18, [2] = 17, [3] = 120 } })[R[14]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 20, [3] = 26 })[R[0]], ({ [0] = 104, [1] = 7, [2] = 6, [3] = 110 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 20, [3] = 26 })[R[0]], ({ [0] = 105, [1] = 8, [2] = 7, [3] = 111 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 20, [3] = 26 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 20, [3] = 26 })[R[0]], ({ [0] = 119, [1] = 22, [2] = 21, [3] = 125 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 121, [2] = 21, [3] = 27 })[R[0]], ({ [0] = 105, [1] = 8, [2] = 7, [3] = 111 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 121, [2] = 21, [3] = 27 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 121, [2] = 21, [3] = 27 })[R[0]], ({ [0] = 119, [1] = 22, [2] = 21, [3] = 125 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 122, [2] = 22, [3] = 28 })[R[0]], ({ [0] = 105, [1] = 8, [2] = 7, [3] = 111 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 122, [2] = 22, [3] = 28 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 122, [2] = 22, [3] = 28 })[R[0]], ({ [0] = 119, [1] = 22, [2] = 21, [3] = 125 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 110, [1] = 13, [2] = 12, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 112, [1] = 15, [2] = 14, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 113, [1] = 16, [2] = 15, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 118, [1] = 21, [2] = 20, [3] = 124 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 119, [1] = 22, [2] = 21, [3] = 125 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 124, [2] = 24, [3] = 30 })[R[0]], ({ [0] = 110, [1] = 13, [2] = 12, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 124, [2] = 24, [3] = 30 })[R[0]], ({ [0] = 118, [1] = 21, [2] = 20, [3] = 124 })[R[0]] })
        game.create_tube({ ({ [0] = 123, [1] = 125, [2] = 25, [3] = 31 })[R[0]], ({ [0] = 108, [1] = 11, [2] = 10, [3] = 114 })[R[0]] })
        game.create_tube({ ({ [0] = 123, [1] = 125, [2] = 25, [3] = 31 })[R[0]], ({ [0] = 109, [1] = 12, [2] = 11, [3] = 115 })[R[0]] })
        game.create_tube({ ({ [0] = 123, [1] = 125, [2] = 25, [3] = 31 })[R[0]], ({ [0] = 110, [1] = 13, [2] = 12, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 123, [1] = 125, [2] = 25, [3] = 31 })[R[0]], ({ [0] = 118, [1] = 21, [2] = 20, [3] = 124 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 20, [3] = 26 })[R[0]], ({ [0] = 104, [1] = 7, [2] = 6, [3] = 110 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 20, [3] = 26 })[R[0]], ({ [0] = 105, [1] = 8, [2] = 7, [3] = 111 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 20, [3] = 26 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 20, [3] = 26 })[R[0]], ({ [0] = 119, [1] = 22, [2] = 21, [3] = 125 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 121, [2] = 21, [3] = 27 })[R[0]], ({ [0] = 105, [1] = 8, [2] = 7, [3] = 111 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 121, [2] = 21, [3] = 27 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 121, [2] = 21, [3] = 27 })[R[0]], ({ [0] = 119, [1] = 22, [2] = 21, [3] = 125 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 122, [2] = 22, [3] = 28 })[R[0]], ({ [0] = 105, [1] = 8, [2] = 7, [3] = 111 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 122, [2] = 22, [3] = 28 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 122, [2] = 22, [3] = 28 })[R[0]], ({ [0] = 119, [1] = 22, [2] = 21, [3] = 125 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 110, [1] = 13, [2] = 12, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 111, [1] = 14, [2] = 13, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 112, [1] = 15, [2] = 14, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 113, [1] = 16, [2] = 15, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 118, [1] = 21, [2] = 20, [3] = 124 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 23, [3] = 29 })[R[0]], ({ [0] = 119, [1] = 22, [2] = 21, [3] = 125 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 124, [2] = 24, [3] = 30 })[R[0]], ({ [0] = 110, [1] = 13, [2] = 12, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 124, [2] = 24, [3] = 30 })[R[0]], ({ [0] = 118, [1] = 21, [2] = 20, [3] = 124 })[R[0]] })
        game.create_tube({ ({ [0] = 123, [1] = 125, [2] = 25, [3] = 31 })[R[0]], ({ [0] = 108, [1] = 11, [2] = 10, [3] = 114 })[R[0]] })
        game.create_tube({ ({ [0] = 123, [1] = 125, [2] = 25, [3] = 31 })[R[0]], ({ [0] = 109, [1] = 12, [2] = 11, [3] = 115 })[R[0]] })
        game.create_tube({ ({ [0] = 123, [1] = 125, [2] = 25, [3] = 31 })[R[0]], ({ [0] = 110, [1] = 13, [2] = 12, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 123, [1] = 125, [2] = 25, [3] = 31 })[R[0]], ({ [0] = 118, [1] = 21, [2] = 20, [3] = 124 })[R[0]] })
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 116, [1] = 118, [2] = 18, [3] = 24 }, [1] = { [0] = 107, [1] = 109, [2] = 9, [3] = 15 }, [2] = { [0] = 115, [1] = 117, [2] = 17, [3] = 23 } })[R[15]][R[0]], ({ [0] = { [0] = 102, [1] = 5, [2] = 4, [3] = 108 }, [1] = { [0] = 110, [1] = 13, [2] = 12, [3] = 116 }, [2] = { [0] = 105, [1] = 8, [2] = 7, [3] = 111 } })[R[15]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 24, [3] = 26 })[R[0]], ({ [0] = 115, [1] = 16, [2] = 17, [3] = 114 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 24, [3] = 26 })[R[0]], ({ [0] = 116, [1] = 17, [2] = 18, [3] = 115 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 24, [3] = 26 })[R[0]], ({ [0] = 115, [1] = 16, [2] = 17, [3] = 114 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 120, [2] = 24, [3] = 26 })[R[0]], ({ [0] = 116, [1] = 17, [2] = 18, [3] = 115 })[R[0]] })
        for i = 1, game.initial_units() do
          R[16] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 114, [1] = 116, [2] = 20, [3] = 22 }, [1] = { [0] = 97, [1] = 99, [2] = 3, [3] = 5 }, [2] = { [0] = 119, [1] = 121, [2] = 25, [3] = 27 } })[R[16]][R[0]], ({ [0] = { [0] = 122, [1] = 23, [2] = 24, [3] = 121 }, [1] = { [0] = 109, [1] = 10, [2] = 11, [3] = 108 }, [2] = { [0] = 122, [1] = 23, [2] = 24, [3] = 121 } })[R[16]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 119, [1] = 121, [2] = 27, [3] = 27 })[R[0]], ({ [0] = 112, [1] = 12, [2] = 12, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 122, [2] = 28, [3] = 28 })[R[0]], ({ [0] = 112, [1] = 12, [2] = 12, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 29, [3] = 29 })[R[0]], ({ [0] = 112, [1] = 12, [2] = 12, [3] = 118 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 119, [1] = 121, [2] = 27, [3] = 27 })[R[0]], ({ [0] = 112, [1] = 12, [2] = 12, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 120, [1] = 122, [2] = 28, [3] = 28 })[R[0]], ({ [0] = 112, [1] = 12, [2] = 12, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 123, [2] = 29, [3] = 29 })[R[0]], ({ [0] = 112, [1] = 12, [2] = 12, [3] = 118 })[R[0]] })
        for i = 1, game.initial_units() do
          R[17] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 100, [1] = 102, [2] = 8, [3] = 8 }, [1] = { [0] = 105, [1] = 107, [2] = 13, [3] = 13 }, [2] = { [0] = 126, [1] = 128, [2] = 34, [3] = 34 } })[R[17]][R[0]], ({ [0] = { [0] = 102, [1] = 2, [2] = 2, [3] = 108 }, [1] = { [0] = 100, [1] = 0, [2] = 0, [3] = 106 }, [2] = { [0] = 115, [1] = 15, [2] = 15, [3] = 121 } })[R[17]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 111, [1] = 12, [2] = 9, [3] = 109 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 112, [1] = 13, [2] = 10, [3] = 110 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 113, [1] = 14, [2] = 11, [3] = 111 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 117, [1] = 18, [2] = 15, [3] = 115 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 118, [1] = 19, [2] = 16, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 119, [1] = 20, [2] = 17, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 120, [1] = 21, [2] = 18, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 110, [1] = 118, [2] = 18, [3] = 18 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 110, [1] = 118, [2] = 18, [3] = 18 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 111, [1] = 119, [2] = 19, [3] = 19 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 111, [1] = 119, [2] = 19, [3] = 19 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 112, [1] = 120, [2] = 20, [3] = 20 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 112, [1] = 120, [2] = 20, [3] = 20 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 121, [2] = 21, [3] = 21 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 121, [2] = 21, [3] = 21 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 122, [2] = 22, [3] = 22 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 122, [2] = 22, [3] = 22 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 123, [2] = 23, [3] = 23 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 123, [2] = 23, [3] = 23 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 110, [1] = 11, [2] = 8, [3] = 108 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 111, [1] = 12, [2] = 9, [3] = 109 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 112, [1] = 13, [2] = 10, [3] = 110 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 113, [1] = 14, [2] = 11, [3] = 111 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 114, [1] = 15, [2] = 12, [3] = 112 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 115, [1] = 16, [2] = 13, [3] = 113 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 116, [1] = 17, [2] = 14, [3] = 114 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 117, [1] = 18, [2] = 15, [3] = 115 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 118, [1] = 19, [2] = 16, [3] = 116 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 111, [1] = 12, [2] = 9, [3] = 109 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 112, [1] = 13, [2] = 10, [3] = 110 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 113, [1] = 14, [2] = 11, [3] = 111 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 117, [1] = 18, [2] = 15, [3] = 115 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 118, [1] = 19, [2] = 16, [3] = 116 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 119, [1] = 20, [2] = 17, [3] = 117 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 120, [1] = 21, [2] = 18, [3] = 118 })[R[0]] })
        game.create_tube({ ({ [0] = 109, [1] = 117, [2] = 17, [3] = 17 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 110, [1] = 118, [2] = 18, [3] = 18 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 110, [1] = 118, [2] = 18, [3] = 18 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 111, [1] = 119, [2] = 19, [3] = 19 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 111, [1] = 119, [2] = 19, [3] = 19 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 112, [1] = 120, [2] = 20, [3] = 20 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 112, [1] = 120, [2] = 20, [3] = 20 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 121, [2] = 21, [3] = 21 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 121, [2] = 21, [3] = 21 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 122, [2] = 22, [3] = 22 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 122, [2] = 22, [3] = 22 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 123, [2] = 23, [3] = 23 })[R[0]], ({ [0] = 108, [1] = 9, [2] = 6, [3] = 106 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 123, [2] = 23, [3] = 23 })[R[0]], ({ [0] = 121, [1] = 22, [2] = 19, [3] = 119 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 110, [1] = 11, [2] = 8, [3] = 108 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 111, [1] = 12, [2] = 9, [3] = 109 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 112, [1] = 13, [2] = 10, [3] = 110 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 113, [1] = 14, [2] = 11, [3] = 111 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 114, [1] = 15, [2] = 12, [3] = 112 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 115, [1] = 16, [2] = 13, [3] = 113 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 116, [1] = 17, [2] = 14, [3] = 114 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 117, [1] = 18, [2] = 15, [3] = 115 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 125, [2] = 25, [3] = 25 })[R[0]], ({ [0] = 118, [1] = 19, [2] = 16, [3] = 116 })[R[0]] })
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 107, [1] = 115, [2] = 15, [3] = 15 }, [1] = { [0] = 113, [1] = 121, [2] = 21, [3] = 21 }, [2] = { [0] = 101, [1] = 109, [2] = 9, [3] = 9 } })[R[18]][R[0]], ({ [0] = { [0] = 104, [1] = 5, [2] = 2, [3] = 102 }, [1] = { [0] = 104, [1] = 5, [2] = 2, [3] = 102 }, [2] = { [0] = 125, [1] = 26, [2] = 23, [3] = 123 } })[R[18]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
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
  elseif n == 3 then
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 64, 16 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 38, 102 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 23, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 91, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 103, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 126 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 126 } }
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 67, 65 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 69, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 81, 95 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 38, 43 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 111, 46 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 113, 35 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 17, 39 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 52, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 84, 16 } }
    pick(4, 3, { 0, 19, 20 })
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 8, [1] = 12, [2] = 106, [3] = 107 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 5, [1] = 101, [2] = 101, [3] = 7 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[1] == 0 or R[1] == 1 or R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 23, [1] = 23, [2] = 115, [3] = 117 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 12, [1] = 108, [2] = 108, [3] = 14 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 20, [1] = 117, [2] = 118, [3] = 19 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 2 then
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
      elseif R[1] == 5 then
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
      elseif R[1] == 6 then
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 31, [1] = 31, [2] = 123, [3] = 125 }, [7] = { [0] = 25, [1] = 25, [2] = 117, [3] = 125 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 123, [2] = 122, [3] = 20 }, [1] = { [0] = 30, [1] = 126, [2] = 126, [3] = 32 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 0 or R[1] == 1 then
      elseif R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 14, [1] = 14, [2] = 106, [3] = 108 }, [7] = { [0] = 26, [1] = 26, [2] = 118, [3] = 126 } })[R[1]][R[0]], ({ [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 18, [1] = 118, [2] = 120, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 } })[R[1]][R[0]], ({ [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
      else
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 25, [1] = 31, [2] = 123, [3] = 125 } })[R[1]][R[0]], ({ [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 3 then
        if LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 4 then
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
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 16, [2] = 100, [3] = 100 }, [1] = { [0] = 4, [1] = 15, [2] = 101, [3] = 111 }, [2] = { [0] = 28, [1] = 32, [2] = 126, [3] = 127 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 6, [1] = 12, [2] = 104, [3] = 106 }, [5] = { [0] = 4, [1] = 6, [2] = 98, [3] = 100 }, [6] = { [0] = 6, [1] = 6, [2] = 98, [3] = 100 }, [7] = { [0] = 18, [1] = 18, [2] = 110, [3] = 118 } })[R[1]][R[0]], ({ [0] = { [0] = 20, [1] = 125, [2] = 124, [3] = 22 }, [1] = { [0] = 27, [1] = 123, [2] = 123, [3] = 29 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 4, [1] = 107, [2] = 102, [3] = 5 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 22, [1] = 122, [2] = 124, [3] = 25 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 24, [1] = 30, [2] = 122, [3] = 124 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 6, [1] = 103, [2] = 104, [3] = 5 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 11, [1] = 107, [2] = 107, [3] = 13 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[1] == 0 or R[1] == 1 or R[1] == 2 or R[1] == 4 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 33, [2] = 123, [3] = 128 })[R[0]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 7, [1] = 110, [2] = 105, [3] = 8 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 21, [2] = 105, [3] = 105 })[R[0]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 21, [2] = 105, [3] = 105 })[R[0]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 32, [2] = 116, [3] = 116 })[R[0]], ({ [0] = 13, [1] = 118, [2] = 117, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[0]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[0]], ({ [0] = 4, [1] = 109, [2] = 108, [3] = 6 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 21, [2] = 105, [3] = 105 })[R[0]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 28, [1] = 32, [2] = 116, [3] = 116 })[R[0]], ({ [0] = 13, [1] = 118, [2] = 117, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[0]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[0]], ({ [0] = 4, [1] = 109, [2] = 108, [3] = 6 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[0]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[0]], ({ [0] = 4, [1] = 109, [2] = 108, [3] = 6 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 3, [1] = 14, [2] = 100, [3] = 110 })[R[0]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[0]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 3, [1] = 14, [2] = 100, [3] = 110 })[R[0]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[0]], ({ [0] = 7, [1] = 103, [2] = 103, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 9, [1] = 20, [2] = 106, [3] = 116 })[R[0]], ({ [0] = 4, [1] = 100, [2] = 100, [3] = 6 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 3, [1] = 14, [2] = 100, [3] = 110 })[R[0]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[0]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[0]], ({ [0] = 7, [1] = 103, [2] = 103, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 9, [1] = 20, [2] = 106, [3] = 116 })[R[0]], ({ [0] = 4, [1] = 100, [2] = 100, [3] = 6 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[0]], ({ [0] = 7, [1] = 103, [2] = 103, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 9, [1] = 20, [2] = 106, [3] = 116 })[R[0]], ({ [0] = 4, [1] = 100, [2] = 100, [3] = 6 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[0]], ({ [0] = 13, [1] = 114, [2] = 113, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[0]], ({ [0] = 13, [1] = 114, [2] = 113, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 6, [1] = 10, [2] = 104, [3] = 105 })[R[0]], ({ [0] = 16, [1] = 117, [2] = 116, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 120, [2] = 119, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[0]], ({ [0] = 20, [1] = 121, [2] = 120, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[0]], ({ [0] = 13, [1] = 114, [2] = 113, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 6, [1] = 10, [2] = 104, [3] = 105 })[R[0]], ({ [0] = 16, [1] = 117, [2] = 116, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 120, [2] = 119, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[0]], ({ [0] = 20, [1] = 121, [2] = 120, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 120, [2] = 119, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[0]], ({ [0] = 20, [1] = 121, [2] = 120, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 3 then
      if LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[0]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[0]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 5, [1] = 13, [2] = 103, [3] = 108 })[R[0]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[0]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 7, [1] = 110, [2] = 105, [3] = 8 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[0]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[0]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[0]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[0]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 5, [1] = 13, [2] = 103, [3] = 108 })[R[0]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 5, [1] = 13, [2] = 103, [3] = 108 })[R[0]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[0]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 32, [2] = 124, [3] = 126 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 32, [2] = 124, [3] = 126 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 24, [2] = 116, [3] = 118 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 25, [2] = 117, [3] = 119 })[R[0]], ({ [0] = 17, [1] = 121, [2] = 115, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 8, [1] = 112, [2] = 106, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 32, [2] = 124, [3] = 126 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 24, [2] = 116, [3] = 118 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 25, [2] = 117, [3] = 119 })[R[0]], ({ [0] = 17, [1] = 121, [2] = 115, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 8, [1] = 112, [2] = 106, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 25, [2] = 117, [3] = 119 })[R[0]], ({ [0] = 17, [1] = 121, [2] = 115, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 8, [1] = 112, [2] = 106, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 24, [2] = 116, [3] = 118 })[R[0]], ({ [0] = 8, [1] = 105, [2] = 106, [3] = 7 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 24, [2] = 116, [3] = 118 })[R[0]], ({ [0] = 8, [1] = 105, [2] = 106, [3] = 7 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 10, [1] = 12, [2] = 104, [3] = 106 })[R[0]], ({ [0] = 16, [1] = 113, [2] = 114, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 9, [1] = 11, [2] = 103, [3] = 105 })[R[0]], ({ [0] = 5, [1] = 102, [2] = 103, [3] = 4 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 112, [3] = 114 })[R[0]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 24, [2] = 116, [3] = 118 })[R[0]], ({ [0] = 8, [1] = 105, [2] = 106, [3] = 7 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 10, [1] = 12, [2] = 104, [3] = 106 })[R[0]], ({ [0] = 16, [1] = 113, [2] = 114, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 9, [1] = 11, [2] = 103, [3] = 105 })[R[0]], ({ [0] = 5, [1] = 102, [2] = 103, [3] = 4 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 112, [3] = 114 })[R[0]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 9, [1] = 11, [2] = 103, [3] = 105 })[R[0]], ({ [0] = 5, [1] = 102, [2] = 103, [3] = 4 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 20, [2] = 112, [3] = 114 })[R[0]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 11, [1] = 11, [2] = 103, [3] = 105 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 117, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 11, [1] = 11, [2] = 103, [3] = 105 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 117, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 4, [1] = 110, [2] = 104, [3] = 4 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 18, [2] = 110, [3] = 112 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 114, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 11, [1] = 117, [2] = 111, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 11, [1] = 11, [2] = 103, [3] = 105 })[R[0]], ({ [0] = 17, [1] = 123, [2] = 117, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 26, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 4, [1] = 110, [2] = 104, [3] = 4 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 18, [2] = 110, [3] = 112 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 114, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 11, [1] = 117, [2] = 111, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 18, [2] = 110, [3] = 112 })[R[0]], ({ [0] = 14, [1] = 120, [2] = 114, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 11, [1] = 117, [2] = 111, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 28, [2] = 120, [3] = 128 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 28, [2] = 120, [3] = 128 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 127 })[R[0]], ({ [0] = 7, [1] = 107, [2] = 109, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 12, [2] = 104, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 7, [1] = 7, [2] = 99, [3] = 107 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 28, [1] = 28, [2] = 120, [3] = 128 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 127 })[R[0]], ({ [0] = 7, [1] = 107, [2] = 109, [3] = 10 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 12, [2] = 104, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 7, [1] = 7, [2] = 99, [3] = 107 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 12, [1] = 12, [2] = 104, [3] = 112 })[R[0]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 7, [1] = 7, [2] = 99, [3] = 107 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 27, [1] = 33, [2] = 125, [3] = 127 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 } })[R[1]][R[0]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 8, [1] = 111, [2] = 106, [3] = 9 }, [4] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [5] = { [0] = 22, [1] = 119, [2] = 120, [3] = 21 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 19, [2] = 103, [3] = 103 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 }, [5] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 9, [1] = 109, [2] = 111, [3] = 12 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 12, [1] = 16, [2] = 110, [3] = 111 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 18, [1] = 121, [2] = 116, [3] = 19 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 12, [1] = 109, [2] = 110, [3] = 11 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 8, [1] = 19, [2] = 105, [3] = 115 }, [2] = { [0] = 13, [1] = 17, [2] = 111, [3] = 112 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 19, [1] = 122, [2] = 117, [3] = 20 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 11, [1] = 111, [2] = 113, [3] = 14 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 22, [2] = 106, [3] = 106 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 8, [1] = 109, [2] = 108, [3] = 5 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 10, [1] = 114, [2] = 108, [3] = 11 }, [5] = { [0] = 17, [1] = 114, [2] = 115, [3] = 16 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 10, [1] = 21, [2] = 107, [3] = 117 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 9, [1] = 110, [2] = 109, [3] = 6 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 11, [1] = 115, [2] = 109, [3] = 12 }, [5] = { [0] = 18, [1] = 115, [2] = 116, [3] = 17 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 24, [2] = 108, [3] = 108 }, [1] = { [0] = 11, [1] = 22, [2] = 108, [3] = 118 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 16, [1] = 16, [2] = 108, [3] = 110 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 10, [1] = 111, [2] = 110, [3] = 7 }, [3] = { [0] = 14, [1] = 117, [2] = 112, [3] = 15 }, [4] = { [0] = 15, [1] = 119, [2] = 113, [3] = 16 }, [5] = { [0] = 19, [1] = 116, [2] = 117, [3] = 18 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 14, [1] = 114, [2] = 116, [3] = 17 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 25, [2] = 109, [3] = 109 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 15, [1] = 118, [2] = 113, [3] = 16 }, [4] = { [0] = 16, [1] = 120, [2] = 114, [3] = 17 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 6, [1] = 111, [2] = 110, [3] = 8 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 12, [1] = 113, [2] = 112, [3] = 9 }, [3] = { [0] = 16, [1] = 119, [2] = 114, [3] = 17 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 16, [1] = 116, [2] = 118, [3] = 19 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 8, [1] = 104, [2] = 104, [3] = 10 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 18, [1] = 122, [2] = 116, [3] = 19 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 17, [1] = 117, [2] = 119, [3] = 20 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[1]][R[0]], ({ [0] = { [0] = 8, [1] = 113, [2] = 112, [3] = 10 }, [1] = { [0] = 9, [1] = 105, [2] = 105, [3] = 11 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 19, [1] = 123, [2] = 117, [3] = 20 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 114, [2] = 113, [3] = 11 }, [1] = { [0] = 10, [1] = 106, [2] = 106, [3] = 12 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 12, [1] = 20, [2] = 110, [3] = 115 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[1]][R[0]], ({ [0] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [1] = { [0] = 15, [1] = 111, [2] = 111, [3] = 17 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[1]][R[0]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 121, [2] = 120, [3] = 18 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 30, [2] = 114, [3] = 114 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 14, [1] = 22, [2] = 112, [3] = 117 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 31, [2] = 115, [3] = 115 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 19, [1] = 115, [2] = 115, [3] = 21 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 23, [1] = 25, [2] = 117, [3] = 119 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 20, [1] = 116, [2] = 116, [3] = 22 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 6, [1] = 110, [2] = 104, [3] = 7 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 25, [1] = 121, [2] = 121, [3] = 27 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 34, [2] = 118, [3] = 118 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 18, [1] = 22, [2] = 116, [3] = 117 }, [3] = { [0] = 18, [1] = 26, [2] = 116, [3] = 121 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 26, [1] = 122, [2] = 122, [3] = 28 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 8, [1] = 108, [2] = 110, [3] = 11 } })[R[1]][R[0]] })
    if R[1] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [2] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 } })[R[21]][R[0]], ({ [0] = { [0] = 5, [1] = 110, [2] = 109, [3] = 7 }, [1] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [2] = { [0] = 17, [1] = 122, [2] = 121, [3] = 19 } })[R[21]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[0]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 5, [1] = 16, [2] = 102, [3] = 112 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 } })[R[22]][R[0]], ({ [0] = { [0] = 22, [1] = 118, [2] = 118, [3] = 24 }, [1] = { [0] = 24, [1] = 120, [2] = 120, [3] = 26 }, [2] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 } })[R[22]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 9, [1] = 13, [2] = 107, [3] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [2] = { [0] = 27, [1] = 31, [2] = 125, [3] = 126 } })[R[23]][R[0]], ({ [0] = { [0] = 5, [1] = 106, [2] = 105, [3] = 2 }, [1] = { [0] = 21, [1] = 122, [2] = 121, [3] = 18 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 } })[R[23]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[0]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [1] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [2] = { [0] = 4, [1] = 12, [2] = 102, [3] = 107 } })[R[24]][R[0]], ({ [0] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 123, [2] = 118, [3] = 21 }, [2] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 } })[R[24]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [1] = { [0] = 9, [1] = 15, [2] = 107, [3] = 109 }, [2] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 } })[R[25]][R[0]], ({ [0] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [1] = { [0] = 12, [1] = 116, [2] = 110, [3] = 13 }, [2] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 } })[R[25]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[0]] })
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [1] = { [0] = 3, [1] = 5, [2] = 97, [3] = 99 }, [2] = { [0] = 25, [1] = 27, [2] = 119, [3] = 121 } })[R[26]][R[0]], ({ [0] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 }, [1] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [2] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 } })[R[26]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 8, [1] = 8, [2] = 100, [3] = 102 }, [1] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [2] = { [0] = 34, [1] = 34, [2] = 126, [3] = 128 } })[R[27]][R[0]], ({ [0] = { [0] = 2, [1] = 108, [2] = 102, [3] = 2 }, [1] = { [0] = 0, [1] = 106, [2] = 100, [3] = 0 }, [2] = { [0] = 15, [1] = 121, [2] = 115, [3] = 15 } })[R[27]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 }, [1] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 }, [2] = { [0] = 9, [1] = 9, [2] = 101, [3] = 109 } })[R[28]][R[0]], ({ [0] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [1] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [2] = { [0] = 23, [1] = 123, [2] = 125, [3] = 26 } })[R[28]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 3, [2] = 14, [3] = 15, [4] = 14, [5] = 14, [6] = 13, [7] = 17 }, [1] = { [0] = 27, [1] = 14, [2] = 18, [3] = 23, [4] = 20, [5] = 16, [6] = 13, [7] = 17 }, [2] = { [0] = 111, [1] = 100, [2] = 112, [3] = 113, [4] = 112, [5] = 108, [6] = 105, [7] = 109 }, [3] = { [0] = 111, [1] = 110, [2] = 113, [3] = 118, [4] = 114, [5] = 110, [6] = 107, [7] = 117 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 6, [3] = 17, [4] = 13, [5] = 15, [6] = 4, [7] = 13 }, [1] = { [0] = 116, [1] = 114, [2] = 107, [3] = 120, [4] = 117, [5] = 112, [6] = 110, [7] = 113 }, [2] = { [0] = 115, [1] = 114, [2] = 106, [3] = 115, [4] = 111, [5] = 113, [6] = 104, [7] = 115 }, [3] = { [0] = 13, [1] = 20, [2] = 3, [3] = 18, [4] = 14, [5] = 14, [6] = 4, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 23, [1] = 3, [2] = 14, [3] = 15, [4] = 14, [5] = 14, [6] = 13, [7] = 17 }, [1] = { [0] = 27, [1] = 14, [2] = 18, [3] = 23, [4] = 20, [5] = 16, [6] = 13, [7] = 17 }, [2] = { [0] = 111, [1] = 100, [2] = 112, [3] = 113, [4] = 112, [5] = 108, [6] = 105, [7] = 109 }, [3] = { [0] = 111, [1] = 110, [2] = 113, [3] = 118, [4] = 114, [5] = 110, [6] = 107, [7] = 117 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 6, [3] = 17, [4] = 13, [5] = 15, [6] = 4, [7] = 13 }, [1] = { [0] = 116, [1] = 114, [2] = 107, [3] = 120, [4] = 117, [5] = 112, [6] = 110, [7] = 113 }, [2] = { [0] = 115, [1] = 114, [2] = 106, [3] = 115, [4] = 111, [5] = 113, [6] = 104, [7] = 115 }, [3] = { [0] = 13, [1] = 20, [2] = 3, [3] = 18, [4] = 14, [5] = 14, [6] = 4, [7] = 16 } })[R[19]][R[10]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 13, [2] = 8, [3] = 23, [4] = 14, [5] = 14, [6] = 22, [7] = 10 }, [1] = { [0] = 27, [1] = 24, [2] = 12, [3] = 31, [4] = 20, [5] = 16, [6] = 22, [7] = 10 }, [2] = { [0] = 111, [1] = 110, [2] = 106, [3] = 121, [4] = 112, [5] = 108, [6] = 114, [7] = 102 }, [3] = { [0] = 111, [1] = 120, [2] = 107, [3] = 126, [4] = 114, [5] = 110, [6] = 116, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 4, [1] = 5, [2] = 11, [3] = 21, [4] = 21, [5] = 21, [6] = 4, [7] = 19 }, [1] = { [0] = 109, [1] = 101, [2] = 112, [3] = 124, [4] = 125, [5] = 118, [6] = 110, [7] = 119 }, [2] = { [0] = 108, [1] = 101, [2] = 111, [3] = 119, [4] = 119, [5] = 119, [6] = 104, [7] = 121 }, [3] = { [0] = 6, [1] = 7, [2] = 8, [3] = 22, [4] = 22, [5] = 20, [6] = 4, [7] = 22 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 35, [1] = 14, [2] = 11, [5] = 24, [6] = 23, [7] = 10 }, [1] = { [0] = 39, [1] = 25, [2] = 15, [5] = 26, [6] = 23, [7] = 10 }, [2] = { [0] = 123, [1] = 111, [2] = 109, [5] = 118, [6] = 115, [7] = 102 }, [3] = { [0] = 123, [1] = 121, [2] = 110, [5] = 120, [6] = 117, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 12, [2] = 17, [5] = 20, [6] = 12, [7] = 6 }, [1] = { [0] = 116, [1] = 108, [2] = 118, [5] = 117, [6] = 118, [7] = 106 }, [2] = { [0] = 115, [1] = 108, [2] = 117, [5] = 118, [6] = 112, [7] = 108 }, [3] = { [0] = 13, [1] = 14, [2] = 14, [5] = 19, [6] = 12, [7] = 9 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 0 then
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
      elseif R[10] == 1 then
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
      elseif R[10] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[19]], ({ [0] = 11, [1] = 112, [2] = 111, [3] = 8 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[19]], ({ [0] = 11, [1] = 112, [2] = 111, [3] = 8 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[19]], ({ [0] = 11, [1] = 112, [2] = 111, [3] = 8 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 14, [2] = 20, [5] = 14, [6] = 14, [7] = 26 }, [1] = { [0] = 16, [1] = 25, [2] = 24, [5] = 16, [6] = 14, [7] = 26 }, [2] = { [0] = 100, [1] = 111, [2] = 118, [5] = 108, [6] = 106, [7] = 118 }, [3] = { [0] = 100, [1] = 121, [2] = 119, [5] = 110, [6] = 108, [7] = 126 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 22, [2] = 17, [5] = 8, [6] = 12, [7] = 18 }, [1] = { [0] = 116, [1] = 118, [2] = 118, [5] = 105, [6] = 118, [7] = 118 }, [2] = { [0] = 115, [1] = 118, [2] = 117, [5] = 106, [6] = 112, [7] = 120 }, [3] = { [0] = 13, [1] = 24, [2] = 14, [5] = 7, [6] = 12, [7] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 0 or R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 13 }, [1] = { [0] = 27, [1] = 24 }, [2] = { [0] = 111, [1] = 110 }, [3] = { [0] = 111, [1] = 120 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 30 }, [1] = { [0] = 123, [1] = 126 }, [2] = { [0] = 122, [1] = 126 }, [3] = { [0] = 20, [1] = 32 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [3] = 7, [4] = 14 }, [1] = { [3] = 15, [4] = 20 }, [2] = { [3] = 105, [4] = 112 }, [3] = { [3] = 110, [4] = 114 } })[R[19]][R[10]], ({ [0] = { [3] = 21, [4] = 5 }, [1] = { [3] = 124, [4] = 109 }, [2] = { [3] = 119, [4] = 103 }, [3] = { [3] = 22, [4] = 6 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
      elseif R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [3] = 10, [4] = 25 }, [1] = { [3] = 18, [4] = 31 }, [2] = { [3] = 108, [4] = 123 }, [3] = { [3] = 113, [4] = 125 } })[R[19]][R[10]], ({ [0] = { [3] = 10, [4] = 17 }, [1] = { [3] = 113, [4] = 121 }, [2] = { [3] = 108, [4] = 115 }, [3] = { [3] = 11, [4] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 4 then
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
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 4, [2] = 28, [3] = 16, [4] = 6, [5] = 4, [6] = 6, [7] = 18 }, [1] = { [0] = 16, [1] = 15, [2] = 32, [3] = 24, [4] = 12, [5] = 6, [6] = 6, [7] = 18 }, [2] = { [0] = 100, [1] = 101, [2] = 126, [3] = 114, [4] = 104, [5] = 98, [6] = 98, [7] = 110 }, [3] = { [0] = 100, [1] = 111, [2] = 127, [3] = 119, [4] = 106, [5] = 100, [6] = 100, [7] = 118 } })[R[19]][R[10]], ({ [0] = { [0] = 20, [1] = 27, [2] = 11, [3] = 4, [4] = 9, [5] = 15, [6] = 12, [7] = 22 }, [1] = { [0] = 125, [1] = 123, [2] = 112, [3] = 107, [4] = 113, [5] = 112, [6] = 118, [7] = 122 }, [2] = { [0] = 124, [1] = 123, [2] = 111, [3] = 102, [4] = 107, [5] = 113, [6] = 112, [7] = 124 }, [3] = { [0] = 22, [1] = 29, [2] = 8, [3] = 5, [4] = 10, [5] = 14, [6] = 12, [7] = 25 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 3, [2] = 24, [3] = 5, [4] = 24, [5] = 22, [6] = 13, [7] = 28 }, [1] = { [0] = 23, [1] = 14, [2] = 28, [3] = 13, [4] = 30, [5] = 24, [6] = 13, [7] = 28 }, [2] = { [0] = 107, [1] = 100, [2] = 122, [3] = 103, [4] = 122, [5] = 116, [6] = 105, [7] = 120 }, [3] = { [0] = 107, [1] = 110, [2] = 123, [3] = 108, [4] = 124, [5] = 118, [6] = 107, [7] = 128 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 13, [2] = 15, [3] = 11, [4] = 13, [5] = 6, [6] = 17, [7] = 13 }, [1] = { [0] = 112, [1] = 109, [2] = 116, [3] = 114, [4] = 117, [5] = 103, [6] = 123, [7] = 113 }, [2] = { [0] = 111, [1] = 109, [2] = 115, [3] = 109, [4] = 111, [5] = 104, [6] = 117, [7] = 115 }, [3] = { [0] = 9, [1] = 15, [2] = 12, [3] = 12, [4] = 14, [5] = 5, [6] = 17, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 3, [2] = 24, [3] = 8, [4] = 26, [5] = 22, [6] = 11, [7] = 28 }, [1] = { [0] = 21, [1] = 14, [2] = 28, [3] = 16, [4] = 32, [5] = 24, [6] = 11, [7] = 28 }, [2] = { [0] = 105, [1] = 100, [2] = 122, [3] = 106, [4] = 124, [5] = 116, [6] = 103, [7] = 120 }, [3] = { [0] = 105, [1] = 110, [2] = 123, [3] = 111, [4] = 126, [5] = 118, [6] = 105, [7] = 128 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 11, [2] = 13, [3] = 7, [4] = 13, [5] = 8, [6] = 17, [7] = 15 }, [1] = { [0] = 112, [1] = 107, [2] = 114, [3] = 110, [4] = 117, [5] = 105, [6] = 123, [7] = 115 }, [2] = { [0] = 111, [1] = 107, [2] = 113, [3] = 105, [4] = 111, [5] = 106, [6] = 117, [7] = 117 }, [3] = { [0] = 9, [1] = 13, [2] = 10, [3] = 8, [4] = 14, [5] = 7, [6] = 17, [7] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 25, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 33, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 123, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 128, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 11, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 114, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 109, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 12, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 23, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 31, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 121, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 126, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 7, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 110, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 105, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 8, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 17, [1] = 3, [2] = 24, [3] = 11, [4] = 26, [5] = 22, [6] = 11, [7] = 28 }, [1] = { [0] = 21, [1] = 14, [2] = 28, [3] = 19, [4] = 32, [5] = 24, [6] = 11, [7] = 28 }, [2] = { [0] = 105, [1] = 100, [2] = 122, [3] = 109, [4] = 124, [5] = 116, [6] = 103, [7] = 120 }, [3] = { [0] = 105, [1] = 110, [2] = 123, [3] = 114, [4] = 126, [5] = 118, [6] = 105, [7] = 128 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 13, [2] = 13, [3] = 22, [4] = 13, [5] = 8, [6] = 17, [7] = 15 }, [1] = { [0] = 112, [1] = 109, [2] = 114, [3] = 125, [4] = 117, [5] = 105, [6] = 123, [7] = 115 }, [2] = { [0] = 111, [1] = 109, [2] = 113, [3] = 120, [4] = 111, [5] = 106, [6] = 117, [7] = 117 }, [3] = { [0] = 9, [1] = 15, [2] = 10, [3] = 23, [4] = 14, [5] = 7, [6] = 17, [7] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 17, [1] = 6, [2] = 24, [3] = 11, [4] = 26, [5] = 22, [6] = 11, [7] = 28 }, [1] = { [0] = 21, [1] = 17, [2] = 28, [3] = 19, [4] = 32, [5] = 24, [6] = 11, [7] = 28 }, [2] = { [0] = 105, [1] = 103, [2] = 122, [3] = 109, [4] = 124, [5] = 116, [6] = 103, [7] = 120 }, [3] = { [0] = 105, [1] = 113, [2] = 123, [3] = 114, [4] = 126, [5] = 118, [6] = 105, [7] = 128 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 13, [2] = 13, [3] = 22, [4] = 13, [5] = 8, [6] = 17, [7] = 15 }, [1] = { [0] = 112, [1] = 109, [2] = 114, [3] = 125, [4] = 117, [5] = 105, [6] = 123, [7] = 115 }, [2] = { [0] = 111, [1] = 109, [2] = 113, [3] = 120, [4] = 111, [5] = 106, [6] = 117, [7] = 117 }, [3] = { [0] = 9, [1] = 15, [2] = 10, [3] = 23, [4] = 14, [5] = 7, [6] = 17, [7] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 3, [2] = 6, [3] = 5, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 14, [2] = 10, [3] = 13, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 100, [2] = 104, [3] = 103, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 110, [2] = 105, [3] = 108, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 11, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 114, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 109, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 12, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 6, [2] = 24, [3] = 5, [4] = 19, [5] = 9, [6] = 18, [7] = 12 }, [1] = { [0] = 18, [1] = 17, [2] = 28, [3] = 13, [4] = 25, [5] = 11, [6] = 18, [7] = 12 }, [2] = { [0] = 102, [1] = 103, [2] = 122, [3] = 103, [4] = 117, [5] = 103, [6] = 110, [7] = 104 }, [3] = { [0] = 102, [1] = 113, [2] = 123, [3] = 108, [4] = 119, [5] = 105, [6] = 112, [7] = 112 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 7, [2] = 19, [3] = 11, [4] = 17, [5] = 5, [6] = 14, [7] = 13 }, [1] = { [0] = 112, [1] = 103, [2] = 120, [3] = 114, [4] = 121, [5] = 102, [6] = 120, [7] = 113 }, [2] = { [0] = 111, [1] = 103, [2] = 119, [3] = 109, [4] = 115, [5] = 103, [6] = 114, [7] = 115 }, [3] = { [0] = 9, [1] = 9, [2] = 16, [3] = 12, [4] = 18, [5] = 4, [6] = 14, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 9, [2] = 20, [3] = 11, [4] = 21, [5] = 18, [6] = 27, [7] = 7 }, [1] = { [0] = 18, [1] = 20, [2] = 24, [3] = 19, [4] = 27, [5] = 20, [6] = 27, [7] = 7 }, [2] = { [0] = 102, [1] = 106, [2] = 118, [3] = 109, [4] = 119, [5] = 112, [6] = 119, [7] = 99 }, [3] = { [0] = 102, [1] = 116, [2] = 119, [3] = 114, [4] = 121, [5] = 114, [6] = 121, [7] = 107 } })[R[19]][R[10]], ({ [0] = { [0] = 4, [1] = 4, [2] = 20, [3] = 22, [4] = 8, [5] = 13, [6] = 11, [7] = 10 }, [1] = { [0] = 109, [1] = 100, [2] = 121, [3] = 125, [4] = 112, [5] = 110, [6] = 117, [7] = 110 }, [2] = { [0] = 108, [1] = 100, [2] = 120, [3] = 120, [4] = 106, [5] = 111, [6] = 111, [7] = 112 }, [3] = { [0] = 6, [1] = 6, [2] = 17, [3] = 23, [4] = 9, [5] = 12, [6] = 11, [7] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 25, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 33, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 123, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 128, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 11, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 114, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 109, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 12, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 23, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 31, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 121, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 126, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 7, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 110, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 105, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 8, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 17, [1] = 3, [2] = 24, [3] = 11, [4] = 26, [5] = 22, [6] = 11, [7] = 28 }, [1] = { [0] = 21, [1] = 14, [2] = 28, [3] = 19, [4] = 32, [5] = 24, [6] = 11, [7] = 28 }, [2] = { [0] = 105, [1] = 100, [2] = 122, [3] = 109, [4] = 124, [5] = 116, [6] = 103, [7] = 120 }, [3] = { [0] = 105, [1] = 110, [2] = 123, [3] = 114, [4] = 126, [5] = 118, [6] = 105, [7] = 128 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 13, [2] = 13, [3] = 22, [4] = 13, [5] = 8, [6] = 17, [7] = 15 }, [1] = { [0] = 112, [1] = 109, [2] = 114, [3] = 125, [4] = 117, [5] = 105, [6] = 123, [7] = 115 }, [2] = { [0] = 111, [1] = 109, [2] = 113, [3] = 120, [4] = 111, [5] = 106, [6] = 117, [7] = 117 }, [3] = { [0] = 9, [1] = 15, [2] = 10, [3] = 23, [4] = 14, [5] = 7, [6] = 17, [7] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 11, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 19, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 109, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 114, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 22, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 125, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 120, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 23, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 6, [2] = 24, [3] = 5, [4] = 19, [5] = 9, [6] = 18, [7] = 12 }, [1] = { [0] = 18, [1] = 17, [2] = 28, [3] = 13, [4] = 25, [5] = 11, [6] = 18, [7] = 12 }, [2] = { [0] = 102, [1] = 103, [2] = 122, [3] = 103, [4] = 117, [5] = 103, [6] = 110, [7] = 104 }, [3] = { [0] = 102, [1] = 113, [2] = 123, [3] = 108, [4] = 119, [5] = 105, [6] = 112, [7] = 112 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 7, [2] = 19, [3] = 11, [4] = 17, [5] = 5, [6] = 14, [7] = 13 }, [1] = { [0] = 112, [1] = 103, [2] = 120, [3] = 114, [4] = 121, [5] = 102, [6] = 120, [7] = 113 }, [2] = { [0] = 111, [1] = 103, [2] = 119, [3] = 109, [4] = 115, [5] = 103, [6] = 114, [7] = 115 }, [3] = { [0] = 9, [1] = 9, [2] = 16, [3] = 12, [4] = 18, [5] = 4, [6] = 14, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 9, [2] = 20, [3] = 11, [4] = 21, [5] = 18, [6] = 27, [7] = 7 }, [1] = { [0] = 18, [1] = 20, [2] = 24, [3] = 19, [4] = 27, [5] = 20, [6] = 27, [7] = 7 }, [2] = { [0] = 102, [1] = 106, [2] = 118, [3] = 109, [4] = 119, [5] = 112, [6] = 119, [7] = 99 }, [3] = { [0] = 102, [1] = 116, [2] = 119, [3] = 114, [4] = 121, [5] = 114, [6] = 121, [7] = 107 } })[R[19]][R[10]], ({ [0] = { [0] = 4, [1] = 4, [2] = 20, [3] = 22, [4] = 8, [5] = 13, [6] = 11, [7] = 10 }, [1] = { [0] = 109, [1] = 100, [2] = 121, [3] = 125, [4] = 112, [5] = 110, [6] = 117, [7] = 110 }, [2] = { [0] = 108, [1] = 100, [2] = 120, [3] = 120, [4] = 106, [5] = 111, [6] = 111, [7] = 112 }, [3] = { [0] = 6, [1] = 6, [2] = 17, [3] = 23, [4] = 9, [5] = 12, [6] = 11, [7] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 25, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 33, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 123, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 128, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 11, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 114, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 109, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 12, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 23, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 31, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 121, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 126, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 7, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 110, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 105, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 8, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 6, [2] = 24, [3] = 11, [4] = 19, [5] = 9, [6] = 18, [7] = 12 }, [1] = { [0] = 18, [1] = 17, [2] = 28, [3] = 19, [4] = 25, [5] = 11, [6] = 18, [7] = 12 }, [2] = { [0] = 102, [1] = 103, [2] = 122, [3] = 109, [4] = 117, [5] = 103, [6] = 110, [7] = 104 }, [3] = { [0] = 102, [1] = 113, [2] = 123, [3] = 114, [4] = 119, [5] = 105, [6] = 112, [7] = 112 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 7, [2] = 19, [3] = 22, [4] = 17, [5] = 5, [6] = 14, [7] = 13 }, [1] = { [0] = 112, [1] = 103, [2] = 120, [3] = 125, [4] = 121, [5] = 102, [6] = 120, [7] = 113 }, [2] = { [0] = 111, [1] = 103, [2] = 119, [3] = 120, [4] = 115, [5] = 103, [6] = 114, [7] = 115 }, [3] = { [0] = 9, [1] = 9, [2] = 16, [3] = 23, [4] = 18, [5] = 4, [6] = 14, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 9, [2] = 20, [3] = 11, [4] = 21, [5] = 18, [6] = 27, [7] = 7 }, [1] = { [0] = 18, [1] = 20, [2] = 24, [3] = 19, [4] = 27, [5] = 20, [6] = 27, [7] = 7 }, [2] = { [0] = 102, [1] = 106, [2] = 118, [3] = 109, [4] = 119, [5] = 112, [6] = 119, [7] = 99 }, [3] = { [0] = 102, [1] = 116, [2] = 119, [3] = 114, [4] = 121, [5] = 114, [6] = 121, [7] = 107 } })[R[19]][R[10]], ({ [0] = { [0] = 4, [1] = 4, [2] = 20, [3] = 22, [4] = 8, [5] = 13, [6] = 11, [7] = 10 }, [1] = { [0] = 109, [1] = 100, [2] = 121, [3] = 125, [4] = 112, [5] = 110, [6] = 117, [7] = 110 }, [2] = { [0] = 108, [1] = 100, [2] = 120, [3] = 120, [4] = 106, [5] = 111, [6] = 111, [7] = 112 }, [3] = { [0] = 6, [1] = 6, [2] = 17, [3] = 23, [4] = 9, [5] = 12, [6] = 11, [7] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 35, [1] = 12, [2] = 16, [3] = 15, [4] = 27, [5] = 10, [6] = 27, [7] = 21 }, [1] = { [0] = 39, [1] = 23, [2] = 20, [3] = 23, [4] = 33, [5] = 12, [6] = 27, [7] = 21 }, [2] = { [0] = 123, [1] = 109, [2] = 114, [3] = 113, [4] = 125, [5] = 104, [6] = 119, [7] = 113 }, [3] = { [0] = 123, [1] = 119, [2] = 115, [3] = 118, [4] = 127, [5] = 106, [6] = 121, [7] = 121 } })[R[19]][R[10]], ({ [0] = { [0] = 15, [1] = 17, [2] = 13, [3] = 8, [4] = 4, [5] = 22, [6] = 14, [7] = 12 }, [1] = { [0] = 120, [1] = 113, [2] = 114, [3] = 111, [4] = 108, [5] = 119, [6] = 120, [7] = 112 }, [2] = { [0] = 119, [1] = 113, [2] = 113, [3] = 106, [4] = 102, [5] = 120, [6] = 114, [7] = 114 }, [3] = { [0] = 17, [1] = 19, [2] = 10, [3] = 9, [4] = 5, [5] = 21, [6] = 14, [7] = 15 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 6, [2] = 11, [3] = 7, [4] = 14, [5] = 14, [6] = 13, [7] = 10 }, [1] = { [0] = 19, [1] = 17, [2] = 15, [3] = 15, [4] = 20, [5] = 16, [6] = 13, [7] = 10 }, [2] = { [0] = 103, [1] = 103, [2] = 109, [3] = 105, [4] = 112, [5] = 108, [6] = 105, [7] = 102 }, [3] = { [0] = 103, [1] = 113, [2] = 110, [3] = 110, [4] = 114, [5] = 110, [6] = 107, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 11, [3] = 17, [4] = 7, [5] = 11, [6] = 6, [7] = 9 }, [1] = { [0] = 116, [1] = 114, [2] = 112, [3] = 120, [4] = 111, [5] = 108, [6] = 112, [7] = 109 }, [2] = { [0] = 115, [1] = 114, [2] = 111, [3] = 115, [4] = 105, [5] = 109, [6] = 106, [7] = 111 }, [3] = { [0] = 13, [1] = 20, [2] = 8, [3] = 18, [4] = 8, [5] = 10, [6] = 6, [7] = 12 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 7, [2] = 12, [3] = 7, [4] = 14, [5] = 14, [6] = 13, [7] = 10 }, [1] = { [0] = 20, [1] = 18, [2] = 16, [3] = 15, [4] = 20, [5] = 16, [6] = 13, [7] = 10 }, [2] = { [0] = 104, [1] = 104, [2] = 110, [3] = 105, [4] = 112, [5] = 108, [6] = 105, [7] = 102 }, [3] = { [0] = 104, [1] = 114, [2] = 111, [3] = 110, [4] = 114, [5] = 110, [6] = 107, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 11, [3] = 18, [4] = 8, [5] = 12, [6] = 7, [7] = 10 }, [1] = { [0] = 116, [1] = 114, [2] = 112, [3] = 121, [4] = 112, [5] = 109, [6] = 113, [7] = 110 }, [2] = { [0] = 115, [1] = 114, [2] = 111, [3] = 116, [4] = 106, [5] = 110, [6] = 107, [7] = 112 }, [3] = { [0] = 13, [1] = 20, [2] = 8, [3] = 19, [4] = 9, [5] = 11, [6] = 7, [7] = 13 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 8, [2] = 13, [3] = 7, [4] = 14, [5] = 14, [6] = 13, [7] = 10 }, [1] = { [0] = 21, [1] = 19, [2] = 17, [3] = 15, [4] = 20, [5] = 16, [6] = 13, [7] = 10 }, [2] = { [0] = 105, [1] = 105, [2] = 111, [3] = 105, [4] = 112, [5] = 108, [6] = 105, [7] = 102 }, [3] = { [0] = 105, [1] = 115, [2] = 112, [3] = 110, [4] = 114, [5] = 110, [6] = 107, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 11, [3] = 19, [4] = 9, [5] = 13, [6] = 8, [7] = 11 }, [1] = { [0] = 116, [1] = 114, [2] = 112, [3] = 122, [4] = 113, [5] = 110, [6] = 114, [7] = 111 }, [2] = { [0] = 115, [1] = 114, [2] = 111, [3] = 117, [4] = 107, [5] = 111, [6] = 108, [7] = 113 }, [3] = { [0] = 13, [1] = 20, [2] = 8, [3] = 20, [4] = 10, [5] = 12, [6] = 8, [7] = 14 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 9, [2] = 14, [3] = 8, [4] = 14, [5] = 14, [6] = 13, [7] = 10 }, [1] = { [0] = 22, [1] = 20, [2] = 18, [3] = 16, [4] = 20, [5] = 16, [6] = 13, [7] = 10 }, [2] = { [0] = 106, [1] = 106, [2] = 112, [3] = 106, [4] = 112, [5] = 108, [6] = 105, [7] = 102 }, [3] = { [0] = 106, [1] = 116, [2] = 113, [3] = 111, [4] = 114, [5] = 110, [6] = 107, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 8, [3] = 17, [4] = 10, [5] = 17, [6] = 9, [7] = 12 }, [1] = { [0] = 116, [1] = 114, [2] = 109, [3] = 120, [4] = 114, [5] = 114, [6] = 115, [7] = 112 }, [2] = { [0] = 115, [1] = 114, [2] = 108, [3] = 115, [4] = 108, [5] = 115, [6] = 109, [7] = 114 }, [3] = { [0] = 13, [1] = 20, [2] = 5, [3] = 18, [4] = 11, [5] = 16, [6] = 9, [7] = 15 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 10, [2] = 14, [3] = 9, [4] = 14, [5] = 14, [6] = 13, [7] = 10 }, [1] = { [0] = 23, [1] = 21, [2] = 18, [3] = 17, [4] = 20, [5] = 16, [6] = 13, [7] = 10 }, [2] = { [0] = 107, [1] = 107, [2] = 112, [3] = 107, [4] = 112, [5] = 108, [6] = 105, [7] = 102 }, [3] = { [0] = 107, [1] = 117, [2] = 113, [3] = 112, [4] = 114, [5] = 110, [6] = 107, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 9, [3] = 13, [4] = 11, [5] = 18, [6] = 10, [7] = 13 }, [1] = { [0] = 116, [1] = 114, [2] = 110, [3] = 116, [4] = 115, [5] = 115, [6] = 116, [7] = 113 }, [2] = { [0] = 115, [1] = 114, [2] = 109, [3] = 111, [4] = 109, [5] = 116, [6] = 110, [7] = 115 }, [3] = { [0] = 13, [1] = 20, [2] = 6, [3] = 14, [4] = 12, [5] = 17, [6] = 10, [7] = 16 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 11, [2] = 14, [3] = 9, [4] = 14, [5] = 14, [6] = 16, [7] = 10 }, [1] = { [0] = 24, [1] = 22, [2] = 18, [3] = 17, [4] = 20, [5] = 16, [6] = 16, [7] = 10 }, [2] = { [0] = 108, [1] = 108, [2] = 112, [3] = 107, [4] = 112, [5] = 108, [6] = 108, [7] = 102 }, [3] = { [0] = 108, [1] = 118, [2] = 113, [3] = 112, [4] = 114, [5] = 110, [6] = 110, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 10, [3] = 14, [4] = 15, [5] = 19, [6] = 4, [7] = 14 }, [1] = { [0] = 116, [1] = 114, [2] = 111, [3] = 117, [4] = 119, [5] = 116, [6] = 110, [7] = 114 }, [2] = { [0] = 115, [1] = 114, [2] = 110, [3] = 112, [4] = 113, [5] = 117, [6] = 104, [7] = 116 }, [3] = { [0] = 13, [1] = 20, [2] = 7, [3] = 15, [4] = 16, [5] = 18, [6] = 4, [7] = 17 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 12, [2] = 14, [3] = 9, [4] = 14, [5] = 17, [6] = 17, [7] = 10 }, [1] = { [0] = 25, [1] = 23, [2] = 18, [3] = 17, [4] = 20, [5] = 19, [6] = 17, [7] = 10 }, [2] = { [0] = 109, [1] = 109, [2] = 112, [3] = 107, [4] = 112, [5] = 111, [6] = 109, [7] = 102 }, [3] = { [0] = 109, [1] = 119, [2] = 113, [3] = 112, [4] = 114, [5] = 113, [6] = 111, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 11, [3] = 15, [4] = 16, [5] = 15, [6] = 4, [7] = 15 }, [1] = { [0] = 116, [1] = 114, [2] = 112, [3] = 118, [4] = 120, [5] = 112, [6] = 110, [7] = 115 }, [2] = { [0] = 115, [1] = 114, [2] = 111, [3] = 113, [4] = 114, [5] = 113, [6] = 104, [7] = 117 }, [3] = { [0] = 13, [1] = 20, [2] = 8, [3] = 16, [4] = 17, [5] = 14, [6] = 4, [7] = 18 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 13, [2] = 14, [3] = 9, [4] = 14, [5] = 17, [6] = 17, [7] = 10 }, [1] = { [0] = 27, [1] = 24, [2] = 18, [3] = 17, [4] = 20, [5] = 19, [6] = 17, [7] = 10 }, [2] = { [0] = 111, [1] = 110, [2] = 112, [3] = 107, [4] = 112, [5] = 111, [6] = 109, [7] = 102 }, [3] = { [0] = 111, [1] = 120, [2] = 113, [3] = 112, [4] = 114, [5] = 113, [6] = 111, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 6, [1] = 7, [2] = 12, [3] = 16, [4] = 17, [5] = 21, [6] = 12, [7] = 16 }, [1] = { [0] = 111, [1] = 103, [2] = 113, [3] = 119, [4] = 121, [5] = 118, [6] = 118, [7] = 116 }, [2] = { [0] = 110, [1] = 103, [2] = 112, [3] = 114, [4] = 115, [5] = 119, [6] = 112, [7] = 118 }, [3] = { [0] = 8, [1] = 9, [2] = 9, [3] = 17, [4] = 18, [5] = 20, [6] = 12, [7] = 19 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 13, [2] = 14, [3] = 9, [4] = 14, [5] = 18, [6] = 18, [7] = 10 }, [1] = { [0] = 27, [1] = 24, [2] = 18, [3] = 17, [4] = 20, [5] = 20, [6] = 18, [7] = 10 }, [2] = { [0] = 111, [1] = 110, [2] = 112, [3] = 107, [4] = 112, [5] = 112, [6] = 110, [7] = 102 }, [3] = { [0] = 111, [1] = 120, [2] = 113, [3] = 112, [4] = 114, [5] = 114, [6] = 112, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 8, [2] = 13, [3] = 17, [4] = 18, [5] = 15, [6] = 4, [7] = 17 }, [1] = { [0] = 112, [1] = 104, [2] = 114, [3] = 120, [4] = 122, [5] = 112, [6] = 110, [7] = 117 }, [2] = { [0] = 111, [1] = 104, [2] = 113, [3] = 115, [4] = 116, [5] = 113, [6] = 104, [7] = 119 }, [3] = { [0] = 9, [1] = 10, [2] = 10, [3] = 18, [4] = 19, [5] = 14, [6] = 4, [7] = 20 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 13, [2] = 14, [3] = 10, [4] = 14, [5] = 18, [6] = 18, [7] = 13 }, [1] = { [0] = 27, [1] = 24, [2] = 18, [3] = 18, [4] = 20, [5] = 20, [6] = 18, [7] = 13 }, [2] = { [0] = 111, [1] = 110, [2] = 112, [3] = 108, [4] = 112, [5] = 112, [6] = 110, [7] = 105 }, [3] = { [0] = 111, [1] = 120, [2] = 113, [3] = 113, [4] = 114, [5] = 114, [6] = 112, [7] = 113 } })[R[19]][R[10]], ({ [0] = { [0] = 8, [1] = 9, [2] = 14, [3] = 13, [4] = 19, [5] = 21, [6] = 12, [7] = 6 }, [1] = { [0] = 113, [1] = 105, [2] = 115, [3] = 116, [4] = 123, [5] = 118, [6] = 118, [7] = 106 }, [2] = { [0] = 112, [1] = 105, [2] = 114, [3] = 111, [4] = 117, [5] = 119, [6] = 112, [7] = 108 }, [3] = { [0] = 10, [1] = 11, [2] = 11, [3] = 14, [4] = 20, [5] = 20, [6] = 12, [7] = 9 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 13, [2] = 14, [3] = 10, [4] = 17, [5] = 19, [6] = 19, [7] = 13 }, [1] = { [0] = 27, [1] = 24, [2] = 18, [3] = 18, [4] = 23, [5] = 21, [6] = 19, [7] = 13 }, [2] = { [0] = 111, [1] = 110, [2] = 112, [3] = 108, [4] = 115, [5] = 113, [6] = 111, [7] = 105 }, [3] = { [0] = 111, [1] = 120, [2] = 113, [3] = 113, [4] = 117, [5] = 115, [6] = 113, [7] = 113 } })[R[19]][R[10]], ({ [0] = { [0] = 9, [1] = 10, [2] = 15, [3] = 17, [4] = 5, [5] = 15, [6] = 4, [7] = 19 }, [1] = { [0] = 114, [1] = 106, [2] = 116, [3] = 120, [4] = 109, [5] = 112, [6] = 110, [7] = 119 }, [2] = { [0] = 113, [1] = 106, [2] = 115, [3] = 115, [4] = 103, [5] = 113, [6] = 104, [7] = 121 }, [3] = { [0] = 11, [1] = 12, [2] = 12, [3] = 18, [4] = 6, [5] = 14, [6] = 4, [7] = 22 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 13, [2] = 14, [3] = 11, [4] = 17, [5] = 19, [6] = 19, [7] = 14 }, [1] = { [0] = 27, [1] = 24, [2] = 18, [3] = 19, [4] = 23, [5] = 21, [6] = 19, [7] = 14 }, [2] = { [0] = 111, [1] = 110, [2] = 112, [3] = 109, [4] = 115, [5] = 113, [6] = 111, [7] = 106 }, [3] = { [0] = 111, [1] = 120, [2] = 113, [3] = 114, [4] = 117, [5] = 115, [6] = 113, [7] = 114 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 18, [2] = 16, [3] = 17, [4] = 13, [5] = 21, [6] = 12, [7] = 6 }, [1] = { [0] = 118, [1] = 114, [2] = 117, [3] = 120, [4] = 117, [5] = 118, [6] = 118, [7] = 106 }, [2] = { [0] = 117, [1] = 114, [2] = 116, [3] = 115, [4] = 111, [5] = 119, [6] = 112, [7] = 108 }, [3] = { [0] = 15, [1] = 20, [2] = 13, [3] = 18, [4] = 14, [5] = 20, [6] = 12, [7] = 9 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 14, [2] = 14, [3] = 12, [4] = 17, [5] = 20, [6] = 20, [7] = 14 }, [1] = { [0] = 27, [1] = 25, [2] = 18, [3] = 20, [4] = 23, [5] = 22, [6] = 20, [7] = 14 }, [2] = { [0] = 111, [1] = 111, [2] = 112, [3] = 110, [4] = 115, [5] = 114, [6] = 112, [7] = 106 }, [3] = { [0] = 111, [1] = 121, [2] = 113, [3] = 115, [4] = 117, [5] = 116, [6] = 114, [7] = 114 } })[R[19]][R[10]], ({ [0] = { [0] = 14, [1] = 15, [2] = 17, [3] = 17, [4] = 21, [5] = 15, [6] = 4, [7] = 19 }, [1] = { [0] = 119, [1] = 111, [2] = 118, [3] = 120, [4] = 125, [5] = 112, [6] = 110, [7] = 119 }, [2] = { [0] = 118, [1] = 111, [2] = 117, [3] = 115, [4] = 119, [5] = 113, [6] = 104, [7] = 121 }, [3] = { [0] = 16, [1] = 17, [2] = 14, [3] = 18, [4] = 22, [5] = 14, [6] = 4, [7] = 22 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 14, [2] = 15, [3] = 13, [4] = 18, [5] = 20, [6] = 20, [7] = 15 }, [1] = { [0] = 27, [1] = 25, [2] = 19, [3] = 21, [4] = 24, [5] = 22, [6] = 20, [7] = 15 }, [2] = { [0] = 111, [1] = 111, [2] = 113, [3] = 111, [4] = 116, [5] = 114, [6] = 112, [7] = 107 }, [3] = { [0] = 111, [1] = 121, [2] = 114, [3] = 116, [4] = 118, [5] = 116, [6] = 114, [7] = 115 } })[R[19]][R[10]], ({ [0] = { [0] = 15, [1] = 16, [2] = 11, [3] = 10, [4] = 5, [5] = 21, [6] = 12, [7] = 6 }, [1] = { [0] = 120, [1] = 112, [2] = 112, [3] = 113, [4] = 109, [5] = 118, [6] = 118, [7] = 106 }, [2] = { [0] = 119, [1] = 112, [2] = 111, [3] = 108, [4] = 103, [5] = 119, [6] = 112, [7] = 108 }, [3] = { [0] = 17, [1] = 18, [2] = 8, [3] = 11, [4] = 6, [5] = 20, [6] = 12, [7] = 9 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 14, [2] = 15, [3] = 13, [4] = 18, [5] = 21, [6] = 22, [7] = 15 }, [1] = { [0] = 27, [1] = 25, [2] = 19, [3] = 21, [4] = 24, [5] = 23, [6] = 22, [7] = 15 }, [2] = { [0] = 111, [1] = 111, [2] = 113, [3] = 111, [4] = 116, [5] = 115, [6] = 114, [7] = 107 }, [3] = { [0] = 111, [1] = 121, [2] = 114, [3] = 116, [4] = 118, [5] = 117, [6] = 116, [7] = 115 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 17, [2] = 17, [3] = 17, [4] = 13, [5] = 15, [6] = 6, [7] = 19 }, [1] = { [0] = 121, [1] = 113, [2] = 118, [3] = 120, [4] = 117, [5] = 112, [6] = 112, [7] = 119 }, [2] = { [0] = 120, [1] = 113, [2] = 117, [3] = 115, [4] = 111, [5] = 113, [6] = 106, [7] = 121 }, [3] = { [0] = 18, [1] = 19, [2] = 14, [3] = 18, [4] = 14, [5] = 14, [6] = 6, [7] = 22 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 14, [2] = 16, [3] = 14, [4] = 18, [5] = 21, [6] = 22, [7] = 16 }, [1] = { [0] = 30, [1] = 25, [2] = 20, [3] = 22, [4] = 24, [5] = 23, [6] = 22, [7] = 16 }, [2] = { [0] = 114, [1] = 111, [2] = 114, [3] = 112, [4] = 116, [5] = 115, [6] = 114, [7] = 108 }, [3] = { [0] = 114, [1] = 121, [2] = 115, [3] = 117, [4] = 118, [5] = 117, [6] = 116, [7] = 116 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 11, [3] = 10, [4] = 21, [5] = 21, [6] = 7, [7] = 6 }, [1] = { [0] = 116, [1] = 114, [2] = 112, [3] = 113, [4] = 125, [5] = 118, [6] = 113, [7] = 106 }, [2] = { [0] = 115, [1] = 114, [2] = 111, [3] = 108, [4] = 119, [5] = 119, [6] = 107, [7] = 108 }, [3] = { [0] = 13, [1] = 20, [2] = 8, [3] = 11, [4] = 22, [5] = 20, [6] = 7, [7] = 9 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 14, [2] = 16, [3] = 15, [4] = 19, [5] = 22, [6] = 22, [7] = 16 }, [1] = { [0] = 31, [1] = 25, [2] = 20, [3] = 23, [4] = 25, [5] = 24, [6] = 22, [7] = 16 }, [2] = { [0] = 115, [1] = 111, [2] = 114, [3] = 113, [4] = 117, [5] = 116, [6] = 114, [7] = 108 }, [3] = { [0] = 115, [1] = 121, [2] = 115, [3] = 118, [4] = 119, [5] = 118, [6] = 116, [7] = 116 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 19, [2] = 17, [3] = 10, [4] = 5, [5] = 15, [6] = 8, [7] = 19 }, [1] = { [0] = 116, [1] = 115, [2] = 118, [3] = 113, [4] = 109, [5] = 112, [6] = 114, [7] = 119 }, [2] = { [0] = 115, [1] = 115, [2] = 117, [3] = 108, [4] = 103, [5] = 113, [6] = 108, [7] = 121 }, [3] = { [0] = 13, [1] = 21, [2] = 14, [3] = 11, [4] = 6, [5] = 14, [6] = 8, [7] = 22 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 14, [2] = 17, [3] = 16, [4] = 19, [5] = 23, [6] = 22, [7] = 17 }, [1] = { [0] = 32, [1] = 25, [2] = 21, [3] = 24, [4] = 25, [5] = 25, [6] = 22, [7] = 17 }, [2] = { [0] = 116, [1] = 111, [2] = 115, [3] = 114, [4] = 117, [5] = 117, [6] = 114, [7] = 109 }, [3] = { [0] = 116, [1] = 121, [2] = 116, [3] = 119, [4] = 119, [5] = 119, [6] = 116, [7] = 117 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 20, [2] = 11, [3] = 10, [4] = 6, [5] = 15, [6] = 9, [7] = 6 }, [1] = { [0] = 116, [1] = 116, [2] = 112, [3] = 113, [4] = 110, [5] = 112, [6] = 115, [7] = 106 }, [2] = { [0] = 115, [1] = 116, [2] = 111, [3] = 108, [4] = 104, [5] = 113, [6] = 109, [7] = 108 }, [3] = { [0] = 13, [1] = 22, [2] = 8, [3] = 11, [4] = 7, [5] = 14, [6] = 9, [7] = 9 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 14, [2] = 17, [3] = 17, [4] = 19, [5] = 24, [6] = 22, [7] = 17 }, [1] = { [0] = 33, [1] = 25, [2] = 21, [3] = 25, [4] = 25, [5] = 26, [6] = 22, [7] = 17 }, [2] = { [0] = 117, [1] = 111, [2] = 115, [3] = 115, [4] = 117, [5] = 118, [6] = 114, [7] = 109 }, [3] = { [0] = 117, [1] = 121, [2] = 116, [3] = 120, [4] = 119, [5] = 120, [6] = 116, [7] = 117 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 25, [2] = 17, [3] = 10, [4] = 13, [5] = 15, [6] = 10, [7] = 7 }, [1] = { [0] = 116, [1] = 121, [2] = 118, [3] = 113, [4] = 117, [5] = 112, [6] = 116, [7] = 107 }, [2] = { [0] = 115, [1] = 121, [2] = 117, [3] = 108, [4] = 111, [5] = 113, [6] = 110, [7] = 109 }, [3] = { [0] = 13, [1] = 27, [2] = 14, [3] = 11, [4] = 14, [5] = 14, [6] = 10, [7] = 10 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 14, [2] = 18, [3] = 18, [4] = 19, [5] = 24, [6] = 26, [7] = 17 }, [1] = { [0] = 34, [1] = 25, [2] = 22, [3] = 26, [4] = 25, [5] = 26, [6] = 26, [7] = 17 }, [2] = { [0] = 118, [1] = 111, [2] = 116, [3] = 116, [4] = 117, [5] = 118, [6] = 118, [7] = 109 }, [3] = { [0] = 118, [1] = 121, [2] = 117, [3] = 121, [4] = 119, [5] = 120, [6] = 120, [7] = 117 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 26, [2] = 11, [3] = 10, [4] = 21, [5] = 16, [6] = 12, [7] = 8 }, [1] = { [0] = 116, [1] = 122, [2] = 112, [3] = 113, [4] = 125, [5] = 113, [6] = 118, [7] = 108 }, [2] = { [0] = 115, [1] = 122, [2] = 111, [3] = 108, [4] = 119, [5] = 114, [6] = 112, [7] = 110 }, [3] = { [0] = 13, [1] = 28, [2] = 8, [3] = 11, [4] = 22, [5] = 15, [6] = 12, [7] = 11 } })[R[19]][R[10]] })
    if R[10] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[19]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[19]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[19]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[19]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[19]] })
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [2] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 } })[R[29]][R[19]], ({ [0] = { [0] = 5, [1] = 110, [2] = 109, [3] = 7 }, [1] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [2] = { [0] = 17, [1] = 122, [2] = 121, [3] = 19 } })[R[29]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[19]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 5, [1] = 16, [2] = 102, [3] = 112 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 } })[R[30]][R[19]], ({ [0] = { [0] = 22, [1] = 118, [2] = 118, [3] = 24 }, [1] = { [0] = 24, [1] = 120, [2] = 120, [3] = 26 }, [2] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 } })[R[30]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 9, [1] = 13, [2] = 107, [3] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [2] = { [0] = 27, [1] = 31, [2] = 125, [3] = 126 } })[R[31]][R[19]], ({ [0] = { [0] = 5, [1] = 106, [2] = 105, [3] = 2 }, [1] = { [0] = 21, [1] = 122, [2] = 121, [3] = 18 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 } })[R[31]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[19]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [1] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [2] = { [0] = 4, [1] = 12, [2] = 102, [3] = 107 } })[R[32]][R[19]], ({ [0] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 123, [2] = 118, [3] = 21 }, [2] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 } })[R[32]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [1] = { [0] = 9, [1] = 15, [2] = 107, [3] = 109 }, [2] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 } })[R[33]][R[19]], ({ [0] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [1] = { [0] = 12, [1] = 116, [2] = 110, [3] = 13 }, [2] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 } })[R[33]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[19]] })
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [1] = { [0] = 3, [1] = 5, [2] = 97, [3] = 99 }, [2] = { [0] = 25, [1] = 27, [2] = 119, [3] = 121 } })[R[34]][R[19]], ({ [0] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 }, [1] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [2] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 } })[R[34]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
        for i = 1, game.initial_units() do
          R[35] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 8, [1] = 8, [2] = 100, [3] = 102 }, [1] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [2] = { [0] = 34, [1] = 34, [2] = 126, [3] = 128 } })[R[35]][R[19]], ({ [0] = { [0] = 2, [1] = 108, [2] = 102, [3] = 2 }, [1] = { [0] = 0, [1] = 106, [2] = 100, [3] = 0 }, [2] = { [0] = 15, [1] = 121, [2] = 115, [3] = 15 } })[R[35]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[19]] })
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 }, [1] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 }, [2] = { [0] = 9, [1] = 9, [2] = 101, [3] = 109 } })[R[36]][R[19]], ({ [0] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [1] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [2] = { [0] = 23, [1] = 123, [2] = 125, [3] = 26 } })[R[36]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[19]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[37]][R[20]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 8, [1] = 12, [2] = 106, [3] = 107 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 5, [1] = 101, [2] = 101, [3] = 7 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    if R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 } })[R[37]][R[20]], ({ [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 17, [1] = 121, [2] = 115, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 10, [1] = 18, [2] = 108, [3] = 113 })[R[20]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[20]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 0 or R[37] == 1 or R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 23, [1] = 23, [2] = 115, [3] = 117 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 12, [1] = 108, [2] = 108, [3] = 14 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 20, [1] = 117, [2] = 118, [3] = 19 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 0 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 1 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 2 then
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
      elseif R[37] == 5 then
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
      elseif R[37] == 6 then
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
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 31, [1] = 31, [2] = 123, [3] = 125 }, [7] = { [0] = 25, [1] = 25, [2] = 117, [3] = 125 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 123, [2] = 122, [3] = 20 }, [1] = { [0] = 30, [1] = 126, [2] = 126, [3] = 32 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 14, [1] = 14, [2] = 106, [3] = 108 }, [7] = { [0] = 26, [1] = 26, [2] = 118, [3] = 126 } })[R[37]][R[20]], ({ [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 18, [1] = 118, [2] = 120, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 0 or R[37] == 1 then
      else
        unseen("R[37]", R[37])
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 12, [1] = 16, [2] = 100, [3] = 100 }, [1] = { [0] = 4, [1] = 15, [2] = 101, [3] = 111 }, [2] = { [0] = 28, [1] = 32, [2] = 126, [3] = 127 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 6, [1] = 12, [2] = 104, [3] = 106 }, [5] = { [0] = 4, [1] = 6, [2] = 98, [3] = 100 }, [6] = { [0] = 6, [1] = 6, [2] = 98, [3] = 100 }, [7] = { [0] = 18, [1] = 18, [2] = 110, [3] = 118 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 125, [2] = 124, [3] = 22 }, [1] = { [0] = 27, [1] = 123, [2] = 123, [3] = 29 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 4, [1] = 107, [2] = 102, [3] = 5 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 22, [1] = 122, [2] = 124, [3] = 25 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 24, [1] = 30, [2] = 122, [3] = 124 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[37]][R[20]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 6, [1] = 103, [2] = 104, [3] = 5 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[37]][R[20]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 11, [1] = 107, [2] = 107, [3] = 13 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[37] == 0 or R[37] == 1 or R[37] == 2 or R[37] == 4 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 25, [1] = 33, [2] = 123, [3] = 128 })[R[20]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 7, [1] = 110, [2] = 105, [3] = 8 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 21, [2] = 105, [3] = 105 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 21, [2] = 105, [3] = 105 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 28, [1] = 32, [2] = 116, [3] = 116 })[R[20]], ({ [0] = 13, [1] = 118, [2] = 117, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 4, [1] = 109, [2] = 108, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 21, [2] = 105, [3] = 105 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 28, [1] = 32, [2] = 116, [3] = 116 })[R[20]], ({ [0] = 13, [1] = 118, [2] = 117, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 4, [1] = 109, [2] = 108, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 4, [1] = 109, [2] = 108, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 3, [1] = 14, [2] = 100, [3] = 110 })[R[20]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[20]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 3, [1] = 14, [2] = 100, [3] = 110 })[R[20]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[20]], ({ [0] = 7, [1] = 103, [2] = 103, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 9, [1] = 20, [2] = 106, [3] = 116 })[R[20]], ({ [0] = 4, [1] = 100, [2] = 100, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 3, [1] = 14, [2] = 100, [3] = 110 })[R[20]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[20]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[20]], ({ [0] = 7, [1] = 103, [2] = 103, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 9, [1] = 20, [2] = 106, [3] = 116 })[R[20]], ({ [0] = 4, [1] = 100, [2] = 100, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[20]], ({ [0] = 7, [1] = 103, [2] = 103, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 9, [1] = 20, [2] = 106, [3] = 116 })[R[20]], ({ [0] = 4, [1] = 100, [2] = 100, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 13, [1] = 114, [2] = 113, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 13, [1] = 114, [2] = 113, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 6, [1] = 10, [2] = 104, [3] = 105 })[R[20]], ({ [0] = 16, [1] = 117, [2] = 116, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 120, [2] = 119, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[20]], ({ [0] = 20, [1] = 121, [2] = 120, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 13, [1] = 114, [2] = 113, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 6, [1] = 10, [2] = 104, [3] = 105 })[R[20]], ({ [0] = 16, [1] = 117, [2] = 116, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 120, [2] = 119, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[20]], ({ [0] = 20, [1] = 121, [2] = 120, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 120, [2] = 119, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[20]], ({ [0] = 20, [1] = 121, [2] = 120, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 5, [1] = 13, [2] = 103, [3] = 108 })[R[20]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 5, [1] = 13, [2] = 103, [3] = 108 })[R[20]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 5, [1] = 13, [2] = 103, [3] = 108 })[R[20]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 7, [1] = 110, [2] = 105, [3] = 8 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 4 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 32, [2] = 124, [3] = 126 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 32, [2] = 124, [3] = 126 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 24, [2] = 116, [3] = 118 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 25, [2] = 117, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 121, [2] = 115, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 8, [1] = 112, [2] = 106, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 32, [2] = 124, [3] = 126 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 24, [2] = 116, [3] = 118 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 25, [2] = 117, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 121, [2] = 115, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 8, [1] = 112, [2] = 106, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 25, [2] = 117, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 121, [2] = 115, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 8, [1] = 112, [2] = 106, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 5 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 24, [2] = 116, [3] = 118 })[R[20]], ({ [0] = 8, [1] = 105, [2] = 106, [3] = 7 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 24, [2] = 116, [3] = 118 })[R[20]], ({ [0] = 8, [1] = 105, [2] = 106, [3] = 7 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 10, [1] = 12, [2] = 104, [3] = 106 })[R[20]], ({ [0] = 16, [1] = 113, [2] = 114, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 9, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 5, [1] = 102, [2] = 103, [3] = 4 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 112, [3] = 114 })[R[20]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 24, [2] = 116, [3] = 118 })[R[20]], ({ [0] = 8, [1] = 105, [2] = 106, [3] = 7 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 10, [1] = 12, [2] = 104, [3] = 106 })[R[20]], ({ [0] = 16, [1] = 113, [2] = 114, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 9, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 5, [1] = 102, [2] = 103, [3] = 4 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 112, [3] = 114 })[R[20]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 9, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 5, [1] = 102, [2] = 103, [3] = 4 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 112, [3] = 114 })[R[20]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 11, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 117, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 11, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 117, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 26, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 4, [1] = 110, [2] = 104, [3] = 4 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 18, [2] = 110, [3] = 112 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 114, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 11, [1] = 117, [2] = 111, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 11, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 117, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 26, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 4, [1] = 110, [2] = 104, [3] = 4 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 18, [2] = 110, [3] = 112 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 114, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 11, [1] = 117, [2] = 111, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 18, [2] = 110, [3] = 112 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 114, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 11, [1] = 117, [2] = 111, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 7 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 28, [1] = 28, [2] = 120, [3] = 128 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 28, [1] = 28, [2] = 120, [3] = 128 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 127 })[R[20]], ({ [0] = 7, [1] = 107, [2] = 109, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 12, [2] = 104, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 7, [1] = 7, [2] = 99, [3] = 107 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 28, [1] = 28, [2] = 120, [3] = 128 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 127 })[R[20]], ({ [0] = 7, [1] = 107, [2] = 109, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 12, [2] = 104, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 7, [1] = 7, [2] = 99, [3] = 107 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 12, [2] = 104, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 7, [1] = 7, [2] = 99, [3] = 107 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 27, [1] = 33, [2] = 125, [3] = 127 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 } })[R[37]][R[20]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 8, [1] = 111, [2] = 106, [3] = 9 }, [4] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [5] = { [0] = 22, [1] = 119, [2] = 120, [3] = 21 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 19, [2] = 103, [3] = 103 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 }, [5] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 9, [1] = 109, [2] = 111, [3] = 12 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 12, [1] = 16, [2] = 110, [3] = 111 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 18, [1] = 121, [2] = 116, [3] = 19 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 12, [1] = 109, [2] = 110, [3] = 11 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 8, [1] = 19, [2] = 105, [3] = 115 }, [2] = { [0] = 13, [1] = 17, [2] = 111, [3] = 112 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 19, [1] = 122, [2] = 117, [3] = 20 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 11, [1] = 111, [2] = 113, [3] = 14 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 22, [2] = 106, [3] = 106 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 8, [1] = 109, [2] = 108, [3] = 5 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 10, [1] = 114, [2] = 108, [3] = 11 }, [5] = { [0] = 17, [1] = 114, [2] = 115, [3] = 16 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 10, [1] = 21, [2] = 107, [3] = 117 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 9, [1] = 110, [2] = 109, [3] = 6 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 11, [1] = 115, [2] = 109, [3] = 12 }, [5] = { [0] = 18, [1] = 115, [2] = 116, [3] = 17 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 24, [2] = 108, [3] = 108 }, [1] = { [0] = 11, [1] = 22, [2] = 108, [3] = 118 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 16, [1] = 16, [2] = 108, [3] = 110 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 10, [1] = 111, [2] = 110, [3] = 7 }, [3] = { [0] = 14, [1] = 117, [2] = 112, [3] = 15 }, [4] = { [0] = 15, [1] = 119, [2] = 113, [3] = 16 }, [5] = { [0] = 19, [1] = 116, [2] = 117, [3] = 18 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 14, [1] = 114, [2] = 116, [3] = 17 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 25, [2] = 109, [3] = 109 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 15, [1] = 118, [2] = 113, [3] = 16 }, [4] = { [0] = 16, [1] = 120, [2] = 114, [3] = 17 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 6, [1] = 111, [2] = 110, [3] = 8 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 12, [1] = 113, [2] = 112, [3] = 9 }, [3] = { [0] = 16, [1] = 119, [2] = 114, [3] = 17 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 16, [1] = 116, [2] = 118, [3] = 19 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 8, [1] = 104, [2] = 104, [3] = 10 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 18, [1] = 122, [2] = 116, [3] = 19 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 17, [1] = 117, [2] = 119, [3] = 20 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[37]][R[20]], ({ [0] = { [0] = 8, [1] = 113, [2] = 112, [3] = 10 }, [1] = { [0] = 9, [1] = 105, [2] = 105, [3] = 11 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 19, [1] = 123, [2] = 117, [3] = 20 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[37]][R[20]], ({ [0] = { [0] = 9, [1] = 114, [2] = 113, [3] = 11 }, [1] = { [0] = 10, [1] = 106, [2] = 106, [3] = 12 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 12, [1] = 20, [2] = 110, [3] = 115 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[37]][R[20]], ({ [0] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [1] = { [0] = 15, [1] = 111, [2] = 111, [3] = 17 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[37]][R[20]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 121, [2] = 120, [3] = 18 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 30, [2] = 114, [3] = 114 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 14, [1] = 22, [2] = 112, [3] = 117 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 31, [2] = 115, [3] = 115 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 19, [1] = 115, [2] = 115, [3] = 21 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 23, [1] = 25, [2] = 117, [3] = 119 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 20, [1] = 116, [2] = 116, [3] = 22 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 6, [1] = 110, [2] = 104, [3] = 7 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 25, [1] = 121, [2] = 121, [3] = 27 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 34, [2] = 118, [3] = 118 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 18, [1] = 22, [2] = 116, [3] = 117 }, [3] = { [0] = 18, [1] = 26, [2] = 116, [3] = 121 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 26, [1] = 122, [2] = 122, [3] = 28 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 8, [1] = 108, [2] = 110, [3] = 11 } })[R[37]][R[20]] })
    if R[37] == 0 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [2] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 } })[R[38]][R[20]], ({ [0] = { [0] = 5, [1] = 110, [2] = 109, [3] = 7 }, [1] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [2] = { [0] = 17, [1] = 122, [2] = 121, [3] = 19 } })[R[38]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[20]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 5, [1] = 16, [2] = 102, [3] = 112 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 } })[R[39]][R[20]], ({ [0] = { [0] = 22, [1] = 118, [2] = 118, [3] = 24 }, [1] = { [0] = 24, [1] = 120, [2] = 120, [3] = 26 }, [2] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 } })[R[39]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 9, [1] = 13, [2] = 107, [3] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [2] = { [0] = 27, [1] = 31, [2] = 125, [3] = 126 } })[R[40]][R[20]], ({ [0] = { [0] = 5, [1] = 106, [2] = 105, [3] = 2 }, [1] = { [0] = 21, [1] = 122, [2] = 121, [3] = 18 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 } })[R[40]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[20]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[20]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[20]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [1] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [2] = { [0] = 4, [1] = 12, [2] = 102, [3] = 107 } })[R[41]][R[20]], ({ [0] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 123, [2] = 118, [3] = 21 }, [2] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 } })[R[41]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [1] = { [0] = 9, [1] = 15, [2] = 107, [3] = 109 }, [2] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 } })[R[42]][R[20]], ({ [0] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [1] = { [0] = 12, [1] = 116, [2] = 110, [3] = 13 }, [2] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 } })[R[42]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 5 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[20]] })
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [1] = { [0] = 3, [1] = 5, [2] = 97, [3] = 99 }, [2] = { [0] = 25, [1] = 27, [2] = 119, [3] = 121 } })[R[43]][R[20]], ({ [0] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 }, [1] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [2] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 } })[R[43]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 8, [1] = 8, [2] = 100, [3] = 102 }, [1] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [2] = { [0] = 34, [1] = 34, [2] = 126, [3] = 128 } })[R[44]][R[20]], ({ [0] = { [0] = 2, [1] = 108, [2] = 102, [3] = 2 }, [1] = { [0] = 0, [1] = 106, [2] = 100, [3] = 0 }, [2] = { [0] = 15, [1] = 121, [2] = 115, [3] = 15 } })[R[44]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[20]] })
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 }, [1] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 }, [2] = { [0] = 9, [1] = 9, [2] = 101, [3] = 109 } })[R[45]][R[20]], ({ [0] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [1] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [2] = { [0] = 23, [1] = 123, [2] = 125, [3] = 26 } })[R[45]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
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
    players[3].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[3].difficulty]]
    players[3].scientists = 16 - 3 * LEVEL_OF[players[3].difficulty]
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
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 103, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 126 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 125, 126 } }
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 67, 65 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 69, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 81, 95 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 38, 43 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 111, 46 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 113, 35 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 17, 39 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 52, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 84, 16 } }
    pick(4, 4, { 0, 19, 20, 46 })
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 8, [1] = 12, [2] = 106, [3] = 107 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 5, [1] = 101, [2] = 101, [3] = 7 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[1] == 0 or R[1] == 1 or R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 23, [1] = 23, [2] = 115, [3] = 117 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 12, [1] = 108, [2] = 108, [3] = 14 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 20, [1] = 117, [2] = 118, [3] = 19 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 0 then
        if LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 1 then
        if LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 2 then
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
      elseif R[1] == 5 then
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
      elseif R[1] == 6 then
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 31, [1] = 31, [2] = 123, [3] = 125 }, [7] = { [0] = 25, [1] = 25, [2] = 117, [3] = 125 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 123, [2] = 122, [3] = 20 }, [1] = { [0] = 30, [1] = 126, [2] = 126, [3] = 32 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 14, [1] = 14, [2] = 106, [3] = 108 }, [7] = { [0] = 26, [1] = 26, [2] = 118, [3] = 126 } })[R[1]][R[0]], ({ [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 18, [1] = 118, [2] = 120, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 0 or R[1] == 1 then
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 } })[R[1]][R[0]], ({ [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 3 then
      elseif R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 25, [1] = 31, [2] = 123, [3] = 125 } })[R[1]][R[0]], ({ [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 3 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 4 then
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
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 12, [1] = 16, [2] = 100, [3] = 100 }, [1] = { [0] = 4, [1] = 15, [2] = 101, [3] = 111 }, [2] = { [0] = 28, [1] = 32, [2] = 126, [3] = 127 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 6, [1] = 12, [2] = 104, [3] = 106 }, [5] = { [0] = 4, [1] = 6, [2] = 98, [3] = 100 }, [6] = { [0] = 6, [1] = 6, [2] = 98, [3] = 100 }, [7] = { [0] = 18, [1] = 18, [2] = 110, [3] = 118 } })[R[1]][R[0]], ({ [0] = { [0] = 20, [1] = 125, [2] = 124, [3] = 22 }, [1] = { [0] = 27, [1] = 123, [2] = 123, [3] = 29 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 4, [1] = 107, [2] = 102, [3] = 5 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 22, [1] = 122, [2] = 124, [3] = 25 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 24, [1] = 30, [2] = 122, [3] = 124 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 6, [1] = 103, [2] = 104, [3] = 5 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 11, [1] = 107, [2] = 107, [3] = 13 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 25, [1] = 33, [2] = 123, [3] = 128 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 9, [1] = 11, [2] = 103, [3] = 105 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 12, [1] = 12, [2] = 104, [3] = 112 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 19, [1] = 120, [2] = 119, [3] = 16 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 5, [1] = 102, [2] = 103, [3] = 4 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 21, [1] = 27, [2] = 119, [3] = 121 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 7, [1] = 7, [2] = 99, [3] = 107 } })[R[1]][R[0]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 4, [1] = 100, [2] = 100, [3] = 6 }, [2] = { [0] = 20, [1] = 121, [2] = 120, [3] = 17 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 11, [1] = 117, [2] = 111, [3] = 11 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 25, [1] = 33, [2] = 123, [3] = 128 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 9, [1] = 11, [2] = 103, [3] = 105 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 12, [1] = 12, [2] = 104, [3] = 112 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 19, [1] = 120, [2] = 119, [3] = 16 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 5, [1] = 102, [2] = 103, [3] = 4 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 21, [1] = 27, [2] = 119, [3] = 121 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 7, [1] = 7, [2] = 99, [3] = 107 } })[R[1]][R[0]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 4, [1] = 100, [2] = 100, [3] = 6 }, [2] = { [0] = 20, [1] = 121, [2] = 120, [3] = 17 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 11, [1] = 117, [2] = 111, [3] = 11 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 25, [1] = 33, [2] = 123, [3] = 128 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 9, [1] = 11, [2] = 103, [3] = 105 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 12, [1] = 12, [2] = 104, [3] = 112 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 19, [1] = 120, [2] = 119, [3] = 16 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 5, [1] = 102, [2] = 103, [3] = 4 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 21, [1] = 27, [2] = 119, [3] = 121 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 7, [1] = 7, [2] = 99, [3] = 107 } })[R[1]][R[0]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 4, [1] = 100, [2] = 100, [3] = 6 }, [2] = { [0] = 20, [1] = 121, [2] = 120, [3] = 17 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 11, [1] = 117, [2] = 111, [3] = 11 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 27, [1] = 33, [2] = 125, [3] = 127 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 } })[R[1]][R[0]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 8, [1] = 111, [2] = 106, [3] = 9 }, [4] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [5] = { [0] = 22, [1] = 119, [2] = 120, [3] = 21 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 19, [2] = 103, [3] = 103 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 }, [5] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 9, [1] = 109, [2] = 111, [3] = 12 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 12, [1] = 16, [2] = 110, [3] = 111 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 18, [1] = 121, [2] = 116, [3] = 19 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 12, [1] = 109, [2] = 110, [3] = 11 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 8, [1] = 19, [2] = 105, [3] = 115 }, [2] = { [0] = 13, [1] = 17, [2] = 111, [3] = 112 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 19, [1] = 122, [2] = 117, [3] = 20 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 11, [1] = 111, [2] = 113, [3] = 14 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 22, [2] = 106, [3] = 106 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 8, [1] = 109, [2] = 108, [3] = 5 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 10, [1] = 114, [2] = 108, [3] = 11 }, [5] = { [0] = 17, [1] = 114, [2] = 115, [3] = 16 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 10, [1] = 21, [2] = 107, [3] = 117 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 9, [1] = 110, [2] = 109, [3] = 6 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 11, [1] = 115, [2] = 109, [3] = 12 }, [5] = { [0] = 18, [1] = 115, [2] = 116, [3] = 17 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 24, [2] = 108, [3] = 108 }, [1] = { [0] = 11, [1] = 22, [2] = 108, [3] = 118 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 16, [1] = 16, [2] = 108, [3] = 110 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 10, [1] = 111, [2] = 110, [3] = 7 }, [3] = { [0] = 14, [1] = 117, [2] = 112, [3] = 15 }, [4] = { [0] = 15, [1] = 119, [2] = 113, [3] = 16 }, [5] = { [0] = 19, [1] = 116, [2] = 117, [3] = 18 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 14, [1] = 114, [2] = 116, [3] = 17 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 25, [2] = 109, [3] = 109 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 15, [1] = 118, [2] = 113, [3] = 16 }, [4] = { [0] = 16, [1] = 120, [2] = 114, [3] = 17 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 6, [1] = 111, [2] = 110, [3] = 8 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 12, [1] = 113, [2] = 112, [3] = 9 }, [3] = { [0] = 16, [1] = 119, [2] = 114, [3] = 17 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 16, [1] = 116, [2] = 118, [3] = 19 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[1]][R[0]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 8, [1] = 104, [2] = 104, [3] = 10 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 18, [1] = 122, [2] = 116, [3] = 19 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 17, [1] = 117, [2] = 119, [3] = 20 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[1]][R[0]], ({ [0] = { [0] = 8, [1] = 113, [2] = 112, [3] = 10 }, [1] = { [0] = 9, [1] = 105, [2] = 105, [3] = 11 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 19, [1] = 123, [2] = 117, [3] = 20 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 114, [2] = 113, [3] = 11 }, [1] = { [0] = 10, [1] = 106, [2] = 106, [3] = 12 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 12, [1] = 20, [2] = 110, [3] = 115 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[1]][R[0]], ({ [0] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [1] = { [0] = 15, [1] = 111, [2] = 111, [3] = 17 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[1]][R[0]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 121, [2] = 120, [3] = 18 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 30, [2] = 114, [3] = 114 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 14, [1] = 22, [2] = 112, [3] = 117 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 31, [2] = 115, [3] = 115 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 19, [1] = 115, [2] = 115, [3] = 21 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 23, [1] = 25, [2] = 117, [3] = 119 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 20, [1] = 116, [2] = 116, [3] = 22 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 6, [1] = 110, [2] = 104, [3] = 7 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 25, [1] = 121, [2] = 121, [3] = 27 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 34, [2] = 118, [3] = 118 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 18, [1] = 22, [2] = 116, [3] = 117 }, [3] = { [0] = 18, [1] = 26, [2] = 116, [3] = 121 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 26, [1] = 122, [2] = 122, [3] = 28 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 8, [1] = 108, [2] = 110, [3] = 11 } })[R[1]][R[0]] })
    if R[1] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[0]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[0]] })
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [2] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 } })[R[47]][R[0]], ({ [0] = { [0] = 5, [1] = 110, [2] = 109, [3] = 7 }, [1] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [2] = { [0] = 17, [1] = 122, [2] = 121, [3] = 19 } })[R[47]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[0]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[0]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 5, [1] = 16, [2] = 102, [3] = 112 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 } })[R[48]][R[0]], ({ [0] = { [0] = 22, [1] = 118, [2] = 118, [3] = 24 }, [1] = { [0] = 24, [1] = 120, [2] = 120, [3] = 26 }, [2] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 } })[R[48]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 9, [1] = 13, [2] = 107, [3] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [2] = { [0] = 27, [1] = 31, [2] = 125, [3] = 126 } })[R[49]][R[0]], ({ [0] = { [0] = 5, [1] = 106, [2] = 105, [3] = 2 }, [1] = { [0] = 21, [1] = 122, [2] = 121, [3] = 18 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 } })[R[49]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[0]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[0]] })
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [1] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [2] = { [0] = 4, [1] = 12, [2] = 102, [3] = 107 } })[R[50]][R[0]], ({ [0] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 123, [2] = 118, [3] = 21 }, [2] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 } })[R[50]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[0]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[0]] })
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [1] = { [0] = 9, [1] = 15, [2] = 107, [3] = 109 }, [2] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 } })[R[51]][R[0]], ({ [0] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [1] = { [0] = 12, [1] = 116, [2] = 110, [3] = 13 }, [2] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 } })[R[51]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[0]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[0]] })
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [1] = { [0] = 3, [1] = 5, [2] = 97, [3] = 99 }, [2] = { [0] = 25, [1] = 27, [2] = 119, [3] = 121 } })[R[52]][R[0]], ({ [0] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 }, [1] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [2] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 } })[R[52]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[0]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[0]] })
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 8, [1] = 8, [2] = 100, [3] = 102 }, [1] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [2] = { [0] = 34, [1] = 34, [2] = 126, [3] = 128 } })[R[53]][R[0]], ({ [0] = { [0] = 2, [1] = 108, [2] = 102, [3] = 2 }, [1] = { [0] = 0, [1] = 106, [2] = 100, [3] = 0 }, [2] = { [0] = 15, [1] = 121, [2] = 115, [3] = 15 } })[R[53]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[0]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[0]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[0]] })
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 }, [1] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 }, [2] = { [0] = 9, [1] = 9, [2] = 101, [3] = 109 } })[R[54]][R[0]], ({ [0] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [1] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [2] = { [0] = 23, [1] = 123, [2] = 125, [3] = 26 } })[R[54]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 3, [2] = 14, [3] = 15, [4] = 14, [5] = 14, [6] = 13, [7] = 17 }, [1] = { [0] = 27, [1] = 14, [2] = 18, [3] = 23, [4] = 20, [5] = 16, [6] = 13, [7] = 17 }, [2] = { [0] = 111, [1] = 100, [2] = 112, [3] = 113, [4] = 112, [5] = 108, [6] = 105, [7] = 109 }, [3] = { [0] = 111, [1] = 110, [2] = 113, [3] = 118, [4] = 114, [5] = 110, [6] = 107, [7] = 117 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 6, [3] = 17, [4] = 13, [5] = 15, [6] = 4, [7] = 13 }, [1] = { [0] = 116, [1] = 114, [2] = 107, [3] = 120, [4] = 117, [5] = 112, [6] = 110, [7] = 113 }, [2] = { [0] = 115, [1] = 114, [2] = 106, [3] = 115, [4] = 111, [5] = 113, [6] = 104, [7] = 115 }, [3] = { [0] = 13, [1] = 20, [2] = 3, [3] = 18, [4] = 14, [5] = 14, [6] = 4, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 23, [1] = 3, [2] = 14, [3] = 15, [4] = 14, [5] = 14, [6] = 13, [7] = 17 }, [1] = { [0] = 27, [1] = 14, [2] = 18, [3] = 23, [4] = 20, [5] = 16, [6] = 13, [7] = 17 }, [2] = { [0] = 111, [1] = 100, [2] = 112, [3] = 113, [4] = 112, [5] = 108, [6] = 105, [7] = 109 }, [3] = { [0] = 111, [1] = 110, [2] = 113, [3] = 118, [4] = 114, [5] = 110, [6] = 107, [7] = 117 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 6, [3] = 17, [4] = 13, [5] = 15, [6] = 4, [7] = 13 }, [1] = { [0] = 116, [1] = 114, [2] = 107, [3] = 120, [4] = 117, [5] = 112, [6] = 110, [7] = 113 }, [2] = { [0] = 115, [1] = 114, [2] = 106, [3] = 115, [4] = 111, [5] = 113, [6] = 104, [7] = 115 }, [3] = { [0] = 13, [1] = 20, [2] = 3, [3] = 18, [4] = 14, [5] = 14, [6] = 4, [7] = 16 } })[R[19]][R[10]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 13, [2] = 8, [3] = 23, [4] = 14, [5] = 14, [6] = 22, [7] = 10 }, [1] = { [0] = 27, [1] = 24, [2] = 12, [3] = 31, [4] = 20, [5] = 16, [6] = 22, [7] = 10 }, [2] = { [0] = 111, [1] = 110, [2] = 106, [3] = 121, [4] = 112, [5] = 108, [6] = 114, [7] = 102 }, [3] = { [0] = 111, [1] = 120, [2] = 107, [3] = 126, [4] = 114, [5] = 110, [6] = 116, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 4, [1] = 5, [2] = 11, [3] = 21, [4] = 21, [5] = 21, [6] = 4, [7] = 19 }, [1] = { [0] = 109, [1] = 101, [2] = 112, [3] = 124, [4] = 125, [5] = 118, [6] = 110, [7] = 119 }, [2] = { [0] = 108, [1] = 101, [2] = 111, [3] = 119, [4] = 119, [5] = 119, [6] = 104, [7] = 121 }, [3] = { [0] = 6, [1] = 7, [2] = 8, [3] = 22, [4] = 22, [5] = 20, [6] = 4, [7] = 22 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [3] = 7, [4] = 14 }, [1] = { [3] = 15, [4] = 20 }, [2] = { [3] = 105, [4] = 112 }, [3] = { [3] = 110, [4] = 114 } })[R[19]][R[10]], ({ [0] = { [3] = 21, [4] = 5 }, [1] = { [3] = 124, [4] = 109 }, [2] = { [3] = 119, [4] = 103 }, [3] = { [3] = 22, [4] = 6 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
      elseif R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [3] = 10, [4] = 25 }, [1] = { [3] = 18, [4] = 31 }, [2] = { [3] = 108, [4] = 123 }, [3] = { [3] = 113, [4] = 125 } })[R[19]][R[10]], ({ [0] = { [3] = 10, [4] = 17 }, [1] = { [3] = 113, [4] = 121 }, [2] = { [3] = 108, [4] = 115 }, [3] = { [3] = 11, [4] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 4 then
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
        unseen("R[10]", R[10])
      end
    elseif R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 35, [1] = 14, [2] = 11, [5] = 24, [6] = 23, [7] = 10 }, [1] = { [0] = 39, [1] = 25, [2] = 15, [5] = 26, [6] = 23, [7] = 10 }, [2] = { [0] = 123, [1] = 111, [2] = 109, [5] = 118, [6] = 115, [7] = 102 }, [3] = { [0] = 123, [1] = 121, [2] = 110, [5] = 120, [6] = 117, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 12, [2] = 17, [5] = 20, [6] = 12, [7] = 6 }, [1] = { [0] = 116, [1] = 108, [2] = 118, [5] = 117, [6] = 118, [7] = 106 }, [2] = { [0] = 115, [1] = 108, [2] = 117, [5] = 118, [6] = 112, [7] = 108 }, [3] = { [0] = 13, [1] = 14, [2] = 14, [5] = 19, [6] = 12, [7] = 9 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 0 then
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
      elseif R[10] == 1 then
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
      elseif R[10] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[19]], ({ [0] = 11, [1] = 112, [2] = 111, [3] = 8 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[19]], ({ [0] = 11, [1] = 112, [2] = 111, [3] = 8 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[19]], ({ [0] = 11, [1] = 112, [2] = 111, [3] = 8 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 14, [2] = 20, [5] = 14, [6] = 14, [7] = 26 }, [1] = { [0] = 16, [1] = 25, [2] = 24, [5] = 16, [6] = 14, [7] = 26 }, [2] = { [0] = 100, [1] = 111, [2] = 118, [5] = 108, [6] = 106, [7] = 118 }, [3] = { [0] = 100, [1] = 121, [2] = 119, [5] = 110, [6] = 108, [7] = 126 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 22, [2] = 17, [5] = 8, [6] = 12, [7] = 18 }, [1] = { [0] = 116, [1] = 118, [2] = 118, [5] = 105, [6] = 118, [7] = 118 }, [2] = { [0] = 115, [1] = 118, [2] = 117, [5] = 106, [6] = 112, [7] = 120 }, [3] = { [0] = 13, [1] = 24, [2] = 14, [5] = 7, [6] = 12, [7] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
      elseif R[10] == 0 or R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 13 }, [1] = { [0] = 27, [1] = 24 }, [2] = { [0] = 111, [1] = 110 }, [3] = { [0] = 111, [1] = 120 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 30 }, [1] = { [0] = 123, [1] = 126 }, [2] = { [0] = 122, [1] = 126 }, [3] = { [0] = 20, [1] = 32 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 4, [2] = 28, [3] = 16, [4] = 6, [5] = 4, [6] = 6, [7] = 18 }, [1] = { [0] = 16, [1] = 15, [2] = 32, [3] = 24, [4] = 12, [5] = 6, [6] = 6, [7] = 18 }, [2] = { [0] = 100, [1] = 101, [2] = 126, [3] = 114, [4] = 104, [5] = 98, [6] = 98, [7] = 110 }, [3] = { [0] = 100, [1] = 111, [2] = 127, [3] = 119, [4] = 106, [5] = 100, [6] = 100, [7] = 118 } })[R[19]][R[10]], ({ [0] = { [0] = 20, [1] = 27, [2] = 11, [3] = 4, [4] = 9, [5] = 15, [6] = 12, [7] = 22 }, [1] = { [0] = 125, [1] = 123, [2] = 112, [3] = 107, [4] = 113, [5] = 112, [6] = 118, [7] = 122 }, [2] = { [0] = 124, [1] = 123, [2] = 111, [3] = 102, [4] = 107, [5] = 113, [6] = 112, [7] = 124 }, [3] = { [0] = 22, [1] = 29, [2] = 8, [3] = 5, [4] = 10, [5] = 14, [6] = 12, [7] = 25 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 3, [2] = 24, [3] = 5, [4] = 24, [5] = 22, [6] = 13, [7] = 28 }, [1] = { [0] = 23, [1] = 14, [2] = 28, [3] = 13, [4] = 30, [5] = 24, [6] = 13, [7] = 28 }, [2] = { [0] = 107, [1] = 100, [2] = 122, [3] = 103, [4] = 122, [5] = 116, [6] = 105, [7] = 120 }, [3] = { [0] = 107, [1] = 110, [2] = 123, [3] = 108, [4] = 124, [5] = 118, [6] = 107, [7] = 128 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 13, [2] = 15, [3] = 11, [4] = 13, [5] = 6, [6] = 17, [7] = 13 }, [1] = { [0] = 112, [1] = 109, [2] = 116, [3] = 114, [4] = 117, [5] = 103, [6] = 123, [7] = 113 }, [2] = { [0] = 111, [1] = 109, [2] = 115, [3] = 109, [4] = 111, [5] = 104, [6] = 117, [7] = 115 }, [3] = { [0] = 9, [1] = 15, [2] = 12, [3] = 12, [4] = 14, [5] = 5, [6] = 17, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 3, [2] = 24, [3] = 8, [4] = 26, [5] = 22, [6] = 11, [7] = 28 }, [1] = { [0] = 21, [1] = 14, [2] = 28, [3] = 16, [4] = 32, [5] = 24, [6] = 11, [7] = 28 }, [2] = { [0] = 105, [1] = 100, [2] = 122, [3] = 106, [4] = 124, [5] = 116, [6] = 103, [7] = 120 }, [3] = { [0] = 105, [1] = 110, [2] = 123, [3] = 111, [4] = 126, [5] = 118, [6] = 105, [7] = 128 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 11, [2] = 13, [3] = 7, [4] = 13, [5] = 8, [6] = 17, [7] = 15 }, [1] = { [0] = 112, [1] = 107, [2] = 114, [3] = 110, [4] = 117, [5] = 105, [6] = 123, [7] = 115 }, [2] = { [0] = 111, [1] = 107, [2] = 113, [3] = 105, [4] = 111, [5] = 106, [6] = 117, [7] = 117 }, [3] = { [0] = 9, [1] = 13, [2] = 10, [3] = 8, [4] = 14, [5] = 7, [6] = 17, [7] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 25, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 33, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 123, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 128, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 11, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 114, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 109, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 12, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 23, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 31, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 121, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 126, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 7, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 110, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 105, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 8, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 17, [1] = 3, [2] = 24, [3] = 11, [4] = 26, [5] = 22, [6] = 11, [7] = 28 }, [1] = { [0] = 21, [1] = 14, [2] = 28, [3] = 19, [4] = 32, [5] = 24, [6] = 11, [7] = 28 }, [2] = { [0] = 105, [1] = 100, [2] = 122, [3] = 109, [4] = 124, [5] = 116, [6] = 103, [7] = 120 }, [3] = { [0] = 105, [1] = 110, [2] = 123, [3] = 114, [4] = 126, [5] = 118, [6] = 105, [7] = 128 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 13, [2] = 13, [3] = 22, [4] = 13, [5] = 8, [6] = 17, [7] = 15 }, [1] = { [0] = 112, [1] = 109, [2] = 114, [3] = 125, [4] = 117, [5] = 105, [6] = 123, [7] = 115 }, [2] = { [0] = 111, [1] = 109, [2] = 113, [3] = 120, [4] = 111, [5] = 106, [6] = 117, [7] = 117 }, [3] = { [0] = 9, [1] = 15, [2] = 10, [3] = 23, [4] = 14, [5] = 7, [6] = 17, [7] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 17, [1] = 6, [2] = 24, [3] = 11, [4] = 26, [5] = 22, [6] = 11, [7] = 28 }, [1] = { [0] = 21, [1] = 17, [2] = 28, [3] = 19, [4] = 32, [5] = 24, [6] = 11, [7] = 28 }, [2] = { [0] = 105, [1] = 103, [2] = 122, [3] = 109, [4] = 124, [5] = 116, [6] = 103, [7] = 120 }, [3] = { [0] = 105, [1] = 113, [2] = 123, [3] = 114, [4] = 126, [5] = 118, [6] = 105, [7] = 128 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 13, [2] = 13, [3] = 22, [4] = 13, [5] = 8, [6] = 17, [7] = 15 }, [1] = { [0] = 112, [1] = 109, [2] = 114, [3] = 125, [4] = 117, [5] = 105, [6] = 123, [7] = 115 }, [2] = { [0] = 111, [1] = 109, [2] = 113, [3] = 120, [4] = 111, [5] = 106, [6] = 117, [7] = 117 }, [3] = { [0] = 9, [1] = 15, [2] = 10, [3] = 23, [4] = 14, [5] = 7, [6] = 17, [7] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 3, [2] = 6, [3] = 5, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 14, [2] = 10, [3] = 13, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 100, [2] = 104, [3] = 103, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 110, [2] = 105, [3] = 108, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 11, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 114, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 109, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 12, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 6, [2] = 24, [3] = 5, [4] = 19, [5] = 9, [6] = 18, [7] = 12 }, [1] = { [0] = 18, [1] = 17, [2] = 28, [3] = 13, [4] = 25, [5] = 11, [6] = 18, [7] = 12 }, [2] = { [0] = 102, [1] = 103, [2] = 122, [3] = 103, [4] = 117, [5] = 103, [6] = 110, [7] = 104 }, [3] = { [0] = 102, [1] = 113, [2] = 123, [3] = 108, [4] = 119, [5] = 105, [6] = 112, [7] = 112 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 7, [2] = 19, [3] = 11, [4] = 17, [5] = 5, [6] = 14, [7] = 13 }, [1] = { [0] = 112, [1] = 103, [2] = 120, [3] = 114, [4] = 121, [5] = 102, [6] = 120, [7] = 113 }, [2] = { [0] = 111, [1] = 103, [2] = 119, [3] = 109, [4] = 115, [5] = 103, [6] = 114, [7] = 115 }, [3] = { [0] = 9, [1] = 9, [2] = 16, [3] = 12, [4] = 18, [5] = 4, [6] = 14, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 9, [2] = 20, [3] = 11, [4] = 21, [5] = 18, [6] = 27, [7] = 7 }, [1] = { [0] = 18, [1] = 20, [2] = 24, [3] = 19, [4] = 27, [5] = 20, [6] = 27, [7] = 7 }, [2] = { [0] = 102, [1] = 106, [2] = 118, [3] = 109, [4] = 119, [5] = 112, [6] = 119, [7] = 99 }, [3] = { [0] = 102, [1] = 116, [2] = 119, [3] = 114, [4] = 121, [5] = 114, [6] = 121, [7] = 107 } })[R[19]][R[10]], ({ [0] = { [0] = 4, [1] = 4, [2] = 20, [3] = 22, [4] = 8, [5] = 13, [6] = 11, [7] = 10 }, [1] = { [0] = 109, [1] = 100, [2] = 121, [3] = 125, [4] = 112, [5] = 110, [6] = 117, [7] = 110 }, [2] = { [0] = 108, [1] = 100, [2] = 120, [3] = 120, [4] = 106, [5] = 111, [6] = 111, [7] = 112 }, [3] = { [0] = 6, [1] = 6, [2] = 17, [3] = 23, [4] = 9, [5] = 12, [6] = 11, [7] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 25, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 33, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 123, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 128, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 11, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 114, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 109, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 12, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 23, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 31, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 121, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 126, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 7, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 110, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 105, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 8, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 17, [1] = 3, [2] = 24, [3] = 11, [4] = 26, [5] = 22, [6] = 11, [7] = 28 }, [1] = { [0] = 21, [1] = 14, [2] = 28, [3] = 19, [4] = 32, [5] = 24, [6] = 11, [7] = 28 }, [2] = { [0] = 105, [1] = 100, [2] = 122, [3] = 109, [4] = 124, [5] = 116, [6] = 103, [7] = 120 }, [3] = { [0] = 105, [1] = 110, [2] = 123, [3] = 114, [4] = 126, [5] = 118, [6] = 105, [7] = 128 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 13, [2] = 13, [3] = 22, [4] = 13, [5] = 8, [6] = 17, [7] = 15 }, [1] = { [0] = 112, [1] = 109, [2] = 114, [3] = 125, [4] = 117, [5] = 105, [6] = 123, [7] = 115 }, [2] = { [0] = 111, [1] = 109, [2] = 113, [3] = 120, [4] = 111, [5] = 106, [6] = 117, [7] = 117 }, [3] = { [0] = 9, [1] = 15, [2] = 10, [3] = 23, [4] = 14, [5] = 7, [6] = 17, [7] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 11, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 19, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 109, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 114, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 22, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 125, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 120, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 23, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 6, [2] = 24, [3] = 5, [4] = 19, [5] = 9, [6] = 18, [7] = 12 }, [1] = { [0] = 18, [1] = 17, [2] = 28, [3] = 13, [4] = 25, [5] = 11, [6] = 18, [7] = 12 }, [2] = { [0] = 102, [1] = 103, [2] = 122, [3] = 103, [4] = 117, [5] = 103, [6] = 110, [7] = 104 }, [3] = { [0] = 102, [1] = 113, [2] = 123, [3] = 108, [4] = 119, [5] = 105, [6] = 112, [7] = 112 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 7, [2] = 19, [3] = 11, [4] = 17, [5] = 5, [6] = 14, [7] = 13 }, [1] = { [0] = 112, [1] = 103, [2] = 120, [3] = 114, [4] = 121, [5] = 102, [6] = 120, [7] = 113 }, [2] = { [0] = 111, [1] = 103, [2] = 119, [3] = 109, [4] = 115, [5] = 103, [6] = 114, [7] = 115 }, [3] = { [0] = 9, [1] = 9, [2] = 16, [3] = 12, [4] = 18, [5] = 4, [6] = 14, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 9, [2] = 20, [3] = 11, [4] = 21, [5] = 18, [6] = 27, [7] = 7 }, [1] = { [0] = 18, [1] = 20, [2] = 24, [3] = 19, [4] = 27, [5] = 20, [6] = 27, [7] = 7 }, [2] = { [0] = 102, [1] = 106, [2] = 118, [3] = 109, [4] = 119, [5] = 112, [6] = 119, [7] = 99 }, [3] = { [0] = 102, [1] = 116, [2] = 119, [3] = 114, [4] = 121, [5] = 114, [6] = 121, [7] = 107 } })[R[19]][R[10]], ({ [0] = { [0] = 4, [1] = 4, [2] = 20, [3] = 22, [4] = 8, [5] = 13, [6] = 11, [7] = 10 }, [1] = { [0] = 109, [1] = 100, [2] = 121, [3] = 125, [4] = 112, [5] = 110, [6] = 117, [7] = 110 }, [2] = { [0] = 108, [1] = 100, [2] = 120, [3] = 120, [4] = 106, [5] = 111, [6] = 111, [7] = 112 }, [3] = { [0] = 6, [1] = 6, [2] = 17, [3] = 23, [4] = 9, [5] = 12, [6] = 11, [7] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 25, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 33, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 123, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 128, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 11, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 114, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 109, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 12, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 6, [2] = 6, [3] = 23, [4] = 18, [5] = 10, [6] = 26, [7] = 27 }, [1] = { [0] = 32, [1] = 17, [2] = 10, [3] = 31, [4] = 24, [5] = 12, [6] = 26, [7] = 27 }, [2] = { [0] = 116, [1] = 103, [2] = 104, [3] = 121, [4] = 116, [5] = 104, [6] = 118, [7] = 119 }, [3] = { [0] = 116, [1] = 113, [2] = 105, [3] = 126, [4] = 118, [5] = 106, [6] = 120, [7] = 127 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 13, [2] = 16, [3] = 7, [4] = 21, [5] = 16, [6] = 4, [7] = 7 }, [1] = { [0] = 118, [1] = 109, [2] = 117, [3] = 110, [4] = 125, [5] = 113, [6] = 110, [7] = 107 }, [2] = { [0] = 117, [1] = 109, [2] = 116, [3] = 105, [4] = 119, [5] = 114, [6] = 104, [7] = 109 }, [3] = { [0] = 15, [1] = 15, [2] = 13, [3] = 8, [4] = 22, [5] = 15, [6] = 4, [7] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 6, [2] = 24, [3] = 11, [4] = 19, [5] = 9, [6] = 18, [7] = 12 }, [1] = { [0] = 18, [1] = 17, [2] = 28, [3] = 19, [4] = 25, [5] = 11, [6] = 18, [7] = 12 }, [2] = { [0] = 102, [1] = 103, [2] = 122, [3] = 109, [4] = 117, [5] = 103, [6] = 110, [7] = 104 }, [3] = { [0] = 102, [1] = 113, [2] = 123, [3] = 114, [4] = 119, [5] = 105, [6] = 112, [7] = 112 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 7, [2] = 19, [3] = 22, [4] = 17, [5] = 5, [6] = 14, [7] = 13 }, [1] = { [0] = 112, [1] = 103, [2] = 120, [3] = 125, [4] = 121, [5] = 102, [6] = 120, [7] = 113 }, [2] = { [0] = 111, [1] = 103, [2] = 119, [3] = 120, [4] = 115, [5] = 103, [6] = 114, [7] = 115 }, [3] = { [0] = 9, [1] = 9, [2] = 16, [3] = 23, [4] = 18, [5] = 4, [6] = 14, [7] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 14, [1] = 9, [2] = 20, [3] = 11, [4] = 21, [5] = 18, [6] = 27, [7] = 7 }, [1] = { [0] = 18, [1] = 20, [2] = 24, [3] = 19, [4] = 27, [5] = 20, [6] = 27, [7] = 7 }, [2] = { [0] = 102, [1] = 106, [2] = 118, [3] = 109, [4] = 119, [5] = 112, [6] = 119, [7] = 99 }, [3] = { [0] = 102, [1] = 116, [2] = 119, [3] = 114, [4] = 121, [5] = 114, [6] = 121, [7] = 107 } })[R[19]][R[10]], ({ [0] = { [0] = 4, [1] = 4, [2] = 20, [3] = 22, [4] = 8, [5] = 13, [6] = 11, [7] = 10 }, [1] = { [0] = 109, [1] = 100, [2] = 121, [3] = 125, [4] = 112, [5] = 110, [6] = 117, [7] = 110 }, [2] = { [0] = 108, [1] = 100, [2] = 120, [3] = 120, [4] = 106, [5] = 111, [6] = 111, [7] = 112 }, [3] = { [0] = 6, [1] = 6, [2] = 17, [3] = 23, [4] = 9, [5] = 12, [6] = 11, [7] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 35, [1] = 12, [2] = 16, [3] = 15, [4] = 27, [5] = 10, [6] = 27, [7] = 21 }, [1] = { [0] = 39, [1] = 23, [2] = 20, [3] = 23, [4] = 33, [5] = 12, [6] = 27, [7] = 21 }, [2] = { [0] = 123, [1] = 109, [2] = 114, [3] = 113, [4] = 125, [5] = 104, [6] = 119, [7] = 113 }, [3] = { [0] = 123, [1] = 119, [2] = 115, [3] = 118, [4] = 127, [5] = 106, [6] = 121, [7] = 121 } })[R[19]][R[10]], ({ [0] = { [0] = 15, [1] = 17, [2] = 13, [3] = 8, [4] = 4, [5] = 22, [6] = 14, [7] = 12 }, [1] = { [0] = 120, [1] = 113, [2] = 114, [3] = 111, [4] = 108, [5] = 119, [6] = 120, [7] = 112 }, [2] = { [0] = 119, [1] = 113, [2] = 113, [3] = 106, [4] = 102, [5] = 120, [6] = 114, [7] = 114 }, [3] = { [0] = 17, [1] = 19, [2] = 10, [3] = 9, [4] = 5, [5] = 21, [6] = 14, [7] = 15 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 6, [2] = 11, [3] = 7, [4] = 14, [5] = 14, [6] = 13, [7] = 10 }, [1] = { [0] = 19, [1] = 17, [2] = 15, [3] = 15, [4] = 20, [5] = 16, [6] = 13, [7] = 10 }, [2] = { [0] = 103, [1] = 103, [2] = 109, [3] = 105, [4] = 112, [5] = 108, [6] = 105, [7] = 102 }, [3] = { [0] = 103, [1] = 113, [2] = 110, [3] = 110, [4] = 114, [5] = 110, [6] = 107, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 11, [3] = 17, [4] = 7, [5] = 11, [6] = 6, [7] = 9 }, [1] = { [0] = 116, [1] = 114, [2] = 112, [3] = 120, [4] = 111, [5] = 108, [6] = 112, [7] = 109 }, [2] = { [0] = 115, [1] = 114, [2] = 111, [3] = 115, [4] = 105, [5] = 109, [6] = 106, [7] = 111 }, [3] = { [0] = 13, [1] = 20, [2] = 8, [3] = 18, [4] = 8, [5] = 10, [6] = 6, [7] = 12 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 7, [2] = 12, [3] = 7, [4] = 14, [5] = 14, [6] = 13, [7] = 10 }, [1] = { [0] = 20, [1] = 18, [2] = 16, [3] = 15, [4] = 20, [5] = 16, [6] = 13, [7] = 10 }, [2] = { [0] = 104, [1] = 104, [2] = 110, [3] = 105, [4] = 112, [5] = 108, [6] = 105, [7] = 102 }, [3] = { [0] = 104, [1] = 114, [2] = 111, [3] = 110, [4] = 114, [5] = 110, [6] = 107, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 11, [3] = 18, [4] = 8, [5] = 12, [6] = 7, [7] = 10 }, [1] = { [0] = 116, [1] = 114, [2] = 112, [3] = 121, [4] = 112, [5] = 109, [6] = 113, [7] = 110 }, [2] = { [0] = 115, [1] = 114, [2] = 111, [3] = 116, [4] = 106, [5] = 110, [6] = 107, [7] = 112 }, [3] = { [0] = 13, [1] = 20, [2] = 8, [3] = 19, [4] = 9, [5] = 11, [6] = 7, [7] = 13 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 8, [2] = 13, [3] = 7, [4] = 14, [5] = 14, [6] = 13, [7] = 10 }, [1] = { [0] = 21, [1] = 19, [2] = 17, [3] = 15, [4] = 20, [5] = 16, [6] = 13, [7] = 10 }, [2] = { [0] = 105, [1] = 105, [2] = 111, [3] = 105, [4] = 112, [5] = 108, [6] = 105, [7] = 102 }, [3] = { [0] = 105, [1] = 115, [2] = 112, [3] = 110, [4] = 114, [5] = 110, [6] = 107, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 11, [3] = 19, [4] = 9, [5] = 13, [6] = 8, [7] = 11 }, [1] = { [0] = 116, [1] = 114, [2] = 112, [3] = 122, [4] = 113, [5] = 110, [6] = 114, [7] = 111 }, [2] = { [0] = 115, [1] = 114, [2] = 111, [3] = 117, [4] = 107, [5] = 111, [6] = 108, [7] = 113 }, [3] = { [0] = 13, [1] = 20, [2] = 8, [3] = 20, [4] = 10, [5] = 12, [6] = 8, [7] = 14 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 9, [2] = 14, [3] = 8, [4] = 14, [5] = 14, [6] = 13, [7] = 10 }, [1] = { [0] = 22, [1] = 20, [2] = 18, [3] = 16, [4] = 20, [5] = 16, [6] = 13, [7] = 10 }, [2] = { [0] = 106, [1] = 106, [2] = 112, [3] = 106, [4] = 112, [5] = 108, [6] = 105, [7] = 102 }, [3] = { [0] = 106, [1] = 116, [2] = 113, [3] = 111, [4] = 114, [5] = 110, [6] = 107, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 8, [3] = 17, [4] = 10, [5] = 17, [6] = 9, [7] = 12 }, [1] = { [0] = 116, [1] = 114, [2] = 109, [3] = 120, [4] = 114, [5] = 114, [6] = 115, [7] = 112 }, [2] = { [0] = 115, [1] = 114, [2] = 108, [3] = 115, [4] = 108, [5] = 115, [6] = 109, [7] = 114 }, [3] = { [0] = 13, [1] = 20, [2] = 5, [3] = 18, [4] = 11, [5] = 16, [6] = 9, [7] = 15 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 10, [2] = 14, [3] = 9, [4] = 14, [5] = 14, [6] = 13, [7] = 10 }, [1] = { [0] = 23, [1] = 21, [2] = 18, [3] = 17, [4] = 20, [5] = 16, [6] = 13, [7] = 10 }, [2] = { [0] = 107, [1] = 107, [2] = 112, [3] = 107, [4] = 112, [5] = 108, [6] = 105, [7] = 102 }, [3] = { [0] = 107, [1] = 117, [2] = 113, [3] = 112, [4] = 114, [5] = 110, [6] = 107, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 9, [3] = 13, [4] = 11, [5] = 18, [6] = 10, [7] = 13 }, [1] = { [0] = 116, [1] = 114, [2] = 110, [3] = 116, [4] = 115, [5] = 115, [6] = 116, [7] = 113 }, [2] = { [0] = 115, [1] = 114, [2] = 109, [3] = 111, [4] = 109, [5] = 116, [6] = 110, [7] = 115 }, [3] = { [0] = 13, [1] = 20, [2] = 6, [3] = 14, [4] = 12, [5] = 17, [6] = 10, [7] = 16 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 11, [2] = 14, [3] = 9, [4] = 14, [5] = 14, [6] = 16, [7] = 10 }, [1] = { [0] = 24, [1] = 22, [2] = 18, [3] = 17, [4] = 20, [5] = 16, [6] = 16, [7] = 10 }, [2] = { [0] = 108, [1] = 108, [2] = 112, [3] = 107, [4] = 112, [5] = 108, [6] = 108, [7] = 102 }, [3] = { [0] = 108, [1] = 118, [2] = 113, [3] = 112, [4] = 114, [5] = 110, [6] = 110, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 10, [3] = 14, [4] = 15, [5] = 19, [6] = 4, [7] = 14 }, [1] = { [0] = 116, [1] = 114, [2] = 111, [3] = 117, [4] = 119, [5] = 116, [6] = 110, [7] = 114 }, [2] = { [0] = 115, [1] = 114, [2] = 110, [3] = 112, [4] = 113, [5] = 117, [6] = 104, [7] = 116 }, [3] = { [0] = 13, [1] = 20, [2] = 7, [3] = 15, [4] = 16, [5] = 18, [6] = 4, [7] = 17 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 12, [2] = 14, [3] = 9, [4] = 14, [5] = 17, [6] = 17, [7] = 10 }, [1] = { [0] = 25, [1] = 23, [2] = 18, [3] = 17, [4] = 20, [5] = 19, [6] = 17, [7] = 10 }, [2] = { [0] = 109, [1] = 109, [2] = 112, [3] = 107, [4] = 112, [5] = 111, [6] = 109, [7] = 102 }, [3] = { [0] = 109, [1] = 119, [2] = 113, [3] = 112, [4] = 114, [5] = 113, [6] = 111, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 11, [3] = 15, [4] = 16, [5] = 15, [6] = 4, [7] = 15 }, [1] = { [0] = 116, [1] = 114, [2] = 112, [3] = 118, [4] = 120, [5] = 112, [6] = 110, [7] = 115 }, [2] = { [0] = 115, [1] = 114, [2] = 111, [3] = 113, [4] = 114, [5] = 113, [6] = 104, [7] = 117 }, [3] = { [0] = 13, [1] = 20, [2] = 8, [3] = 16, [4] = 17, [5] = 14, [6] = 4, [7] = 18 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 13, [2] = 14, [3] = 9, [4] = 14, [5] = 17, [6] = 17, [7] = 10 }, [1] = { [0] = 27, [1] = 24, [2] = 18, [3] = 17, [4] = 20, [5] = 19, [6] = 17, [7] = 10 }, [2] = { [0] = 111, [1] = 110, [2] = 112, [3] = 107, [4] = 112, [5] = 111, [6] = 109, [7] = 102 }, [3] = { [0] = 111, [1] = 120, [2] = 113, [3] = 112, [4] = 114, [5] = 113, [6] = 111, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 6, [1] = 7, [2] = 12, [3] = 16, [4] = 17, [5] = 21, [6] = 12, [7] = 16 }, [1] = { [0] = 111, [1] = 103, [2] = 113, [3] = 119, [4] = 121, [5] = 118, [6] = 118, [7] = 116 }, [2] = { [0] = 110, [1] = 103, [2] = 112, [3] = 114, [4] = 115, [5] = 119, [6] = 112, [7] = 118 }, [3] = { [0] = 8, [1] = 9, [2] = 9, [3] = 17, [4] = 18, [5] = 20, [6] = 12, [7] = 19 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 13, [2] = 14, [3] = 9, [4] = 14, [5] = 18, [6] = 18, [7] = 10 }, [1] = { [0] = 27, [1] = 24, [2] = 18, [3] = 17, [4] = 20, [5] = 20, [6] = 18, [7] = 10 }, [2] = { [0] = 111, [1] = 110, [2] = 112, [3] = 107, [4] = 112, [5] = 112, [6] = 110, [7] = 102 }, [3] = { [0] = 111, [1] = 120, [2] = 113, [3] = 112, [4] = 114, [5] = 114, [6] = 112, [7] = 110 } })[R[19]][R[10]], ({ [0] = { [0] = 7, [1] = 8, [2] = 13, [3] = 17, [4] = 18, [5] = 15, [6] = 4, [7] = 17 }, [1] = { [0] = 112, [1] = 104, [2] = 114, [3] = 120, [4] = 122, [5] = 112, [6] = 110, [7] = 117 }, [2] = { [0] = 111, [1] = 104, [2] = 113, [3] = 115, [4] = 116, [5] = 113, [6] = 104, [7] = 119 }, [3] = { [0] = 9, [1] = 10, [2] = 10, [3] = 18, [4] = 19, [5] = 14, [6] = 4, [7] = 20 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 13, [2] = 14, [3] = 10, [4] = 14, [5] = 18, [6] = 18, [7] = 13 }, [1] = { [0] = 27, [1] = 24, [2] = 18, [3] = 18, [4] = 20, [5] = 20, [6] = 18, [7] = 13 }, [2] = { [0] = 111, [1] = 110, [2] = 112, [3] = 108, [4] = 112, [5] = 112, [6] = 110, [7] = 105 }, [3] = { [0] = 111, [1] = 120, [2] = 113, [3] = 113, [4] = 114, [5] = 114, [6] = 112, [7] = 113 } })[R[19]][R[10]], ({ [0] = { [0] = 8, [1] = 9, [2] = 14, [3] = 13, [4] = 19, [5] = 21, [6] = 12, [7] = 6 }, [1] = { [0] = 113, [1] = 105, [2] = 115, [3] = 116, [4] = 123, [5] = 118, [6] = 118, [7] = 106 }, [2] = { [0] = 112, [1] = 105, [2] = 114, [3] = 111, [4] = 117, [5] = 119, [6] = 112, [7] = 108 }, [3] = { [0] = 10, [1] = 11, [2] = 11, [3] = 14, [4] = 20, [5] = 20, [6] = 12, [7] = 9 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 13, [2] = 14, [3] = 10, [4] = 17, [5] = 19, [6] = 19, [7] = 13 }, [1] = { [0] = 27, [1] = 24, [2] = 18, [3] = 18, [4] = 23, [5] = 21, [6] = 19, [7] = 13 }, [2] = { [0] = 111, [1] = 110, [2] = 112, [3] = 108, [4] = 115, [5] = 113, [6] = 111, [7] = 105 }, [3] = { [0] = 111, [1] = 120, [2] = 113, [3] = 113, [4] = 117, [5] = 115, [6] = 113, [7] = 113 } })[R[19]][R[10]], ({ [0] = { [0] = 9, [1] = 10, [2] = 15, [3] = 17, [4] = 5, [5] = 15, [6] = 4, [7] = 19 }, [1] = { [0] = 114, [1] = 106, [2] = 116, [3] = 120, [4] = 109, [5] = 112, [6] = 110, [7] = 119 }, [2] = { [0] = 113, [1] = 106, [2] = 115, [3] = 115, [4] = 103, [5] = 113, [6] = 104, [7] = 121 }, [3] = { [0] = 11, [1] = 12, [2] = 12, [3] = 18, [4] = 6, [5] = 14, [6] = 4, [7] = 22 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 13, [2] = 14, [3] = 11, [4] = 17, [5] = 19, [6] = 19, [7] = 14 }, [1] = { [0] = 27, [1] = 24, [2] = 18, [3] = 19, [4] = 23, [5] = 21, [6] = 19, [7] = 14 }, [2] = { [0] = 111, [1] = 110, [2] = 112, [3] = 109, [4] = 115, [5] = 113, [6] = 111, [7] = 106 }, [3] = { [0] = 111, [1] = 120, [2] = 113, [3] = 114, [4] = 117, [5] = 115, [6] = 113, [7] = 114 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 18, [2] = 16, [3] = 17, [4] = 13, [5] = 21, [6] = 12, [7] = 6 }, [1] = { [0] = 118, [1] = 114, [2] = 117, [3] = 120, [4] = 117, [5] = 118, [6] = 118, [7] = 106 }, [2] = { [0] = 117, [1] = 114, [2] = 116, [3] = 115, [4] = 111, [5] = 119, [6] = 112, [7] = 108 }, [3] = { [0] = 15, [1] = 20, [2] = 13, [3] = 18, [4] = 14, [5] = 20, [6] = 12, [7] = 9 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 14, [2] = 14, [3] = 12, [4] = 17, [5] = 20, [6] = 20, [7] = 14 }, [1] = { [0] = 27, [1] = 25, [2] = 18, [3] = 20, [4] = 23, [5] = 22, [6] = 20, [7] = 14 }, [2] = { [0] = 111, [1] = 111, [2] = 112, [3] = 110, [4] = 115, [5] = 114, [6] = 112, [7] = 106 }, [3] = { [0] = 111, [1] = 121, [2] = 113, [3] = 115, [4] = 117, [5] = 116, [6] = 114, [7] = 114 } })[R[19]][R[10]], ({ [0] = { [0] = 14, [1] = 15, [2] = 17, [3] = 17, [4] = 21, [5] = 15, [6] = 4, [7] = 19 }, [1] = { [0] = 119, [1] = 111, [2] = 118, [3] = 120, [4] = 125, [5] = 112, [6] = 110, [7] = 119 }, [2] = { [0] = 118, [1] = 111, [2] = 117, [3] = 115, [4] = 119, [5] = 113, [6] = 104, [7] = 121 }, [3] = { [0] = 16, [1] = 17, [2] = 14, [3] = 18, [4] = 22, [5] = 14, [6] = 4, [7] = 22 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 14, [2] = 15, [3] = 13, [4] = 18, [5] = 20, [6] = 20, [7] = 15 }, [1] = { [0] = 27, [1] = 25, [2] = 19, [3] = 21, [4] = 24, [5] = 22, [6] = 20, [7] = 15 }, [2] = { [0] = 111, [1] = 111, [2] = 113, [3] = 111, [4] = 116, [5] = 114, [6] = 112, [7] = 107 }, [3] = { [0] = 111, [1] = 121, [2] = 114, [3] = 116, [4] = 118, [5] = 116, [6] = 114, [7] = 115 } })[R[19]][R[10]], ({ [0] = { [0] = 15, [1] = 16, [2] = 11, [3] = 10, [4] = 5, [5] = 21, [6] = 12, [7] = 6 }, [1] = { [0] = 120, [1] = 112, [2] = 112, [3] = 113, [4] = 109, [5] = 118, [6] = 118, [7] = 106 }, [2] = { [0] = 119, [1] = 112, [2] = 111, [3] = 108, [4] = 103, [5] = 119, [6] = 112, [7] = 108 }, [3] = { [0] = 17, [1] = 18, [2] = 8, [3] = 11, [4] = 6, [5] = 20, [6] = 12, [7] = 9 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 14, [2] = 15, [3] = 13, [4] = 18, [5] = 21, [6] = 22, [7] = 15 }, [1] = { [0] = 27, [1] = 25, [2] = 19, [3] = 21, [4] = 24, [5] = 23, [6] = 22, [7] = 15 }, [2] = { [0] = 111, [1] = 111, [2] = 113, [3] = 111, [4] = 116, [5] = 115, [6] = 114, [7] = 107 }, [3] = { [0] = 111, [1] = 121, [2] = 114, [3] = 116, [4] = 118, [5] = 117, [6] = 116, [7] = 115 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 17, [2] = 17, [3] = 17, [4] = 13, [5] = 15, [6] = 6, [7] = 19 }, [1] = { [0] = 121, [1] = 113, [2] = 118, [3] = 120, [4] = 117, [5] = 112, [6] = 112, [7] = 119 }, [2] = { [0] = 120, [1] = 113, [2] = 117, [3] = 115, [4] = 111, [5] = 113, [6] = 106, [7] = 121 }, [3] = { [0] = 18, [1] = 19, [2] = 14, [3] = 18, [4] = 14, [5] = 14, [6] = 6, [7] = 22 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 14, [2] = 16, [3] = 14, [4] = 18, [5] = 21, [6] = 22, [7] = 16 }, [1] = { [0] = 30, [1] = 25, [2] = 20, [3] = 22, [4] = 24, [5] = 23, [6] = 22, [7] = 16 }, [2] = { [0] = 114, [1] = 111, [2] = 114, [3] = 112, [4] = 116, [5] = 115, [6] = 114, [7] = 108 }, [3] = { [0] = 114, [1] = 121, [2] = 115, [3] = 117, [4] = 118, [5] = 117, [6] = 116, [7] = 116 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 18, [2] = 11, [3] = 10, [4] = 21, [5] = 21, [6] = 7, [7] = 6 }, [1] = { [0] = 116, [1] = 114, [2] = 112, [3] = 113, [4] = 125, [5] = 118, [6] = 113, [7] = 106 }, [2] = { [0] = 115, [1] = 114, [2] = 111, [3] = 108, [4] = 119, [5] = 119, [6] = 107, [7] = 108 }, [3] = { [0] = 13, [1] = 20, [2] = 8, [3] = 11, [4] = 22, [5] = 20, [6] = 7, [7] = 9 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 14, [2] = 16, [3] = 15, [4] = 19, [5] = 22, [6] = 22, [7] = 16 }, [1] = { [0] = 31, [1] = 25, [2] = 20, [3] = 23, [4] = 25, [5] = 24, [6] = 22, [7] = 16 }, [2] = { [0] = 115, [1] = 111, [2] = 114, [3] = 113, [4] = 117, [5] = 116, [6] = 114, [7] = 108 }, [3] = { [0] = 115, [1] = 121, [2] = 115, [3] = 118, [4] = 119, [5] = 118, [6] = 116, [7] = 116 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 19, [2] = 17, [3] = 10, [4] = 5, [5] = 15, [6] = 8, [7] = 19 }, [1] = { [0] = 116, [1] = 115, [2] = 118, [3] = 113, [4] = 109, [5] = 112, [6] = 114, [7] = 119 }, [2] = { [0] = 115, [1] = 115, [2] = 117, [3] = 108, [4] = 103, [5] = 113, [6] = 108, [7] = 121 }, [3] = { [0] = 13, [1] = 21, [2] = 14, [3] = 11, [4] = 6, [5] = 14, [6] = 8, [7] = 22 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 14, [2] = 17, [3] = 16, [4] = 19, [5] = 23, [6] = 22, [7] = 17 }, [1] = { [0] = 32, [1] = 25, [2] = 21, [3] = 24, [4] = 25, [5] = 25, [6] = 22, [7] = 17 }, [2] = { [0] = 116, [1] = 111, [2] = 115, [3] = 114, [4] = 117, [5] = 117, [6] = 114, [7] = 109 }, [3] = { [0] = 116, [1] = 121, [2] = 116, [3] = 119, [4] = 119, [5] = 119, [6] = 116, [7] = 117 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 20, [2] = 11, [3] = 10, [4] = 6, [5] = 15, [6] = 9, [7] = 6 }, [1] = { [0] = 116, [1] = 116, [2] = 112, [3] = 113, [4] = 110, [5] = 112, [6] = 115, [7] = 106 }, [2] = { [0] = 115, [1] = 116, [2] = 111, [3] = 108, [4] = 104, [5] = 113, [6] = 109, [7] = 108 }, [3] = { [0] = 13, [1] = 22, [2] = 8, [3] = 11, [4] = 7, [5] = 14, [6] = 9, [7] = 9 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 14, [2] = 17, [3] = 17, [4] = 19, [5] = 24, [6] = 22, [7] = 17 }, [1] = { [0] = 33, [1] = 25, [2] = 21, [3] = 25, [4] = 25, [5] = 26, [6] = 22, [7] = 17 }, [2] = { [0] = 117, [1] = 111, [2] = 115, [3] = 115, [4] = 117, [5] = 118, [6] = 114, [7] = 109 }, [3] = { [0] = 117, [1] = 121, [2] = 116, [3] = 120, [4] = 119, [5] = 120, [6] = 116, [7] = 117 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 25, [2] = 17, [3] = 10, [4] = 13, [5] = 15, [6] = 10, [7] = 7 }, [1] = { [0] = 116, [1] = 121, [2] = 118, [3] = 113, [4] = 117, [5] = 112, [6] = 116, [7] = 107 }, [2] = { [0] = 115, [1] = 121, [2] = 117, [3] = 108, [4] = 111, [5] = 113, [6] = 110, [7] = 109 }, [3] = { [0] = 13, [1] = 27, [2] = 14, [3] = 11, [4] = 14, [5] = 14, [6] = 10, [7] = 10 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 14, [2] = 18, [3] = 18, [4] = 19, [5] = 24, [6] = 26, [7] = 17 }, [1] = { [0] = 34, [1] = 25, [2] = 22, [3] = 26, [4] = 25, [5] = 26, [6] = 26, [7] = 17 }, [2] = { [0] = 118, [1] = 111, [2] = 116, [3] = 116, [4] = 117, [5] = 118, [6] = 118, [7] = 109 }, [3] = { [0] = 118, [1] = 121, [2] = 117, [3] = 121, [4] = 119, [5] = 120, [6] = 120, [7] = 117 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 26, [2] = 11, [3] = 10, [4] = 21, [5] = 16, [6] = 12, [7] = 8 }, [1] = { [0] = 116, [1] = 122, [2] = 112, [3] = 113, [4] = 125, [5] = 113, [6] = 118, [7] = 108 }, [2] = { [0] = 115, [1] = 122, [2] = 111, [3] = 108, [4] = 119, [5] = 114, [6] = 112, [7] = 110 }, [3] = { [0] = 13, [1] = 28, [2] = 8, [3] = 11, [4] = 22, [5] = 15, [6] = 12, [7] = 11 } })[R[19]][R[10]] })
    if R[10] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[19]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[19]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[19]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[19]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[19]] })
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [2] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 } })[R[55]][R[19]], ({ [0] = { [0] = 5, [1] = 110, [2] = 109, [3] = 7 }, [1] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [2] = { [0] = 17, [1] = 122, [2] = 121, [3] = 19 } })[R[55]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[19]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[19]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 5, [1] = 16, [2] = 102, [3] = 112 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 } })[R[56]][R[19]], ({ [0] = { [0] = 22, [1] = 118, [2] = 118, [3] = 24 }, [1] = { [0] = 24, [1] = 120, [2] = 120, [3] = 26 }, [2] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 } })[R[56]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 9, [1] = 13, [2] = 107, [3] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [2] = { [0] = 27, [1] = 31, [2] = 125, [3] = 126 } })[R[57]][R[19]], ({ [0] = { [0] = 5, [1] = 106, [2] = 105, [3] = 2 }, [1] = { [0] = 21, [1] = 122, [2] = 121, [3] = 18 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 } })[R[57]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[19]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[19]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [1] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [2] = { [0] = 4, [1] = 12, [2] = 102, [3] = 107 } })[R[58]][R[19]], ({ [0] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 123, [2] = 118, [3] = 21 }, [2] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 } })[R[58]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[19]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[19]] })
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [1] = { [0] = 9, [1] = 15, [2] = 107, [3] = 109 }, [2] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 } })[R[59]][R[19]], ({ [0] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [1] = { [0] = 12, [1] = 116, [2] = 110, [3] = 13 }, [2] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 } })[R[59]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[19]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[19]] })
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [1] = { [0] = 3, [1] = 5, [2] = 97, [3] = 99 }, [2] = { [0] = 25, [1] = 27, [2] = 119, [3] = 121 } })[R[60]][R[19]], ({ [0] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 }, [1] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [2] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 } })[R[60]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[19]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[19]] })
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 8, [1] = 8, [2] = 100, [3] = 102 }, [1] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [2] = { [0] = 34, [1] = 34, [2] = 126, [3] = 128 } })[R[61]][R[19]], ({ [0] = { [0] = 2, [1] = 108, [2] = 102, [3] = 2 }, [1] = { [0] = 0, [1] = 106, [2] = 100, [3] = 0 }, [2] = { [0] = 15, [1] = 121, [2] = 115, [3] = 15 } })[R[61]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[19]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[19]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[19]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[19]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[19]] })
        for i = 1, game.initial_units() do
          R[62] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 }, [1] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 }, [2] = { [0] = 9, [1] = 9, [2] = 101, [3] = 109 } })[R[62]][R[19]], ({ [0] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [1] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [2] = { [0] = 23, [1] = 123, [2] = 125, [3] = 26 } })[R[62]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[37]][R[20]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 8, [1] = 12, [2] = 106, [3] = 107 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 5, [1] = 101, [2] = 101, [3] = 7 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    if R[37] == 0 or R[37] == 1 or R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 23, [1] = 23, [2] = 115, [3] = 117 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 12, [1] = 108, [2] = 108, [3] = 14 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 20, [1] = 117, [2] = 118, [3] = 19 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 0 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 1 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 2 then
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
      elseif R[37] == 5 then
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
      elseif R[37] == 6 then
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
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 31, [1] = 31, [2] = 123, [3] = 125 }, [7] = { [0] = 25, [1] = 25, [2] = 117, [3] = 125 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 123, [2] = 122, [3] = 20 }, [1] = { [0] = 30, [1] = 126, [2] = 126, [3] = 32 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 0 or R[37] == 1 then
      elseif R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 14, [1] = 14, [2] = 106, [3] = 108 }, [7] = { [0] = 26, [1] = 26, [2] = 118, [3] = 126 } })[R[37]][R[20]], ({ [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 18, [1] = 118, [2] = 120, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 } })[R[37]][R[20]], ({ [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 17, [1] = 121, [2] = 115, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 10, [1] = 18, [2] = 108, [3] = 113 })[R[20]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[20]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 12, [1] = 16, [2] = 100, [3] = 100 }, [1] = { [0] = 4, [1] = 15, [2] = 101, [3] = 111 }, [2] = { [0] = 28, [1] = 32, [2] = 126, [3] = 127 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 6, [1] = 12, [2] = 104, [3] = 106 }, [5] = { [0] = 4, [1] = 6, [2] = 98, [3] = 100 }, [6] = { [0] = 6, [1] = 6, [2] = 98, [3] = 100 }, [7] = { [0] = 18, [1] = 18, [2] = 110, [3] = 118 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 125, [2] = 124, [3] = 22 }, [1] = { [0] = 27, [1] = 123, [2] = 123, [3] = 29 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 4, [1] = 107, [2] = 102, [3] = 5 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 22, [1] = 122, [2] = 124, [3] = 25 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 24, [1] = 30, [2] = 122, [3] = 124 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[37]][R[20]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 6, [1] = 103, [2] = 104, [3] = 5 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[37]][R[20]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 11, [1] = 107, [2] = 107, [3] = 13 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[37] == 0 or R[37] == 1 or R[37] == 2 or R[37] == 4 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 25, [1] = 33, [2] = 123, [3] = 128 })[R[20]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[3].difficulty] == 2 then
      elseif LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 7, [1] = 110, [2] = 105, [3] = 8 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 21, [2] = 105, [3] = 105 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 21, [2] = 105, [3] = 105 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 28, [1] = 32, [2] = 116, [3] = 116 })[R[20]], ({ [0] = 13, [1] = 118, [2] = 117, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 4, [1] = 109, [2] = 108, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 21, [2] = 105, [3] = 105 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 28, [1] = 32, [2] = 116, [3] = 116 })[R[20]], ({ [0] = 13, [1] = 118, [2] = 117, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 4, [1] = 109, [2] = 108, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 7, [1] = 112, [2] = 111, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 14, [1] = 18, [2] = 102, [3] = 102 })[R[20]], ({ [0] = 4, [1] = 109, [2] = 108, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 3, [1] = 14, [2] = 100, [3] = 110 })[R[20]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[20]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 3, [1] = 14, [2] = 100, [3] = 110 })[R[20]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[20]], ({ [0] = 7, [1] = 103, [2] = 103, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 9, [1] = 20, [2] = 106, [3] = 116 })[R[20]], ({ [0] = 4, [1] = 100, [2] = 100, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 3, [1] = 14, [2] = 100, [3] = 110 })[R[20]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[20]], ({ [0] = 13, [1] = 109, [2] = 109, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[20]], ({ [0] = 7, [1] = 103, [2] = 103, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 9, [1] = 20, [2] = 106, [3] = 116 })[R[20]], ({ [0] = 4, [1] = 100, [2] = 100, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 6, [1] = 17, [2] = 103, [3] = 113 })[R[20]], ({ [0] = 7, [1] = 103, [2] = 103, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 9, [1] = 20, [2] = 106, [3] = 116 })[R[20]], ({ [0] = 4, [1] = 100, [2] = 100, [3] = 6 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 13, [1] = 114, [2] = 113, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 13, [1] = 114, [2] = 113, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 6, [1] = 10, [2] = 104, [3] = 105 })[R[20]], ({ [0] = 16, [1] = 117, [2] = 116, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 120, [2] = 119, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[20]], ({ [0] = 20, [1] = 121, [2] = 120, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 13, [1] = 114, [2] = 113, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 6, [1] = 10, [2] = 104, [3] = 105 })[R[20]], ({ [0] = 16, [1] = 117, [2] = 116, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 120, [2] = 119, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[20]], ({ [0] = 20, [1] = 121, [2] = 120, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 24, [1] = 28, [2] = 122, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 120, [2] = 119, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 20, [1] = 24, [2] = 118, [3] = 119 })[R[20]], ({ [0] = 20, [1] = 121, [2] = 120, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 3 then
      if LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 7, [1] = 110, [2] = 105, [3] = 8 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 5, [1] = 13, [2] = 103, [3] = 108 })[R[20]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 5, [1] = 13, [2] = 103, [3] = 108 })[R[20]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 5, [1] = 13, [2] = 103, [3] = 108 })[R[20]], ({ [0] = 11, [1] = 114, [2] = 109, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 19, [2] = 109, [3] = 114 })[R[20]], ({ [0] = 22, [1] = 125, [2] = 120, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 4 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 32, [2] = 124, [3] = 126 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 32, [2] = 124, [3] = 126 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 24, [2] = 116, [3] = 118 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 25, [2] = 117, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 121, [2] = 115, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 8, [1] = 112, [2] = 106, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 32, [2] = 124, [3] = 126 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 24, [2] = 116, [3] = 118 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 25, [2] = 117, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 121, [2] = 115, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 8, [1] = 112, [2] = 106, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 25, [2] = 117, [3] = 119 })[R[20]], ({ [0] = 17, [1] = 121, [2] = 115, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 8, [1] = 112, [2] = 106, [3] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 5 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 24, [2] = 116, [3] = 118 })[R[20]], ({ [0] = 8, [1] = 105, [2] = 106, [3] = 7 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 24, [2] = 116, [3] = 118 })[R[20]], ({ [0] = 8, [1] = 105, [2] = 106, [3] = 7 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 10, [1] = 12, [2] = 104, [3] = 106 })[R[20]], ({ [0] = 16, [1] = 113, [2] = 114, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 9, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 5, [1] = 102, [2] = 103, [3] = 4 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 112, [3] = 114 })[R[20]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 24, [2] = 116, [3] = 118 })[R[20]], ({ [0] = 8, [1] = 105, [2] = 106, [3] = 7 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 10, [1] = 12, [2] = 104, [3] = 106 })[R[20]], ({ [0] = 16, [1] = 113, [2] = 114, [3] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 9, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 5, [1] = 102, [2] = 103, [3] = 4 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 112, [3] = 114 })[R[20]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 9, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 5, [1] = 102, [2] = 103, [3] = 4 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 18, [1] = 20, [2] = 112, [3] = 114 })[R[20]], ({ [0] = 13, [1] = 110, [2] = 111, [3] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 11, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 117, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 11, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 117, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 26, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 4, [1] = 110, [2] = 104, [3] = 4 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 18, [2] = 110, [3] = 112 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 114, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 11, [1] = 117, [2] = 111, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 11, [1] = 11, [2] = 103, [3] = 105 })[R[20]], ({ [0] = 17, [1] = 123, [2] = 117, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 26, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 4, [1] = 110, [2] = 104, [3] = 4 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 18, [2] = 110, [3] = 112 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 114, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 11, [1] = 117, [2] = 111, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 18, [2] = 110, [3] = 112 })[R[20]], ({ [0] = 14, [1] = 120, [2] = 114, [3] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 11, [1] = 117, [2] = 111, [3] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 7 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 28, [1] = 28, [2] = 120, [3] = 128 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 28, [1] = 28, [2] = 120, [3] = 128 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 127 })[R[20]], ({ [0] = 7, [1] = 107, [2] = 109, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 12, [2] = 104, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 7, [1] = 7, [2] = 99, [3] = 107 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 28, [1] = 28, [2] = 120, [3] = 128 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 27, [1] = 27, [2] = 119, [3] = 127 })[R[20]], ({ [0] = 7, [1] = 107, [2] = 109, [3] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 12, [2] = 104, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 7, [1] = 7, [2] = 99, [3] = 107 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 12, [1] = 12, [2] = 104, [3] = 112 })[R[20]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 7, [1] = 7, [2] = 99, [3] = 107 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 27, [1] = 33, [2] = 125, [3] = 127 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 } })[R[37]][R[20]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 8, [1] = 111, [2] = 106, [3] = 9 }, [4] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [5] = { [0] = 22, [1] = 119, [2] = 120, [3] = 21 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 19, [2] = 103, [3] = 103 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 }, [5] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 9, [1] = 109, [2] = 111, [3] = 12 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 12, [1] = 16, [2] = 110, [3] = 111 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 18, [1] = 121, [2] = 116, [3] = 19 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 12, [1] = 109, [2] = 110, [3] = 11 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 8, [1] = 19, [2] = 105, [3] = 115 }, [2] = { [0] = 13, [1] = 17, [2] = 111, [3] = 112 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 19, [1] = 122, [2] = 117, [3] = 20 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 11, [1] = 111, [2] = 113, [3] = 14 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 22, [2] = 106, [3] = 106 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 8, [1] = 109, [2] = 108, [3] = 5 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 10, [1] = 114, [2] = 108, [3] = 11 }, [5] = { [0] = 17, [1] = 114, [2] = 115, [3] = 16 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 10, [1] = 21, [2] = 107, [3] = 117 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 9, [1] = 110, [2] = 109, [3] = 6 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 11, [1] = 115, [2] = 109, [3] = 12 }, [5] = { [0] = 18, [1] = 115, [2] = 116, [3] = 17 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 24, [2] = 108, [3] = 108 }, [1] = { [0] = 11, [1] = 22, [2] = 108, [3] = 118 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 16, [1] = 16, [2] = 108, [3] = 110 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 10, [1] = 111, [2] = 110, [3] = 7 }, [3] = { [0] = 14, [1] = 117, [2] = 112, [3] = 15 }, [4] = { [0] = 15, [1] = 119, [2] = 113, [3] = 16 }, [5] = { [0] = 19, [1] = 116, [2] = 117, [3] = 18 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 14, [1] = 114, [2] = 116, [3] = 17 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 25, [2] = 109, [3] = 109 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 15, [1] = 118, [2] = 113, [3] = 16 }, [4] = { [0] = 16, [1] = 120, [2] = 114, [3] = 17 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 6, [1] = 111, [2] = 110, [3] = 8 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 12, [1] = 113, [2] = 112, [3] = 9 }, [3] = { [0] = 16, [1] = 119, [2] = 114, [3] = 17 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 16, [1] = 116, [2] = 118, [3] = 19 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[37]][R[20]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 8, [1] = 104, [2] = 104, [3] = 10 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 18, [1] = 122, [2] = 116, [3] = 19 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 17, [1] = 117, [2] = 119, [3] = 20 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[37]][R[20]], ({ [0] = { [0] = 8, [1] = 113, [2] = 112, [3] = 10 }, [1] = { [0] = 9, [1] = 105, [2] = 105, [3] = 11 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 19, [1] = 123, [2] = 117, [3] = 20 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[37]][R[20]], ({ [0] = { [0] = 9, [1] = 114, [2] = 113, [3] = 11 }, [1] = { [0] = 10, [1] = 106, [2] = 106, [3] = 12 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 12, [1] = 20, [2] = 110, [3] = 115 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[37]][R[20]], ({ [0] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [1] = { [0] = 15, [1] = 111, [2] = 111, [3] = 17 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[37]][R[20]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 121, [2] = 120, [3] = 18 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 30, [2] = 114, [3] = 114 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 14, [1] = 22, [2] = 112, [3] = 117 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 31, [2] = 115, [3] = 115 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 19, [1] = 115, [2] = 115, [3] = 21 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 23, [1] = 25, [2] = 117, [3] = 119 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 20, [1] = 116, [2] = 116, [3] = 22 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 6, [1] = 110, [2] = 104, [3] = 7 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 25, [1] = 121, [2] = 121, [3] = 27 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 34, [2] = 118, [3] = 118 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 18, [1] = 22, [2] = 116, [3] = 117 }, [3] = { [0] = 18, [1] = 26, [2] = 116, [3] = 121 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 26, [1] = 122, [2] = 122, [3] = 28 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 8, [1] = 108, [2] = 110, [3] = 11 } })[R[37]][R[20]] })
    if R[37] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[20]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[20]] })
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [2] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 } })[R[63]][R[20]], ({ [0] = { [0] = 5, [1] = 110, [2] = 109, [3] = 7 }, [1] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [2] = { [0] = 17, [1] = 122, [2] = 121, [3] = 19 } })[R[63]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[20]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[20]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 5, [1] = 16, [2] = 102, [3] = 112 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 } })[R[64]][R[20]], ({ [0] = { [0] = 22, [1] = 118, [2] = 118, [3] = 24 }, [1] = { [0] = 24, [1] = 120, [2] = 120, [3] = 26 }, [2] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 } })[R[64]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 9, [1] = 13, [2] = 107, [3] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [2] = { [0] = 27, [1] = 31, [2] = 125, [3] = 126 } })[R[65]][R[20]], ({ [0] = { [0] = 5, [1] = 106, [2] = 105, [3] = 2 }, [1] = { [0] = 21, [1] = 122, [2] = 121, [3] = 18 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 } })[R[65]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[20]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[20]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[20]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[20]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [1] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [2] = { [0] = 4, [1] = 12, [2] = 102, [3] = 107 } })[R[66]][R[20]], ({ [0] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 123, [2] = 118, [3] = 21 }, [2] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 } })[R[66]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[20]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[20]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [1] = { [0] = 9, [1] = 15, [2] = 107, [3] = 109 }, [2] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 } })[R[67]][R[20]], ({ [0] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [1] = { [0] = 12, [1] = 116, [2] = 110, [3] = 13 }, [2] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 } })[R[67]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[20]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[20]] })
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [1] = { [0] = 3, [1] = 5, [2] = 97, [3] = 99 }, [2] = { [0] = 25, [1] = 27, [2] = 119, [3] = 121 } })[R[68]][R[20]], ({ [0] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 }, [1] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [2] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 } })[R[68]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[20]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[20]] })
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 8, [1] = 8, [2] = 100, [3] = 102 }, [1] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [2] = { [0] = 34, [1] = 34, [2] = 126, [3] = 128 } })[R[69]][R[20]], ({ [0] = { [0] = 2, [1] = 108, [2] = 102, [3] = 2 }, [1] = { [0] = 0, [1] = 106, [2] = 100, [3] = 0 }, [2] = { [0] = 15, [1] = 121, [2] = 115, [3] = 15 } })[R[69]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[20]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[20]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[20]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[20]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[20]] })
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 }, [1] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 }, [2] = { [0] = 9, [1] = 9, [2] = 101, [3] = 109 } })[R[70]][R[20]], ({ [0] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [1] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [2] = { [0] = 23, [1] = 123, [2] = 125, [3] = 26 } })[R[70]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
    end
    R[71] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 6, [1] = 107, [2] = 106, [3] = 3 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[71]][R[46]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 8, [1] = 12, [2] = 106, [3] = 107 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[71]][R[46]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 5, [1] = 101, [2] = 101, [3] = 7 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    if R[71] == 0 or R[71] == 1 or R[71] == 2 or R[71] == 5 or R[71] == 6 or R[71] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 23, [1] = 23, [2] = 115, [3] = 117 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 12, [1] = 108, [2] = 108, [3] = 14 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 20, [1] = 117, [2] = 118, [3] = 19 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 0 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[46]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[46]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 12, [1] = 16, [2] = 100, [3] = 100 })[R[46]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 1 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[46]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[46]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[46]], ({ [0] = 22, [1] = 118, [2] = 118, [3] = 24 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 2 then
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
      elseif R[71] == 5 then
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
      elseif R[71] == 6 then
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
      elseif R[71] == 7 then
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
        unseen("R[71]", R[71])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 31, [1] = 31, [2] = 123, [3] = 125 }, [7] = { [0] = 25, [1] = 25, [2] = 117, [3] = 125 } })[R[71]][R[46]], ({ [0] = { [0] = 18, [1] = 123, [2] = 122, [3] = 20 }, [1] = { [0] = 30, [1] = 126, [2] = 126, [3] = 32 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 2 or R[71] == 5 or R[71] == 6 or R[71] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 14, [1] = 14, [2] = 106, [3] = 108 }, [7] = { [0] = 26, [1] = 26, [2] = 118, [3] = 126 } })[R[71]][R[46]], ({ [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 18, [1] = 118, [2] = 120, [3] = 21 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 0 or R[71] == 1 then
      else
        unseen("R[71]", R[71])
      end
    elseif R[71] == 3 or R[71] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 } })[R[71]][R[46]], ({ [3] = { [0] = 21, [1] = 124, [2] = 119, [3] = 22 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[46]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
      else
        unseen("R[71]", R[71])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 25, [1] = 31, [2] = 123, [3] = 125 } })[R[71]][R[46]], ({ [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 3 then
        if LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[46]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[46]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[46]], ({ [0] = 10, [1] = 113, [2] = 108, [3] = 11 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 4 then
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
        unseen("R[71]", R[71])
      end
    else
      unseen("R[71]", R[71])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = { [0] = 12, [1] = 16, [2] = 100, [3] = 100 }, [1] = { [0] = 4, [1] = 15, [2] = 101, [3] = 111 }, [2] = { [0] = 28, [1] = 32, [2] = 126, [3] = 127 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 6, [1] = 12, [2] = 104, [3] = 106 }, [5] = { [0] = 4, [1] = 6, [2] = 98, [3] = 100 }, [6] = { [0] = 6, [1] = 6, [2] = 98, [3] = 100 }, [7] = { [0] = 18, [1] = 18, [2] = 110, [3] = 118 } })[R[71]][R[46]], ({ [0] = { [0] = 20, [1] = 125, [2] = 124, [3] = 22 }, [1] = { [0] = 27, [1] = 123, [2] = 123, [3] = 29 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 4, [1] = 107, [2] = 102, [3] = 5 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 22, [1] = 122, [2] = 124, [3] = 25 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 24, [1] = 30, [2] = 122, [3] = 124 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[71]][R[46]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 6, [1] = 103, [2] = 104, [3] = 5 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[71]][R[46]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 11, [1] = 107, [2] = 107, [3] = 13 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[4].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 25, [1] = 33, [2] = 123, [3] = 128 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[71]][R[46]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[71]][R[46]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 9, [1] = 11, [2] = 103, [3] = 105 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 12, [1] = 12, [2] = 104, [3] = 112 } })[R[71]][R[46]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 19, [1] = 120, [2] = 119, [3] = 16 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 5, [1] = 102, [2] = 103, [3] = 4 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 21, [1] = 27, [2] = 119, [3] = 121 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 7, [1] = 7, [2] = 99, [3] = 107 } })[R[71]][R[46]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 4, [1] = 100, [2] = 100, [3] = 6 }, [2] = { [0] = 20, [1] = 121, [2] = 120, [3] = 17 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 11, [1] = 117, [2] = 111, [3] = 11 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 25, [1] = 33, [2] = 123, [3] = 128 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 3, [1] = 14, [2] = 100, [3] = 110 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 26, [1] = 32, [2] = 124, [3] = 126 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 11, [1] = 11, [2] = 103, [3] = 105 }, [7] = { [0] = 28, [1] = 28, [2] = 120, [3] = 128 } })[R[71]][R[46]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 8, [1] = 105, [2] = 106, [3] = 7 }, [6] = { [0] = 17, [1] = 123, [2] = 117, [3] = 17 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 5, [1] = 13, [2] = 103, [3] = 108 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 9, [1] = 11, [2] = 103, [3] = 105 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 12, [1] = 12, [2] = 104, [3] = 112 } })[R[71]][R[46]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 19, [1] = 120, [2] = 119, [3] = 16 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 5, [1] = 102, [2] = 103, [3] = 4 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 21, [1] = 27, [2] = 119, [3] = 121 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 7, [1] = 7, [2] = 99, [3] = 107 } })[R[71]][R[46]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 4, [1] = 100, [2] = 100, [3] = 6 }, [2] = { [0] = 20, [1] = 121, [2] = 120, [3] = 17 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 11, [1] = 117, [2] = 111, [3] = 11 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 25, [1] = 33, [2] = 123, [3] = 128 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 11, [1] = 114, [2] = 109, [3] = 12 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 6, [1] = 10, [2] = 104, [3] = 105 }, [3] = { [0] = 23, [1] = 31, [2] = 121, [3] = 126 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 27, [1] = 27, [2] = 119, [3] = 127 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 13, [1] = 109, [2] = 109, [3] = 15 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 7, [1] = 110, [2] = 105, [3] = 8 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 24, [1] = 28, [2] = 122, [3] = 123 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 9, [1] = 11, [2] = 103, [3] = 105 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 12, [1] = 12, [2] = 104, [3] = 112 } })[R[71]][R[46]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 19, [1] = 120, [2] = 119, [3] = 16 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 5, [1] = 102, [2] = 103, [3] = 4 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 14, [1] = 18, [2] = 102, [3] = 102 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 20, [1] = 24, [2] = 118, [3] = 119 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 21, [1] = 27, [2] = 119, [3] = 121 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 7, [1] = 7, [2] = 99, [3] = 107 } })[R[71]][R[46]], ({ [0] = { [0] = 4, [1] = 109, [2] = 108, [3] = 6 }, [1] = { [0] = 4, [1] = 100, [2] = 100, [3] = 6 }, [2] = { [0] = 20, [1] = 121, [2] = 120, [3] = 17 }, [3] = { [0] = 22, [1] = 125, [2] = 120, [3] = 23 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 11, [1] = 117, [2] = 111, [3] = 11 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 35, [1] = 39, [2] = 123, [3] = 123 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 27, [1] = 33, [2] = 125, [3] = 127 }, [5] = { [0] = 10, [1] = 12, [2] = 104, [3] = 106 }, [6] = { [0] = 27, [1] = 27, [2] = 119, [3] = 121 }, [7] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 } })[R[71]][R[46]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 8, [1] = 111, [2] = 106, [3] = 9 }, [4] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [5] = { [0] = 22, [1] = 119, [2] = 120, [3] = 21 }, [6] = { [0] = 14, [1] = 120, [2] = 114, [3] = 14 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 15, [1] = 19, [2] = 103, [3] = 103 }, [1] = { [0] = 6, [1] = 17, [2] = 103, [3] = 113 }, [2] = { [0] = 11, [1] = 15, [2] = 109, [3] = 110 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 }, [5] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 9, [1] = 109, [2] = 111, [3] = 12 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 12, [1] = 16, [2] = 110, [3] = 111 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 18, [1] = 121, [2] = 116, [3] = 19 }, [4] = { [0] = 8, [1] = 112, [2] = 106, [3] = 9 }, [5] = { [0] = 12, [1] = 109, [2] = 110, [3] = 11 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 10, [1] = 110, [2] = 112, [3] = 13 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 21, [2] = 105, [3] = 105 }, [1] = { [0] = 8, [1] = 19, [2] = 105, [3] = 115 }, [2] = { [0] = 13, [1] = 17, [2] = 111, [3] = 112 }, [3] = { [0] = 7, [1] = 15, [2] = 105, [3] = 110 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 19, [1] = 122, [2] = 117, [3] = 20 }, [4] = { [0] = 9, [1] = 113, [2] = 107, [3] = 10 }, [5] = { [0] = 13, [1] = 110, [2] = 111, [3] = 12 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 11, [1] = 111, [2] = 113, [3] = 14 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 22, [2] = 106, [3] = 106 }, [1] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 8, [1] = 16, [2] = 106, [3] = 111 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 8, [1] = 109, [2] = 108, [3] = 5 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 10, [1] = 114, [2] = 108, [3] = 11 }, [5] = { [0] = 17, [1] = 114, [2] = 115, [3] = 16 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 12, [1] = 112, [2] = 114, [3] = 15 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 23, [2] = 107, [3] = 107 }, [1] = { [0] = 10, [1] = 21, [2] = 107, [3] = 117 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 9, [1] = 110, [2] = 109, [3] = 6 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 11, [1] = 115, [2] = 109, [3] = 12 }, [5] = { [0] = 18, [1] = 115, [2] = 116, [3] = 17 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 13, [1] = 113, [2] = 115, [3] = 16 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 24, [2] = 108, [3] = 108 }, [1] = { [0] = 11, [1] = 22, [2] = 108, [3] = 118 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 14, [1] = 16, [2] = 108, [3] = 110 }, [6] = { [0] = 16, [1] = 16, [2] = 108, [3] = 110 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 10, [1] = 111, [2] = 110, [3] = 7 }, [3] = { [0] = 14, [1] = 117, [2] = 112, [3] = 15 }, [4] = { [0] = 15, [1] = 119, [2] = 113, [3] = 16 }, [5] = { [0] = 19, [1] = 116, [2] = 117, [3] = 18 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 14, [1] = 114, [2] = 116, [3] = 17 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 25, [2] = 109, [3] = 109 }, [1] = { [0] = 12, [1] = 23, [2] = 109, [3] = 119 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 15, [1] = 118, [2] = 113, [3] = 16 }, [4] = { [0] = 16, [1] = 120, [2] = 114, [3] = 17 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 15, [1] = 115, [2] = 117, [3] = 18 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 17, [1] = 19, [2] = 111, [3] = 113 }, [6] = { [0] = 17, [1] = 17, [2] = 109, [3] = 111 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[71]][R[46]], ({ [0] = { [0] = 6, [1] = 111, [2] = 110, [3] = 8 }, [1] = { [0] = 7, [1] = 103, [2] = 103, [3] = 9 }, [2] = { [0] = 12, [1] = 113, [2] = 112, [3] = 9 }, [3] = { [0] = 16, [1] = 119, [2] = 114, [3] = 17 }, [4] = { [0] = 17, [1] = 121, [2] = 115, [3] = 18 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 16, [1] = 116, [2] = 118, [3] = 19 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 9, [1] = 17, [2] = 107, [3] = 112 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 10, [1] = 10, [2] = 102, [3] = 110 } })[R[71]][R[46]], ({ [0] = { [0] = 7, [1] = 112, [2] = 111, [3] = 9 }, [1] = { [0] = 8, [1] = 104, [2] = 104, [3] = 10 }, [2] = { [0] = 13, [1] = 114, [2] = 113, [3] = 10 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 18, [1] = 122, [2] = 116, [3] = 19 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 17, [1] = 117, [2] = 119, [3] = 20 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 14, [1] = 20, [2] = 112, [3] = 114 }, [5] = { [0] = 18, [1] = 20, [2] = 112, [3] = 114 }, [6] = { [0] = 18, [1] = 18, [2] = 110, [3] = 112 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[71]][R[46]], ({ [0] = { [0] = 8, [1] = 113, [2] = 112, [3] = 10 }, [1] = { [0] = 9, [1] = 105, [2] = 105, [3] = 11 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 }, [3] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [4] = { [0] = 19, [1] = 123, [2] = 117, [3] = 20 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 10, [1] = 18, [2] = 108, [3] = 113 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 13, [1] = 13, [2] = 105, [3] = 113 } })[R[71]][R[46]], ({ [0] = { [0] = 9, [1] = 114, [2] = 113, [3] = 11 }, [1] = { [0] = 10, [1] = 106, [2] = 106, [3] = 12 }, [2] = { [0] = 15, [1] = 116, [2] = 115, [3] = 12 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 13, [1] = 24, [2] = 110, [3] = 120 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 11, [1] = 19, [2] = 109, [3] = 114 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 19, [1] = 21, [2] = 113, [3] = 115 }, [6] = { [0] = 19, [1] = 19, [2] = 111, [3] = 113 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 118, [2] = 117, [3] = 15 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 16, [1] = 117, [2] = 116, [3] = 13 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [3] = { [0] = 12, [1] = 20, [2] = 110, [3] = 115 }, [4] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 14, [1] = 14, [2] = 106, [3] = 114 } })[R[71]][R[46]], ({ [0] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [1] = { [0] = 15, [1] = 111, [2] = 111, [3] = 17 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 4, [1] = 110, [2] = 104, [3] = 4 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [6] = { [0] = 20, [1] = 20, [2] = 112, [3] = 114 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[71]][R[46]], ({ [0] = { [0] = 15, [1] = 120, [2] = 119, [3] = 17 }, [1] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 27, [2] = 111, [3] = 111 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 15, [1] = 19, [2] = 113, [3] = 114 }, [3] = { [0] = 13, [1] = 21, [2] = 111, [3] = 116 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 121, [2] = 120, [3] = 18 }, [1] = { [0] = 17, [1] = 113, [2] = 113, [3] = 19 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 6, [1] = 112, [2] = 106, [3] = 6 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 30, [2] = 114, [3] = 114 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 14, [1] = 22, [2] = 112, [3] = 117 }, [4] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [5] = { [0] = 21, [1] = 23, [2] = 115, [3] = 117 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 18, [1] = 114, [2] = 114, [3] = 20 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 21, [1] = 118, [2] = 119, [3] = 20 }, [6] = { [0] = 7, [1] = 113, [2] = 107, [3] = 7 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 31, [2] = 115, [3] = 115 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 16, [1] = 20, [2] = 114, [3] = 115 }, [3] = { [0] = 15, [1] = 23, [2] = 113, [3] = 118 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 22, [1] = 24, [2] = 116, [3] = 118 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 16, [1] = 16, [2] = 108, [3] = 116 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 19, [1] = 115, [2] = 115, [3] = 21 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 5, [1] = 109, [2] = 103, [3] = 6 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 8, [1] = 114, [2] = 108, [3] = 8 }, [7] = { [0] = 19, [1] = 119, [2] = 121, [3] = 22 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 23, [1] = 25, [2] = 117, [3] = 119 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 20, [1] = 116, [2] = 116, [3] = 22 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 6, [1] = 110, [2] = 104, [3] = 7 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 9, [1] = 115, [2] = 109, [3] = 9 }, [7] = { [0] = 6, [1] = 106, [2] = 108, [3] = 9 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 17, [1] = 21, [2] = 115, [3] = 116 }, [3] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 22, [1] = 22, [2] = 114, [3] = 116 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 25, [1] = 121, [2] = 121, [3] = 27 }, [2] = { [0] = 17, [1] = 118, [2] = 117, [3] = 14 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 13, [1] = 117, [2] = 111, [3] = 14 }, [5] = { [0] = 15, [1] = 112, [2] = 113, [3] = 14 }, [6] = { [0] = 10, [1] = 116, [2] = 110, [3] = 10 }, [7] = { [0] = 7, [1] = 107, [2] = 109, [3] = 10 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 34, [2] = 118, [3] = 118 }, [1] = { [0] = 14, [1] = 25, [2] = 111, [3] = 121 }, [2] = { [0] = 18, [1] = 22, [2] = 116, [3] = 117 }, [3] = { [0] = 18, [1] = 26, [2] = 116, [3] = 121 }, [4] = { [0] = 19, [1] = 25, [2] = 117, [3] = 119 }, [5] = { [0] = 24, [1] = 26, [2] = 118, [3] = 120 }, [6] = { [0] = 26, [1] = 26, [2] = 118, [3] = 120 }, [7] = { [0] = 17, [1] = 17, [2] = 109, [3] = 117 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 116, [2] = 115, [3] = 13 }, [1] = { [0] = 26, [1] = 122, [2] = 122, [3] = 28 }, [2] = { [0] = 11, [1] = 112, [2] = 111, [3] = 8 }, [3] = { [0] = 10, [1] = 113, [2] = 108, [3] = 11 }, [4] = { [0] = 21, [1] = 125, [2] = 119, [3] = 22 }, [5] = { [0] = 16, [1] = 113, [2] = 114, [3] = 15 }, [6] = { [0] = 12, [1] = 118, [2] = 112, [3] = 12 }, [7] = { [0] = 8, [1] = 108, [2] = 110, [3] = 11 } })[R[71]][R[46]] })
    if R[71] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[46]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[46]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 35, [2] = 119, [3] = 119 })[R[46]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 32, [1] = 36, [2] = 120, [3] = 120 })[R[46]], ({ [0] = 11, [1] = 116, [2] = 115, [3] = 13 })[R[46]] })
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 29, [1] = 33, [2] = 117, [3] = 117 }, [1] = { [0] = 16, [1] = 20, [2] = 104, [3] = 104 }, [2] = { [0] = 28, [1] = 32, [2] = 116, [3] = 116 } })[R[72]][R[46]], ({ [0] = { [0] = 5, [1] = 110, [2] = 109, [3] = 7 }, [1] = { [0] = 14, [1] = 119, [2] = 118, [3] = 16 }, [2] = { [0] = 17, [1] = 122, [2] = 121, [3] = 19 } })[R[72]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[46]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[46]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[46]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[46]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[46]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[46]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[46]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[46]], ({ [0] = 27, [1] = 123, [2] = 123, [3] = 29 })[R[46]] })
        game.create_tube({ ({ [0] = 14, [1] = 25, [2] = 111, [3] = 121 })[R[46]], ({ [0] = 28, [1] = 124, [2] = 124, [3] = 30 })[R[46]] })
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 5, [1] = 16, [2] = 102, [3] = 112 }, [1] = { [0] = 7, [1] = 18, [2] = 104, [3] = 114 }, [2] = { [0] = 9, [1] = 20, [2] = 106, [3] = 116 } })[R[73]][R[46]], ({ [0] = { [0] = 22, [1] = 118, [2] = 118, [3] = 24 }, [1] = { [0] = 24, [1] = 120, [2] = 120, [3] = 26 }, [2] = { [0] = 16, [1] = 112, [2] = 112, [3] = 18 } })[R[73]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 9, [1] = 13, [2] = 107, [3] = 108 }, [1] = { [0] = 14, [1] = 18, [2] = 112, [3] = 113 }, [2] = { [0] = 27, [1] = 31, [2] = 125, [3] = 126 } })[R[74]][R[46]], ({ [0] = { [0] = 5, [1] = 106, [2] = 105, [3] = 2 }, [1] = { [0] = 21, [1] = 122, [2] = 121, [3] = 18 }, [2] = { [0] = 14, [1] = 115, [2] = 114, [3] = 11 } })[R[74]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[46]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[46]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[46]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[46]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[46]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[46]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[46]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[46]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 16, [1] = 24, [2] = 114, [3] = 119 }, [1] = { [0] = 17, [1] = 25, [2] = 115, [3] = 120 }, [2] = { [0] = 4, [1] = 12, [2] = 102, [3] = 107 } })[R[75]][R[46]], ({ [0] = { [0] = 13, [1] = 116, [2] = 111, [3] = 14 }, [1] = { [0] = 20, [1] = 123, [2] = 118, [3] = 21 }, [2] = { [0] = 17, [1] = 120, [2] = 115, [3] = 18 } })[R[75]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 26, [2] = 116, [3] = 121 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 27, [2] = 117, [3] = 122 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 28, [2] = 118, [3] = 123 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[46]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 29, [2] = 119, [3] = 124 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[46]], ({ [0] = 13, [1] = 116, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[46]], ({ [0] = 14, [1] = 117, [2] = 112, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[46]], ({ [0] = 15, [1] = 118, [2] = 113, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[46]], ({ [0] = 16, [1] = 119, [2] = 114, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 30, [2] = 120, [3] = 125 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[46]], ({ [0] = 17, [1] = 120, [2] = 115, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[46]], ({ [0] = 18, [1] = 121, [2] = 116, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 31, [2] = 121, [3] = 126 })[R[46]], ({ [0] = 19, [1] = 122, [2] = 117, [3] = 20 })[R[46]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[46]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[46]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[46]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[46]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[46]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[46]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[46]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[46]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[46]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[46]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[46]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[46]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 6, [1] = 110, [2] = 104, [3] = 7 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[46]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[46]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 27, [2] = 119, [3] = 121 })[R[46]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[46]], ({ [0] = 7, [1] = 111, [2] = 105, [3] = 8 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[46]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 28, [2] = 120, [3] = 122 })[R[46]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 13, [1] = 117, [2] = 111, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 14, [1] = 118, [2] = 112, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 15, [1] = 119, [2] = 113, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 21, [1] = 125, [2] = 119, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[46]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 24, [1] = 30, [2] = 122, [3] = 124 })[R[46]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[46]], ({ [0] = 10, [1] = 114, [2] = 108, [3] = 11 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[46]], ({ [0] = 11, [1] = 115, [2] = 109, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[46]], ({ [0] = 12, [1] = 116, [2] = 110, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 31, [2] = 123, [3] = 125 })[R[46]], ({ [0] = 20, [1] = 124, [2] = 118, [3] = 21 })[R[46]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 18, [1] = 24, [2] = 116, [3] = 118 }, [1] = { [0] = 9, [1] = 15, [2] = 107, [3] = 109 }, [2] = { [0] = 17, [1] = 23, [2] = 115, [3] = 117 } })[R[76]][R[46]], ({ [0] = { [0] = 4, [1] = 108, [2] = 102, [3] = 5 }, [1] = { [0] = 12, [1] = 116, [2] = 110, [3] = 13 }, [2] = { [0] = 7, [1] = 111, [2] = 105, [3] = 8 } })[R[76]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 17, [1] = 114, [2] = 115, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 24, [1] = 26, [2] = 118, [3] = 120 })[R[46]], ({ [0] = 18, [1] = 115, [2] = 116, [3] = 17 })[R[46]] })
        for i = 1, game.initial_units() do
          R[77] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 20, [1] = 22, [2] = 114, [3] = 116 }, [1] = { [0] = 3, [1] = 5, [2] = 97, [3] = 99 }, [2] = { [0] = 25, [1] = 27, [2] = 119, [3] = 121 } })[R[77]][R[46]], ({ [0] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 }, [1] = { [0] = 11, [1] = 108, [2] = 109, [3] = 10 }, [2] = { [0] = 24, [1] = 121, [2] = 122, [3] = 23 } })[R[77]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 27, [1] = 27, [2] = 119, [3] = 121 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 28, [1] = 28, [2] = 120, [3] = 122 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 29, [1] = 29, [2] = 121, [3] = 123 })[R[46]], ({ [0] = 12, [1] = 118, [2] = 112, [3] = 12 })[R[46]] })
        for i = 1, game.initial_units() do
          R[78] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 8, [1] = 8, [2] = 100, [3] = 102 }, [1] = { [0] = 13, [1] = 13, [2] = 105, [3] = 107 }, [2] = { [0] = 34, [1] = 34, [2] = 126, [3] = 128 } })[R[78]][R[46]], ({ [0] = { [0] = 2, [1] = 108, [2] = 102, [3] = 2 }, [1] = { [0] = 0, [1] = 106, [2] = 100, [3] = 0 }, [2] = { [0] = 15, [1] = 121, [2] = 115, [3] = 15 } })[R[78]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 17, [1] = 117, [2] = 119, [3] = 20 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 18, [1] = 118, [2] = 120, [3] = 21 })[R[46]] })
        game.create_tube({ ({ [0] = 17, [1] = 17, [2] = 109, [3] = 117 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 18, [1] = 18, [2] = 110, [3] = 118 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 19, [2] = 111, [3] = 119 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 20, [2] = 112, [3] = 120 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 21, [1] = 21, [2] = 113, [3] = 121 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 22, [2] = 114, [3] = 122 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[46]], ({ [0] = 6, [1] = 106, [2] = 108, [3] = 9 })[R[46]] })
        game.create_tube({ ({ [0] = 23, [1] = 23, [2] = 115, [3] = 123 })[R[46]], ({ [0] = 19, [1] = 119, [2] = 121, [3] = 22 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 8, [1] = 108, [2] = 110, [3] = 11 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 9, [1] = 109, [2] = 111, [3] = 12 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 10, [1] = 110, [2] = 112, [3] = 13 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 11, [1] = 111, [2] = 113, [3] = 14 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 12, [1] = 112, [2] = 114, [3] = 15 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 13, [1] = 113, [2] = 115, [3] = 16 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 14, [1] = 114, [2] = 116, [3] = 17 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 15, [1] = 115, [2] = 117, [3] = 18 })[R[46]] })
        game.create_tube({ ({ [0] = 25, [1] = 25, [2] = 117, [3] = 125 })[R[46]], ({ [0] = 16, [1] = 116, [2] = 118, [3] = 19 })[R[46]] })
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 15, [1] = 15, [2] = 107, [3] = 115 }, [1] = { [0] = 21, [1] = 21, [2] = 113, [3] = 121 }, [2] = { [0] = 9, [1] = 9, [2] = 101, [3] = 109 } })[R[79]][R[46]], ({ [0] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [1] = { [0] = 2, [1] = 102, [2] = 104, [3] = 5 }, [2] = { [0] = 23, [1] = 123, [2] = 125, [3] = 26 } })[R[79]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[71]", R[71])
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
    players[3].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[3].difficulty]]
    players[3].scientists = 16 - 3 * LEVEL_OF[players[3].difficulty]
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
    players[4].workers = ({ [0] = 30, [1] = 26, [2] = 24 })[LEVEL_OF[players[4].difficulty]]
    players[4].scientists = 16 - 3 * LEVEL_OF[players[4].difficulty]
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
  local t2 = trigger.midas{time = 25000}
  mission.victory(t2, "Have the most ore in storage at Mark 250", {one_shot = true})
  if game.disasters_enabled() then
    trigger.time{min = 18000, max = 20000, one_shot = false, on = Meteor}  -- after 180 to 200 marks
    trigger.time{min = 12000, max = 18000, one_shot = false, on = Storm}  -- after 120 to 180 marks
  end
  return true
end
