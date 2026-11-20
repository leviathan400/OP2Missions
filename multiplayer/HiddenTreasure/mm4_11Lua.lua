-- mm4_11Lua.lua  -  4 Player, Midas, 'Hidden Treasure' map. (Lua)
--
-- Converted by op2dll from mm4_11.dll ("4 Player, Midas, 'Hidden Treasure' map."): its setup replayed. `on_init` makes the original's
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
  local r1 = game.rand(126)
  local r2 = game.rand(127)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function Storm(t)
  local r1 = game.rand(4)
  local r2 = game.rand(7)
  local r3 = game.rand(128)
  if r1 == 0 then
    game.create_lightning({ 1, r3 + 1 }, nil, r2 + 10)
  elseif r1 == 1 then
    game.create_lightning({ 129, r3 + 1 }, nil, r2 + 10)
  elseif r1 == 2 then
    game.create_lightning({ r3 + 1, 2 }, nil, r2 + 10)
  else
    game.create_lightning({ r3 + 1, 129 }, nil, r2 + 10)
  end
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 39, 98 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 45, 48 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 98, 37 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 92, 90 } }
    pick(16, 4, { 0, 1, 2, 3 })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 35, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 47, 89 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 101 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 68, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 46, 64 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 84, 84 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 68 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 82, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 95, 73 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 62, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 52 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 87, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 106, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 74, 46 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 70, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 62, 11 } }
    R[4] = game.rand(4)
    R[5] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 97 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 11, [1] = 98, [2] = 94, [3] = 7 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    if R[5] == 0 or R[5] == 1 or R[5] == 2 or R[5] == 5 or R[5] == 6 or R[5] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 21, [1] = 24, [2] = 117, [3] = 115 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 18, [1] = 105, [2] = 101, [3] = 14 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 27, [1] = 118, [2] = 116, [3] = 19 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[5] == 0 then
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
      elseif R[5] == 1 then
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
      elseif R[5] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[5] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[5] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[5] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[5]", R[5])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 16, [2] = 102, [3] = 98 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 12, [1] = 15, [2] = 108, [3] = 106 }, [7] = { [0] = 24, [1] = 22, [2] = 118, [3] = 123 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 28, [1] = 115, [2] = 111, [3] = 24 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 25, [1] = 120, [2] = 121, [3] = 19 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[5] == 2 or R[5] == 5 or R[5] == 6 or R[5] == 7 then
      elseif R[5] == 0 or R[5] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 } })[R[5]][R[4]], ({ [0] = { [0] = 26, [1] = 124, [2] = 119, [3] = 21 }, [1] = { [0] = 36, [1] = 123, [2] = 119, [3] = 32 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[5]", R[5])
      end
    elseif R[5] == 3 or R[5] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 } })[R[5]][R[4]], ({ [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[5] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 21, [1] = 17, [2] = 111, [3] = 98 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[5] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[5]", R[5])
      end
    else
      unseen("R[5]", R[5])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 16, [2] = 102, [3] = 98 }, [1] = { [0] = 13, [1] = 10, [2] = 115, [3] = 109 }, [2] = { [0] = 35, [1] = 31, [2] = 125, [3] = 117 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 17, [1] = 11, [2] = 105, [3] = 93 }, [5] = { [0] = 5, [1] = 4, [2] = 95, [3] = 95 }, [6] = { [0] = 4, [1] = 7, [2] = 100, [3] = 98 }, [7] = { [0] = 16, [1] = 14, [2] = 110, [3] = 115 } })[R[5]][R[4]], ({ [0] = { [0] = 28, [1] = 126, [2] = 121, [3] = 23 }, [1] = { [0] = 33, [1] = 120, [2] = 116, [3] = 29 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 11, [1] = 107, [2] = 104, [3] = 3 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 29, [1] = 124, [2] = 125, [3] = 23 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 35, [1] = 29, [2] = 123, [3] = 111 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[5]][R[4]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 13, [1] = 104, [2] = 102, [3] = 5 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[5]][R[4]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 17, [1] = 104, [2] = 100, [3] = 13 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[5] == 0 or R[5] == 1 or R[5] == 2 or R[5] == 4 or R[5] == 5 or R[5] == 6 or R[5] == 7 then
    elseif R[5] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 36, [1] = 32, [2] = 126, [3] = 113 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 107, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    else
      unseen("R[5]", R[5])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[5]][R[4]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[5]][R[4]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[5] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 32, [2] = 118, [3] = 114 })[R[4]], ({ [0] = 21, [1] = 119, [2] = 114, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 32, [2] = 118, [3] = 114 })[R[4]], ({ [0] = 21, [1] = 119, [2] = 114, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[4]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[4]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[4]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 9, [2] = 103, [3] = 95 })[R[4]], ({ [0] = 23, [1] = 117, [2] = 114, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 9, [2] = 103, [3] = 95 })[R[4]], ({ [0] = 23, [1] = 117, [2] = 114, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 3 then
      if LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      elseif LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 23, [2] = 117, [3] = 105 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 23, [2] = 117, [3] = 105 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[4]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[4]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 10, [2] = 101, [3] = 101 })[R[4]], ({ [0] = 23, [1] = 114, [2] = 112, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[4]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 10, [2] = 101, [3] = 101 })[R[4]], ({ [0] = 23, [1] = 114, [2] = 112, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[4]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[4]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 120, [3] = 118 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 113, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[4]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 120, [3] = 118 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 113, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 23, [2] = 119, [3] = 124 })[R[4]], ({ [0] = 14, [1] = 109, [2] = 110, [3] = 8 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 23, [2] = 119, [3] = 124 })[R[4]], ({ [0] = 14, [1] = 109, [2] = 110, [3] = 8 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[5]", R[5])
    end
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 38, [1] = 32, [2] = 126, [3] = 114 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 } })[R[5]][R[4]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 15, [1] = 111, [2] = 108, [3] = 7 }, [4] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [5] = { [0] = 29, [1] = 120, [2] = 118, [3] = 21 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 19, [2] = 105, [3] = 101 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 }, [5] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 16, [1] = 111, [2] = 112, [3] = 10 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 19, [1] = 15, [2] = 109, [3] = 101 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 25, [1] = 121, [2] = 118, [3] = 17 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 19, [1] = 110, [2] = 108, [3] = 11 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 17, [1] = 14, [2] = 119, [3] = 113 }, [2] = { [0] = 20, [1] = 16, [2] = 110, [3] = 102 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 26, [1] = 122, [2] = 119, [3] = 18 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 18, [1] = 113, [2] = 114, [3] = 12 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 22, [2] = 108, [3] = 104 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 15, [1] = 109, [2] = 106, [3] = 12 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 17, [1] = 113, [2] = 112, [3] = 9 }, [5] = { [0] = 24, [1] = 115, [2] = 113, [3] = 16 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 19, [1] = 16, [2] = 121, [3] = 115 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 16, [1] = 110, [2] = 107, [3] = 13 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 114, [2] = 113, [3] = 10 }, [5] = { [0] = 25, [1] = 116, [2] = 114, [3] = 17 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 24, [2] = 110, [3] = 106 }, [1] = { [0] = 20, [1] = 17, [2] = 122, [3] = 116 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 14, [1] = 17, [2] = 110, [3] = 108 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 17, [1] = 111, [2] = 108, [3] = 14 }, [3] = { [0] = 21, [1] = 117, [2] = 114, [3] = 13 }, [4] = { [0] = 22, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 26, [1] = 117, [2] = 115, [3] = 18 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 21, [1] = 116, [2] = 117, [3] = 15 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 25, [2] = 111, [3] = 107 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 22, [1] = 118, [2] = 115, [3] = 14 }, [4] = { [0] = 23, [1] = 119, [2] = 118, [3] = 15 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 14, [1] = 112, [2] = 107, [3] = 9 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 19, [1] = 113, [2] = 110, [3] = 16 }, [3] = { [0] = 23, [1] = 119, [2] = 116, [3] = 15 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 23, [1] = 118, [2] = 119, [3] = 17 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 14, [1] = 101, [2] = 97, [3] = 10 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 25, [1] = 121, [2] = 120, [3] = 17 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 24, [1] = 119, [2] = 120, [3] = 18 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[5]][R[4]], ({ [0] = { [0] = 16, [1] = 114, [2] = 109, [3] = 11 }, [1] = { [0] = 15, [1] = 102, [2] = 98, [3] = 11 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 26, [1] = 122, [2] = 121, [3] = 18 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[5]][R[4]], ({ [0] = { [0] = 17, [1] = 115, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 103, [2] = 99, [3] = 12 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[5]][R[4]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 23, [1] = 19, [2] = 113, [3] = 100 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[5]][R[4]], ({ [0] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [1] = { [0] = 21, [1] = 108, [2] = 104, [3] = 17 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[5]][R[4]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[5]][R[4]], ({ [0] = { [0] = 24, [1] = 122, [2] = 117, [3] = 19 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 30, [2] = 116, [3] = 112 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 25, [1] = 21, [2] = 115, [3] = 102 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 31, [2] = 117, [3] = 113 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 25, [1] = 112, [2] = 108, [3] = 21 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 24, [1] = 23, [2] = 114, [3] = 114 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 26, [1] = 113, [2] = 109, [3] = 22 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 13, [1] = 109, [2] = 108, [3] = 5 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 31, [1] = 118, [2] = 114, [3] = 27 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 34, [2] = 120, [3] = 116 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 25, [1] = 21, [2] = 115, [3] = 107 }, [3] = { [0] = 29, [1] = 25, [2] = 119, [3] = 106 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 32, [1] = 119, [2] = 115, [3] = 28 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 15, [1] = 110, [2] = 111, [3] = 9 } })[R[5]][R[4]] })
    if R[5] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
        for i = 1, game.initial_units() do
          R[6] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [2] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 } })[R[6]][R[4]], ({ [0] = { [0] = 13, [1] = 111, [2] = 106, [3] = 8 }, [1] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [2] = { [0] = 25, [1] = 123, [2] = 118, [3] = 20 } })[R[6]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[4]] })
        for i = 1, game.initial_units() do
          R[7] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 11, [2] = 116, [3] = 110 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 } })[R[7]][R[4]], ({ [0] = { [0] = 28, [1] = 115, [2] = 111, [3] = 24 }, [1] = { [0] = 30, [1] = 117, [2] = 113, [3] = 26 }, [2] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 } })[R[7]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[8] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 12, [2] = 106, [3] = 98 }, [1] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [2] = { [0] = 34, [1] = 30, [2] = 124, [3] = 116 } })[R[8]][R[4]], ({ [0] = { [0] = 12, [1] = 106, [2] = 103, [3] = 9 }, [1] = { [0] = 28, [1] = 122, [2] = 119, [3] = 25 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 } })[R[8]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[4]] })
        for i = 1, game.initial_units() do
          R[9] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [1] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 92 } })[R[9]][R[4]], ({ [0] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [1] = { [0] = 27, [1] = 123, [2] = 120, [3] = 19 }, [2] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 } })[R[9]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[4]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        for i = 1, game.initial_units() do
          R[10] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [1] = { [0] = 20, [1] = 14, [2] = 108, [3] = 96 }, [2] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 } })[R[10]][R[4]], ({ [0] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [1] = { [0] = 19, [1] = 115, [2] = 114, [3] = 11 }, [2] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 } })[R[10]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[4]] })
        for i = 1, game.initial_units() do
          R[11] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [1] = { [0] = 4, [1] = 3, [2] = 94, [3] = 94 }, [2] = { [0] = 26, [1] = 25, [2] = 116, [3] = 116 } })[R[11]][R[4]], ({ [0] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 }, [1] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [2] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 } })[R[11]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        for i = 1, game.initial_units() do
          R[12] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 6, [1] = 9, [2] = 102, [3] = 100 }, [1] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [2] = { [0] = 32, [1] = 35, [2] = 128, [3] = 126 } })[R[12]][R[4]], ({ [0] = { [0] = 13, [1] = 108, [2] = 111, [3] = 8 }, [1] = { [0] = 11, [1] = 106, [2] = 109, [3] = 6 }, [2] = { [0] = 26, [1] = 121, [2] = 124, [3] = 21 } })[R[12]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
        for i = 1, game.initial_units() do
          R[13] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 }, [1] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 }, [2] = { [0] = 7, [1] = 5, [2] = 101, [3] = 106 } })[R[13]][R[4]], ({ [0] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [1] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [2] = { [0] = 30, [1] = 125, [2] = 126, [3] = 24 } })[R[13]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[5]", R[5])
    end
    R[14] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 114, [1] = 108, [2] = 12, [3] = 9 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 116, [1] = 103, [2] = 26, [3] = 22 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 105, [1] = 105, [2] = 15, [3] = 14 }, [6] = { [0] = 107, [1] = 105, [2] = 11, [3] = 14 }, [7] = { [0] = 109, [1] = 114, [2] = 15, [3] = 13 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 107, [1] = 20, [2] = 24, [3] = 111 }, [2] = { [0] = 104, [1] = 10, [2] = 13, [3] = 107 }, [3] = { [0] = 117, [1] = 16, [2] = 24, [3] = 120 }, [4] = { [0] = 115, [1] = 12, [2] = 20, [3] = 116 }, [5] = { [0] = 111, [1] = 14, [2] = 22, [3] = 113 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 116, [1] = 14, [2] = 20, [3] = 115 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 114, [1] = 108, [2] = 12, [3] = 9 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 116, [1] = 103, [2] = 26, [3] = 22 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 105, [1] = 105, [2] = 15, [3] = 14 }, [6] = { [0] = 107, [1] = 105, [2] = 11, [3] = 14 }, [7] = { [0] = 109, [1] = 114, [2] = 15, [3] = 13 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 107, [1] = 20, [2] = 24, [3] = 111 }, [2] = { [0] = 104, [1] = 10, [2] = 13, [3] = 107 }, [3] = { [0] = 117, [1] = 16, [2] = 24, [3] = 120 }, [4] = { [0] = 115, [1] = 12, [2] = 20, [3] = 116 }, [5] = { [0] = 111, [1] = 14, [2] = 22, [3] = 113 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 116, [1] = 14, [2] = 20, [3] = 115 } })[R[14]][R[4]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 124, [1] = 118, [2] = 22, [3] = 19 }, [2] = { [0] = 105, [1] = 97, [2] = 15, [3] = 11 }, [3] = { [0] = 124, [1] = 111, [2] = 34, [3] = 30 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 105, [1] = 105, [2] = 15, [3] = 14 }, [6] = { [0] = 116, [1] = 114, [2] = 20, [3] = 23 }, [7] = { [0] = 102, [1] = 107, [2] = 8, [3] = 6 } })[R[14]][R[4]], ({ [0] = { [0] = 105, [1] = 7, [2] = 12, [3] = 110 }, [1] = { [0] = 94, [1] = 7, [2] = 11, [3] = 98 }, [2] = { [0] = 109, [1] = 15, [2] = 18, [3] = 112 }, [3] = { [0] = 121, [1] = 20, [2] = 28, [3] = 124 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 117, [1] = 20, [2] = 28, [3] = 119 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 122, [1] = 20, [2] = 26, [3] = 121 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    if R[14] == 0 or R[14] == 1 or R[14] == 2 or R[14] == 5 or R[14] == 6 or R[14] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 121, [2] = 36, [3] = 39 }, [1] = { [0] = 125, [1] = 119, [2] = 23, [3] = 20 }, [2] = { [0] = 108, [1] = 100, [2] = 18, [3] = 14 }, [5] = { [0] = 115, [1] = 115, [2] = 25, [3] = 24 }, [6] = { [0] = 117, [1] = 115, [2] = 21, [3] = 24 }, [7] = { [0] = 102, [1] = 107, [2] = 8, [3] = 6 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 101, [1] = 14, [2] = 18, [3] = 105 }, [2] = { [0] = 115, [1] = 21, [2] = 24, [3] = 118 }, [5] = { [0] = 116, [1] = 19, [2] = 27, [3] = 118 }, [6] = { [0] = 121, [1] = 18, [2] = 23, [3] = 118 }, [7] = { [0] = 109, [1] = 7, [2] = 13, [3] = 108 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 0 then
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
      elseif R[14] == 1 then
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
      elseif R[14] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 117, [1] = 109, [2] = 27, [3] = 23 })[R[4]], ({ [0] = 109, [1] = 15, [2] = 18, [3] = 112 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 117, [1] = 109, [2] = 27, [3] = 23 })[R[4]], ({ [0] = 109, [1] = 15, [2] = 18, [3] = 112 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 117, [1] = 109, [2] = 27, [3] = 23 })[R[4]], ({ [0] = 109, [1] = 15, [2] = 18, [3] = 112 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[14] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 115, [1] = 115, [2] = 25, [3] = 24 })[R[4]], ({ [0] = 109, [1] = 12, [2] = 20, [3] = 111 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 115, [1] = 115, [2] = 25, [3] = 24 })[R[4]], ({ [0] = 109, [1] = 12, [2] = 20, [3] = 111 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 115, [1] = 115, [2] = 25, [3] = 24 })[R[4]], ({ [0] = 109, [1] = 12, [2] = 20, [3] = 111 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[14] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 125, [1] = 123, [2] = 29, [3] = 32 })[R[4]], ({ [0] = 121, [1] = 18, [2] = 23, [3] = 118 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 125, [1] = 123, [2] = 29, [3] = 32 })[R[4]], ({ [0] = 121, [1] = 18, [2] = 23, [3] = 118 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 125, [1] = 123, [2] = 29, [3] = 32 })[R[4]], ({ [0] = 121, [1] = 18, [2] = 23, [3] = 118 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[14] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 102, [1] = 98, [2] = 13, [3] = 16 }, [1] = { [0] = 125, [1] = 119, [2] = 23, [3] = 20 }, [2] = { [0] = 117, [1] = 109, [2] = 27, [3] = 23 }, [5] = { [0] = 105, [1] = 105, [2] = 15, [3] = 14 }, [6] = { [0] = 108, [1] = 106, [2] = 12, [3] = 15 }, [7] = { [0] = 118, [1] = 123, [2] = 24, [3] = 22 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 111, [1] = 24, [2] = 28, [3] = 115 }, [2] = { [0] = 115, [1] = 21, [2] = 24, [3] = 118 }, [5] = { [0] = 104, [1] = 7, [2] = 15, [3] = 106 }, [6] = { [0] = 121, [1] = 18, [2] = 23, [3] = 118 }, [7] = { [0] = 121, [1] = 19, [2] = 25, [3] = 120 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 0 or R[14] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 124, [1] = 118, [2] = 22, [3] = 19 } })[R[14]][R[4]], ({ [0] = { [0] = 119, [1] = 21, [2] = 26, [3] = 124 }, [1] = { [0] = 119, [1] = 32, [2] = 36, [3] = 123 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 2 or R[14] == 5 or R[14] == 6 or R[14] == 7 then
      else
        unseen("R[14]", R[14])
      end
    elseif R[14] == 3 or R[14] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 108, [1] = 95, [2] = 18, [3] = 14 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 } })[R[14]][R[4]], ({ [3] = { [0] = 121, [1] = 20, [2] = 28, [3] = 124 }, [4] = { [0] = 107, [1] = 4, [2] = 12, [3] = 108 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 124, [1] = 112, [2] = 36, [3] = 30 })[R[4]], ({ [0] = 109, [1] = 6, [2] = 14, [3] = 110 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 3 then
      else
        unseen("R[14]", R[14])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [3] = { [0] = 111, [1] = 98, [2] = 21, [3] = 17 }, [4] = { [0] = 124, [1] = 112, [2] = 36, [3] = 30 } })[R[14]][R[4]], ({ [3] = { [0] = 110, [1] = 9, [2] = 17, [3] = 113 }, [4] = { [0] = 119, [1] = 16, [2] = 24, [3] = 120 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 3 then
        if LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 122, [1] = 109, [2] = 32, [3] = 28 })[R[4]], ({ [0] = 110, [1] = 9, [2] = 17, [3] = 113 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 122, [1] = 109, [2] = 32, [3] = 28 })[R[4]], ({ [0] = 110, [1] = 9, [2] = 17, [3] = 113 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 122, [1] = 109, [2] = 32, [3] = 28 })[R[4]], ({ [0] = 110, [1] = 9, [2] = 17, [3] = 113 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[14] == 4 then
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
    else
      unseen("R[14]", R[14])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 102, [1] = 98, [2] = 13, [3] = 16 }, [1] = { [0] = 115, [1] = 109, [2] = 13, [3] = 10 }, [2] = { [0] = 125, [1] = 117, [2] = 35, [3] = 31 }, [3] = { [0] = 117, [1] = 104, [2] = 27, [3] = 23 }, [4] = { [0] = 105, [1] = 93, [2] = 17, [3] = 11 }, [5] = { [0] = 95, [1] = 95, [2] = 5, [3] = 4 }, [6] = { [0] = 100, [1] = 98, [2] = 4, [3] = 7 }, [7] = { [0] = 110, [1] = 115, [2] = 16, [3] = 14 } })[R[14]][R[4]], ({ [0] = { [0] = 121, [1] = 23, [2] = 28, [3] = 126 }, [1] = { [0] = 116, [1] = 29, [2] = 33, [3] = 120 }, [2] = { [0] = 109, [1] = 15, [2] = 18, [3] = 112 }, [3] = { [0] = 104, [1] = 3, [2] = 11, [3] = 107 }, [4] = { [0] = 111, [1] = 8, [2] = 16, [3] = 112 }, [5] = { [0] = 111, [1] = 14, [2] = 22, [3] = 113 }, [6] = { [0] = 121, [1] = 18, [2] = 23, [3] = 118 }, [7] = { [0] = 125, [1] = 23, [2] = 29, [3] = 124 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 109, [1] = 105, [2] = 20, [3] = 23 }, [1] = { [0] = 114, [1] = 108, [2] = 12, [3] = 9 }, [2] = { [0] = 121, [1] = 113, [2] = 31, [3] = 27 }, [3] = { [0] = 106, [1] = 93, [2] = 16, [3] = 12 }, [4] = { [0] = 123, [1] = 111, [2] = 35, [3] = 29 }, [5] = { [0] = 113, [1] = 113, [2] = 23, [3] = 22 }, [6] = { [0] = 107, [1] = 105, [2] = 11, [3] = 14 }, [7] = { [0] = 120, [1] = 125, [2] = 26, [3] = 24 } })[R[14]][R[4]], ({ [0] = { [0] = 108, [1] = 10, [2] = 15, [3] = 113 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 113, [1] = 19, [2] = 22, [3] = 116 }, [3] = { [0] = 111, [1] = 10, [2] = 18, [3] = 114 }, [4] = { [0] = 115, [1] = 12, [2] = 20, [3] = 116 }, [5] = { [0] = 102, [1] = 5, [2] = 13, [3] = 104 }, [6] = { [0] = 126, [1] = 23, [2] = 28, [3] = 123 }, [7] = { [0] = 116, [1] = 14, [2] = 20, [3] = 115 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 107, [1] = 103, [2] = 18, [3] = 21 }, [1] = { [0] = 114, [1] = 108, [2] = 12, [3] = 9 }, [2] = { [0] = 121, [1] = 113, [2] = 31, [3] = 27 }, [3] = { [0] = 109, [1] = 96, [2] = 19, [3] = 15 }, [4] = { [0] = 125, [1] = 113, [2] = 37, [3] = 31 }, [5] = { [0] = 113, [1] = 113, [2] = 23, [3] = 22 }, [6] = { [0] = 105, [1] = 103, [2] = 9, [3] = 12 }, [7] = { [0] = 120, [1] = 125, [2] = 26, [3] = 24 } })[R[14]][R[4]], ({ [0] = { [0] = 108, [1] = 10, [2] = 15, [3] = 113 }, [1] = { [0] = 100, [1] = 13, [2] = 17, [3] = 104 }, [2] = { [0] = 111, [1] = 17, [2] = 20, [3] = 114 }, [3] = { [0] = 107, [1] = 6, [2] = 14, [3] = 110 }, [4] = { [0] = 115, [1] = 12, [2] = 20, [3] = 116 }, [5] = { [0] = 104, [1] = 7, [2] = 15, [3] = 106 }, [6] = { [0] = 126, [1] = 23, [2] = 28, [3] = 123 }, [7] = { [0] = 118, [1] = 16, [2] = 22, [3] = 117 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 118, [1] = 114, [2] = 29, [3] = 32 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 103, [1] = 95, [2] = 13, [3] = 9 }, [3] = { [0] = 126, [1] = 113, [2] = 36, [3] = 32 }, [4] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [5] = { [0] = 101, [1] = 101, [2] = 11, [3] = 10 }, [6] = { [0] = 120, [1] = 118, [2] = 24, [3] = 27 }, [7] = { [0] = 119, [1] = 124, [2] = 25, [3] = 23 } })[R[14]][R[4]], ({ [0] = { [0] = 114, [1] = 16, [2] = 21, [3] = 119 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 114, [1] = 20, [2] = 23, [3] = 117 }, [3] = { [0] = 111, [1] = 10, [2] = 18, [3] = 114 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 112, [1] = 15, [2] = 23, [3] = 114 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 110, [1] = 8, [2] = 14, [3] = 109 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 118, [1] = 114, [2] = 29, [3] = 32 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 103, [1] = 95, [2] = 13, [3] = 9 }, [3] = { [0] = 124, [1] = 111, [2] = 34, [3] = 30 }, [4] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [5] = { [0] = 101, [1] = 101, [2] = 11, [3] = 10 }, [6] = { [0] = 120, [1] = 118, [2] = 24, [3] = 27 }, [7] = { [0] = 119, [1] = 124, [2] = 25, [3] = 23 } })[R[14]][R[4]], ({ [0] = { [0] = 114, [1] = 16, [2] = 21, [3] = 119 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 114, [1] = 20, [2] = 23, [3] = 117 }, [3] = { [0] = 107, [1] = 6, [2] = 14, [3] = 110 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 112, [1] = 15, [2] = 23, [3] = 114 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 110, [1] = 8, [2] = 14, [3] = 109 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 107, [1] = 103, [2] = 18, [3] = 21 }, [1] = { [0] = 114, [1] = 108, [2] = 12, [3] = 9 }, [2] = { [0] = 121, [1] = 113, [2] = 31, [3] = 27 }, [3] = { [0] = 112, [1] = 99, [2] = 22, [3] = 18 }, [4] = { [0] = 125, [1] = 113, [2] = 37, [3] = 31 }, [5] = { [0] = 113, [1] = 113, [2] = 23, [3] = 22 }, [6] = { [0] = 105, [1] = 103, [2] = 9, [3] = 12 }, [7] = { [0] = 120, [1] = 125, [2] = 26, [3] = 24 } })[R[14]][R[4]], ({ [0] = { [0] = 108, [1] = 10, [2] = 15, [3] = 113 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 111, [1] = 17, [2] = 20, [3] = 114 }, [3] = { [0] = 122, [1] = 21, [2] = 29, [3] = 125 }, [4] = { [0] = 115, [1] = 12, [2] = 20, [3] = 116 }, [5] = { [0] = 104, [1] = 7, [2] = 15, [3] = 106 }, [6] = { [0] = 126, [1] = 23, [2] = 28, [3] = 123 }, [7] = { [0] = 118, [1] = 16, [2] = 22, [3] = 117 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 107, [1] = 103, [2] = 18, [3] = 21 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 121, [1] = 113, [2] = 31, [3] = 27 }, [3] = { [0] = 112, [1] = 99, [2] = 22, [3] = 18 }, [4] = { [0] = 125, [1] = 113, [2] = 37, [3] = 31 }, [5] = { [0] = 113, [1] = 113, [2] = 23, [3] = 22 }, [6] = { [0] = 105, [1] = 103, [2] = 9, [3] = 12 }, [7] = { [0] = 120, [1] = 125, [2] = 26, [3] = 24 } })[R[14]][R[4]], ({ [0] = { [0] = 108, [1] = 10, [2] = 15, [3] = 113 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 111, [1] = 17, [2] = 20, [3] = 114 }, [3] = { [0] = 122, [1] = 21, [2] = 29, [3] = 125 }, [4] = { [0] = 115, [1] = 12, [2] = 20, [3] = 116 }, [5] = { [0] = 104, [1] = 7, [2] = 15, [3] = 106 }, [6] = { [0] = 126, [1] = 23, [2] = 28, [3] = 123 }, [7] = { [0] = 118, [1] = 16, [2] = 22, [3] = 117 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 118, [1] = 114, [2] = 29, [3] = 32 }, [1] = { [0] = 114, [1] = 108, [2] = 12, [3] = 9 }, [2] = { [0] = 103, [1] = 95, [2] = 13, [3] = 9 }, [3] = { [0] = 106, [1] = 93, [2] = 16, [3] = 12 }, [4] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [5] = { [0] = 101, [1] = 101, [2] = 11, [3] = 10 }, [6] = { [0] = 120, [1] = 118, [2] = 24, [3] = 27 }, [7] = { [0] = 119, [1] = 124, [2] = 25, [3] = 23 } })[R[14]][R[4]], ({ [0] = { [0] = 114, [1] = 16, [2] = 21, [3] = 119 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 114, [1] = 20, [2] = 23, [3] = 117 }, [3] = { [0] = 111, [1] = 10, [2] = 18, [3] = 114 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 112, [1] = 15, [2] = 23, [3] = 114 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 110, [1] = 8, [2] = 14, [3] = 109 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 104, [1] = 100, [2] = 15, [3] = 18 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 121, [1] = 113, [2] = 31, [3] = 27 }, [3] = { [0] = 106, [1] = 93, [2] = 16, [3] = 12 }, [4] = { [0] = 118, [1] = 106, [2] = 30, [3] = 24 }, [5] = { [0] = 100, [1] = 100, [2] = 10, [3] = 9 }, [6] = { [0] = 112, [1] = 110, [2] = 16, [3] = 19 }, [7] = { [0] = 104, [1] = 109, [2] = 10, [3] = 8 } })[R[14]][R[4]], ({ [0] = { [0] = 108, [1] = 10, [2] = 15, [3] = 113 }, [1] = { [0] = 96, [1] = 9, [2] = 13, [3] = 100 }, [2] = { [0] = 117, [1] = 23, [2] = 26, [3] = 120 }, [3] = { [0] = 111, [1] = 10, [2] = 18, [3] = 114 }, [4] = { [0] = 119, [1] = 16, [2] = 24, [3] = 120 }, [5] = { [0] = 101, [1] = 4, [2] = 12, [3] = 103 }, [6] = { [0] = 123, [1] = 20, [2] = 25, [3] = 120 }, [7] = { [0] = 116, [1] = 14, [2] = 20, [3] = 115 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 104, [1] = 100, [2] = 15, [3] = 18 }, [1] = { [0] = 120, [1] = 114, [2] = 18, [3] = 15 }, [2] = { [0] = 117, [1] = 109, [2] = 27, [3] = 23 }, [3] = { [0] = 112, [1] = 99, [2] = 22, [3] = 18 }, [4] = { [0] = 120, [1] = 108, [2] = 32, [3] = 26 }, [5] = { [0] = 109, [1] = 109, [2] = 19, [3] = 18 }, [6] = { [0] = 121, [1] = 119, [2] = 25, [3] = 28 }, [7] = { [0] = 99, [1] = 104, [2] = 5, [3] = 3 } })[R[14]][R[4]], ({ [0] = { [0] = 105, [1] = 7, [2] = 12, [3] = 110 }, [1] = { [0] = 93, [1] = 6, [2] = 10, [3] = 97 }, [2] = { [0] = 118, [1] = 24, [2] = 27, [3] = 121 }, [3] = { [0] = 122, [1] = 21, [2] = 29, [3] = 125 }, [4] = { [0] = 110, [1] = 7, [2] = 15, [3] = 111 }, [5] = { [0] = 109, [1] = 12, [2] = 20, [3] = 111 }, [6] = { [0] = 120, [1] = 17, [2] = 22, [3] = 117 }, [7] = { [0] = 113, [1] = 11, [2] = 17, [3] = 112 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 118, [1] = 114, [2] = 29, [3] = 32 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 103, [1] = 95, [2] = 13, [3] = 9 }, [3] = { [0] = 126, [1] = 113, [2] = 36, [3] = 32 }, [4] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [5] = { [0] = 101, [1] = 101, [2] = 11, [3] = 10 }, [6] = { [0] = 120, [1] = 118, [2] = 24, [3] = 27 }, [7] = { [0] = 119, [1] = 124, [2] = 25, [3] = 23 } })[R[14]][R[4]], ({ [0] = { [0] = 114, [1] = 16, [2] = 21, [3] = 119 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 114, [1] = 20, [2] = 23, [3] = 117 }, [3] = { [0] = 111, [1] = 10, [2] = 18, [3] = 114 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 112, [1] = 15, [2] = 23, [3] = 114 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 110, [1] = 8, [2] = 14, [3] = 109 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 118, [1] = 114, [2] = 29, [3] = 32 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 103, [1] = 95, [2] = 13, [3] = 9 }, [3] = { [0] = 124, [1] = 111, [2] = 34, [3] = 30 }, [4] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [5] = { [0] = 101, [1] = 101, [2] = 11, [3] = 10 }, [6] = { [0] = 120, [1] = 118, [2] = 24, [3] = 27 }, [7] = { [0] = 119, [1] = 124, [2] = 25, [3] = 23 } })[R[14]][R[4]], ({ [0] = { [0] = 114, [1] = 16, [2] = 21, [3] = 119 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 114, [1] = 20, [2] = 23, [3] = 117 }, [3] = { [0] = 107, [1] = 6, [2] = 14, [3] = 110 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 112, [1] = 15, [2] = 23, [3] = 114 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 110, [1] = 8, [2] = 14, [3] = 109 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 104, [1] = 100, [2] = 15, [3] = 18 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 121, [1] = 113, [2] = 31, [3] = 27 }, [3] = { [0] = 112, [1] = 99, [2] = 22, [3] = 18 }, [4] = { [0] = 118, [1] = 106, [2] = 30, [3] = 24 }, [5] = { [0] = 100, [1] = 100, [2] = 10, [3] = 9 }, [6] = { [0] = 112, [1] = 110, [2] = 16, [3] = 19 }, [7] = { [0] = 104, [1] = 109, [2] = 10, [3] = 8 } })[R[14]][R[4]], ({ [0] = { [0] = 108, [1] = 10, [2] = 15, [3] = 113 }, [1] = { [0] = 96, [1] = 9, [2] = 13, [3] = 100 }, [2] = { [0] = 117, [1] = 23, [2] = 26, [3] = 120 }, [3] = { [0] = 122, [1] = 21, [2] = 29, [3] = 125 }, [4] = { [0] = 119, [1] = 16, [2] = 24, [3] = 120 }, [5] = { [0] = 101, [1] = 4, [2] = 12, [3] = 103 }, [6] = { [0] = 123, [1] = 20, [2] = 25, [3] = 120 }, [7] = { [0] = 116, [1] = 14, [2] = 20, [3] = 115 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 104, [1] = 100, [2] = 15, [3] = 18 }, [1] = { [0] = 120, [1] = 114, [2] = 18, [3] = 15 }, [2] = { [0] = 117, [1] = 109, [2] = 27, [3] = 23 }, [3] = { [0] = 112, [1] = 99, [2] = 22, [3] = 18 }, [4] = { [0] = 120, [1] = 108, [2] = 32, [3] = 26 }, [5] = { [0] = 109, [1] = 109, [2] = 19, [3] = 18 }, [6] = { [0] = 121, [1] = 119, [2] = 25, [3] = 28 }, [7] = { [0] = 99, [1] = 104, [2] = 5, [3] = 3 } })[R[14]][R[4]], ({ [0] = { [0] = 105, [1] = 7, [2] = 12, [3] = 110 }, [1] = { [0] = 93, [1] = 6, [2] = 10, [3] = 97 }, [2] = { [0] = 118, [1] = 24, [2] = 27, [3] = 121 }, [3] = { [0] = 122, [1] = 21, [2] = 29, [3] = 125 }, [4] = { [0] = 110, [1] = 7, [2] = 15, [3] = 111 }, [5] = { [0] = 109, [1] = 12, [2] = 20, [3] = 111 }, [6] = { [0] = 120, [1] = 17, [2] = 22, [3] = 117 }, [7] = { [0] = 113, [1] = 11, [2] = 17, [3] = 112 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 118, [1] = 114, [2] = 29, [3] = 32 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 103, [1] = 95, [2] = 13, [3] = 9 }, [3] = { [0] = 126, [1] = 113, [2] = 36, [3] = 32 }, [4] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [5] = { [0] = 101, [1] = 101, [2] = 11, [3] = 10 }, [6] = { [0] = 120, [1] = 118, [2] = 24, [3] = 27 }, [7] = { [0] = 119, [1] = 124, [2] = 25, [3] = 23 } })[R[14]][R[4]], ({ [0] = { [0] = 114, [1] = 16, [2] = 21, [3] = 119 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 114, [1] = 20, [2] = 23, [3] = 117 }, [3] = { [0] = 111, [1] = 10, [2] = 18, [3] = 114 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 112, [1] = 15, [2] = 23, [3] = 114 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 110, [1] = 8, [2] = 14, [3] = 109 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 118, [1] = 114, [2] = 29, [3] = 32 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 103, [1] = 95, [2] = 13, [3] = 9 }, [3] = { [0] = 124, [1] = 111, [2] = 34, [3] = 30 }, [4] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [5] = { [0] = 101, [1] = 101, [2] = 11, [3] = 10 }, [6] = { [0] = 120, [1] = 118, [2] = 24, [3] = 27 }, [7] = { [0] = 119, [1] = 124, [2] = 25, [3] = 23 } })[R[14]][R[4]], ({ [0] = { [0] = 114, [1] = 16, [2] = 21, [3] = 119 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 114, [1] = 20, [2] = 23, [3] = 117 }, [3] = { [0] = 107, [1] = 6, [2] = 14, [3] = 110 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 112, [1] = 15, [2] = 23, [3] = 114 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 110, [1] = 8, [2] = 14, [3] = 109 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 107, [1] = 103, [2] = 18, [3] = 21 }, [1] = { [0] = 114, [1] = 108, [2] = 12, [3] = 9 }, [2] = { [0] = 121, [1] = 113, [2] = 31, [3] = 27 }, [3] = { [0] = 112, [1] = 99, [2] = 22, [3] = 18 }, [4] = { [0] = 125, [1] = 113, [2] = 37, [3] = 31 }, [5] = { [0] = 113, [1] = 113, [2] = 23, [3] = 22 }, [6] = { [0] = 105, [1] = 103, [2] = 9, [3] = 12 }, [7] = { [0] = 120, [1] = 125, [2] = 26, [3] = 24 } })[R[14]][R[4]], ({ [0] = { [0] = 108, [1] = 10, [2] = 15, [3] = 113 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 111, [1] = 17, [2] = 20, [3] = 114 }, [3] = { [0] = 122, [1] = 21, [2] = 29, [3] = 125 }, [4] = { [0] = 115, [1] = 12, [2] = 20, [3] = 116 }, [5] = { [0] = 104, [1] = 7, [2] = 15, [3] = 106 }, [6] = { [0] = 126, [1] = 23, [2] = 28, [3] = 123 }, [7] = { [0] = 118, [1] = 16, [2] = 22, [3] = 117 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 114, [2] = 29, [3] = 32 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 103, [1] = 95, [2] = 13, [3] = 9 }, [3] = { [0] = 112, [1] = 99, [2] = 22, [3] = 18 }, [4] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [5] = { [0] = 101, [1] = 101, [2] = 11, [3] = 10 }, [6] = { [0] = 120, [1] = 118, [2] = 24, [3] = 27 }, [7] = { [0] = 119, [1] = 124, [2] = 25, [3] = 23 } })[R[14]][R[4]], ({ [0] = { [0] = 114, [1] = 16, [2] = 21, [3] = 119 }, [1] = { [0] = 102, [1] = 15, [2] = 19, [3] = 106 }, [2] = { [0] = 114, [1] = 20, [2] = 23, [3] = 117 }, [3] = { [0] = 122, [1] = 21, [2] = 29, [3] = 125 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 112, [1] = 15, [2] = 23, [3] = 114 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 110, [1] = 8, [2] = 14, [3] = 109 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 104, [1] = 100, [2] = 15, [3] = 18 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 121, [1] = 113, [2] = 31, [3] = 27 }, [3] = { [0] = 106, [1] = 93, [2] = 16, [3] = 12 }, [4] = { [0] = 118, [1] = 106, [2] = 30, [3] = 24 }, [5] = { [0] = 100, [1] = 100, [2] = 10, [3] = 9 }, [6] = { [0] = 112, [1] = 110, [2] = 16, [3] = 19 }, [7] = { [0] = 104, [1] = 109, [2] = 10, [3] = 8 } })[R[14]][R[4]], ({ [0] = { [0] = 108, [1] = 10, [2] = 15, [3] = 113 }, [1] = { [0] = 96, [1] = 9, [2] = 13, [3] = 100 }, [2] = { [0] = 117, [1] = 23, [2] = 26, [3] = 120 }, [3] = { [0] = 111, [1] = 10, [2] = 18, [3] = 114 }, [4] = { [0] = 119, [1] = 16, [2] = 24, [3] = 120 }, [5] = { [0] = 101, [1] = 4, [2] = 12, [3] = 103 }, [6] = { [0] = 123, [1] = 20, [2] = 25, [3] = 120 }, [7] = { [0] = 116, [1] = 14, [2] = 20, [3] = 115 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 104, [1] = 100, [2] = 15, [3] = 18 }, [1] = { [0] = 120, [1] = 114, [2] = 18, [3] = 15 }, [2] = { [0] = 117, [1] = 109, [2] = 27, [3] = 23 }, [3] = { [0] = 112, [1] = 99, [2] = 22, [3] = 18 }, [4] = { [0] = 120, [1] = 108, [2] = 32, [3] = 26 }, [5] = { [0] = 109, [1] = 109, [2] = 19, [3] = 18 }, [6] = { [0] = 121, [1] = 119, [2] = 25, [3] = 28 }, [7] = { [0] = 99, [1] = 104, [2] = 5, [3] = 3 } })[R[14]][R[4]], ({ [0] = { [0] = 105, [1] = 7, [2] = 12, [3] = 110 }, [1] = { [0] = 93, [1] = 6, [2] = 10, [3] = 97 }, [2] = { [0] = 118, [1] = 24, [2] = 27, [3] = 121 }, [3] = { [0] = 122, [1] = 21, [2] = 29, [3] = 125 }, [4] = { [0] = 110, [1] = 7, [2] = 15, [3] = 111 }, [5] = { [0] = 109, [1] = 12, [2] = 20, [3] = 111 }, [6] = { [0] = 120, [1] = 17, [2] = 22, [3] = 117 }, [7] = { [0] = 113, [1] = 11, [2] = 17, [3] = 112 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 121, [2] = 36, [3] = 39 }, [1] = { [0] = 123, [1] = 117, [2] = 21, [3] = 18 }, [2] = { [0] = 113, [1] = 105, [2] = 23, [3] = 19 }, [3] = { [0] = 116, [1] = 103, [2] = 26, [3] = 22 }, [4] = { [0] = 126, [1] = 114, [2] = 38, [3] = 32 }, [5] = { [0] = 101, [1] = 101, [2] = 11, [3] = 10 }, [6] = { [0] = 121, [1] = 119, [2] = 25, [3] = 28 }, [7] = { [0] = 113, [1] = 118, [2] = 19, [3] = 17 } })[R[14]][R[4]], ({ [0] = { [0] = 116, [1] = 18, [2] = 23, [3] = 121 }, [1] = { [0] = 106, [1] = 19, [2] = 23, [3] = 110 }, [2] = { [0] = 111, [1] = 17, [2] = 20, [3] = 114 }, [3] = { [0] = 108, [1] = 7, [2] = 15, [3] = 111 }, [4] = { [0] = 106, [1] = 3, [2] = 11, [3] = 107 }, [5] = { [0] = 118, [1] = 21, [2] = 29, [3] = 120 }, [6] = { [0] = 123, [1] = 20, [2] = 25, [3] = 120 }, [7] = { [0] = 115, [1] = 13, [2] = 19, [3] = 114 } })[R[14]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 105, [1] = 101, [2] = 16, [3] = 19 }, [1] = { [0] = 117, [1] = 111, [2] = 15, [3] = 12 }, [2] = { [0] = 108, [1] = 100, [2] = 18, [3] = 14 }, [3] = { [0] = 108, [1] = 95, [2] = 18, [3] = 14 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 105, [1] = 105, [2] = 15, [3] = 14 }, [6] = { [0] = 107, [1] = 105, [2] = 11, [3] = 14 }, [7] = { [0] = 102, [1] = 107, [2] = 8, [3] = 6 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 107, [1] = 20, [2] = 24, [3] = 111 }, [2] = { [0] = 109, [1] = 15, [2] = 18, [3] = 112 }, [3] = { [0] = 117, [1] = 16, [2] = 24, [3] = 120 }, [4] = { [0] = 109, [1] = 6, [2] = 14, [3] = 110 }, [5] = { [0] = 107, [1] = 10, [2] = 18, [3] = 109 }, [6] = { [0] = 115, [1] = 12, [2] = 17, [3] = 112 }, [7] = { [0] = 112, [1] = 10, [2] = 16, [3] = 111 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 106, [1] = 102, [2] = 17, [3] = 20 }, [1] = { [0] = 118, [1] = 112, [2] = 16, [3] = 13 }, [2] = { [0] = 109, [1] = 101, [2] = 19, [3] = 15 }, [3] = { [0] = 108, [1] = 95, [2] = 18, [3] = 14 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 105, [1] = 105, [2] = 15, [3] = 14 }, [6] = { [0] = 107, [1] = 105, [2] = 11, [3] = 14 }, [7] = { [0] = 102, [1] = 107, [2] = 8, [3] = 6 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 107, [1] = 20, [2] = 24, [3] = 111 }, [2] = { [0] = 109, [1] = 15, [2] = 18, [3] = 112 }, [3] = { [0] = 118, [1] = 17, [2] = 25, [3] = 121 }, [4] = { [0] = 110, [1] = 7, [2] = 15, [3] = 111 }, [5] = { [0] = 108, [1] = 11, [2] = 19, [3] = 110 }, [6] = { [0] = 116, [1] = 13, [2] = 18, [3] = 113 }, [7] = { [0] = 113, [1] = 11, [2] = 17, [3] = 112 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 107, [1] = 103, [2] = 18, [3] = 21 }, [1] = { [0] = 119, [1] = 113, [2] = 17, [3] = 14 }, [2] = { [0] = 110, [1] = 102, [2] = 20, [3] = 16 }, [3] = { [0] = 108, [1] = 95, [2] = 18, [3] = 14 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 105, [1] = 105, [2] = 15, [3] = 14 }, [6] = { [0] = 107, [1] = 105, [2] = 11, [3] = 14 }, [7] = { [0] = 102, [1] = 107, [2] = 8, [3] = 6 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 107, [1] = 20, [2] = 24, [3] = 111 }, [2] = { [0] = 109, [1] = 15, [2] = 18, [3] = 112 }, [3] = { [0] = 119, [1] = 18, [2] = 26, [3] = 122 }, [4] = { [0] = 111, [1] = 8, [2] = 16, [3] = 112 }, [5] = { [0] = 109, [1] = 12, [2] = 20, [3] = 111 }, [6] = { [0] = 117, [1] = 14, [2] = 19, [3] = 114 }, [7] = { [0] = 114, [1] = 12, [2] = 18, [3] = 113 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 108, [1] = 104, [2] = 19, [3] = 22 }, [1] = { [0] = 120, [1] = 114, [2] = 18, [3] = 15 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 109, [1] = 96, [2] = 19, [3] = 15 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 105, [1] = 105, [2] = 15, [3] = 14 }, [6] = { [0] = 107, [1] = 105, [2] = 11, [3] = 14 }, [7] = { [0] = 102, [1] = 107, [2] = 8, [3] = 6 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 107, [1] = 20, [2] = 24, [3] = 111 }, [2] = { [0] = 106, [1] = 12, [2] = 15, [3] = 109 }, [3] = { [0] = 117, [1] = 16, [2] = 24, [3] = 120 }, [4] = { [0] = 112, [1] = 9, [2] = 17, [3] = 113 }, [5] = { [0] = 113, [1] = 16, [2] = 24, [3] = 115 }, [6] = { [0] = 118, [1] = 15, [2] = 20, [3] = 115 }, [7] = { [0] = 115, [1] = 13, [2] = 19, [3] = 114 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 109, [1] = 105, [2] = 20, [3] = 23 }, [1] = { [0] = 121, [1] = 115, [2] = 19, [3] = 16 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 110, [1] = 97, [2] = 20, [3] = 16 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 105, [1] = 105, [2] = 15, [3] = 14 }, [6] = { [0] = 107, [1] = 105, [2] = 11, [3] = 14 }, [7] = { [0] = 102, [1] = 107, [2] = 8, [3] = 6 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 107, [1] = 20, [2] = 24, [3] = 111 }, [2] = { [0] = 107, [1] = 13, [2] = 16, [3] = 110 }, [3] = { [0] = 113, [1] = 12, [2] = 20, [3] = 116 }, [4] = { [0] = 113, [1] = 10, [2] = 18, [3] = 114 }, [5] = { [0] = 114, [1] = 17, [2] = 25, [3] = 116 }, [6] = { [0] = 119, [1] = 16, [2] = 21, [3] = 116 }, [7] = { [0] = 116, [1] = 14, [2] = 20, [3] = 115 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 110, [1] = 106, [2] = 21, [3] = 24 }, [1] = { [0] = 122, [1] = 116, [2] = 20, [3] = 17 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 110, [1] = 97, [2] = 20, [3] = 16 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 105, [1] = 105, [2] = 15, [3] = 14 }, [6] = { [0] = 110, [1] = 108, [2] = 14, [3] = 17 }, [7] = { [0] = 102, [1] = 107, [2] = 8, [3] = 6 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 107, [1] = 20, [2] = 24, [3] = 111 }, [2] = { [0] = 108, [1] = 14, [2] = 17, [3] = 111 }, [3] = { [0] = 114, [1] = 13, [2] = 21, [3] = 117 }, [4] = { [0] = 117, [1] = 14, [2] = 22, [3] = 118 }, [5] = { [0] = 115, [1] = 18, [2] = 26, [3] = 117 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 117, [1] = 15, [2] = 21, [3] = 116 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 111, [1] = 107, [2] = 22, [3] = 25 }, [1] = { [0] = 123, [1] = 117, [2] = 21, [3] = 18 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 110, [1] = 97, [2] = 20, [3] = 16 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 108, [1] = 108, [2] = 18, [3] = 17 }, [6] = { [0] = 111, [1] = 109, [2] = 15, [3] = 18 }, [7] = { [0] = 102, [1] = 107, [2] = 8, [3] = 6 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 107, [1] = 20, [2] = 24, [3] = 111 }, [2] = { [0] = 109, [1] = 15, [2] = 18, [3] = 112 }, [3] = { [0] = 115, [1] = 14, [2] = 22, [3] = 118 }, [4] = { [0] = 118, [1] = 15, [2] = 23, [3] = 119 }, [5] = { [0] = 111, [1] = 14, [2] = 22, [3] = 113 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 118, [1] = 16, [2] = 22, [3] = 117 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 124, [1] = 118, [2] = 22, [3] = 19 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 110, [1] = 97, [2] = 20, [3] = 16 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 108, [1] = 108, [2] = 18, [3] = 17 }, [6] = { [0] = 111, [1] = 109, [2] = 15, [3] = 18 }, [7] = { [0] = 102, [1] = 107, [2] = 8, [3] = 6 } })[R[14]][R[4]], ({ [0] = { [0] = 107, [1] = 9, [2] = 14, [3] = 112 }, [1] = { [0] = 96, [1] = 9, [2] = 13, [3] = 100 }, [2] = { [0] = 110, [1] = 16, [2] = 19, [3] = 113 }, [3] = { [0] = 116, [1] = 15, [2] = 23, [3] = 119 }, [4] = { [0] = 119, [1] = 16, [2] = 24, [3] = 120 }, [5] = { [0] = 117, [1] = 20, [2] = 28, [3] = 119 }, [6] = { [0] = 121, [1] = 18, [2] = 23, [3] = 118 }, [7] = { [0] = 119, [1] = 17, [2] = 23, [3] = 118 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 124, [1] = 118, [2] = 22, [3] = 19 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 110, [1] = 97, [2] = 20, [3] = 16 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 109, [1] = 109, [2] = 19, [3] = 18 }, [6] = { [0] = 112, [1] = 110, [2] = 16, [3] = 19 }, [7] = { [0] = 102, [1] = 107, [2] = 8, [3] = 6 } })[R[14]][R[4]], ({ [0] = { [0] = 108, [1] = 10, [2] = 15, [3] = 113 }, [1] = { [0] = 97, [1] = 10, [2] = 14, [3] = 101 }, [2] = { [0] = 111, [1] = 17, [2] = 20, [3] = 114 }, [3] = { [0] = 117, [1] = 16, [2] = 24, [3] = 120 }, [4] = { [0] = 120, [1] = 17, [2] = 25, [3] = 121 }, [5] = { [0] = 111, [1] = 14, [2] = 22, [3] = 113 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 120, [1] = 18, [2] = 24, [3] = 119 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 124, [1] = 118, [2] = 22, [3] = 19 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 111, [1] = 98, [2] = 21, [3] = 17 }, [4] = { [0] = 113, [1] = 101, [2] = 25, [3] = 19 }, [5] = { [0] = 109, [1] = 109, [2] = 19, [3] = 18 }, [6] = { [0] = 112, [1] = 110, [2] = 16, [3] = 19 }, [7] = { [0] = 105, [1] = 110, [2] = 11, [3] = 9 } })[R[14]][R[4]], ({ [0] = { [0] = 109, [1] = 11, [2] = 16, [3] = 114 }, [1] = { [0] = 98, [1] = 11, [2] = 15, [3] = 102 }, [2] = { [0] = 112, [1] = 18, [2] = 21, [3] = 115 }, [3] = { [0] = 113, [1] = 12, [2] = 20, [3] = 116 }, [4] = { [0] = 121, [1] = 18, [2] = 26, [3] = 122 }, [5] = { [0] = 117, [1] = 20, [2] = 28, [3] = 119 }, [6] = { [0] = 121, [1] = 18, [2] = 23, [3] = 118 }, [7] = { [0] = 109, [1] = 7, [2] = 13, [3] = 108 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 124, [1] = 118, [2] = 22, [3] = 19 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 111, [1] = 98, [2] = 21, [3] = 17 }, [4] = { [0] = 116, [1] = 104, [2] = 28, [3] = 22 }, [5] = { [0] = 110, [1] = 110, [2] = 20, [3] = 19 }, [6] = { [0] = 113, [1] = 111, [2] = 17, [3] = 20 }, [7] = { [0] = 105, [1] = 110, [2] = 11, [3] = 9 } })[R[14]][R[4]], ({ [0] = { [0] = 110, [1] = 12, [2] = 17, [3] = 115 }, [1] = { [0] = 99, [1] = 12, [2] = 16, [3] = 103 }, [2] = { [0] = 113, [1] = 19, [2] = 22, [3] = 116 }, [3] = { [0] = 117, [1] = 16, [2] = 24, [3] = 120 }, [4] = { [0] = 107, [1] = 4, [2] = 12, [3] = 108 }, [5] = { [0] = 111, [1] = 14, [2] = 22, [3] = 113 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 122, [1] = 20, [2] = 26, [3] = 121 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 124, [1] = 118, [2] = 22, [3] = 19 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 112, [1] = 99, [2] = 22, [3] = 18 }, [4] = { [0] = 116, [1] = 104, [2] = 28, [3] = 22 }, [5] = { [0] = 110, [1] = 110, [2] = 20, [3] = 19 }, [6] = { [0] = 113, [1] = 111, [2] = 17, [3] = 20 }, [7] = { [0] = 106, [1] = 111, [2] = 12, [3] = 10 } })[R[14]][R[4]], ({ [0] = { [0] = 114, [1] = 16, [2] = 21, [3] = 119 }, [1] = { [0] = 107, [1] = 20, [2] = 24, [3] = 111 }, [2] = { [0] = 114, [1] = 20, [2] = 23, [3] = 117 }, [3] = { [0] = 117, [1] = 16, [2] = 24, [3] = 120 }, [4] = { [0] = 115, [1] = 12, [2] = 20, [3] = 116 }, [5] = { [0] = 117, [1] = 20, [2] = 28, [3] = 119 }, [6] = { [0] = 121, [1] = 18, [2] = 23, [3] = 118 }, [7] = { [0] = 109, [1] = 7, [2] = 13, [3] = 108 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 125, [1] = 119, [2] = 23, [3] = 20 }, [2] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [3] = { [0] = 113, [1] = 100, [2] = 23, [3] = 19 }, [4] = { [0] = 116, [1] = 104, [2] = 28, [3] = 22 }, [5] = { [0] = 111, [1] = 111, [2] = 21, [3] = 20 }, [6] = { [0] = 114, [1] = 112, [2] = 18, [3] = 21 }, [7] = { [0] = 106, [1] = 111, [2] = 12, [3] = 10 } })[R[14]][R[4]], ({ [0] = { [0] = 115, [1] = 17, [2] = 22, [3] = 120 }, [1] = { [0] = 104, [1] = 17, [2] = 21, [3] = 108 }, [2] = { [0] = 115, [1] = 21, [2] = 24, [3] = 118 }, [3] = { [0] = 117, [1] = 16, [2] = 24, [3] = 120 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 111, [1] = 14, [2] = 22, [3] = 113 }, [6] = { [0] = 113, [1] = 10, [2] = 15, [3] = 110 }, [7] = { [0] = 122, [1] = 20, [2] = 26, [3] = 121 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 125, [1] = 119, [2] = 23, [3] = 20 }, [2] = { [0] = 112, [1] = 104, [2] = 22, [3] = 18 }, [3] = { [0] = 114, [1] = 101, [2] = 24, [3] = 20 }, [4] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [5] = { [0] = 111, [1] = 111, [2] = 21, [3] = 20 }, [6] = { [0] = 114, [1] = 112, [2] = 18, [3] = 21 }, [7] = { [0] = 107, [1] = 112, [2] = 13, [3] = 11 } })[R[14]][R[4]], ({ [0] = { [0] = 116, [1] = 18, [2] = 23, [3] = 121 }, [1] = { [0] = 105, [1] = 18, [2] = 22, [3] = 109 }, [2] = { [0] = 109, [1] = 15, [2] = 18, [3] = 112 }, [3] = { [0] = 110, [1] = 9, [2] = 17, [3] = 113 }, [4] = { [0] = 107, [1] = 4, [2] = 12, [3] = 108 }, [5] = { [0] = 117, [1] = 20, [2] = 28, [3] = 119 }, [6] = { [0] = 121, [1] = 18, [2] = 23, [3] = 118 }, [7] = { [0] = 109, [1] = 7, [2] = 13, [3] = 108 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 109, [2] = 24, [3] = 27 }, [1] = { [0] = 125, [1] = 119, [2] = 23, [3] = 20 }, [2] = { [0] = 112, [1] = 104, [2] = 22, [3] = 18 }, [3] = { [0] = 114, [1] = 101, [2] = 24, [3] = 20 }, [4] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [5] = { [0] = 112, [1] = 112, [2] = 22, [3] = 21 }, [6] = { [0] = 116, [1] = 114, [2] = 20, [3] = 23 }, [7] = { [0] = 107, [1] = 112, [2] = 13, [3] = 11 } })[R[14]][R[4]], ({ [0] = { [0] = 117, [1] = 19, [2] = 24, [3] = 122 }, [1] = { [0] = 106, [1] = 19, [2] = 23, [3] = 110 }, [2] = { [0] = 115, [1] = 21, [2] = 24, [3] = 118 }, [3] = { [0] = 117, [1] = 16, [2] = 24, [3] = 120 }, [4] = { [0] = 115, [1] = 12, [2] = 20, [3] = 116 }, [5] = { [0] = 111, [1] = 14, [2] = 22, [3] = 113 }, [6] = { [0] = 115, [1] = 12, [2] = 17, [3] = 112 }, [7] = { [0] = 122, [1] = 20, [2] = 26, [3] = 121 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 116, [1] = 112, [2] = 27, [3] = 30 }, [1] = { [0] = 125, [1] = 119, [2] = 23, [3] = 20 }, [2] = { [0] = 113, [1] = 105, [2] = 23, [3] = 19 }, [3] = { [0] = 115, [1] = 102, [2] = 25, [3] = 21 }, [4] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [5] = { [0] = 112, [1] = 112, [2] = 22, [3] = 21 }, [6] = { [0] = 116, [1] = 114, [2] = 20, [3] = 23 }, [7] = { [0] = 108, [1] = 113, [2] = 14, [3] = 12 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 107, [1] = 20, [2] = 24, [3] = 111 }, [2] = { [0] = 109, [1] = 15, [2] = 18, [3] = 112 }, [3] = { [0] = 110, [1] = 9, [2] = 17, [3] = 113 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 117, [1] = 20, [2] = 28, [3] = 119 }, [6] = { [0] = 116, [1] = 13, [2] = 18, [3] = 113 }, [7] = { [0] = 109, [1] = 7, [2] = 13, [3] = 108 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 117, [1] = 113, [2] = 28, [3] = 31 }, [1] = { [0] = 125, [1] = 119, [2] = 23, [3] = 20 }, [2] = { [0] = 113, [1] = 105, [2] = 23, [3] = 19 }, [3] = { [0] = 116, [1] = 103, [2] = 26, [3] = 22 }, [4] = { [0] = 118, [1] = 106, [2] = 30, [3] = 24 }, [5] = { [0] = 113, [1] = 113, [2] = 23, [3] = 22 }, [6] = { [0] = 116, [1] = 114, [2] = 20, [3] = 23 }, [7] = { [0] = 108, [1] = 113, [2] = 14, [3] = 12 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 108, [1] = 21, [2] = 25, [3] = 112 }, [2] = { [0] = 115, [1] = 21, [2] = 24, [3] = 118 }, [3] = { [0] = 110, [1] = 9, [2] = 17, [3] = 113 }, [4] = { [0] = 107, [1] = 4, [2] = 12, [3] = 108 }, [5] = { [0] = 111, [1] = 14, [2] = 22, [3] = 113 }, [6] = { [0] = 117, [1] = 14, [2] = 19, [3] = 114 }, [7] = { [0] = 122, [1] = 20, [2] = 26, [3] = 121 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 118, [1] = 114, [2] = 29, [3] = 32 }, [1] = { [0] = 125, [1] = 119, [2] = 23, [3] = 20 }, [2] = { [0] = 114, [1] = 106, [2] = 24, [3] = 20 }, [3] = { [0] = 117, [1] = 104, [2] = 27, [3] = 23 }, [4] = { [0] = 118, [1] = 106, [2] = 30, [3] = 24 }, [5] = { [0] = 114, [1] = 114, [2] = 24, [3] = 23 }, [6] = { [0] = 116, [1] = 114, [2] = 20, [3] = 23 }, [7] = { [0] = 109, [1] = 114, [2] = 15, [3] = 13 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 109, [1] = 22, [2] = 26, [3] = 113 }, [2] = { [0] = 109, [1] = 15, [2] = 18, [3] = 112 }, [3] = { [0] = 110, [1] = 9, [2] = 17, [3] = 113 }, [4] = { [0] = 108, [1] = 5, [2] = 13, [3] = 109 }, [5] = { [0] = 111, [1] = 14, [2] = 22, [3] = 113 }, [6] = { [0] = 118, [1] = 15, [2] = 20, [3] = 115 }, [7] = { [0] = 109, [1] = 7, [2] = 13, [3] = 108 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 119, [1] = 115, [2] = 30, [3] = 33 }, [1] = { [0] = 125, [1] = 119, [2] = 23, [3] = 20 }, [2] = { [0] = 114, [1] = 106, [2] = 24, [3] = 20 }, [3] = { [0] = 118, [1] = 105, [2] = 28, [3] = 24 }, [4] = { [0] = 118, [1] = 106, [2] = 30, [3] = 24 }, [5] = { [0] = 115, [1] = 115, [2] = 25, [3] = 24 }, [6] = { [0] = 116, [1] = 114, [2] = 20, [3] = 23 }, [7] = { [0] = 109, [1] = 114, [2] = 15, [3] = 13 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 114, [1] = 27, [2] = 31, [3] = 118 }, [2] = { [0] = 115, [1] = 21, [2] = 24, [3] = 118 }, [3] = { [0] = 110, [1] = 9, [2] = 17, [3] = 113 }, [4] = { [0] = 115, [1] = 12, [2] = 20, [3] = 116 }, [5] = { [0] = 111, [1] = 14, [2] = 22, [3] = 113 }, [6] = { [0] = 119, [1] = 16, [2] = 21, [3] = 116 }, [7] = { [0] = 110, [1] = 8, [2] = 14, [3] = 109 } })[R[14]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 120, [1] = 116, [2] = 31, [3] = 34 }, [1] = { [0] = 125, [1] = 119, [2] = 23, [3] = 20 }, [2] = { [0] = 115, [1] = 107, [2] = 25, [3] = 21 }, [3] = { [0] = 119, [1] = 106, [2] = 29, [3] = 25 }, [4] = { [0] = 118, [1] = 106, [2] = 30, [3] = 24 }, [5] = { [0] = 115, [1] = 115, [2] = 25, [3] = 24 }, [6] = { [0] = 120, [1] = 118, [2] = 24, [3] = 27 }, [7] = { [0] = 109, [1] = 114, [2] = 15, [3] = 13 } })[R[14]][R[4]], ({ [0] = { [0] = 112, [1] = 14, [2] = 19, [3] = 117 }, [1] = { [0] = 115, [1] = 28, [2] = 32, [3] = 119 }, [2] = { [0] = 109, [1] = 15, [2] = 18, [3] = 112 }, [3] = { [0] = 110, [1] = 9, [2] = 17, [3] = 113 }, [4] = { [0] = 123, [1] = 20, [2] = 28, [3] = 124 }, [5] = { [0] = 112, [1] = 15, [2] = 23, [3] = 114 }, [6] = { [0] = 121, [1] = 18, [2] = 23, [3] = 118 }, [7] = { [0] = 111, [1] = 9, [2] = 15, [3] = 110 } })[R[14]][R[4]] })
    if R[14] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 121, [1] = 117, [2] = 32, [3] = 35 })[R[4]], ({ [0] = 112, [1] = 14, [2] = 19, [3] = 117 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 118, [2] = 33, [3] = 36 })[R[4]], ({ [0] = 112, [1] = 14, [2] = 19, [3] = 117 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 121, [1] = 117, [2] = 32, [3] = 35 })[R[4]], ({ [0] = 112, [1] = 14, [2] = 19, [3] = 117 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 118, [2] = 33, [3] = 36 })[R[4]], ({ [0] = 112, [1] = 14, [2] = 19, [3] = 117 })[R[4]] })
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 119, [1] = 115, [2] = 30, [3] = 33 }, [1] = { [0] = 106, [1] = 102, [2] = 17, [3] = 20 }, [2] = { [0] = 118, [1] = 114, [2] = 29, [3] = 32 } })[R[15]][R[4]], ({ [0] = { [0] = 106, [1] = 8, [2] = 13, [3] = 111 }, [1] = { [0] = 115, [1] = 17, [2] = 22, [3] = 120 }, [2] = { [0] = 118, [1] = 20, [2] = 25, [3] = 123 } })[R[15]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 125, [1] = 119, [2] = 23, [3] = 20 })[R[4]], ({ [0] = 116, [1] = 29, [2] = 33, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 125, [1] = 119, [2] = 23, [3] = 20 })[R[4]], ({ [0] = 116, [1] = 29, [2] = 33, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 125, [1] = 119, [2] = 23, [3] = 20 })[R[4]], ({ [0] = 117, [1] = 30, [2] = 34, [3] = 121 })[R[4]] })
        for i = 1, game.initial_units() do
          R[16] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 116, [1] = 110, [2] = 14, [3] = 11 }, [1] = { [0] = 118, [1] = 112, [2] = 16, [3] = 13 }, [2] = { [0] = 120, [1] = 114, [2] = 18, [3] = 15 } })[R[16]][R[4]], ({ [0] = { [0] = 111, [1] = 24, [2] = 28, [3] = 115 }, [1] = { [0] = 113, [1] = 26, [2] = 30, [3] = 117 }, [2] = { [0] = 105, [1] = 18, [2] = 22, [3] = 109 } })[R[16]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 125, [1] = 119, [2] = 23, [3] = 20 })[R[4]], ({ [0] = 116, [1] = 29, [2] = 33, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 125, [1] = 119, [2] = 23, [3] = 20 })[R[4]], ({ [0] = 116, [1] = 29, [2] = 33, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 125, [1] = 119, [2] = 23, [3] = 20 })[R[4]], ({ [0] = 117, [1] = 30, [2] = 34, [3] = 121 })[R[4]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[17] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 106, [1] = 98, [2] = 16, [3] = 12 }, [1] = { [0] = 111, [1] = 103, [2] = 21, [3] = 17 }, [2] = { [0] = 124, [1] = 116, [2] = 34, [3] = 30 } })[R[17]][R[4]], ({ [0] = { [0] = 103, [1] = 9, [2] = 12, [3] = 106 }, [1] = { [0] = 119, [1] = 25, [2] = 28, [3] = 122 }, [2] = { [0] = 112, [1] = 18, [2] = 21, [3] = 115 } })[R[17]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 119, [1] = 106, [2] = 29, [3] = 25 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 120, [1] = 107, [2] = 30, [3] = 26 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 121, [1] = 108, [2] = 31, [3] = 27 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 109, [2] = 32, [3] = 28 })[R[4]], ({ [0] = 113, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 109, [2] = 32, [3] = 28 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 110, [2] = 33, [3] = 29 })[R[4]], ({ [0] = 113, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 110, [2] = 33, [3] = 29 })[R[4]], ({ [0] = 114, [1] = 13, [2] = 21, [3] = 117 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 110, [2] = 33, [3] = 29 })[R[4]], ({ [0] = 115, [1] = 14, [2] = 22, [3] = 118 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 110, [2] = 33, [3] = 29 })[R[4]], ({ [0] = 116, [1] = 15, [2] = 23, [3] = 119 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 110, [2] = 33, [3] = 29 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 111, [2] = 34, [3] = 30 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 111, [2] = 34, [3] = 30 })[R[4]], ({ [0] = 118, [1] = 17, [2] = 25, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 111, [2] = 34, [3] = 30 })[R[4]], ({ [0] = 119, [1] = 18, [2] = 26, [3] = 122 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 119, [1] = 106, [2] = 29, [3] = 25 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 120, [1] = 107, [2] = 30, [3] = 26 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 121, [1] = 108, [2] = 31, [3] = 27 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 109, [2] = 32, [3] = 28 })[R[4]], ({ [0] = 113, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 109, [2] = 32, [3] = 28 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 110, [2] = 33, [3] = 29 })[R[4]], ({ [0] = 113, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 110, [2] = 33, [3] = 29 })[R[4]], ({ [0] = 114, [1] = 13, [2] = 21, [3] = 117 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 110, [2] = 33, [3] = 29 })[R[4]], ({ [0] = 115, [1] = 14, [2] = 22, [3] = 118 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 110, [2] = 33, [3] = 29 })[R[4]], ({ [0] = 116, [1] = 15, [2] = 23, [3] = 119 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 110, [2] = 33, [3] = 29 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 111, [2] = 34, [3] = 30 })[R[4]], ({ [0] = 117, [1] = 16, [2] = 24, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 111, [2] = 34, [3] = 30 })[R[4]], ({ [0] = 118, [1] = 17, [2] = 25, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 111, [2] = 34, [3] = 30 })[R[4]], ({ [0] = 119, [1] = 18, [2] = 26, [3] = 122 })[R[4]] })
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 104, [2] = 27, [3] = 23 }, [1] = { [0] = 118, [1] = 105, [2] = 28, [3] = 24 }, [2] = { [0] = 105, [1] = 92, [2] = 15, [3] = 11 } })[R[18]][R[4]], ({ [0] = { [0] = 113, [1] = 12, [2] = 20, [3] = 116 }, [1] = { [0] = 120, [1] = 19, [2] = 27, [3] = 123 }, [2] = { [0] = 117, [1] = 16, [2] = 24, [3] = 120 } })[R[18]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 119, [1] = 107, [2] = 31, [3] = 25 })[R[4]], ({ [0] = 108, [1] = 5, [2] = 13, [3] = 109 })[R[4]] })
        game.create_tube({ ({ [0] = 119, [1] = 107, [2] = 31, [3] = 25 })[R[4]], ({ [0] = 109, [1] = 6, [2] = 14, [3] = 110 })[R[4]] })
        game.create_tube({ ({ [0] = 119, [1] = 107, [2] = 31, [3] = 25 })[R[4]], ({ [0] = 115, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 119, [1] = 107, [2] = 31, [3] = 25 })[R[4]], ({ [0] = 123, [1] = 20, [2] = 28, [3] = 124 })[R[4]] })
        game.create_tube({ ({ [0] = 120, [1] = 108, [2] = 32, [3] = 26 })[R[4]], ({ [0] = 109, [1] = 6, [2] = 14, [3] = 110 })[R[4]] })
        game.create_tube({ ({ [0] = 120, [1] = 108, [2] = 32, [3] = 26 })[R[4]], ({ [0] = 115, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 120, [1] = 108, [2] = 32, [3] = 26 })[R[4]], ({ [0] = 123, [1] = 20, [2] = 28, [3] = 124 })[R[4]] })
        game.create_tube({ ({ [0] = 121, [1] = 109, [2] = 33, [3] = 27 })[R[4]], ({ [0] = 109, [1] = 6, [2] = 14, [3] = 110 })[R[4]] })
        game.create_tube({ ({ [0] = 121, [1] = 109, [2] = 33, [3] = 27 })[R[4]], ({ [0] = 115, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 121, [1] = 109, [2] = 33, [3] = 27 })[R[4]], ({ [0] = 123, [1] = 20, [2] = 28, [3] = 124 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 114, [1] = 11, [2] = 19, [3] = 115 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 115, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 116, [1] = 13, [2] = 21, [3] = 117 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 117, [1] = 14, [2] = 22, [3] = 118 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 122, [1] = 19, [2] = 27, [3] = 123 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 123, [1] = 20, [2] = 28, [3] = 124 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 111, [2] = 35, [3] = 29 })[R[4]], ({ [0] = 114, [1] = 11, [2] = 19, [3] = 115 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 111, [2] = 35, [3] = 29 })[R[4]], ({ [0] = 122, [1] = 19, [2] = 27, [3] = 123 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 112, [2] = 36, [3] = 30 })[R[4]], ({ [0] = 112, [1] = 9, [2] = 17, [3] = 113 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 112, [2] = 36, [3] = 30 })[R[4]], ({ [0] = 113, [1] = 10, [2] = 18, [3] = 114 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 112, [2] = 36, [3] = 30 })[R[4]], ({ [0] = 114, [1] = 11, [2] = 19, [3] = 115 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 112, [2] = 36, [3] = 30 })[R[4]], ({ [0] = 122, [1] = 19, [2] = 27, [3] = 123 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 119, [1] = 107, [2] = 31, [3] = 25 })[R[4]], ({ [0] = 108, [1] = 5, [2] = 13, [3] = 109 })[R[4]] })
        game.create_tube({ ({ [0] = 119, [1] = 107, [2] = 31, [3] = 25 })[R[4]], ({ [0] = 109, [1] = 6, [2] = 14, [3] = 110 })[R[4]] })
        game.create_tube({ ({ [0] = 119, [1] = 107, [2] = 31, [3] = 25 })[R[4]], ({ [0] = 115, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 119, [1] = 107, [2] = 31, [3] = 25 })[R[4]], ({ [0] = 123, [1] = 20, [2] = 28, [3] = 124 })[R[4]] })
        game.create_tube({ ({ [0] = 120, [1] = 108, [2] = 32, [3] = 26 })[R[4]], ({ [0] = 109, [1] = 6, [2] = 14, [3] = 110 })[R[4]] })
        game.create_tube({ ({ [0] = 120, [1] = 108, [2] = 32, [3] = 26 })[R[4]], ({ [0] = 115, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 120, [1] = 108, [2] = 32, [3] = 26 })[R[4]], ({ [0] = 123, [1] = 20, [2] = 28, [3] = 124 })[R[4]] })
        game.create_tube({ ({ [0] = 121, [1] = 109, [2] = 33, [3] = 27 })[R[4]], ({ [0] = 109, [1] = 6, [2] = 14, [3] = 110 })[R[4]] })
        game.create_tube({ ({ [0] = 121, [1] = 109, [2] = 33, [3] = 27 })[R[4]], ({ [0] = 115, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 121, [1] = 109, [2] = 33, [3] = 27 })[R[4]], ({ [0] = 123, [1] = 20, [2] = 28, [3] = 124 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 114, [1] = 11, [2] = 19, [3] = 115 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 115, [1] = 12, [2] = 20, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 116, [1] = 13, [2] = 21, [3] = 117 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 117, [1] = 14, [2] = 22, [3] = 118 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 122, [1] = 19, [2] = 27, [3] = 123 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 110, [2] = 34, [3] = 28 })[R[4]], ({ [0] = 123, [1] = 20, [2] = 28, [3] = 124 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 111, [2] = 35, [3] = 29 })[R[4]], ({ [0] = 114, [1] = 11, [2] = 19, [3] = 115 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 111, [2] = 35, [3] = 29 })[R[4]], ({ [0] = 122, [1] = 19, [2] = 27, [3] = 123 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 112, [2] = 36, [3] = 30 })[R[4]], ({ [0] = 112, [1] = 9, [2] = 17, [3] = 113 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 112, [2] = 36, [3] = 30 })[R[4]], ({ [0] = 113, [1] = 10, [2] = 18, [3] = 114 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 112, [2] = 36, [3] = 30 })[R[4]], ({ [0] = 114, [1] = 11, [2] = 19, [3] = 115 })[R[4]] })
        game.create_tube({ ({ [0] = 124, [1] = 112, [2] = 36, [3] = 30 })[R[4]], ({ [0] = 122, [1] = 19, [2] = 27, [3] = 123 })[R[4]] })
        for i = 1, game.initial_units() do
          R[19] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 105, [2] = 29, [3] = 23 }, [1] = { [0] = 108, [1] = 96, [2] = 20, [3] = 14 }, [2] = { [0] = 116, [1] = 104, [2] = 28, [3] = 22 } })[R[19]][R[4]], ({ [0] = { [0] = 106, [1] = 3, [2] = 11, [3] = 107 }, [1] = { [0] = 114, [1] = 11, [2] = 19, [3] = 115 }, [2] = { [0] = 109, [1] = 6, [2] = 14, [3] = 110 } })[R[19]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 115, [1] = 115, [2] = 25, [3] = 24 })[R[4]], ({ [0] = 113, [1] = 16, [2] = 24, [3] = 115 })[R[4]] })
        game.create_tube({ ({ [0] = 115, [1] = 115, [2] = 25, [3] = 24 })[R[4]], ({ [0] = 114, [1] = 17, [2] = 25, [3] = 116 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 115, [1] = 115, [2] = 25, [3] = 24 })[R[4]], ({ [0] = 113, [1] = 16, [2] = 24, [3] = 115 })[R[4]] })
        game.create_tube({ ({ [0] = 115, [1] = 115, [2] = 25, [3] = 24 })[R[4]], ({ [0] = 114, [1] = 17, [2] = 25, [3] = 116 })[R[4]] })
        for i = 1, game.initial_units() do
          R[20] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 111, [1] = 111, [2] = 21, [3] = 20 }, [1] = { [0] = 94, [1] = 94, [2] = 4, [3] = 3 }, [2] = { [0] = 116, [1] = 116, [2] = 26, [3] = 25 } })[R[20]][R[4]], ({ [0] = { [0] = 120, [1] = 23, [2] = 31, [3] = 122 }, [1] = { [0] = 107, [1] = 10, [2] = 18, [3] = 109 }, [2] = { [0] = 120, [1] = 23, [2] = 31, [3] = 122 } })[R[20]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 6 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 121, [1] = 119, [2] = 25, [3] = 28 })[R[4]], ({ [0] = 121, [1] = 18, [2] = 23, [3] = 118 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 120, [2] = 26, [3] = 29 })[R[4]], ({ [0] = 121, [1] = 18, [2] = 23, [3] = 118 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 121, [2] = 27, [3] = 30 })[R[4]], ({ [0] = 121, [1] = 18, [2] = 23, [3] = 118 })[R[4]] })
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 102, [1] = 100, [2] = 6, [3] = 9 }, [1] = { [0] = 107, [1] = 105, [2] = 11, [3] = 14 }, [2] = { [0] = 128, [1] = 126, [2] = 32, [3] = 35 } })[R[21]][R[4]], ({ [0] = { [0] = 111, [1] = 8, [2] = 13, [3] = 108 }, [1] = { [0] = 109, [1] = 6, [2] = 11, [3] = 106 }, [2] = { [0] = 124, [1] = 21, [2] = 26, [3] = 121 } })[R[21]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 121, [1] = 119, [2] = 25, [3] = 28 })[R[4]], ({ [0] = 121, [1] = 18, [2] = 23, [3] = 118 })[R[4]] })
        game.create_tube({ ({ [0] = 122, [1] = 120, [2] = 26, [3] = 29 })[R[4]], ({ [0] = 121, [1] = 18, [2] = 23, [3] = 118 })[R[4]] })
        game.create_tube({ ({ [0] = 123, [1] = 121, [2] = 27, [3] = 30 })[R[4]], ({ [0] = 121, [1] = 18, [2] = 23, [3] = 118 })[R[4]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 112, [1] = 10, [2] = 16, [3] = 111 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 113, [1] = 11, [2] = 17, [3] = 112 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 114, [1] = 12, [2] = 18, [3] = 113 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 118, [1] = 16, [2] = 22, [3] = 117 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 119, [1] = 17, [2] = 23, [3] = 118 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 120, [1] = 18, [2] = 24, [3] = 119 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 121, [1] = 19, [2] = 25, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 110, [1] = 115, [2] = 16, [3] = 14 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 110, [1] = 115, [2] = 16, [3] = 14 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 111, [1] = 116, [2] = 17, [3] = 15 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 111, [1] = 116, [2] = 17, [3] = 15 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 112, [1] = 117, [2] = 18, [3] = 16 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 112, [1] = 117, [2] = 18, [3] = 16 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 113, [1] = 118, [2] = 19, [3] = 17 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 113, [1] = 118, [2] = 19, [3] = 17 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 114, [1] = 119, [2] = 20, [3] = 18 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 114, [1] = 119, [2] = 20, [3] = 18 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 115, [1] = 120, [2] = 21, [3] = 19 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 115, [1] = 120, [2] = 21, [3] = 19 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 111, [1] = 9, [2] = 15, [3] = 110 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 112, [1] = 10, [2] = 16, [3] = 111 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 113, [1] = 11, [2] = 17, [3] = 112 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 114, [1] = 12, [2] = 18, [3] = 113 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 115, [1] = 13, [2] = 19, [3] = 114 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 116, [1] = 14, [2] = 20, [3] = 115 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 117, [1] = 15, [2] = 21, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 118, [1] = 16, [2] = 22, [3] = 117 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 119, [1] = 17, [2] = 23, [3] = 118 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 112, [1] = 10, [2] = 16, [3] = 111 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 113, [1] = 11, [2] = 17, [3] = 112 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 114, [1] = 12, [2] = 18, [3] = 113 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 118, [1] = 16, [2] = 22, [3] = 117 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 119, [1] = 17, [2] = 23, [3] = 118 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 120, [1] = 18, [2] = 24, [3] = 119 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 121, [1] = 19, [2] = 25, [3] = 120 })[R[4]] })
        game.create_tube({ ({ [0] = 109, [1] = 114, [2] = 15, [3] = 13 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 110, [1] = 115, [2] = 16, [3] = 14 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 110, [1] = 115, [2] = 16, [3] = 14 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 111, [1] = 116, [2] = 17, [3] = 15 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 111, [1] = 116, [2] = 17, [3] = 15 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 112, [1] = 117, [2] = 18, [3] = 16 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 112, [1] = 117, [2] = 18, [3] = 16 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 113, [1] = 118, [2] = 19, [3] = 17 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 113, [1] = 118, [2] = 19, [3] = 17 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 114, [1] = 119, [2] = 20, [3] = 18 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 114, [1] = 119, [2] = 20, [3] = 18 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 115, [1] = 120, [2] = 21, [3] = 19 })[R[4]], ({ [0] = 109, [1] = 7, [2] = 13, [3] = 108 })[R[4]] })
        game.create_tube({ ({ [0] = 115, [1] = 120, [2] = 21, [3] = 19 })[R[4]], ({ [0] = 122, [1] = 20, [2] = 26, [3] = 121 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 111, [1] = 9, [2] = 15, [3] = 110 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 112, [1] = 10, [2] = 16, [3] = 111 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 113, [1] = 11, [2] = 17, [3] = 112 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 114, [1] = 12, [2] = 18, [3] = 113 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 115, [1] = 13, [2] = 19, [3] = 114 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 116, [1] = 14, [2] = 20, [3] = 115 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 117, [1] = 15, [2] = 21, [3] = 116 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 118, [1] = 16, [2] = 22, [3] = 117 })[R[4]] })
        game.create_tube({ ({ [0] = 117, [1] = 122, [2] = 23, [3] = 21 })[R[4]], ({ [0] = 119, [1] = 17, [2] = 23, [3] = 118 })[R[4]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 107, [1] = 112, [2] = 13, [3] = 11 }, [1] = { [0] = 113, [1] = 118, [2] = 19, [3] = 17 }, [2] = { [0] = 101, [1] = 106, [2] = 7, [3] = 5 } })[R[22]][R[4]], ({ [0] = { [0] = 105, [1] = 3, [2] = 9, [3] = 104 }, [1] = { [0] = 105, [1] = 3, [2] = 9, [3] = 104 }, [2] = { [0] = 126, [1] = 24, [2] = 30, [3] = 125 } })[R[22]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[14]", R[14])
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 39, 98 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 45, 48 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 98, 37 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 92, 90 } }
    pick(16, 4, { 0, 1, 2, 3 })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 35, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 47, 89 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 101 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 68, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 46, 64 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 84, 84 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 68 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 82, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 95, 73 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 62, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 52 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 87, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 106, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 74, 46 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 70, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 62, 11 } }
    pick(4, 3, { 4, 23, 24 })
    R[5] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 97 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 11, [1] = 98, [2] = 94, [3] = 7 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    if R[5] == 3 or R[5] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 } })[R[5]][R[4]], ({ [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[5] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 21, [1] = 17, [2] = 111, [3] = 98 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[5] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[5]", R[5])
      end
    elseif R[5] == 0 or R[5] == 1 or R[5] == 2 or R[5] == 5 or R[5] == 6 or R[5] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 21, [1] = 24, [2] = 117, [3] = 115 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 18, [1] = 105, [2] = 101, [3] = 14 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 27, [1] = 118, [2] = 116, [3] = 19 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[5] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[5] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[5] == 2 then
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
      elseif R[5] == 5 then
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
      elseif R[5] == 6 then
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
      elseif R[5] == 7 then
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
        unseen("R[5]", R[5])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 29, [1] = 32, [2] = 125, [3] = 123 }, [7] = { [0] = 23, [1] = 21, [2] = 117, [3] = 122 } })[R[5]][R[4]], ({ [0] = { [0] = 26, [1] = 124, [2] = 119, [3] = 21 }, [1] = { [0] = 36, [1] = 123, [2] = 119, [3] = 32 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[5] == 2 or R[5] == 5 or R[5] == 6 or R[5] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 12, [1] = 15, [2] = 108, [3] = 106 }, [7] = { [0] = 24, [1] = 22, [2] = 118, [3] = 123 } })[R[5]][R[4]], ({ [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 25, [1] = 120, [2] = 121, [3] = 19 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[5] == 0 or R[5] == 1 then
      else
        unseen("R[5]", R[5])
      end
    else
      unseen("R[5]", R[5])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 16, [2] = 102, [3] = 98 }, [1] = { [0] = 13, [1] = 10, [2] = 115, [3] = 109 }, [2] = { [0] = 35, [1] = 31, [2] = 125, [3] = 117 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 17, [1] = 11, [2] = 105, [3] = 93 }, [5] = { [0] = 5, [1] = 4, [2] = 95, [3] = 95 }, [6] = { [0] = 4, [1] = 7, [2] = 100, [3] = 98 }, [7] = { [0] = 16, [1] = 14, [2] = 110, [3] = 115 } })[R[5]][R[4]], ({ [0] = { [0] = 28, [1] = 126, [2] = 121, [3] = 23 }, [1] = { [0] = 33, [1] = 120, [2] = 116, [3] = 29 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 11, [1] = 107, [2] = 104, [3] = 3 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 29, [1] = 124, [2] = 125, [3] = 23 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 35, [1] = 29, [2] = 123, [3] = 111 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[5]][R[4]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 13, [1] = 104, [2] = 102, [3] = 5 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[5]][R[4]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 17, [1] = 104, [2] = 100, [3] = 13 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[5] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 36, [1] = 32, [2] = 126, [3] = 113 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 107, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 0 or R[5] == 1 or R[5] == 2 or R[5] == 4 or R[5] == 5 or R[5] == 6 or R[5] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[5]][R[4]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[5]][R[4]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[5]", R[5])
    end
    U[#U]:set_lights(true)
    if R[5] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 32, [2] = 118, [3] = 114 })[R[4]], ({ [0] = 21, [1] = 119, [2] = 114, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 32, [2] = 118, [3] = 114 })[R[4]], ({ [0] = 21, [1] = 119, [2] = 114, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[4]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[4]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[4]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 9, [2] = 103, [3] = 95 })[R[4]], ({ [0] = 23, [1] = 117, [2] = 114, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 9, [2] = 103, [3] = 95 })[R[4]], ({ [0] = 23, [1] = 117, [2] = 114, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 107, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 23, [2] = 117, [3] = 105 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 23, [2] = 117, [3] = 105 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[4]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[4]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 10, [2] = 101, [3] = 101 })[R[4]], ({ [0] = 23, [1] = 114, [2] = 112, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[4]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 10, [2] = 101, [3] = 101 })[R[4]], ({ [0] = 23, [1] = 114, [2] = 112, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[4]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[4]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 120, [3] = 118 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 113, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[4]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 120, [3] = 118 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 113, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 23, [2] = 119, [3] = 124 })[R[4]], ({ [0] = 14, [1] = 109, [2] = 110, [3] = 8 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 23, [2] = 119, [3] = 124 })[R[4]], ({ [0] = 14, [1] = 109, [2] = 110, [3] = 8 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[5]", R[5])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 38, [1] = 32, [2] = 126, [3] = 114 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 } })[R[5]][R[4]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 15, [1] = 111, [2] = 108, [3] = 7 }, [4] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [5] = { [0] = 29, [1] = 120, [2] = 118, [3] = 21 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 19, [2] = 105, [3] = 101 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 }, [5] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 16, [1] = 111, [2] = 112, [3] = 10 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 19, [1] = 15, [2] = 109, [3] = 101 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 25, [1] = 121, [2] = 118, [3] = 17 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 19, [1] = 110, [2] = 108, [3] = 11 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 17, [1] = 14, [2] = 119, [3] = 113 }, [2] = { [0] = 20, [1] = 16, [2] = 110, [3] = 102 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 26, [1] = 122, [2] = 119, [3] = 18 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 18, [1] = 113, [2] = 114, [3] = 12 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 22, [2] = 108, [3] = 104 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 15, [1] = 109, [2] = 106, [3] = 12 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 17, [1] = 113, [2] = 112, [3] = 9 }, [5] = { [0] = 24, [1] = 115, [2] = 113, [3] = 16 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 19, [1] = 16, [2] = 121, [3] = 115 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 16, [1] = 110, [2] = 107, [3] = 13 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 114, [2] = 113, [3] = 10 }, [5] = { [0] = 25, [1] = 116, [2] = 114, [3] = 17 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 24, [2] = 110, [3] = 106 }, [1] = { [0] = 20, [1] = 17, [2] = 122, [3] = 116 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 14, [1] = 17, [2] = 110, [3] = 108 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 17, [1] = 111, [2] = 108, [3] = 14 }, [3] = { [0] = 21, [1] = 117, [2] = 114, [3] = 13 }, [4] = { [0] = 22, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 26, [1] = 117, [2] = 115, [3] = 18 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 21, [1] = 116, [2] = 117, [3] = 15 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 25, [2] = 111, [3] = 107 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 22, [1] = 118, [2] = 115, [3] = 14 }, [4] = { [0] = 23, [1] = 119, [2] = 118, [3] = 15 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 14, [1] = 112, [2] = 107, [3] = 9 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 19, [1] = 113, [2] = 110, [3] = 16 }, [3] = { [0] = 23, [1] = 119, [2] = 116, [3] = 15 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 23, [1] = 118, [2] = 119, [3] = 17 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 14, [1] = 101, [2] = 97, [3] = 10 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 25, [1] = 121, [2] = 120, [3] = 17 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 24, [1] = 119, [2] = 120, [3] = 18 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[5]][R[4]], ({ [0] = { [0] = 16, [1] = 114, [2] = 109, [3] = 11 }, [1] = { [0] = 15, [1] = 102, [2] = 98, [3] = 11 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 26, [1] = 122, [2] = 121, [3] = 18 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[5]][R[4]], ({ [0] = { [0] = 17, [1] = 115, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 103, [2] = 99, [3] = 12 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[5]][R[4]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 23, [1] = 19, [2] = 113, [3] = 100 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[5]][R[4]], ({ [0] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [1] = { [0] = 21, [1] = 108, [2] = 104, [3] = 17 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[5]][R[4]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[5]][R[4]], ({ [0] = { [0] = 24, [1] = 122, [2] = 117, [3] = 19 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 30, [2] = 116, [3] = 112 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 25, [1] = 21, [2] = 115, [3] = 102 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 31, [2] = 117, [3] = 113 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 25, [1] = 112, [2] = 108, [3] = 21 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 24, [1] = 23, [2] = 114, [3] = 114 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 26, [1] = 113, [2] = 109, [3] = 22 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 13, [1] = 109, [2] = 108, [3] = 5 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 31, [1] = 118, [2] = 114, [3] = 27 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 34, [2] = 120, [3] = 116 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 25, [1] = 21, [2] = 115, [3] = 107 }, [3] = { [0] = 29, [1] = 25, [2] = 119, [3] = 106 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 32, [1] = 119, [2] = 115, [3] = 28 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 15, [1] = 110, [2] = 111, [3] = 9 } })[R[5]][R[4]] })
    if R[5] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [2] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 } })[R[25]][R[4]], ({ [0] = { [0] = 13, [1] = 111, [2] = 106, [3] = 8 }, [1] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [2] = { [0] = 25, [1] = 123, [2] = 118, [3] = 20 } })[R[25]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[4]] })
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 11, [2] = 116, [3] = 110 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 } })[R[26]][R[4]], ({ [0] = { [0] = 28, [1] = 115, [2] = 111, [3] = 24 }, [1] = { [0] = 30, [1] = 117, [2] = 113, [3] = 26 }, [2] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 } })[R[26]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 12, [2] = 106, [3] = 98 }, [1] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [2] = { [0] = 34, [1] = 30, [2] = 124, [3] = 116 } })[R[27]][R[4]], ({ [0] = { [0] = 12, [1] = 106, [2] = 103, [3] = 9 }, [1] = { [0] = 28, [1] = 122, [2] = 119, [3] = 25 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 } })[R[27]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[4]] })
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [1] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 92 } })[R[28]][R[4]], ({ [0] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [1] = { [0] = 27, [1] = 123, [2] = 120, [3] = 19 }, [2] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 } })[R[28]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [1] = { [0] = 20, [1] = 14, [2] = 108, [3] = 96 }, [2] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 } })[R[29]][R[4]], ({ [0] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [1] = { [0] = 19, [1] = 115, [2] = 114, [3] = 11 }, [2] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 } })[R[29]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[4]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [1] = { [0] = 4, [1] = 3, [2] = 94, [3] = 94 }, [2] = { [0] = 26, [1] = 25, [2] = 116, [3] = 116 } })[R[30]][R[4]], ({ [0] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 }, [1] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [2] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 } })[R[30]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 6, [1] = 9, [2] = 102, [3] = 100 }, [1] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [2] = { [0] = 32, [1] = 35, [2] = 128, [3] = 126 } })[R[31]][R[4]], ({ [0] = { [0] = 13, [1] = 108, [2] = 111, [3] = 8 }, [1] = { [0] = 11, [1] = 106, [2] = 109, [3] = 6 }, [2] = { [0] = 26, [1] = 121, [2] = 124, [3] = 21 } })[R[31]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 }, [1] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 }, [2] = { [0] = 7, [1] = 5, [2] = 101, [3] = 106 } })[R[32]][R[4]], ({ [0] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [1] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [2] = { [0] = 30, [1] = 125, [2] = 126, [3] = 24 } })[R[32]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[5]", R[5])
    end
    R[14] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 12, [2] = 21, [3] = 26, [4] = 25, [5] = 15, [6] = 11, [7] = 15 }, [1] = { [0] = 27, [1] = 9, [2] = 17, [3] = 22, [4] = 19, [5] = 14, [6] = 14, [7] = 13 }, [2] = { [0] = 113, [1] = 114, [2] = 111, [3] = 116, [4] = 113, [5] = 105, [6] = 107, [7] = 109 }, [3] = { [0] = 109, [1] = 108, [2] = 103, [3] = 103, [4] = 101, [5] = 105, [6] = 105, [7] = 114 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 13, [3] = 24, [4] = 20, [5] = 22, [6] = 15, [7] = 20 }, [1] = { [0] = 117, [1] = 111, [2] = 107, [3] = 120, [4] = 116, [5] = 113, [6] = 110, [7] = 115 }, [2] = { [0] = 112, [1] = 107, [2] = 104, [3] = 117, [4] = 115, [5] = 111, [6] = 113, [7] = 116 }, [3] = { [0] = 14, [1] = 20, [2] = 10, [3] = 16, [4] = 12, [5] = 14, [6] = 10, [7] = 14 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 24, [1] = 12, [2] = 21, [3] = 26, [4] = 25, [5] = 15, [6] = 11, [7] = 15 }, [1] = { [0] = 27, [1] = 9, [2] = 17, [3] = 22, [4] = 19, [5] = 14, [6] = 14, [7] = 13 }, [2] = { [0] = 113, [1] = 114, [2] = 111, [3] = 116, [4] = 113, [5] = 105, [6] = 107, [7] = 109 }, [3] = { [0] = 109, [1] = 108, [2] = 103, [3] = 103, [4] = 101, [5] = 105, [6] = 105, [7] = 114 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 13, [3] = 24, [4] = 20, [5] = 22, [6] = 15, [7] = 20 }, [1] = { [0] = 117, [1] = 111, [2] = 107, [3] = 120, [4] = 116, [5] = 113, [6] = 110, [7] = 115 }, [2] = { [0] = 112, [1] = 107, [2] = 104, [3] = 117, [4] = 115, [5] = 111, [6] = 113, [7] = 116 }, [3] = { [0] = 14, [1] = 20, [2] = 10, [3] = 16, [4] = 12, [5] = 14, [6] = 10, [7] = 14 } })[R[23]][R[14]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 22, [2] = 15, [3] = 34, [4] = 25, [5] = 15, [6] = 20, [7] = 8 }, [1] = { [0] = 27, [1] = 19, [2] = 11, [3] = 30, [4] = 19, [5] = 14, [6] = 23, [7] = 6 }, [2] = { [0] = 113, [1] = 124, [2] = 105, [3] = 124, [4] = 113, [5] = 105, [6] = 116, [7] = 102 }, [3] = { [0] = 109, [1] = 118, [2] = 97, [3] = 111, [4] = 101, [5] = 105, [6] = 114, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 12, [1] = 11, [2] = 18, [3] = 28, [4] = 28, [5] = 28, [6] = 15, [7] = 26 }, [1] = { [0] = 110, [1] = 98, [2] = 112, [3] = 124, [4] = 124, [5] = 119, [6] = 110, [7] = 121 }, [2] = { [0] = 105, [1] = 94, [2] = 109, [3] = 121, [4] = 123, [5] = 117, [6] = 113, [7] = 122 }, [3] = { [0] = 7, [1] = 7, [2] = 15, [3] = 20, [4] = 20, [5] = 20, [6] = 10, [7] = 20 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    if R[14] == 0 or R[14] == 1 or R[14] == 2 or R[14] == 5 or R[14] == 6 or R[14] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 23, [2] = 18, [5] = 25, [6] = 21, [7] = 8 }, [1] = { [0] = 39, [1] = 20, [2] = 14, [5] = 24, [6] = 24, [7] = 6 }, [2] = { [0] = 125, [1] = 125, [2] = 108, [5] = 115, [6] = 117, [7] = 102 }, [3] = { [0] = 121, [1] = 119, [2] = 100, [5] = 115, [6] = 115, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 18, [2] = 24, [5] = 27, [6] = 23, [7] = 13 }, [1] = { [0] = 117, [1] = 105, [2] = 118, [5] = 118, [6] = 118, [7] = 108 }, [2] = { [0] = 112, [1] = 101, [2] = 115, [5] = 116, [6] = 121, [7] = 109 }, [3] = { [0] = 14, [1] = 14, [2] = 21, [5] = 19, [6] = 18, [7] = 7 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 0 then
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
      elseif R[14] == 1 then
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
      elseif R[14] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[23]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[23]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[23]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[14] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[23]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[23]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[23]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[14] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[14] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[14]", R[14])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 23, [2] = 27, [5] = 15, [6] = 12, [7] = 24 }, [1] = { [0] = 16, [1] = 20, [2] = 23, [5] = 14, [6] = 15, [7] = 22 }, [2] = { [0] = 102, [1] = 125, [2] = 117, [5] = 105, [6] = 108, [7] = 118 }, [3] = { [0] = 98, [1] = 119, [2] = 109, [5] = 105, [6] = 106, [7] = 123 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 28, [2] = 24, [5] = 15, [6] = 23, [7] = 25 }, [1] = { [0] = 117, [1] = 115, [2] = 118, [5] = 106, [6] = 118, [7] = 120 }, [2] = { [0] = 112, [1] = 111, [2] = 115, [5] = 104, [6] = 121, [7] = 121 }, [3] = { [0] = 14, [1] = 24, [2] = 21, [5] = 7, [6] = 18, [7] = 19 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 2 or R[14] == 5 or R[14] == 6 or R[14] == 7 then
      elseif R[14] == 0 or R[14] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 22 }, [1] = { [0] = 27, [1] = 19 }, [2] = { [0] = 113, [1] = 124 }, [3] = { [0] = 109, [1] = 118 } })[R[23]][R[14]], ({ [0] = { [0] = 26, [1] = 36 }, [1] = { [0] = 124, [1] = 123 }, [2] = { [0] = 119, [1] = 119 }, [3] = { [0] = 21, [1] = 32 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[14]", R[14])
      end
    elseif R[14] == 3 or R[14] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [3] = 18, [4] = 25 }, [1] = { [3] = 14, [4] = 19 }, [2] = { [3] = 108, [4] = 113 }, [3] = { [3] = 95, [4] = 101 } })[R[23]][R[14]], ({ [0] = { [3] = 28, [4] = 12 }, [1] = { [3] = 124, [4] = 108 }, [2] = { [3] = 121, [4] = 107 }, [3] = { [3] = 20, [4] = 4 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 3 then
      else
        unseen("R[14]", R[14])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [3] = 21, [4] = 36 }, [1] = { [3] = 17, [4] = 30 }, [2] = { [3] = 111, [4] = 124 }, [3] = { [3] = 98, [4] = 112 } })[R[23]][R[14]], ({ [0] = { [3] = 17, [4] = 24 }, [1] = { [3] = 113, [4] = 120 }, [2] = { [3] = 110, [4] = 119 }, [3] = { [3] = 9, [4] = 16 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[14] == 4 then
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
    else
      unseen("R[14]", R[14])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 13, [2] = 35, [3] = 27, [4] = 17, [5] = 5, [6] = 4, [7] = 16 }, [1] = { [0] = 16, [1] = 10, [2] = 31, [3] = 23, [4] = 11, [5] = 4, [6] = 7, [7] = 14 }, [2] = { [0] = 102, [1] = 115, [2] = 125, [3] = 117, [4] = 105, [5] = 95, [6] = 100, [7] = 110 }, [3] = { [0] = 98, [1] = 109, [2] = 117, [3] = 104, [4] = 93, [5] = 95, [6] = 98, [7] = 115 } })[R[23]][R[14]], ({ [0] = { [0] = 28, [1] = 33, [2] = 18, [3] = 11, [4] = 16, [5] = 22, [6] = 23, [7] = 29 }, [1] = { [0] = 126, [1] = 120, [2] = 112, [3] = 107, [4] = 112, [5] = 113, [6] = 118, [7] = 124 }, [2] = { [0] = 121, [1] = 116, [2] = 109, [3] = 104, [4] = 111, [5] = 111, [6] = 121, [7] = 125 }, [3] = { [0] = 23, [1] = 29, [2] = 15, [3] = 3, [4] = 8, [5] = 14, [6] = 18, [7] = 23 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 12, [2] = 31, [3] = 16, [4] = 35, [5] = 23, [6] = 11, [7] = 26 }, [1] = { [0] = 23, [1] = 9, [2] = 27, [3] = 12, [4] = 29, [5] = 22, [6] = 14, [7] = 24 }, [2] = { [0] = 109, [1] = 114, [2] = 121, [3] = 106, [4] = 123, [5] = 113, [6] = 107, [7] = 120 }, [3] = { [0] = 105, [1] = 108, [2] = 113, [3] = 93, [4] = 111, [5] = 113, [6] = 105, [7] = 125 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 19, [2] = 22, [3] = 18, [4] = 20, [5] = 13, [6] = 28, [7] = 20 }, [1] = { [0] = 113, [1] = 106, [2] = 116, [3] = 114, [4] = 116, [5] = 104, [6] = 123, [7] = 115 }, [2] = { [0] = 108, [1] = 102, [2] = 113, [3] = 111, [4] = 115, [5] = 102, [6] = 126, [7] = 116 }, [3] = { [0] = 10, [1] = 15, [2] = 19, [3] = 10, [4] = 12, [5] = 5, [6] = 23, [7] = 14 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 12, [2] = 31, [3] = 19, [4] = 37, [5] = 23, [6] = 9, [7] = 26 }, [1] = { [0] = 21, [1] = 9, [2] = 27, [3] = 15, [4] = 31, [5] = 22, [6] = 12, [7] = 24 }, [2] = { [0] = 107, [1] = 114, [2] = 121, [3] = 109, [4] = 125, [5] = 113, [6] = 105, [7] = 120 }, [3] = { [0] = 103, [1] = 108, [2] = 113, [3] = 96, [4] = 113, [5] = 113, [6] = 103, [7] = 125 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 17, [2] = 20, [3] = 14, [4] = 20, [5] = 15, [6] = 28, [7] = 22 }, [1] = { [0] = 113, [1] = 104, [2] = 114, [3] = 110, [4] = 116, [5] = 106, [6] = 123, [7] = 117 }, [2] = { [0] = 108, [1] = 100, [2] = 111, [3] = 107, [4] = 115, [5] = 104, [6] = 126, [7] = 118 }, [3] = { [0] = 10, [1] = 13, [2] = 17, [3] = 6, [4] = 12, [5] = 7, [6] = 23, [7] = 16 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 29, [1] = 15, [2] = 13, [3] = 36, [4] = 29, [5] = 11, [6] = 24, [7] = 25 }, [1] = { [0] = 32, [1] = 12, [2] = 9, [3] = 32, [4] = 23, [5] = 10, [6] = 27, [7] = 23 }, [2] = { [0] = 118, [1] = 117, [2] = 103, [3] = 126, [4] = 117, [5] = 101, [6] = 120, [7] = 119 }, [3] = { [0] = 114, [1] = 111, [2] = 95, [3] = 113, [4] = 105, [5] = 101, [6] = 118, [7] = 124 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 19, [2] = 23, [3] = 18, [4] = 28, [5] = 23, [6] = 15, [7] = 14 }, [1] = { [0] = 119, [1] = 106, [2] = 117, [3] = 114, [4] = 124, [5] = 114, [6] = 110, [7] = 109 }, [2] = { [0] = 114, [1] = 102, [2] = 114, [3] = 111, [4] = 123, [5] = 112, [6] = 113, [7] = 110 }, [3] = { [0] = 16, [1] = 15, [2] = 20, [3] = 10, [4] = 20, [5] = 15, [6] = 10, [7] = 8 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 29, [1] = 15, [2] = 13, [3] = 34, [4] = 29, [5] = 11, [6] = 24, [7] = 25 }, [1] = { [0] = 32, [1] = 12, [2] = 9, [3] = 30, [4] = 23, [5] = 10, [6] = 27, [7] = 23 }, [2] = { [0] = 118, [1] = 117, [2] = 103, [3] = 124, [4] = 117, [5] = 101, [6] = 120, [7] = 119 }, [3] = { [0] = 114, [1] = 111, [2] = 95, [3] = 111, [4] = 105, [5] = 101, [6] = 118, [7] = 124 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 19, [2] = 23, [3] = 14, [4] = 28, [5] = 23, [6] = 15, [7] = 14 }, [1] = { [0] = 119, [1] = 106, [2] = 117, [3] = 110, [4] = 124, [5] = 114, [6] = 110, [7] = 109 }, [2] = { [0] = 114, [1] = 102, [2] = 114, [3] = 107, [4] = 123, [5] = 112, [6] = 113, [7] = 110 }, [3] = { [0] = 16, [1] = 15, [2] = 20, [3] = 6, [4] = 20, [5] = 15, [6] = 10, [7] = 8 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 18, [1] = 12, [2] = 31, [3] = 22, [4] = 37, [5] = 23, [6] = 9, [7] = 26 }, [1] = { [0] = 21, [1] = 9, [2] = 27, [3] = 18, [4] = 31, [5] = 22, [6] = 12, [7] = 24 }, [2] = { [0] = 107, [1] = 114, [2] = 121, [3] = 112, [4] = 125, [5] = 113, [6] = 105, [7] = 120 }, [3] = { [0] = 103, [1] = 108, [2] = 113, [3] = 99, [4] = 113, [5] = 113, [6] = 103, [7] = 125 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 19, [2] = 20, [3] = 29, [4] = 20, [5] = 15, [6] = 28, [7] = 22 }, [1] = { [0] = 113, [1] = 106, [2] = 114, [3] = 125, [4] = 116, [5] = 106, [6] = 123, [7] = 117 }, [2] = { [0] = 108, [1] = 102, [2] = 111, [3] = 122, [4] = 115, [5] = 104, [6] = 126, [7] = 118 }, [3] = { [0] = 10, [1] = 15, [2] = 17, [3] = 21, [4] = 12, [5] = 7, [6] = 23, [7] = 16 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 18, [1] = 15, [2] = 31, [3] = 22, [4] = 37, [5] = 23, [6] = 9, [7] = 26 }, [1] = { [0] = 21, [1] = 12, [2] = 27, [3] = 18, [4] = 31, [5] = 22, [6] = 12, [7] = 24 }, [2] = { [0] = 107, [1] = 117, [2] = 121, [3] = 112, [4] = 125, [5] = 113, [6] = 105, [7] = 120 }, [3] = { [0] = 103, [1] = 111, [2] = 113, [3] = 99, [4] = 113, [5] = 113, [6] = 103, [7] = 125 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 19, [2] = 20, [3] = 29, [4] = 20, [5] = 15, [6] = 28, [7] = 22 }, [1] = { [0] = 113, [1] = 106, [2] = 114, [3] = 125, [4] = 116, [5] = 106, [6] = 123, [7] = 117 }, [2] = { [0] = 108, [1] = 102, [2] = 111, [3] = 122, [4] = 115, [5] = 104, [6] = 126, [7] = 118 }, [3] = { [0] = 10, [1] = 15, [2] = 17, [3] = 21, [4] = 12, [5] = 7, [6] = 23, [7] = 16 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 29, [1] = 12, [2] = 13, [3] = 16, [4] = 29, [5] = 11, [6] = 24, [7] = 25 }, [1] = { [0] = 32, [1] = 9, [2] = 9, [3] = 12, [4] = 23, [5] = 10, [6] = 27, [7] = 23 }, [2] = { [0] = 118, [1] = 114, [2] = 103, [3] = 106, [4] = 117, [5] = 101, [6] = 120, [7] = 119 }, [3] = { [0] = 114, [1] = 108, [2] = 95, [3] = 93, [4] = 105, [5] = 101, [6] = 118, [7] = 124 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 19, [2] = 23, [3] = 18, [4] = 28, [5] = 23, [6] = 15, [7] = 14 }, [1] = { [0] = 119, [1] = 106, [2] = 117, [3] = 114, [4] = 124, [5] = 114, [6] = 110, [7] = 109 }, [2] = { [0] = 114, [1] = 102, [2] = 114, [3] = 111, [4] = 123, [5] = 112, [6] = 113, [7] = 110 }, [3] = { [0] = 16, [1] = 15, [2] = 20, [3] = 10, [4] = 20, [5] = 15, [6] = 10, [7] = 8 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 15, [1] = 15, [2] = 31, [3] = 16, [4] = 30, [5] = 10, [6] = 16, [7] = 10 }, [1] = { [0] = 18, [1] = 12, [2] = 27, [3] = 12, [4] = 24, [5] = 9, [6] = 19, [7] = 8 }, [2] = { [0] = 104, [1] = 117, [2] = 121, [3] = 106, [4] = 118, [5] = 100, [6] = 112, [7] = 104 }, [3] = { [0] = 100, [1] = 111, [2] = 113, [3] = 93, [4] = 106, [5] = 100, [6] = 110, [7] = 109 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 13, [2] = 26, [3] = 18, [4] = 24, [5] = 12, [6] = 25, [7] = 20 }, [1] = { [0] = 113, [1] = 100, [2] = 120, [3] = 114, [4] = 120, [5] = 103, [6] = 120, [7] = 115 }, [2] = { [0] = 108, [1] = 96, [2] = 117, [3] = 111, [4] = 119, [5] = 101, [6] = 123, [7] = 116 }, [3] = { [0] = 10, [1] = 9, [2] = 23, [3] = 10, [4] = 16, [5] = 4, [6] = 20, [7] = 14 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 27, [3] = 22, [4] = 32, [5] = 19, [6] = 25, [7] = 5 }, [1] = { [0] = 18, [1] = 15, [2] = 23, [3] = 18, [4] = 26, [5] = 18, [6] = 28, [7] = 3 }, [2] = { [0] = 104, [1] = 120, [2] = 117, [3] = 112, [4] = 120, [5] = 109, [6] = 121, [7] = 99 }, [3] = { [0] = 100, [1] = 114, [2] = 109, [3] = 99, [4] = 108, [5] = 109, [6] = 119, [7] = 104 } })[R[23]][R[14]], ({ [0] = { [0] = 12, [1] = 10, [2] = 27, [3] = 29, [4] = 15, [5] = 20, [6] = 22, [7] = 17 }, [1] = { [0] = 110, [1] = 97, [2] = 121, [3] = 125, [4] = 111, [5] = 111, [6] = 117, [7] = 112 }, [2] = { [0] = 105, [1] = 93, [2] = 118, [3] = 122, [4] = 110, [5] = 109, [6] = 120, [7] = 113 }, [3] = { [0] = 7, [1] = 6, [2] = 24, [3] = 21, [4] = 7, [5] = 12, [6] = 17, [7] = 11 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 29, [1] = 15, [2] = 13, [3] = 36, [4] = 29, [5] = 11, [6] = 24, [7] = 25 }, [1] = { [0] = 32, [1] = 12, [2] = 9, [3] = 32, [4] = 23, [5] = 10, [6] = 27, [7] = 23 }, [2] = { [0] = 118, [1] = 117, [2] = 103, [3] = 126, [4] = 117, [5] = 101, [6] = 120, [7] = 119 }, [3] = { [0] = 114, [1] = 111, [2] = 95, [3] = 113, [4] = 105, [5] = 101, [6] = 118, [7] = 124 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 19, [2] = 23, [3] = 18, [4] = 28, [5] = 23, [6] = 15, [7] = 14 }, [1] = { [0] = 119, [1] = 106, [2] = 117, [3] = 114, [4] = 124, [5] = 114, [6] = 110, [7] = 109 }, [2] = { [0] = 114, [1] = 102, [2] = 114, [3] = 111, [4] = 123, [5] = 112, [6] = 113, [7] = 110 }, [3] = { [0] = 16, [1] = 15, [2] = 20, [3] = 10, [4] = 20, [5] = 15, [6] = 10, [7] = 8 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 29, [1] = 15, [2] = 13, [3] = 34, [4] = 29, [5] = 11, [6] = 24, [7] = 25 }, [1] = { [0] = 32, [1] = 12, [2] = 9, [3] = 30, [4] = 23, [5] = 10, [6] = 27, [7] = 23 }, [2] = { [0] = 118, [1] = 117, [2] = 103, [3] = 124, [4] = 117, [5] = 101, [6] = 120, [7] = 119 }, [3] = { [0] = 114, [1] = 111, [2] = 95, [3] = 111, [4] = 105, [5] = 101, [6] = 118, [7] = 124 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 19, [2] = 23, [3] = 14, [4] = 28, [5] = 23, [6] = 15, [7] = 14 }, [1] = { [0] = 119, [1] = 106, [2] = 117, [3] = 110, [4] = 124, [5] = 114, [6] = 110, [7] = 109 }, [2] = { [0] = 114, [1] = 102, [2] = 114, [3] = 107, [4] = 123, [5] = 112, [6] = 113, [7] = 110 }, [3] = { [0] = 16, [1] = 15, [2] = 20, [3] = 6, [4] = 20, [5] = 15, [6] = 10, [7] = 8 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 18, [1] = 12, [2] = 31, [3] = 22, [4] = 37, [5] = 23, [6] = 9, [7] = 26 }, [1] = { [0] = 21, [1] = 9, [2] = 27, [3] = 18, [4] = 31, [5] = 22, [6] = 12, [7] = 24 }, [2] = { [0] = 107, [1] = 114, [2] = 121, [3] = 112, [4] = 125, [5] = 113, [6] = 105, [7] = 120 }, [3] = { [0] = 103, [1] = 108, [2] = 113, [3] = 99, [4] = 113, [5] = 113, [6] = 103, [7] = 125 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 19, [2] = 20, [3] = 29, [4] = 20, [5] = 15, [6] = 28, [7] = 22 }, [1] = { [0] = 113, [1] = 106, [2] = 114, [3] = 125, [4] = 116, [5] = 106, [6] = 123, [7] = 117 }, [2] = { [0] = 108, [1] = 102, [2] = 111, [3] = 122, [4] = 115, [5] = 104, [6] = 126, [7] = 118 }, [3] = { [0] = 10, [1] = 15, [2] = 17, [3] = 21, [4] = 12, [5] = 7, [6] = 23, [7] = 16 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 15, [2] = 13, [3] = 22, [4] = 29, [5] = 11, [6] = 24, [7] = 25 }, [1] = { [0] = 32, [1] = 12, [2] = 9, [3] = 18, [4] = 23, [5] = 10, [6] = 27, [7] = 23 }, [2] = { [0] = 118, [1] = 117, [2] = 103, [3] = 112, [4] = 117, [5] = 101, [6] = 120, [7] = 119 }, [3] = { [0] = 114, [1] = 111, [2] = 95, [3] = 99, [4] = 105, [5] = 101, [6] = 118, [7] = 124 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 19, [2] = 23, [3] = 29, [4] = 28, [5] = 23, [6] = 15, [7] = 14 }, [1] = { [0] = 119, [1] = 106, [2] = 117, [3] = 125, [4] = 124, [5] = 114, [6] = 110, [7] = 109 }, [2] = { [0] = 114, [1] = 102, [2] = 114, [3] = 122, [4] = 123, [5] = 112, [6] = 113, [7] = 110 }, [3] = { [0] = 16, [1] = 15, [2] = 20, [3] = 21, [4] = 20, [5] = 15, [6] = 10, [7] = 8 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 15, [1] = 15, [2] = 31, [3] = 16, [4] = 30, [5] = 10, [6] = 16, [7] = 10 }, [1] = { [0] = 18, [1] = 12, [2] = 27, [3] = 12, [4] = 24, [5] = 9, [6] = 19, [7] = 8 }, [2] = { [0] = 104, [1] = 117, [2] = 121, [3] = 106, [4] = 118, [5] = 100, [6] = 112, [7] = 104 }, [3] = { [0] = 100, [1] = 111, [2] = 113, [3] = 93, [4] = 106, [5] = 100, [6] = 110, [7] = 109 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 13, [2] = 26, [3] = 18, [4] = 24, [5] = 12, [6] = 25, [7] = 20 }, [1] = { [0] = 113, [1] = 100, [2] = 120, [3] = 114, [4] = 120, [5] = 103, [6] = 120, [7] = 115 }, [2] = { [0] = 108, [1] = 96, [2] = 117, [3] = 111, [4] = 119, [5] = 101, [6] = 123, [7] = 116 }, [3] = { [0] = 10, [1] = 9, [2] = 23, [3] = 10, [4] = 16, [5] = 4, [6] = 20, [7] = 14 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 27, [3] = 22, [4] = 32, [5] = 19, [6] = 25, [7] = 5 }, [1] = { [0] = 18, [1] = 15, [2] = 23, [3] = 18, [4] = 26, [5] = 18, [6] = 28, [7] = 3 }, [2] = { [0] = 104, [1] = 120, [2] = 117, [3] = 112, [4] = 120, [5] = 109, [6] = 121, [7] = 99 }, [3] = { [0] = 100, [1] = 114, [2] = 109, [3] = 99, [4] = 108, [5] = 109, [6] = 119, [7] = 104 } })[R[23]][R[14]], ({ [0] = { [0] = 12, [1] = 10, [2] = 27, [3] = 29, [4] = 15, [5] = 20, [6] = 22, [7] = 17 }, [1] = { [0] = 110, [1] = 97, [2] = 121, [3] = 125, [4] = 111, [5] = 111, [6] = 117, [7] = 112 }, [2] = { [0] = 105, [1] = 93, [2] = 118, [3] = 122, [4] = 110, [5] = 109, [6] = 120, [7] = 113 }, [3] = { [0] = 7, [1] = 6, [2] = 24, [3] = 21, [4] = 7, [5] = 12, [6] = 17, [7] = 11 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 29, [1] = 15, [2] = 13, [3] = 36, [4] = 29, [5] = 11, [6] = 24, [7] = 25 }, [1] = { [0] = 32, [1] = 12, [2] = 9, [3] = 32, [4] = 23, [5] = 10, [6] = 27, [7] = 23 }, [2] = { [0] = 118, [1] = 117, [2] = 103, [3] = 126, [4] = 117, [5] = 101, [6] = 120, [7] = 119 }, [3] = { [0] = 114, [1] = 111, [2] = 95, [3] = 113, [4] = 105, [5] = 101, [6] = 118, [7] = 124 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 19, [2] = 23, [3] = 18, [4] = 28, [5] = 23, [6] = 15, [7] = 14 }, [1] = { [0] = 119, [1] = 106, [2] = 117, [3] = 114, [4] = 124, [5] = 114, [6] = 110, [7] = 109 }, [2] = { [0] = 114, [1] = 102, [2] = 114, [3] = 111, [4] = 123, [5] = 112, [6] = 113, [7] = 110 }, [3] = { [0] = 16, [1] = 15, [2] = 20, [3] = 10, [4] = 20, [5] = 15, [6] = 10, [7] = 8 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 29, [1] = 15, [2] = 13, [3] = 34, [4] = 29, [5] = 11, [6] = 24, [7] = 25 }, [1] = { [0] = 32, [1] = 12, [2] = 9, [3] = 30, [4] = 23, [5] = 10, [6] = 27, [7] = 23 }, [2] = { [0] = 118, [1] = 117, [2] = 103, [3] = 124, [4] = 117, [5] = 101, [6] = 120, [7] = 119 }, [3] = { [0] = 114, [1] = 111, [2] = 95, [3] = 111, [4] = 105, [5] = 101, [6] = 118, [7] = 124 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 19, [2] = 23, [3] = 14, [4] = 28, [5] = 23, [6] = 15, [7] = 14 }, [1] = { [0] = 119, [1] = 106, [2] = 117, [3] = 110, [4] = 124, [5] = 114, [6] = 110, [7] = 109 }, [2] = { [0] = 114, [1] = 102, [2] = 114, [3] = 107, [4] = 123, [5] = 112, [6] = 113, [7] = 110 }, [3] = { [0] = 16, [1] = 15, [2] = 20, [3] = 6, [4] = 20, [5] = 15, [6] = 10, [7] = 8 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 15, [1] = 15, [2] = 31, [3] = 22, [4] = 30, [5] = 10, [6] = 16, [7] = 10 }, [1] = { [0] = 18, [1] = 12, [2] = 27, [3] = 18, [4] = 24, [5] = 9, [6] = 19, [7] = 8 }, [2] = { [0] = 104, [1] = 117, [2] = 121, [3] = 112, [4] = 118, [5] = 100, [6] = 112, [7] = 104 }, [3] = { [0] = 100, [1] = 111, [2] = 113, [3] = 99, [4] = 106, [5] = 100, [6] = 110, [7] = 109 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 13, [2] = 26, [3] = 29, [4] = 24, [5] = 12, [6] = 25, [7] = 20 }, [1] = { [0] = 113, [1] = 100, [2] = 120, [3] = 125, [4] = 120, [5] = 103, [6] = 120, [7] = 115 }, [2] = { [0] = 108, [1] = 96, [2] = 117, [3] = 122, [4] = 119, [5] = 101, [6] = 123, [7] = 116 }, [3] = { [0] = 10, [1] = 9, [2] = 23, [3] = 21, [4] = 16, [5] = 4, [6] = 20, [7] = 14 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[14]], player = players[2], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 27, [3] = 22, [4] = 32, [5] = 19, [6] = 25, [7] = 5 }, [1] = { [0] = 18, [1] = 15, [2] = 23, [3] = 18, [4] = 26, [5] = 18, [6] = 28, [7] = 3 }, [2] = { [0] = 104, [1] = 120, [2] = 117, [3] = 112, [4] = 120, [5] = 109, [6] = 121, [7] = 99 }, [3] = { [0] = 100, [1] = 114, [2] = 109, [3] = 99, [4] = 108, [5] = 109, [6] = 119, [7] = 104 } })[R[23]][R[14]], ({ [0] = { [0] = 12, [1] = 10, [2] = 27, [3] = 29, [4] = 15, [5] = 20, [6] = 22, [7] = 17 }, [1] = { [0] = 110, [1] = 97, [2] = 121, [3] = 125, [4] = 111, [5] = 111, [6] = 117, [7] = 112 }, [2] = { [0] = 105, [1] = 93, [2] = 118, [3] = 122, [4] = 110, [5] = 109, [6] = 120, [7] = 113 }, [3] = { [0] = 7, [1] = 6, [2] = 24, [3] = 21, [4] = 7, [5] = 12, [6] = 17, [7] = 11 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 21, [2] = 23, [3] = 26, [4] = 38, [5] = 11, [6] = 25, [7] = 19 }, [1] = { [0] = 39, [1] = 18, [2] = 19, [3] = 22, [4] = 32, [5] = 10, [6] = 28, [7] = 17 }, [2] = { [0] = 125, [1] = 123, [2] = 113, [3] = 116, [4] = 126, [5] = 101, [6] = 121, [7] = 113 }, [3] = { [0] = 121, [1] = 117, [2] = 105, [3] = 103, [4] = 114, [5] = 101, [6] = 119, [7] = 118 } })[R[23]][R[14]], ({ [0] = { [0] = 23, [1] = 23, [2] = 20, [3] = 15, [4] = 11, [5] = 29, [6] = 25, [7] = 19 }, [1] = { [0] = 121, [1] = 110, [2] = 114, [3] = 111, [4] = 107, [5] = 120, [6] = 120, [7] = 114 }, [2] = { [0] = 116, [1] = 106, [2] = 111, [3] = 108, [4] = 106, [5] = 118, [6] = 123, [7] = 115 }, [3] = { [0] = 18, [1] = 19, [2] = 17, [3] = 7, [4] = 3, [5] = 21, [6] = 20, [7] = 13 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 15, [2] = 18, [3] = 18, [4] = 25, [5] = 15, [6] = 11, [7] = 8 }, [1] = { [0] = 19, [1] = 12, [2] = 14, [3] = 14, [4] = 19, [5] = 14, [6] = 14, [7] = 6 }, [2] = { [0] = 105, [1] = 117, [2] = 108, [3] = 108, [4] = 113, [5] = 105, [6] = 107, [7] = 102 }, [3] = { [0] = 101, [1] = 111, [2] = 100, [3] = 95, [4] = 101, [5] = 105, [6] = 105, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 18, [3] = 24, [4] = 14, [5] = 18, [6] = 17, [7] = 16 }, [1] = { [0] = 117, [1] = 111, [2] = 112, [3] = 120, [4] = 110, [5] = 109, [6] = 112, [7] = 111 }, [2] = { [0] = 112, [1] = 107, [2] = 109, [3] = 117, [4] = 109, [5] = 107, [6] = 115, [7] = 112 }, [3] = { [0] = 14, [1] = 20, [2] = 15, [3] = 16, [4] = 6, [5] = 10, [6] = 12, [7] = 10 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 16, [2] = 19, [3] = 18, [4] = 25, [5] = 15, [6] = 11, [7] = 8 }, [1] = { [0] = 20, [1] = 13, [2] = 15, [3] = 14, [4] = 19, [5] = 14, [6] = 14, [7] = 6 }, [2] = { [0] = 106, [1] = 118, [2] = 109, [3] = 108, [4] = 113, [5] = 105, [6] = 107, [7] = 102 }, [3] = { [0] = 102, [1] = 112, [2] = 101, [3] = 95, [4] = 101, [5] = 105, [6] = 105, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 18, [3] = 25, [4] = 15, [5] = 19, [6] = 18, [7] = 17 }, [1] = { [0] = 117, [1] = 111, [2] = 112, [3] = 121, [4] = 111, [5] = 110, [6] = 113, [7] = 112 }, [2] = { [0] = 112, [1] = 107, [2] = 109, [3] = 118, [4] = 110, [5] = 108, [6] = 116, [7] = 113 }, [3] = { [0] = 14, [1] = 20, [2] = 15, [3] = 17, [4] = 7, [5] = 11, [6] = 13, [7] = 11 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 17, [2] = 20, [3] = 18, [4] = 25, [5] = 15, [6] = 11, [7] = 8 }, [1] = { [0] = 21, [1] = 14, [2] = 16, [3] = 14, [4] = 19, [5] = 14, [6] = 14, [7] = 6 }, [2] = { [0] = 107, [1] = 119, [2] = 110, [3] = 108, [4] = 113, [5] = 105, [6] = 107, [7] = 102 }, [3] = { [0] = 103, [1] = 113, [2] = 102, [3] = 95, [4] = 101, [5] = 105, [6] = 105, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 18, [3] = 26, [4] = 16, [5] = 20, [6] = 19, [7] = 18 }, [1] = { [0] = 117, [1] = 111, [2] = 112, [3] = 122, [4] = 112, [5] = 111, [6] = 114, [7] = 113 }, [2] = { [0] = 112, [1] = 107, [2] = 109, [3] = 119, [4] = 111, [5] = 109, [6] = 117, [7] = 114 }, [3] = { [0] = 14, [1] = 20, [2] = 15, [3] = 18, [4] = 8, [5] = 12, [6] = 14, [7] = 12 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 18, [2] = 21, [3] = 19, [4] = 25, [5] = 15, [6] = 11, [7] = 8 }, [1] = { [0] = 22, [1] = 15, [2] = 17, [3] = 15, [4] = 19, [5] = 14, [6] = 14, [7] = 6 }, [2] = { [0] = 108, [1] = 120, [2] = 111, [3] = 109, [4] = 113, [5] = 105, [6] = 107, [7] = 102 }, [3] = { [0] = 104, [1] = 114, [2] = 103, [3] = 96, [4] = 101, [5] = 105, [6] = 105, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 15, [3] = 24, [4] = 17, [5] = 24, [6] = 20, [7] = 19 }, [1] = { [0] = 117, [1] = 111, [2] = 109, [3] = 120, [4] = 113, [5] = 115, [6] = 115, [7] = 114 }, [2] = { [0] = 112, [1] = 107, [2] = 106, [3] = 117, [4] = 112, [5] = 113, [6] = 118, [7] = 115 }, [3] = { [0] = 14, [1] = 20, [2] = 12, [3] = 16, [4] = 9, [5] = 16, [6] = 15, [7] = 13 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 19, [2] = 21, [3] = 20, [4] = 25, [5] = 15, [6] = 11, [7] = 8 }, [1] = { [0] = 23, [1] = 16, [2] = 17, [3] = 16, [4] = 19, [5] = 14, [6] = 14, [7] = 6 }, [2] = { [0] = 109, [1] = 121, [2] = 111, [3] = 110, [4] = 113, [5] = 105, [6] = 107, [7] = 102 }, [3] = { [0] = 105, [1] = 115, [2] = 103, [3] = 97, [4] = 101, [5] = 105, [6] = 105, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 16, [3] = 20, [4] = 18, [5] = 25, [6] = 21, [7] = 20 }, [1] = { [0] = 117, [1] = 111, [2] = 110, [3] = 116, [4] = 114, [5] = 116, [6] = 116, [7] = 115 }, [2] = { [0] = 112, [1] = 107, [2] = 107, [3] = 113, [4] = 113, [5] = 114, [6] = 119, [7] = 116 }, [3] = { [0] = 14, [1] = 20, [2] = 13, [3] = 12, [4] = 10, [5] = 17, [6] = 16, [7] = 14 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 20, [2] = 21, [3] = 20, [4] = 25, [5] = 15, [6] = 14, [7] = 8 }, [1] = { [0] = 24, [1] = 17, [2] = 17, [3] = 16, [4] = 19, [5] = 14, [6] = 17, [7] = 6 }, [2] = { [0] = 110, [1] = 122, [2] = 111, [3] = 110, [4] = 113, [5] = 105, [6] = 110, [7] = 102 }, [3] = { [0] = 106, [1] = 116, [2] = 103, [3] = 97, [4] = 101, [5] = 105, [6] = 108, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 17, [3] = 21, [4] = 22, [5] = 26, [6] = 15, [7] = 21 }, [1] = { [0] = 117, [1] = 111, [2] = 111, [3] = 117, [4] = 118, [5] = 117, [6] = 110, [7] = 116 }, [2] = { [0] = 112, [1] = 107, [2] = 108, [3] = 114, [4] = 117, [5] = 115, [6] = 113, [7] = 117 }, [3] = { [0] = 14, [1] = 20, [2] = 14, [3] = 13, [4] = 14, [5] = 18, [6] = 10, [7] = 15 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 21, [2] = 21, [3] = 20, [4] = 25, [5] = 18, [6] = 15, [7] = 8 }, [1] = { [0] = 25, [1] = 18, [2] = 17, [3] = 16, [4] = 19, [5] = 17, [6] = 18, [7] = 6 }, [2] = { [0] = 111, [1] = 123, [2] = 111, [3] = 110, [4] = 113, [5] = 108, [6] = 111, [7] = 102 }, [3] = { [0] = 107, [1] = 117, [2] = 103, [3] = 97, [4] = 101, [5] = 108, [6] = 109, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 18, [3] = 22, [4] = 23, [5] = 22, [6] = 15, [7] = 22 }, [1] = { [0] = 117, [1] = 111, [2] = 112, [3] = 118, [4] = 119, [5] = 113, [6] = 110, [7] = 117 }, [2] = { [0] = 112, [1] = 107, [2] = 109, [3] = 115, [4] = 118, [5] = 111, [6] = 113, [7] = 118 }, [3] = { [0] = 14, [1] = 20, [2] = 15, [3] = 14, [4] = 15, [5] = 14, [6] = 10, [7] = 16 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 22, [2] = 21, [3] = 20, [4] = 25, [5] = 18, [6] = 15, [7] = 8 }, [1] = { [0] = 27, [1] = 19, [2] = 17, [3] = 16, [4] = 19, [5] = 17, [6] = 18, [7] = 6 }, [2] = { [0] = 113, [1] = 124, [2] = 111, [3] = 110, [4] = 113, [5] = 108, [6] = 111, [7] = 102 }, [3] = { [0] = 109, [1] = 118, [2] = 103, [3] = 97, [4] = 101, [5] = 108, [6] = 109, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 14, [1] = 13, [2] = 19, [3] = 23, [4] = 24, [5] = 28, [6] = 23, [7] = 23 }, [1] = { [0] = 112, [1] = 100, [2] = 113, [3] = 119, [4] = 120, [5] = 119, [6] = 118, [7] = 118 }, [2] = { [0] = 107, [1] = 96, [2] = 110, [3] = 116, [4] = 119, [5] = 117, [6] = 121, [7] = 119 }, [3] = { [0] = 9, [1] = 9, [2] = 16, [3] = 15, [4] = 16, [5] = 20, [6] = 18, [7] = 17 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 22, [2] = 21, [3] = 20, [4] = 25, [5] = 19, [6] = 16, [7] = 8 }, [1] = { [0] = 27, [1] = 19, [2] = 17, [3] = 16, [4] = 19, [5] = 18, [6] = 19, [7] = 6 }, [2] = { [0] = 113, [1] = 124, [2] = 111, [3] = 110, [4] = 113, [5] = 109, [6] = 112, [7] = 102 }, [3] = { [0] = 109, [1] = 118, [2] = 103, [3] = 97, [4] = 101, [5] = 109, [6] = 110, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 14, [2] = 20, [3] = 24, [4] = 25, [5] = 22, [6] = 15, [7] = 24 }, [1] = { [0] = 113, [1] = 101, [2] = 114, [3] = 120, [4] = 121, [5] = 113, [6] = 110, [7] = 119 }, [2] = { [0] = 108, [1] = 97, [2] = 111, [3] = 117, [4] = 120, [5] = 111, [6] = 113, [7] = 120 }, [3] = { [0] = 10, [1] = 10, [2] = 17, [3] = 16, [4] = 17, [5] = 14, [6] = 10, [7] = 18 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 22, [2] = 21, [3] = 21, [4] = 25, [5] = 19, [6] = 16, [7] = 11 }, [1] = { [0] = 27, [1] = 19, [2] = 17, [3] = 17, [4] = 19, [5] = 18, [6] = 19, [7] = 9 }, [2] = { [0] = 113, [1] = 124, [2] = 111, [3] = 111, [4] = 113, [5] = 109, [6] = 112, [7] = 105 }, [3] = { [0] = 109, [1] = 118, [2] = 103, [3] = 98, [4] = 101, [5] = 109, [6] = 110, [7] = 110 } })[R[23]][R[14]], ({ [0] = { [0] = 16, [1] = 15, [2] = 21, [3] = 20, [4] = 26, [5] = 28, [6] = 23, [7] = 13 }, [1] = { [0] = 114, [1] = 102, [2] = 115, [3] = 116, [4] = 122, [5] = 119, [6] = 118, [7] = 108 }, [2] = { [0] = 109, [1] = 98, [2] = 112, [3] = 113, [4] = 121, [5] = 117, [6] = 121, [7] = 109 }, [3] = { [0] = 11, [1] = 11, [2] = 18, [3] = 12, [4] = 18, [5] = 20, [6] = 18, [7] = 7 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 22, [2] = 21, [3] = 21, [4] = 28, [5] = 20, [6] = 17, [7] = 11 }, [1] = { [0] = 27, [1] = 19, [2] = 17, [3] = 17, [4] = 22, [5] = 19, [6] = 20, [7] = 9 }, [2] = { [0] = 113, [1] = 124, [2] = 111, [3] = 111, [4] = 116, [5] = 110, [6] = 113, [7] = 105 }, [3] = { [0] = 109, [1] = 118, [2] = 103, [3] = 98, [4] = 104, [5] = 110, [6] = 111, [7] = 110 } })[R[23]][R[14]], ({ [0] = { [0] = 17, [1] = 16, [2] = 22, [3] = 24, [4] = 12, [5] = 22, [6] = 15, [7] = 26 }, [1] = { [0] = 115, [1] = 103, [2] = 116, [3] = 120, [4] = 108, [5] = 113, [6] = 110, [7] = 121 }, [2] = { [0] = 110, [1] = 99, [2] = 113, [3] = 117, [4] = 107, [5] = 111, [6] = 113, [7] = 122 }, [3] = { [0] = 12, [1] = 12, [2] = 19, [3] = 16, [4] = 4, [5] = 14, [6] = 10, [7] = 20 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 22, [2] = 21, [3] = 22, [4] = 28, [5] = 20, [6] = 17, [7] = 12 }, [1] = { [0] = 27, [1] = 19, [2] = 17, [3] = 18, [4] = 22, [5] = 19, [6] = 20, [7] = 10 }, [2] = { [0] = 113, [1] = 124, [2] = 111, [3] = 112, [4] = 116, [5] = 110, [6] = 113, [7] = 106 }, [3] = { [0] = 109, [1] = 118, [2] = 103, [3] = 99, [4] = 104, [5] = 110, [6] = 111, [7] = 111 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 24, [2] = 23, [3] = 24, [4] = 20, [5] = 28, [6] = 23, [7] = 13 }, [1] = { [0] = 119, [1] = 111, [2] = 117, [3] = 120, [4] = 116, [5] = 119, [6] = 118, [7] = 108 }, [2] = { [0] = 114, [1] = 107, [2] = 114, [3] = 117, [4] = 115, [5] = 117, [6] = 121, [7] = 109 }, [3] = { [0] = 16, [1] = 20, [2] = 20, [3] = 16, [4] = 12, [5] = 20, [6] = 18, [7] = 7 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 23, [2] = 21, [3] = 23, [4] = 28, [5] = 21, [6] = 18, [7] = 12 }, [1] = { [0] = 27, [1] = 20, [2] = 17, [3] = 19, [4] = 22, [5] = 20, [6] = 21, [7] = 10 }, [2] = { [0] = 113, [1] = 125, [2] = 111, [3] = 113, [4] = 116, [5] = 111, [6] = 114, [7] = 106 }, [3] = { [0] = 109, [1] = 119, [2] = 103, [3] = 100, [4] = 104, [5] = 111, [6] = 112, [7] = 111 } })[R[23]][R[14]], ({ [0] = { [0] = 22, [1] = 21, [2] = 24, [3] = 24, [4] = 28, [5] = 22, [6] = 15, [7] = 26 }, [1] = { [0] = 120, [1] = 108, [2] = 118, [3] = 120, [4] = 124, [5] = 113, [6] = 110, [7] = 121 }, [2] = { [0] = 115, [1] = 104, [2] = 115, [3] = 117, [4] = 123, [5] = 111, [6] = 113, [7] = 122 }, [3] = { [0] = 17, [1] = 17, [2] = 21, [3] = 16, [4] = 20, [5] = 14, [6] = 10, [7] = 20 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 23, [2] = 22, [3] = 24, [4] = 29, [5] = 21, [6] = 18, [7] = 13 }, [1] = { [0] = 27, [1] = 20, [2] = 18, [3] = 20, [4] = 23, [5] = 20, [6] = 21, [7] = 11 }, [2] = { [0] = 113, [1] = 125, [2] = 112, [3] = 114, [4] = 117, [5] = 111, [6] = 114, [7] = 107 }, [3] = { [0] = 109, [1] = 119, [2] = 104, [3] = 101, [4] = 105, [5] = 111, [6] = 112, [7] = 112 } })[R[23]][R[14]], ({ [0] = { [0] = 23, [1] = 22, [2] = 18, [3] = 17, [4] = 12, [5] = 28, [6] = 23, [7] = 13 }, [1] = { [0] = 121, [1] = 109, [2] = 112, [3] = 113, [4] = 108, [5] = 119, [6] = 118, [7] = 108 }, [2] = { [0] = 116, [1] = 105, [2] = 109, [3] = 110, [4] = 107, [5] = 117, [6] = 121, [7] = 109 }, [3] = { [0] = 18, [1] = 18, [2] = 15, [3] = 9, [4] = 4, [5] = 20, [6] = 18, [7] = 7 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 23, [2] = 22, [3] = 24, [4] = 29, [5] = 22, [6] = 20, [7] = 13 }, [1] = { [0] = 27, [1] = 20, [2] = 18, [3] = 20, [4] = 23, [5] = 21, [6] = 23, [7] = 11 }, [2] = { [0] = 113, [1] = 125, [2] = 112, [3] = 114, [4] = 117, [5] = 112, [6] = 116, [7] = 107 }, [3] = { [0] = 109, [1] = 119, [2] = 104, [3] = 101, [4] = 105, [5] = 112, [6] = 114, [7] = 112 } })[R[23]][R[14]], ({ [0] = { [0] = 24, [1] = 23, [2] = 24, [3] = 24, [4] = 20, [5] = 22, [6] = 17, [7] = 26 }, [1] = { [0] = 122, [1] = 110, [2] = 118, [3] = 120, [4] = 116, [5] = 113, [6] = 112, [7] = 121 }, [2] = { [0] = 117, [1] = 106, [2] = 115, [3] = 117, [4] = 115, [5] = 111, [6] = 115, [7] = 122 }, [3] = { [0] = 19, [1] = 19, [2] = 21, [3] = 16, [4] = 12, [5] = 14, [6] = 12, [7] = 20 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 23, [2] = 23, [3] = 25, [4] = 29, [5] = 22, [6] = 20, [7] = 14 }, [1] = { [0] = 30, [1] = 20, [2] = 19, [3] = 21, [4] = 23, [5] = 21, [6] = 23, [7] = 12 }, [2] = { [0] = 116, [1] = 125, [2] = 113, [3] = 115, [4] = 117, [5] = 112, [6] = 116, [7] = 108 }, [3] = { [0] = 112, [1] = 119, [2] = 105, [3] = 102, [4] = 105, [5] = 112, [6] = 114, [7] = 113 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 18, [3] = 17, [4] = 28, [5] = 28, [6] = 18, [7] = 13 }, [1] = { [0] = 117, [1] = 111, [2] = 112, [3] = 113, [4] = 124, [5] = 119, [6] = 113, [7] = 108 }, [2] = { [0] = 112, [1] = 107, [2] = 109, [3] = 110, [4] = 123, [5] = 117, [6] = 116, [7] = 109 }, [3] = { [0] = 14, [1] = 20, [2] = 15, [3] = 9, [4] = 20, [5] = 20, [6] = 13, [7] = 7 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 23, [2] = 23, [3] = 26, [4] = 30, [5] = 23, [6] = 20, [7] = 14 }, [1] = { [0] = 31, [1] = 20, [2] = 19, [3] = 22, [4] = 24, [5] = 22, [6] = 23, [7] = 12 }, [2] = { [0] = 117, [1] = 125, [2] = 113, [3] = 116, [4] = 118, [5] = 113, [6] = 116, [7] = 108 }, [3] = { [0] = 113, [1] = 119, [2] = 105, [3] = 103, [4] = 106, [5] = 113, [6] = 114, [7] = 113 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 25, [2] = 24, [3] = 17, [4] = 12, [5] = 22, [6] = 19, [7] = 26 }, [1] = { [0] = 117, [1] = 112, [2] = 118, [3] = 113, [4] = 108, [5] = 113, [6] = 114, [7] = 121 }, [2] = { [0] = 112, [1] = 108, [2] = 115, [3] = 110, [4] = 107, [5] = 111, [6] = 117, [7] = 122 }, [3] = { [0] = 14, [1] = 21, [2] = 21, [3] = 9, [4] = 4, [5] = 14, [6] = 14, [7] = 20 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 23, [2] = 24, [3] = 27, [4] = 30, [5] = 24, [6] = 20, [7] = 15 }, [1] = { [0] = 32, [1] = 20, [2] = 20, [3] = 23, [4] = 24, [5] = 23, [6] = 23, [7] = 13 }, [2] = { [0] = 118, [1] = 125, [2] = 114, [3] = 117, [4] = 118, [5] = 114, [6] = 116, [7] = 109 }, [3] = { [0] = 114, [1] = 119, [2] = 106, [3] = 104, [4] = 106, [5] = 114, [6] = 114, [7] = 114 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 26, [2] = 18, [3] = 17, [4] = 13, [5] = 22, [6] = 20, [7] = 13 }, [1] = { [0] = 117, [1] = 113, [2] = 112, [3] = 113, [4] = 109, [5] = 113, [6] = 115, [7] = 108 }, [2] = { [0] = 112, [1] = 109, [2] = 109, [3] = 110, [4] = 108, [5] = 111, [6] = 118, [7] = 109 }, [3] = { [0] = 14, [1] = 22, [2] = 15, [3] = 9, [4] = 5, [5] = 14, [6] = 15, [7] = 7 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 23, [2] = 24, [3] = 28, [4] = 30, [5] = 25, [6] = 20, [7] = 15 }, [1] = { [0] = 33, [1] = 20, [2] = 20, [3] = 24, [4] = 24, [5] = 24, [6] = 23, [7] = 13 }, [2] = { [0] = 119, [1] = 125, [2] = 114, [3] = 118, [4] = 118, [5] = 115, [6] = 116, [7] = 109 }, [3] = { [0] = 115, [1] = 119, [2] = 106, [3] = 105, [4] = 106, [5] = 115, [6] = 114, [7] = 114 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 31, [2] = 24, [3] = 17, [4] = 20, [5] = 22, [6] = 21, [7] = 14 }, [1] = { [0] = 117, [1] = 118, [2] = 118, [3] = 113, [4] = 116, [5] = 113, [6] = 116, [7] = 109 }, [2] = { [0] = 112, [1] = 114, [2] = 115, [3] = 110, [4] = 115, [5] = 111, [6] = 119, [7] = 110 }, [3] = { [0] = 14, [1] = 27, [2] = 21, [3] = 9, [4] = 12, [5] = 14, [6] = 16, [7] = 8 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 23, [2] = 25, [3] = 29, [4] = 30, [5] = 25, [6] = 24, [7] = 15 }, [1] = { [0] = 34, [1] = 20, [2] = 21, [3] = 25, [4] = 24, [5] = 24, [6] = 27, [7] = 13 }, [2] = { [0] = 120, [1] = 125, [2] = 115, [3] = 119, [4] = 118, [5] = 115, [6] = 120, [7] = 109 }, [3] = { [0] = 116, [1] = 119, [2] = 107, [3] = 106, [4] = 106, [5] = 115, [6] = 118, [7] = 114 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 32, [2] = 18, [3] = 17, [4] = 28, [5] = 23, [6] = 23, [7] = 15 }, [1] = { [0] = 117, [1] = 119, [2] = 112, [3] = 113, [4] = 124, [5] = 114, [6] = 118, [7] = 110 }, [2] = { [0] = 112, [1] = 115, [2] = 109, [3] = 110, [4] = 123, [5] = 112, [6] = 121, [7] = 111 }, [3] = { [0] = 14, [1] = 28, [2] = 15, [3] = 9, [4] = 20, [5] = 15, [6] = 18, [7] = 9 } })[R[23]][R[14]] })
    if R[14] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[23]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[23]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[23]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[23]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[23]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [2] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 } })[R[33]][R[23]], ({ [0] = { [0] = 13, [1] = 111, [2] = 106, [3] = 8 }, [1] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [2] = { [0] = 25, [1] = 123, [2] = 118, [3] = 20 } })[R[33]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[23]] })
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 11, [2] = 116, [3] = 110 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 } })[R[34]][R[23]], ({ [0] = { [0] = 28, [1] = 115, [2] = 111, [3] = 24 }, [1] = { [0] = 30, [1] = 117, [2] = 113, [3] = 26 }, [2] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 } })[R[34]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[35] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 12, [2] = 106, [3] = 98 }, [1] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [2] = { [0] = 34, [1] = 30, [2] = 124, [3] = 116 } })[R[35]][R[23]], ({ [0] = { [0] = 12, [1] = 106, [2] = 103, [3] = 9 }, [1] = { [0] = 28, [1] = 122, [2] = 119, [3] = 25 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 } })[R[35]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[23]] })
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [1] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 92 } })[R[36]][R[23]], ({ [0] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [1] = { [0] = 27, [1] = 123, [2] = 120, [3] = 19 }, [2] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 } })[R[36]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
        for i = 1, game.initial_units() do
          R[37] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [1] = { [0] = 20, [1] = 14, [2] = 108, [3] = 96 }, [2] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 } })[R[37]][R[23]], ({ [0] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [1] = { [0] = 19, [1] = 115, [2] = 114, [3] = 11 }, [2] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 } })[R[37]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[23]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[23]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[23]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[23]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[23]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [1] = { [0] = 4, [1] = 3, [2] = 94, [3] = 94 }, [2] = { [0] = 26, [1] = 25, [2] = 116, [3] = 116 } })[R[38]][R[23]], ({ [0] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 }, [1] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [2] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 } })[R[38]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 6, [1] = 9, [2] = 102, [3] = 100 }, [1] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [2] = { [0] = 32, [1] = 35, [2] = 128, [3] = 126 } })[R[39]][R[23]], ({ [0] = { [0] = 13, [1] = 108, [2] = 111, [3] = 8 }, [1] = { [0] = 11, [1] = 106, [2] = 109, [3] = 6 }, [2] = { [0] = 26, [1] = 121, [2] = 124, [3] = 21 } })[R[39]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[23]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 }, [1] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 }, [2] = { [0] = 7, [1] = 5, [2] = 101, [3] = 106 } })[R[40]][R[23]], ({ [0] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [1] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [2] = { [0] = 30, [1] = 125, [2] = 126, [3] = 24 } })[R[40]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[23]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[14]", R[14])
    end
    R[41] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[41]][R[24]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 97 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 11, [1] = 98, [2] = 94, [3] = 7 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    if R[41] == 0 or R[41] == 1 or R[41] == 2 or R[41] == 5 or R[41] == 6 or R[41] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 21, [1] = 24, [2] = 117, [3] = 115 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 18, [1] = 105, [2] = 101, [3] = 14 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 27, [1] = 118, [2] = 116, [3] = 19 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      if R[41] == 0 then
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
      elseif R[41] == 1 then
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
      elseif R[41] == 2 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[24]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[24]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[24]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[41] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[24]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[24]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[24]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[41] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[41] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[41]", R[41])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = { [0] = 13, [1] = 16, [2] = 102, [3] = 98 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 12, [1] = 15, [2] = 108, [3] = 106 }, [7] = { [0] = 24, [1] = 22, [2] = 118, [3] = 123 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 28, [1] = 115, [2] = 111, [3] = 24 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 25, [1] = 120, [2] = 121, [3] = 19 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      if R[41] == 2 or R[41] == 5 or R[41] == 6 or R[41] == 7 then
      elseif R[41] == 0 or R[41] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 } })[R[41]][R[24]], ({ [0] = { [0] = 26, [1] = 124, [2] = 119, [3] = 21 }, [1] = { [0] = 36, [1] = 123, [2] = 119, [3] = 32 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[41]", R[41])
      end
    elseif R[41] == 3 or R[41] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 } })[R[41]][R[24]], ({ [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      if R[41] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 21, [1] = 17, [2] = 111, [3] = 98 })[R[24]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[41] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[41]", R[41])
      end
    else
      unseen("R[41]", R[41])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 13, [1] = 16, [2] = 102, [3] = 98 }, [1] = { [0] = 13, [1] = 10, [2] = 115, [3] = 109 }, [2] = { [0] = 35, [1] = 31, [2] = 125, [3] = 117 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 17, [1] = 11, [2] = 105, [3] = 93 }, [5] = { [0] = 5, [1] = 4, [2] = 95, [3] = 95 }, [6] = { [0] = 4, [1] = 7, [2] = 100, [3] = 98 }, [7] = { [0] = 16, [1] = 14, [2] = 110, [3] = 115 } })[R[41]][R[24]], ({ [0] = { [0] = 28, [1] = 126, [2] = 121, [3] = 23 }, [1] = { [0] = 33, [1] = 120, [2] = 116, [3] = 29 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 11, [1] = 107, [2] = 104, [3] = 3 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 29, [1] = 124, [2] = 125, [3] = 23 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 35, [1] = 29, [2] = 123, [3] = 111 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 13, [1] = 104, [2] = 102, [3] = 5 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 17, [1] = 104, [2] = 100, [3] = 13 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 36, [1] = 32, [2] = 126, [3] = 113 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 10, [1] = 9, [2] = 100, [3] = 100 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 10, [1] = 8, [2] = 104, [3] = 109 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 26, [1] = 120, [2] = 117, [3] = 23 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 12, [1] = 103, [2] = 101, [3] = 4 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 32, [1] = 26, [2] = 120, [3] = 108 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 5, [1] = 3, [2] = 99, [3] = 104 } })[R[41]][R[24]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 10, [1] = 97, [2] = 93, [3] = 6 }, [2] = { [0] = 27, [1] = 121, [2] = 118, [3] = 24 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 22, [1] = 117, [2] = 120, [3] = 17 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 36, [1] = 32, [2] = 126, [3] = 113 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 10, [1] = 9, [2] = 100, [3] = 100 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 10, [1] = 8, [2] = 104, [3] = 109 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 26, [1] = 120, [2] = 117, [3] = 23 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 12, [1] = 103, [2] = 101, [3] = 4 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 32, [1] = 26, [2] = 120, [3] = 108 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 5, [1] = 3, [2] = 99, [3] = 104 } })[R[41]][R[24]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 10, [1] = 97, [2] = 93, [3] = 6 }, [2] = { [0] = 27, [1] = 121, [2] = 118, [3] = 24 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 22, [1] = 117, [2] = 120, [3] = 17 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 36, [1] = 32, [2] = 126, [3] = 113 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 10, [1] = 9, [2] = 100, [3] = 100 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 10, [1] = 8, [2] = 104, [3] = 109 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 26, [1] = 120, [2] = 117, [3] = 23 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 12, [1] = 103, [2] = 101, [3] = 4 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[41]], player = players[3], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 32, [1] = 26, [2] = 120, [3] = 108 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 5, [1] = 3, [2] = 99, [3] = 104 } })[R[41]][R[24]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 10, [1] = 97, [2] = 93, [3] = 6 }, [2] = { [0] = 27, [1] = 121, [2] = 118, [3] = 24 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 22, [1] = 117, [2] = 120, [3] = 17 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 38, [1] = 32, [2] = 126, [3] = 114 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 } })[R[41]][R[24]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 15, [1] = 111, [2] = 108, [3] = 7 }, [4] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [5] = { [0] = 29, [1] = 120, [2] = 118, [3] = 21 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 19, [2] = 105, [3] = 101 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 }, [5] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 16, [1] = 111, [2] = 112, [3] = 10 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 19, [1] = 15, [2] = 109, [3] = 101 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 25, [1] = 121, [2] = 118, [3] = 17 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 19, [1] = 110, [2] = 108, [3] = 11 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 17, [1] = 14, [2] = 119, [3] = 113 }, [2] = { [0] = 20, [1] = 16, [2] = 110, [3] = 102 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 26, [1] = 122, [2] = 119, [3] = 18 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 18, [1] = 113, [2] = 114, [3] = 12 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 22, [2] = 108, [3] = 104 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 15, [1] = 109, [2] = 106, [3] = 12 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 17, [1] = 113, [2] = 112, [3] = 9 }, [5] = { [0] = 24, [1] = 115, [2] = 113, [3] = 16 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 19, [1] = 16, [2] = 121, [3] = 115 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 16, [1] = 110, [2] = 107, [3] = 13 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 114, [2] = 113, [3] = 10 }, [5] = { [0] = 25, [1] = 116, [2] = 114, [3] = 17 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 24, [2] = 110, [3] = 106 }, [1] = { [0] = 20, [1] = 17, [2] = 122, [3] = 116 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 14, [1] = 17, [2] = 110, [3] = 108 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 17, [1] = 111, [2] = 108, [3] = 14 }, [3] = { [0] = 21, [1] = 117, [2] = 114, [3] = 13 }, [4] = { [0] = 22, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 26, [1] = 117, [2] = 115, [3] = 18 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 21, [1] = 116, [2] = 117, [3] = 15 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 25, [2] = 111, [3] = 107 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 22, [1] = 118, [2] = 115, [3] = 14 }, [4] = { [0] = 23, [1] = 119, [2] = 118, [3] = 15 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 14, [1] = 112, [2] = 107, [3] = 9 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 19, [1] = 113, [2] = 110, [3] = 16 }, [3] = { [0] = 23, [1] = 119, [2] = 116, [3] = 15 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 23, [1] = 118, [2] = 119, [3] = 17 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 14, [1] = 101, [2] = 97, [3] = 10 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 25, [1] = 121, [2] = 120, [3] = 17 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 24, [1] = 119, [2] = 120, [3] = 18 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[41]][R[24]], ({ [0] = { [0] = 16, [1] = 114, [2] = 109, [3] = 11 }, [1] = { [0] = 15, [1] = 102, [2] = 98, [3] = 11 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 26, [1] = 122, [2] = 121, [3] = 18 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[41]][R[24]], ({ [0] = { [0] = 17, [1] = 115, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 103, [2] = 99, [3] = 12 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 23, [1] = 19, [2] = 113, [3] = 100 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[41]][R[24]], ({ [0] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [1] = { [0] = 21, [1] = 108, [2] = 104, [3] = 17 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[41]][R[24]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[41]][R[24]], ({ [0] = { [0] = 24, [1] = 122, [2] = 117, [3] = 19 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 30, [2] = 116, [3] = 112 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 25, [1] = 21, [2] = 115, [3] = 102 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 31, [2] = 117, [3] = 113 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 25, [1] = 112, [2] = 108, [3] = 21 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 24, [1] = 23, [2] = 114, [3] = 114 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 26, [1] = 113, [2] = 109, [3] = 22 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 13, [1] = 109, [2] = 108, [3] = 5 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 31, [1] = 118, [2] = 114, [3] = 27 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 34, [2] = 120, [3] = 116 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 25, [1] = 21, [2] = 115, [3] = 107 }, [3] = { [0] = 29, [1] = 25, [2] = 119, [3] = 106 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 32, [1] = 119, [2] = 115, [3] = 28 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 15, [1] = 110, [2] = 111, [3] = 9 } })[R[41]][R[24]] })
    if R[41] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[24]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[24]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[24]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[24]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[24]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [2] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 } })[R[42]][R[24]], ({ [0] = { [0] = 13, [1] = 111, [2] = 106, [3] = 8 }, [1] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [2] = { [0] = 25, [1] = 123, [2] = 118, [3] = 20 } })[R[42]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[24]] })
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 11, [2] = 116, [3] = 110 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 } })[R[43]][R[24]], ({ [0] = { [0] = 28, [1] = 115, [2] = 111, [3] = 24 }, [1] = { [0] = 30, [1] = 117, [2] = 113, [3] = 26 }, [2] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 } })[R[43]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 16, [1] = 12, [2] = 106, [3] = 98 }, [1] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [2] = { [0] = 34, [1] = 30, [2] = 124, [3] = 116 } })[R[44]][R[24]], ({ [0] = { [0] = 12, [1] = 106, [2] = 103, [3] = 9 }, [1] = { [0] = 28, [1] = 122, [2] = 119, [3] = 25 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 } })[R[44]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[24]] })
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [1] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 92 } })[R[45]][R[24]], ({ [0] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [1] = { [0] = 27, [1] = 123, [2] = 120, [3] = 19 }, [2] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 } })[R[45]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
        for i = 1, game.initial_units() do
          R[46] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [1] = { [0] = 20, [1] = 14, [2] = 108, [3] = 96 }, [2] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 } })[R[46]][R[24]], ({ [0] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [1] = { [0] = 19, [1] = 115, [2] = 114, [3] = 11 }, [2] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 } })[R[46]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[24]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[24]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[24]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[24]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[24]] })
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [1] = { [0] = 4, [1] = 3, [2] = 94, [3] = 94 }, [2] = { [0] = 26, [1] = 25, [2] = 116, [3] = 116 } })[R[47]][R[24]], ({ [0] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 }, [1] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [2] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 } })[R[47]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 6, [1] = 9, [2] = 102, [3] = 100 }, [1] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [2] = { [0] = 32, [1] = 35, [2] = 128, [3] = 126 } })[R[48]][R[24]], ({ [0] = { [0] = 13, [1] = 108, [2] = 111, [3] = 8 }, [1] = { [0] = 11, [1] = 106, [2] = 109, [3] = 6 }, [2] = { [0] = 26, [1] = 121, [2] = 124, [3] = 21 } })[R[48]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[24]] })
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 }, [1] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 }, [2] = { [0] = 7, [1] = 5, [2] = 101, [3] = 106 } })[R[49]][R[24]], ({ [0] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [1] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [2] = { [0] = 30, [1] = 125, [2] = 126, [3] = 24 } })[R[49]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[41]", R[41])
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 39, 98 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 45, 48 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 98, 37 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 92, 90 } }
    pick(16, 4, { 0, 1, 2, 3 })
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 35, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 47, 89 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 101 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 68, 81 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 46, 64 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 84, 84 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 68 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 82, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 95, 73 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 62, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 52 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 87, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 106, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 74, 46 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 70, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 62, 11 } }
    pick(4, 4, { 4, 23, 24, 50 })
    R[5] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 97 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 11, [1] = 98, [2] = 94, [3] = 7 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    if R[5] == 0 or R[5] == 1 or R[5] == 2 or R[5] == 5 or R[5] == 6 or R[5] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 21, [1] = 24, [2] = 117, [3] = 115 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 18, [1] = 105, [2] = 101, [3] = 14 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 27, [1] = 118, [2] = 116, [3] = 19 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[5] == 0 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[5] == 1 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[5] == 2 then
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
      elseif R[5] == 5 then
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
      elseif R[5] == 6 then
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
      elseif R[5] == 7 then
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
        unseen("R[5]", R[5])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 29, [1] = 32, [2] = 125, [3] = 123 }, [7] = { [0] = 23, [1] = 21, [2] = 117, [3] = 122 } })[R[5]][R[4]], ({ [0] = { [0] = 26, [1] = 124, [2] = 119, [3] = 21 }, [1] = { [0] = 36, [1] = 123, [2] = 119, [3] = 32 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[5] == 0 or R[5] == 1 then
      elseif R[5] == 2 or R[5] == 5 or R[5] == 6 or R[5] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 12, [1] = 15, [2] = 108, [3] = 106 }, [7] = { [0] = 24, [1] = 22, [2] = 118, [3] = 123 } })[R[5]][R[4]], ({ [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 25, [1] = 120, [2] = 121, [3] = 19 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[5]", R[5])
      end
    elseif R[5] == 3 or R[5] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 } })[R[5]][R[4]], ({ [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
      if R[5] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[5] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 21, [1] = 17, [2] = 111, [3] = 98 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[5]", R[5])
      end
    else
      unseen("R[5]", R[5])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 16, [2] = 102, [3] = 98 }, [1] = { [0] = 13, [1] = 10, [2] = 115, [3] = 109 }, [2] = { [0] = 35, [1] = 31, [2] = 125, [3] = 117 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 17, [1] = 11, [2] = 105, [3] = 93 }, [5] = { [0] = 5, [1] = 4, [2] = 95, [3] = 95 }, [6] = { [0] = 4, [1] = 7, [2] = 100, [3] = 98 }, [7] = { [0] = 16, [1] = 14, [2] = 110, [3] = 115 } })[R[5]][R[4]], ({ [0] = { [0] = 28, [1] = 126, [2] = 121, [3] = 23 }, [1] = { [0] = 33, [1] = 120, [2] = 116, [3] = 29 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 11, [1] = 107, [2] = 104, [3] = 3 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 29, [1] = 124, [2] = 125, [3] = 23 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 35, [1] = 29, [2] = 123, [3] = 111 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[5]][R[4]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 13, [1] = 104, [2] = 102, [3] = 5 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[5]][R[4]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 17, [1] = 104, [2] = 100, [3] = 13 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[5] == 0 or R[5] == 1 or R[5] == 2 or R[5] == 4 or R[5] == 5 or R[5] == 6 or R[5] == 7 then
    elseif R[5] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 36, [1] = 32, [2] = 126, [3] = 113 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 107, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    else
      unseen("R[5]", R[5])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[5]][R[4]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[5]][R[4]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[5] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 32, [2] = 118, [3] = 114 })[R[4]], ({ [0] = 21, [1] = 119, [2] = 114, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 32, [2] = 118, [3] = 114 })[R[4]], ({ [0] = 21, [1] = 119, [2] = 114, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[4]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[4]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[4]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[4]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 9, [2] = 103, [3] = 95 })[R[4]], ({ [0] = 23, [1] = 117, [2] = 114, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 9, [2] = 103, [3] = 95 })[R[4]], ({ [0] = 23, [1] = 117, [2] = 114, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[4]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[4]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 3 then
      if LEVEL_OF[players[1].difficulty] == 2 then
      elseif LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[4]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 23, [2] = 117, [3] = 105 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 29, [1] = 23, [2] = 117, [3] = 105 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[4]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[4]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 10, [2] = 101, [3] = 101 })[R[4]], ({ [0] = 23, [1] = 114, [2] = 112, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[4]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 11, [1] = 10, [2] = 101, [3] = 101 })[R[4]], ({ [0] = 23, [1] = 114, [2] = 112, [3] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[4]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[4]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[4]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 120, [3] = 118 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 113, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[4]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 24, [1] = 27, [2] = 120, [3] = 118 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 113, [3] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[5] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 23, [2] = 119, [3] = 124 })[R[4]], ({ [0] = 14, [1] = 109, [2] = 110, [3] = 8 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 23, [2] = 119, [3] = 124 })[R[4]], ({ [0] = 14, [1] = 109, [2] = 110, [3] = 8 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[5]", R[5])
    end
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 38, [1] = 32, [2] = 126, [3] = 114 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 } })[R[5]][R[4]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 15, [1] = 111, [2] = 108, [3] = 7 }, [4] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [5] = { [0] = 29, [1] = 120, [2] = 118, [3] = 21 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[5]][R[4]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 19, [2] = 105, [3] = 101 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 }, [5] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 16, [1] = 111, [2] = 112, [3] = 10 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 19, [1] = 15, [2] = 109, [3] = 101 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 25, [1] = 121, [2] = 118, [3] = 17 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 19, [1] = 110, [2] = 108, [3] = 11 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 17, [1] = 14, [2] = 119, [3] = 113 }, [2] = { [0] = 20, [1] = 16, [2] = 110, [3] = 102 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 26, [1] = 122, [2] = 119, [3] = 18 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 18, [1] = 113, [2] = 114, [3] = 12 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 22, [2] = 108, [3] = 104 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 15, [1] = 109, [2] = 106, [3] = 12 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 17, [1] = 113, [2] = 112, [3] = 9 }, [5] = { [0] = 24, [1] = 115, [2] = 113, [3] = 16 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 19, [1] = 16, [2] = 121, [3] = 115 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 16, [1] = 110, [2] = 107, [3] = 13 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 114, [2] = 113, [3] = 10 }, [5] = { [0] = 25, [1] = 116, [2] = 114, [3] = 17 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 24, [2] = 110, [3] = 106 }, [1] = { [0] = 20, [1] = 17, [2] = 122, [3] = 116 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 14, [1] = 17, [2] = 110, [3] = 108 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 17, [1] = 111, [2] = 108, [3] = 14 }, [3] = { [0] = 21, [1] = 117, [2] = 114, [3] = 13 }, [4] = { [0] = 22, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 26, [1] = 117, [2] = 115, [3] = 18 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 21, [1] = 116, [2] = 117, [3] = 15 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 25, [2] = 111, [3] = 107 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 22, [1] = 118, [2] = 115, [3] = 14 }, [4] = { [0] = 23, [1] = 119, [2] = 118, [3] = 15 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 14, [1] = 112, [2] = 107, [3] = 9 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 19, [1] = 113, [2] = 110, [3] = 16 }, [3] = { [0] = 23, [1] = 119, [2] = 116, [3] = 15 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 23, [1] = 118, [2] = 119, [3] = 17 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[5]][R[4]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 14, [1] = 101, [2] = 97, [3] = 10 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 25, [1] = 121, [2] = 120, [3] = 17 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 24, [1] = 119, [2] = 120, [3] = 18 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[5]][R[4]], ({ [0] = { [0] = 16, [1] = 114, [2] = 109, [3] = 11 }, [1] = { [0] = 15, [1] = 102, [2] = 98, [3] = 11 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 26, [1] = 122, [2] = 121, [3] = 18 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[5]][R[4]], ({ [0] = { [0] = 17, [1] = 115, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 103, [2] = 99, [3] = 12 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[5]][R[4]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 23, [1] = 19, [2] = 113, [3] = 100 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[5]][R[4]], ({ [0] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [1] = { [0] = 21, [1] = 108, [2] = 104, [3] = 17 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[5]][R[4]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[5]][R[4]], ({ [0] = { [0] = 24, [1] = 122, [2] = 117, [3] = 19 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 30, [2] = 116, [3] = 112 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 25, [1] = 21, [2] = 115, [3] = 102 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 31, [2] = 117, [3] = 113 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 25, [1] = 112, [2] = 108, [3] = 21 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 24, [1] = 23, [2] = 114, [3] = 114 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 26, [1] = 113, [2] = 109, [3] = 22 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 13, [1] = 109, [2] = 108, [3] = 5 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 31, [1] = 118, [2] = 114, [3] = 27 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[5]][R[4]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 34, [2] = 120, [3] = 116 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 25, [1] = 21, [2] = 115, [3] = 107 }, [3] = { [0] = 29, [1] = 25, [2] = 119, [3] = 106 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[5]][R[4]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 32, [1] = 119, [2] = 115, [3] = 28 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 15, [1] = 110, [2] = 111, [3] = 9 } })[R[5]][R[4]] })
    if R[5] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[4]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[4]] })
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [2] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 } })[R[51]][R[4]], ({ [0] = { [0] = 13, [1] = 111, [2] = 106, [3] = 8 }, [1] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [2] = { [0] = 25, [1] = 123, [2] = 118, [3] = 20 } })[R[51]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[4]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[4]] })
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 11, [2] = 116, [3] = 110 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 } })[R[52]][R[4]], ({ [0] = { [0] = 28, [1] = 115, [2] = 111, [3] = 24 }, [1] = { [0] = 30, [1] = 117, [2] = 113, [3] = 26 }, [2] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 } })[R[52]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 16, [1] = 12, [2] = 106, [3] = 98 }, [1] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [2] = { [0] = 34, [1] = 30, [2] = 124, [3] = 116 } })[R[53]][R[4]], ({ [0] = { [0] = 12, [1] = 106, [2] = 103, [3] = 9 }, [1] = { [0] = 28, [1] = 122, [2] = 119, [3] = 25 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 } })[R[53]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[4]] })
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [1] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 92 } })[R[54]][R[4]], ({ [0] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [1] = { [0] = 27, [1] = 123, [2] = 120, [3] = 19 }, [2] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 } })[R[54]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[4]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[4]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[4]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[4]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[4]] })
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [1] = { [0] = 20, [1] = 14, [2] = 108, [3] = 96 }, [2] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 } })[R[55]][R[4]], ({ [0] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [1] = { [0] = 19, [1] = 115, [2] = 114, [3] = 11 }, [2] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 } })[R[55]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[4]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[4]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [1] = { [0] = 4, [1] = 3, [2] = 94, [3] = 94 }, [2] = { [0] = 26, [1] = 25, [2] = 116, [3] = 116 } })[R[56]][R[4]], ({ [0] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 }, [1] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [2] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 } })[R[56]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[4]] })
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 6, [1] = 9, [2] = 102, [3] = 100 }, [1] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [2] = { [0] = 32, [1] = 35, [2] = 128, [3] = 126 } })[R[57]][R[4]], ({ [0] = { [0] = 13, [1] = 108, [2] = 111, [3] = 8 }, [1] = { [0] = 11, [1] = 106, [2] = 109, [3] = 6 }, [2] = { [0] = 26, [1] = 121, [2] = 124, [3] = 21 } })[R[57]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[5] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 }, [1] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 }, [2] = { [0] = 7, [1] = 5, [2] = 101, [3] = 106 } })[R[58]][R[4]], ({ [0] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [1] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [2] = { [0] = 30, [1] = 125, [2] = 126, [3] = 24 } })[R[58]][R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[4]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[4]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[4]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[4]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[4]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[4]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[5]", R[5])
    end
    R[14] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 12, [2] = 21, [3] = 26, [4] = 25, [5] = 15, [6] = 11, [7] = 15 }, [1] = { [0] = 27, [1] = 9, [2] = 17, [3] = 22, [4] = 19, [5] = 14, [6] = 14, [7] = 13 }, [2] = { [0] = 113, [1] = 114, [2] = 111, [3] = 116, [4] = 113, [5] = 105, [6] = 107, [7] = 109 }, [3] = { [0] = 109, [1] = 108, [2] = 103, [3] = 103, [4] = 101, [5] = 105, [6] = 105, [7] = 114 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 13, [3] = 24, [4] = 20, [5] = 22, [6] = 15, [7] = 20 }, [1] = { [0] = 117, [1] = 111, [2] = 107, [3] = 120, [4] = 116, [5] = 113, [6] = 110, [7] = 115 }, [2] = { [0] = 112, [1] = 107, [2] = 104, [3] = 117, [4] = 115, [5] = 111, [6] = 113, [7] = 116 }, [3] = { [0] = 14, [1] = 20, [2] = 10, [3] = 16, [4] = 12, [5] = 14, [6] = 10, [7] = 14 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 24, [1] = 12, [2] = 21, [3] = 26, [4] = 25, [5] = 15, [6] = 11, [7] = 15 }, [1] = { [0] = 27, [1] = 9, [2] = 17, [3] = 22, [4] = 19, [5] = 14, [6] = 14, [7] = 13 }, [2] = { [0] = 113, [1] = 114, [2] = 111, [3] = 116, [4] = 113, [5] = 105, [6] = 107, [7] = 109 }, [3] = { [0] = 109, [1] = 108, [2] = 103, [3] = 103, [4] = 101, [5] = 105, [6] = 105, [7] = 114 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 13, [3] = 24, [4] = 20, [5] = 22, [6] = 15, [7] = 20 }, [1] = { [0] = 117, [1] = 111, [2] = 107, [3] = 120, [4] = 116, [5] = 113, [6] = 110, [7] = 115 }, [2] = { [0] = 112, [1] = 107, [2] = 104, [3] = 117, [4] = 115, [5] = 111, [6] = 113, [7] = 116 }, [3] = { [0] = 14, [1] = 20, [2] = 10, [3] = 16, [4] = 12, [5] = 14, [6] = 10, [7] = 14 } })[R[23]][R[14]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 22, [2] = 15, [3] = 34, [4] = 25, [5] = 15, [6] = 20, [7] = 8 }, [1] = { [0] = 27, [1] = 19, [2] = 11, [3] = 30, [4] = 19, [5] = 14, [6] = 23, [7] = 6 }, [2] = { [0] = 113, [1] = 124, [2] = 105, [3] = 124, [4] = 113, [5] = 105, [6] = 116, [7] = 102 }, [3] = { [0] = 109, [1] = 118, [2] = 97, [3] = 111, [4] = 101, [5] = 105, [6] = 114, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 12, [1] = 11, [2] = 18, [3] = 28, [4] = 28, [5] = 28, [6] = 15, [7] = 26 }, [1] = { [0] = 110, [1] = 98, [2] = 112, [3] = 124, [4] = 124, [5] = 119, [6] = 110, [7] = 121 }, [2] = { [0] = 105, [1] = 94, [2] = 109, [3] = 121, [4] = 123, [5] = 117, [6] = 113, [7] = 122 }, [3] = { [0] = 7, [1] = 7, [2] = 15, [3] = 20, [4] = 20, [5] = 20, [6] = 10, [7] = 20 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    if R[14] == 0 or R[14] == 1 or R[14] == 2 or R[14] == 5 or R[14] == 6 or R[14] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 23, [2] = 18, [5] = 25, [6] = 21, [7] = 8 }, [1] = { [0] = 39, [1] = 20, [2] = 14, [5] = 24, [6] = 24, [7] = 6 }, [2] = { [0] = 125, [1] = 125, [2] = 108, [5] = 115, [6] = 117, [7] = 102 }, [3] = { [0] = 121, [1] = 119, [2] = 100, [5] = 115, [6] = 115, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 18, [2] = 24, [5] = 27, [6] = 23, [7] = 13 }, [1] = { [0] = 117, [1] = 105, [2] = 118, [5] = 118, [6] = 118, [7] = 108 }, [2] = { [0] = 112, [1] = 101, [2] = 115, [5] = 116, [6] = 121, [7] = 109 }, [3] = { [0] = 14, [1] = 14, [2] = 21, [5] = 19, [6] = 18, [7] = 7 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 0 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[23]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[23]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[23]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[14] == 1 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[14] == 2 then
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
      elseif R[14] == 5 then
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
      elseif R[14] == 6 then
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
      elseif R[14] == 7 then
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
        unseen("R[14]", R[14])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 22, [2] = 27, [5] = 25, [6] = 29, [7] = 23 }, [1] = { [0] = 27, [1] = 19, [2] = 23, [5] = 24, [6] = 32, [7] = 21 }, [2] = { [0] = 113, [1] = 124, [2] = 117, [5] = 115, [6] = 125, [7] = 117 }, [3] = { [0] = 109, [1] = 118, [2] = 109, [5] = 115, [6] = 123, [7] = 122 } })[R[23]][R[14]], ({ [0] = { [0] = 26, [1] = 36, [2] = 18, [5] = 20, [6] = 23, [7] = 13 }, [1] = { [0] = 124, [1] = 123, [2] = 112, [5] = 111, [6] = 118, [7] = 108 }, [2] = { [0] = 119, [1] = 119, [2] = 109, [5] = 109, [6] = 121, [7] = 109 }, [3] = { [0] = 21, [1] = 32, [2] = 15, [5] = 12, [6] = 18, [7] = 7 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 2 or R[14] == 5 or R[14] == 6 or R[14] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [2] = 27, [5] = 15, [6] = 12, [7] = 24 }, [1] = { [2] = 23, [5] = 14, [6] = 15, [7] = 22 }, [2] = { [2] = 117, [5] = 105, [6] = 108, [7] = 118 }, [3] = { [2] = 109, [5] = 105, [6] = 106, [7] = 123 } })[R[23]][R[14]], ({ [0] = { [2] = 24, [5] = 15, [6] = 23, [7] = 25 }, [1] = { [2] = 118, [5] = 106, [6] = 118, [7] = 120 }, [2] = { [2] = 115, [5] = 104, [6] = 121, [7] = 121 }, [3] = { [2] = 21, [5] = 7, [6] = 18, [7] = 19 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 0 or R[14] == 1 then
      else
        unseen("R[14]", R[14])
      end
    elseif R[14] == 3 or R[14] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [3] = 18, [4] = 25 }, [1] = { [3] = 14, [4] = 19 }, [2] = { [3] = 108, [4] = 113 }, [3] = { [3] = 95, [4] = 101 } })[R[23]][R[14]], ({ [0] = { [3] = 28, [4] = 12 }, [1] = { [3] = 124, [4] = 108 }, [2] = { [3] = 121, [4] = 107 }, [3] = { [3] = 20, [4] = 4 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[14] == 3 then
      else
        unseen("R[14]", R[14])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [3] = 21, [4] = 36 }, [1] = { [3] = 17, [4] = 30 }, [2] = { [3] = 111, [4] = 124 }, [3] = { [3] = 98, [4] = 112 } })[R[23]][R[14]], ({ [0] = { [3] = 17, [4] = 24 }, [1] = { [3] = 113, [4] = 120 }, [2] = { [3] = 110, [4] = 119 }, [3] = { [3] = 9, [4] = 16 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      if R[14] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[14] == 4 then
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
        unseen("R[14]", R[14])
      end
    else
      unseen("R[14]", R[14])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 13, [2] = 35, [3] = 27, [4] = 17, [5] = 5, [6] = 4, [7] = 16 }, [1] = { [0] = 16, [1] = 10, [2] = 31, [3] = 23, [4] = 11, [5] = 4, [6] = 7, [7] = 14 }, [2] = { [0] = 102, [1] = 115, [2] = 125, [3] = 117, [4] = 105, [5] = 95, [6] = 100, [7] = 110 }, [3] = { [0] = 98, [1] = 109, [2] = 117, [3] = 104, [4] = 93, [5] = 95, [6] = 98, [7] = 115 } })[R[23]][R[14]], ({ [0] = { [0] = 28, [1] = 33, [2] = 18, [3] = 11, [4] = 16, [5] = 22, [6] = 23, [7] = 29 }, [1] = { [0] = 126, [1] = 120, [2] = 112, [3] = 107, [4] = 112, [5] = 113, [6] = 118, [7] = 124 }, [2] = { [0] = 121, [1] = 116, [2] = 109, [3] = 104, [4] = 111, [5] = 111, [6] = 121, [7] = 125 }, [3] = { [0] = 23, [1] = 29, [2] = 15, [3] = 3, [4] = 8, [5] = 14, [6] = 18, [7] = 23 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 12, [2] = 31, [3] = 16, [4] = 35, [5] = 23, [6] = 11, [7] = 26 }, [1] = { [0] = 23, [1] = 9, [2] = 27, [3] = 12, [4] = 29, [5] = 22, [6] = 14, [7] = 24 }, [2] = { [0] = 109, [1] = 114, [2] = 121, [3] = 106, [4] = 123, [5] = 113, [6] = 107, [7] = 120 }, [3] = { [0] = 105, [1] = 108, [2] = 113, [3] = 93, [4] = 111, [5] = 113, [6] = 105, [7] = 125 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 19, [2] = 22, [3] = 18, [4] = 20, [5] = 13, [6] = 28, [7] = 20 }, [1] = { [0] = 113, [1] = 106, [2] = 116, [3] = 114, [4] = 116, [5] = 104, [6] = 123, [7] = 115 }, [2] = { [0] = 108, [1] = 102, [2] = 113, [3] = 111, [4] = 115, [5] = 102, [6] = 126, [7] = 116 }, [3] = { [0] = 10, [1] = 15, [2] = 19, [3] = 10, [4] = 12, [5] = 5, [6] = 23, [7] = 14 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 12, [2] = 31, [3] = 19, [4] = 37, [5] = 23, [6] = 9, [7] = 26 }, [1] = { [0] = 21, [1] = 9, [2] = 27, [3] = 15, [4] = 31, [5] = 22, [6] = 12, [7] = 24 }, [2] = { [0] = 107, [1] = 114, [2] = 121, [3] = 109, [4] = 125, [5] = 113, [6] = 105, [7] = 120 }, [3] = { [0] = 103, [1] = 108, [2] = 113, [3] = 96, [4] = 113, [5] = 113, [6] = 103, [7] = 125 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 17, [2] = 20, [3] = 14, [4] = 20, [5] = 15, [6] = 28, [7] = 22 }, [1] = { [0] = 113, [1] = 104, [2] = 114, [3] = 110, [4] = 116, [5] = 106, [6] = 123, [7] = 117 }, [2] = { [0] = 108, [1] = 100, [2] = 111, [3] = 107, [4] = 115, [5] = 104, [6] = 126, [7] = 118 }, [3] = { [0] = 10, [1] = 13, [2] = 17, [3] = 6, [4] = 12, [5] = 7, [6] = 23, [7] = 16 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[14] == 0 or R[14] == 1 or R[14] == 2 or R[14] == 4 or R[14] == 5 or R[14] == 6 or R[14] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 15, [2] = 13, [4] = 29, [5] = 11, [6] = 24, [7] = 25 }, [1] = { [0] = 32, [1] = 12, [2] = 9, [4] = 23, [5] = 10, [6] = 27, [7] = 23 }, [2] = { [0] = 118, [1] = 117, [2] = 103, [4] = 117, [5] = 101, [6] = 120, [7] = 119 }, [3] = { [0] = 114, [1] = 111, [2] = 95, [4] = 105, [5] = 101, [6] = 118, [7] = 124 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 19, [2] = 23, [4] = 28, [5] = 23, [6] = 15, [7] = 14 }, [1] = { [0] = 119, [1] = 106, [2] = 117, [4] = 124, [5] = 114, [6] = 110, [7] = 109 }, [2] = { [0] = 114, [1] = 102, [2] = 114, [4] = 123, [5] = 112, [6] = 113, [7] = 110 }, [3] = { [0] = 16, [1] = 15, [2] = 20, [4] = 20, [5] = 15, [6] = 10, [7] = 8 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 15, [2] = 13, [4] = 29, [5] = 11, [6] = 24, [7] = 25 }, [1] = { [0] = 32, [1] = 12, [2] = 9, [4] = 23, [5] = 10, [6] = 27, [7] = 23 }, [2] = { [0] = 118, [1] = 117, [2] = 103, [4] = 117, [5] = 101, [6] = 120, [7] = 119 }, [3] = { [0] = 114, [1] = 111, [2] = 95, [4] = 105, [5] = 101, [6] = 118, [7] = 124 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 19, [2] = 23, [4] = 28, [5] = 23, [6] = 15, [7] = 14 }, [1] = { [0] = 119, [1] = 106, [2] = 117, [4] = 124, [5] = 114, [6] = 110, [7] = 109 }, [2] = { [0] = 114, [1] = 102, [2] = 114, [4] = 123, [5] = 112, [6] = 113, [7] = 110 }, [3] = { [0] = 16, [1] = 15, [2] = 20, [4] = 20, [5] = 15, [6] = 10, [7] = 8 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[14] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 36, [1] = 32, [2] = 126, [3] = 113 })[R[23]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 107, [3] = 6 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[14]", R[14])
    end
    U[#U]:set_lights(true)
    if R[14] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[23]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[23]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 29, [1] = 32, [2] = 118, [3] = 114 })[R[23]], ({ [0] = 21, [1] = 119, [2] = 114, [3] = 16 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[23]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[23]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[23]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 29, [1] = 32, [2] = 118, [3] = 114 })[R[23]], ({ [0] = 21, [1] = 119, [2] = 114, [3] = 16 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[23]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[23]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[23]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[23]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[14] == 1 then
      if LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[23]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[23]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[23]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[23]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[23]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[23]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[23]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[23]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[23]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[23]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[23]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[14] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[23]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[23]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 9, [2] = 103, [3] = 95 })[R[23]], ({ [0] = 23, [1] = 117, [2] = 114, [3] = 20 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[23]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[23]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[23]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 9, [2] = 103, [3] = 95 })[R[23]], ({ [0] = 23, [1] = 117, [2] = 114, [3] = 20 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[23]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[23]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[23]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[23]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[14] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[23]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[23]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[23]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[23]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[23]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 107, [3] = 6 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[23]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[23]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[23]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[23]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[23]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[23]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[14] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 29, [1] = 23, [2] = 117, [3] = 105 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 29, [1] = 23, [2] = 117, [3] = 105 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[14] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[23]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[23]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 10, [2] = 101, [3] = 101 })[R[23]], ({ [0] = 23, [1] = 114, [2] = 112, [3] = 15 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[23]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[23]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 10, [2] = 101, [3] = 101 })[R[23]], ({ [0] = 23, [1] = 114, [2] = 112, [3] = 15 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[23]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[23]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[14] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[23]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[23]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 27, [2] = 120, [3] = 118 })[R[23]], ({ [0] = 15, [1] = 110, [2] = 113, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[23]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[23]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 24, [1] = 27, [2] = 120, [3] = 118 })[R[23]], ({ [0] = 15, [1] = 110, [2] = 113, [3] = 10 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[23]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[23]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[14] == 7 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 23, [2] = 119, [3] = 124 })[R[23]], ({ [0] = 14, [1] = 109, [2] = 110, [3] = 8 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[23]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 23, [2] = 119, [3] = 124 })[R[23]], ({ [0] = 14, [1] = 109, [2] = 110, [3] = 8 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[23]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[23]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[23]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[14]", R[14])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 21, [2] = 23, [3] = 26, [4] = 38, [5] = 11, [6] = 25, [7] = 19 }, [1] = { [0] = 39, [1] = 18, [2] = 19, [3] = 22, [4] = 32, [5] = 10, [6] = 28, [7] = 17 }, [2] = { [0] = 125, [1] = 123, [2] = 113, [3] = 116, [4] = 126, [5] = 101, [6] = 121, [7] = 113 }, [3] = { [0] = 121, [1] = 117, [2] = 105, [3] = 103, [4] = 114, [5] = 101, [6] = 119, [7] = 118 } })[R[23]][R[14]], ({ [0] = { [0] = 23, [1] = 23, [2] = 20, [3] = 15, [4] = 11, [5] = 29, [6] = 25, [7] = 19 }, [1] = { [0] = 121, [1] = 110, [2] = 114, [3] = 111, [4] = 107, [5] = 120, [6] = 120, [7] = 114 }, [2] = { [0] = 116, [1] = 106, [2] = 111, [3] = 108, [4] = 106, [5] = 118, [6] = 123, [7] = 115 }, [3] = { [0] = 18, [1] = 19, [2] = 17, [3] = 7, [4] = 3, [5] = 21, [6] = 20, [7] = 13 } })[R[23]][R[14]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 15, [2] = 18, [3] = 18, [4] = 25, [5] = 15, [6] = 11, [7] = 8 }, [1] = { [0] = 19, [1] = 12, [2] = 14, [3] = 14, [4] = 19, [5] = 14, [6] = 14, [7] = 6 }, [2] = { [0] = 105, [1] = 117, [2] = 108, [3] = 108, [4] = 113, [5] = 105, [6] = 107, [7] = 102 }, [3] = { [0] = 101, [1] = 111, [2] = 100, [3] = 95, [4] = 101, [5] = 105, [6] = 105, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 18, [3] = 24, [4] = 14, [5] = 18, [6] = 17, [7] = 16 }, [1] = { [0] = 117, [1] = 111, [2] = 112, [3] = 120, [4] = 110, [5] = 109, [6] = 112, [7] = 111 }, [2] = { [0] = 112, [1] = 107, [2] = 109, [3] = 117, [4] = 109, [5] = 107, [6] = 115, [7] = 112 }, [3] = { [0] = 14, [1] = 20, [2] = 15, [3] = 16, [4] = 6, [5] = 10, [6] = 12, [7] = 10 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 16, [2] = 19, [3] = 18, [4] = 25, [5] = 15, [6] = 11, [7] = 8 }, [1] = { [0] = 20, [1] = 13, [2] = 15, [3] = 14, [4] = 19, [5] = 14, [6] = 14, [7] = 6 }, [2] = { [0] = 106, [1] = 118, [2] = 109, [3] = 108, [4] = 113, [5] = 105, [6] = 107, [7] = 102 }, [3] = { [0] = 102, [1] = 112, [2] = 101, [3] = 95, [4] = 101, [5] = 105, [6] = 105, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 18, [3] = 25, [4] = 15, [5] = 19, [6] = 18, [7] = 17 }, [1] = { [0] = 117, [1] = 111, [2] = 112, [3] = 121, [4] = 111, [5] = 110, [6] = 113, [7] = 112 }, [2] = { [0] = 112, [1] = 107, [2] = 109, [3] = 118, [4] = 110, [5] = 108, [6] = 116, [7] = 113 }, [3] = { [0] = 14, [1] = 20, [2] = 15, [3] = 17, [4] = 7, [5] = 11, [6] = 13, [7] = 11 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 17, [2] = 20, [3] = 18, [4] = 25, [5] = 15, [6] = 11, [7] = 8 }, [1] = { [0] = 21, [1] = 14, [2] = 16, [3] = 14, [4] = 19, [5] = 14, [6] = 14, [7] = 6 }, [2] = { [0] = 107, [1] = 119, [2] = 110, [3] = 108, [4] = 113, [5] = 105, [6] = 107, [7] = 102 }, [3] = { [0] = 103, [1] = 113, [2] = 102, [3] = 95, [4] = 101, [5] = 105, [6] = 105, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 18, [3] = 26, [4] = 16, [5] = 20, [6] = 19, [7] = 18 }, [1] = { [0] = 117, [1] = 111, [2] = 112, [3] = 122, [4] = 112, [5] = 111, [6] = 114, [7] = 113 }, [2] = { [0] = 112, [1] = 107, [2] = 109, [3] = 119, [4] = 111, [5] = 109, [6] = 117, [7] = 114 }, [3] = { [0] = 14, [1] = 20, [2] = 15, [3] = 18, [4] = 8, [5] = 12, [6] = 14, [7] = 12 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 18, [2] = 21, [3] = 19, [4] = 25, [5] = 15, [6] = 11, [7] = 8 }, [1] = { [0] = 22, [1] = 15, [2] = 17, [3] = 15, [4] = 19, [5] = 14, [6] = 14, [7] = 6 }, [2] = { [0] = 108, [1] = 120, [2] = 111, [3] = 109, [4] = 113, [5] = 105, [6] = 107, [7] = 102 }, [3] = { [0] = 104, [1] = 114, [2] = 103, [3] = 96, [4] = 101, [5] = 105, [6] = 105, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 15, [3] = 24, [4] = 17, [5] = 24, [6] = 20, [7] = 19 }, [1] = { [0] = 117, [1] = 111, [2] = 109, [3] = 120, [4] = 113, [5] = 115, [6] = 115, [7] = 114 }, [2] = { [0] = 112, [1] = 107, [2] = 106, [3] = 117, [4] = 112, [5] = 113, [6] = 118, [7] = 115 }, [3] = { [0] = 14, [1] = 20, [2] = 12, [3] = 16, [4] = 9, [5] = 16, [6] = 15, [7] = 13 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 19, [2] = 21, [3] = 20, [4] = 25, [5] = 15, [6] = 11, [7] = 8 }, [1] = { [0] = 23, [1] = 16, [2] = 17, [3] = 16, [4] = 19, [5] = 14, [6] = 14, [7] = 6 }, [2] = { [0] = 109, [1] = 121, [2] = 111, [3] = 110, [4] = 113, [5] = 105, [6] = 107, [7] = 102 }, [3] = { [0] = 105, [1] = 115, [2] = 103, [3] = 97, [4] = 101, [5] = 105, [6] = 105, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 16, [3] = 20, [4] = 18, [5] = 25, [6] = 21, [7] = 20 }, [1] = { [0] = 117, [1] = 111, [2] = 110, [3] = 116, [4] = 114, [5] = 116, [6] = 116, [7] = 115 }, [2] = { [0] = 112, [1] = 107, [2] = 107, [3] = 113, [4] = 113, [5] = 114, [6] = 119, [7] = 116 }, [3] = { [0] = 14, [1] = 20, [2] = 13, [3] = 12, [4] = 10, [5] = 17, [6] = 16, [7] = 14 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 20, [2] = 21, [3] = 20, [4] = 25, [5] = 15, [6] = 14, [7] = 8 }, [1] = { [0] = 24, [1] = 17, [2] = 17, [3] = 16, [4] = 19, [5] = 14, [6] = 17, [7] = 6 }, [2] = { [0] = 110, [1] = 122, [2] = 111, [3] = 110, [4] = 113, [5] = 105, [6] = 110, [7] = 102 }, [3] = { [0] = 106, [1] = 116, [2] = 103, [3] = 97, [4] = 101, [5] = 105, [6] = 108, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 17, [3] = 21, [4] = 22, [5] = 26, [6] = 15, [7] = 21 }, [1] = { [0] = 117, [1] = 111, [2] = 111, [3] = 117, [4] = 118, [5] = 117, [6] = 110, [7] = 116 }, [2] = { [0] = 112, [1] = 107, [2] = 108, [3] = 114, [4] = 117, [5] = 115, [6] = 113, [7] = 117 }, [3] = { [0] = 14, [1] = 20, [2] = 14, [3] = 13, [4] = 14, [5] = 18, [6] = 10, [7] = 15 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 21, [2] = 21, [3] = 20, [4] = 25, [5] = 18, [6] = 15, [7] = 8 }, [1] = { [0] = 25, [1] = 18, [2] = 17, [3] = 16, [4] = 19, [5] = 17, [6] = 18, [7] = 6 }, [2] = { [0] = 111, [1] = 123, [2] = 111, [3] = 110, [4] = 113, [5] = 108, [6] = 111, [7] = 102 }, [3] = { [0] = 107, [1] = 117, [2] = 103, [3] = 97, [4] = 101, [5] = 108, [6] = 109, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 18, [3] = 22, [4] = 23, [5] = 22, [6] = 15, [7] = 22 }, [1] = { [0] = 117, [1] = 111, [2] = 112, [3] = 118, [4] = 119, [5] = 113, [6] = 110, [7] = 117 }, [2] = { [0] = 112, [1] = 107, [2] = 109, [3] = 115, [4] = 118, [5] = 111, [6] = 113, [7] = 118 }, [3] = { [0] = 14, [1] = 20, [2] = 15, [3] = 14, [4] = 15, [5] = 14, [6] = 10, [7] = 16 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 22, [2] = 21, [3] = 20, [4] = 25, [5] = 18, [6] = 15, [7] = 8 }, [1] = { [0] = 27, [1] = 19, [2] = 17, [3] = 16, [4] = 19, [5] = 17, [6] = 18, [7] = 6 }, [2] = { [0] = 113, [1] = 124, [2] = 111, [3] = 110, [4] = 113, [5] = 108, [6] = 111, [7] = 102 }, [3] = { [0] = 109, [1] = 118, [2] = 103, [3] = 97, [4] = 101, [5] = 108, [6] = 109, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 14, [1] = 13, [2] = 19, [3] = 23, [4] = 24, [5] = 28, [6] = 23, [7] = 23 }, [1] = { [0] = 112, [1] = 100, [2] = 113, [3] = 119, [4] = 120, [5] = 119, [6] = 118, [7] = 118 }, [2] = { [0] = 107, [1] = 96, [2] = 110, [3] = 116, [4] = 119, [5] = 117, [6] = 121, [7] = 119 }, [3] = { [0] = 9, [1] = 9, [2] = 16, [3] = 15, [4] = 16, [5] = 20, [6] = 18, [7] = 17 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 22, [2] = 21, [3] = 20, [4] = 25, [5] = 19, [6] = 16, [7] = 8 }, [1] = { [0] = 27, [1] = 19, [2] = 17, [3] = 16, [4] = 19, [5] = 18, [6] = 19, [7] = 6 }, [2] = { [0] = 113, [1] = 124, [2] = 111, [3] = 110, [4] = 113, [5] = 109, [6] = 112, [7] = 102 }, [3] = { [0] = 109, [1] = 118, [2] = 103, [3] = 97, [4] = 101, [5] = 109, [6] = 110, [7] = 107 } })[R[23]][R[14]], ({ [0] = { [0] = 15, [1] = 14, [2] = 20, [3] = 24, [4] = 25, [5] = 22, [6] = 15, [7] = 24 }, [1] = { [0] = 113, [1] = 101, [2] = 114, [3] = 120, [4] = 121, [5] = 113, [6] = 110, [7] = 119 }, [2] = { [0] = 108, [1] = 97, [2] = 111, [3] = 117, [4] = 120, [5] = 111, [6] = 113, [7] = 120 }, [3] = { [0] = 10, [1] = 10, [2] = 17, [3] = 16, [4] = 17, [5] = 14, [6] = 10, [7] = 18 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 22, [2] = 21, [3] = 21, [4] = 25, [5] = 19, [6] = 16, [7] = 11 }, [1] = { [0] = 27, [1] = 19, [2] = 17, [3] = 17, [4] = 19, [5] = 18, [6] = 19, [7] = 9 }, [2] = { [0] = 113, [1] = 124, [2] = 111, [3] = 111, [4] = 113, [5] = 109, [6] = 112, [7] = 105 }, [3] = { [0] = 109, [1] = 118, [2] = 103, [3] = 98, [4] = 101, [5] = 109, [6] = 110, [7] = 110 } })[R[23]][R[14]], ({ [0] = { [0] = 16, [1] = 15, [2] = 21, [3] = 20, [4] = 26, [5] = 28, [6] = 23, [7] = 13 }, [1] = { [0] = 114, [1] = 102, [2] = 115, [3] = 116, [4] = 122, [5] = 119, [6] = 118, [7] = 108 }, [2] = { [0] = 109, [1] = 98, [2] = 112, [3] = 113, [4] = 121, [5] = 117, [6] = 121, [7] = 109 }, [3] = { [0] = 11, [1] = 11, [2] = 18, [3] = 12, [4] = 18, [5] = 20, [6] = 18, [7] = 7 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 22, [2] = 21, [3] = 21, [4] = 28, [5] = 20, [6] = 17, [7] = 11 }, [1] = { [0] = 27, [1] = 19, [2] = 17, [3] = 17, [4] = 22, [5] = 19, [6] = 20, [7] = 9 }, [2] = { [0] = 113, [1] = 124, [2] = 111, [3] = 111, [4] = 116, [5] = 110, [6] = 113, [7] = 105 }, [3] = { [0] = 109, [1] = 118, [2] = 103, [3] = 98, [4] = 104, [5] = 110, [6] = 111, [7] = 110 } })[R[23]][R[14]], ({ [0] = { [0] = 17, [1] = 16, [2] = 22, [3] = 24, [4] = 12, [5] = 22, [6] = 15, [7] = 26 }, [1] = { [0] = 115, [1] = 103, [2] = 116, [3] = 120, [4] = 108, [5] = 113, [6] = 110, [7] = 121 }, [2] = { [0] = 110, [1] = 99, [2] = 113, [3] = 117, [4] = 107, [5] = 111, [6] = 113, [7] = 122 }, [3] = { [0] = 12, [1] = 12, [2] = 19, [3] = 16, [4] = 4, [5] = 14, [6] = 10, [7] = 20 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 22, [2] = 21, [3] = 22, [4] = 28, [5] = 20, [6] = 17, [7] = 12 }, [1] = { [0] = 27, [1] = 19, [2] = 17, [3] = 18, [4] = 22, [5] = 19, [6] = 20, [7] = 10 }, [2] = { [0] = 113, [1] = 124, [2] = 111, [3] = 112, [4] = 116, [5] = 110, [6] = 113, [7] = 106 }, [3] = { [0] = 109, [1] = 118, [2] = 103, [3] = 99, [4] = 104, [5] = 110, [6] = 111, [7] = 111 } })[R[23]][R[14]], ({ [0] = { [0] = 21, [1] = 24, [2] = 23, [3] = 24, [4] = 20, [5] = 28, [6] = 23, [7] = 13 }, [1] = { [0] = 119, [1] = 111, [2] = 117, [3] = 120, [4] = 116, [5] = 119, [6] = 118, [7] = 108 }, [2] = { [0] = 114, [1] = 107, [2] = 114, [3] = 117, [4] = 115, [5] = 117, [6] = 121, [7] = 109 }, [3] = { [0] = 16, [1] = 20, [2] = 20, [3] = 16, [4] = 12, [5] = 20, [6] = 18, [7] = 7 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 23, [2] = 21, [3] = 23, [4] = 28, [5] = 21, [6] = 18, [7] = 12 }, [1] = { [0] = 27, [1] = 20, [2] = 17, [3] = 19, [4] = 22, [5] = 20, [6] = 21, [7] = 10 }, [2] = { [0] = 113, [1] = 125, [2] = 111, [3] = 113, [4] = 116, [5] = 111, [6] = 114, [7] = 106 }, [3] = { [0] = 109, [1] = 119, [2] = 103, [3] = 100, [4] = 104, [5] = 111, [6] = 112, [7] = 111 } })[R[23]][R[14]], ({ [0] = { [0] = 22, [1] = 21, [2] = 24, [3] = 24, [4] = 28, [5] = 22, [6] = 15, [7] = 26 }, [1] = { [0] = 120, [1] = 108, [2] = 118, [3] = 120, [4] = 124, [5] = 113, [6] = 110, [7] = 121 }, [2] = { [0] = 115, [1] = 104, [2] = 115, [3] = 117, [4] = 123, [5] = 111, [6] = 113, [7] = 122 }, [3] = { [0] = 17, [1] = 17, [2] = 21, [3] = 16, [4] = 20, [5] = 14, [6] = 10, [7] = 20 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 23, [2] = 22, [3] = 24, [4] = 29, [5] = 21, [6] = 18, [7] = 13 }, [1] = { [0] = 27, [1] = 20, [2] = 18, [3] = 20, [4] = 23, [5] = 20, [6] = 21, [7] = 11 }, [2] = { [0] = 113, [1] = 125, [2] = 112, [3] = 114, [4] = 117, [5] = 111, [6] = 114, [7] = 107 }, [3] = { [0] = 109, [1] = 119, [2] = 104, [3] = 101, [4] = 105, [5] = 111, [6] = 112, [7] = 112 } })[R[23]][R[14]], ({ [0] = { [0] = 23, [1] = 22, [2] = 18, [3] = 17, [4] = 12, [5] = 28, [6] = 23, [7] = 13 }, [1] = { [0] = 121, [1] = 109, [2] = 112, [3] = 113, [4] = 108, [5] = 119, [6] = 118, [7] = 108 }, [2] = { [0] = 116, [1] = 105, [2] = 109, [3] = 110, [4] = 107, [5] = 117, [6] = 121, [7] = 109 }, [3] = { [0] = 18, [1] = 18, [2] = 15, [3] = 9, [4] = 4, [5] = 20, [6] = 18, [7] = 7 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 23, [2] = 22, [3] = 24, [4] = 29, [5] = 22, [6] = 20, [7] = 13 }, [1] = { [0] = 27, [1] = 20, [2] = 18, [3] = 20, [4] = 23, [5] = 21, [6] = 23, [7] = 11 }, [2] = { [0] = 113, [1] = 125, [2] = 112, [3] = 114, [4] = 117, [5] = 112, [6] = 116, [7] = 107 }, [3] = { [0] = 109, [1] = 119, [2] = 104, [3] = 101, [4] = 105, [5] = 112, [6] = 114, [7] = 112 } })[R[23]][R[14]], ({ [0] = { [0] = 24, [1] = 23, [2] = 24, [3] = 24, [4] = 20, [5] = 22, [6] = 17, [7] = 26 }, [1] = { [0] = 122, [1] = 110, [2] = 118, [3] = 120, [4] = 116, [5] = 113, [6] = 112, [7] = 121 }, [2] = { [0] = 117, [1] = 106, [2] = 115, [3] = 117, [4] = 115, [5] = 111, [6] = 115, [7] = 122 }, [3] = { [0] = 19, [1] = 19, [2] = 21, [3] = 16, [4] = 12, [5] = 14, [6] = 12, [7] = 20 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 23, [2] = 23, [3] = 25, [4] = 29, [5] = 22, [6] = 20, [7] = 14 }, [1] = { [0] = 30, [1] = 20, [2] = 19, [3] = 21, [4] = 23, [5] = 21, [6] = 23, [7] = 12 }, [2] = { [0] = 116, [1] = 125, [2] = 113, [3] = 115, [4] = 117, [5] = 112, [6] = 116, [7] = 108 }, [3] = { [0] = 112, [1] = 119, [2] = 105, [3] = 102, [4] = 105, [5] = 112, [6] = 114, [7] = 113 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 24, [2] = 18, [3] = 17, [4] = 28, [5] = 28, [6] = 18, [7] = 13 }, [1] = { [0] = 117, [1] = 111, [2] = 112, [3] = 113, [4] = 124, [5] = 119, [6] = 113, [7] = 108 }, [2] = { [0] = 112, [1] = 107, [2] = 109, [3] = 110, [4] = 123, [5] = 117, [6] = 116, [7] = 109 }, [3] = { [0] = 14, [1] = 20, [2] = 15, [3] = 9, [4] = 20, [5] = 20, [6] = 13, [7] = 7 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 23, [2] = 23, [3] = 26, [4] = 30, [5] = 23, [6] = 20, [7] = 14 }, [1] = { [0] = 31, [1] = 20, [2] = 19, [3] = 22, [4] = 24, [5] = 22, [6] = 23, [7] = 12 }, [2] = { [0] = 117, [1] = 125, [2] = 113, [3] = 116, [4] = 118, [5] = 113, [6] = 116, [7] = 108 }, [3] = { [0] = 113, [1] = 119, [2] = 105, [3] = 103, [4] = 106, [5] = 113, [6] = 114, [7] = 113 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 25, [2] = 24, [3] = 17, [4] = 12, [5] = 22, [6] = 19, [7] = 26 }, [1] = { [0] = 117, [1] = 112, [2] = 118, [3] = 113, [4] = 108, [5] = 113, [6] = 114, [7] = 121 }, [2] = { [0] = 112, [1] = 108, [2] = 115, [3] = 110, [4] = 107, [5] = 111, [6] = 117, [7] = 122 }, [3] = { [0] = 14, [1] = 21, [2] = 21, [3] = 9, [4] = 4, [5] = 14, [6] = 14, [7] = 20 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 23, [2] = 24, [3] = 27, [4] = 30, [5] = 24, [6] = 20, [7] = 15 }, [1] = { [0] = 32, [1] = 20, [2] = 20, [3] = 23, [4] = 24, [5] = 23, [6] = 23, [7] = 13 }, [2] = { [0] = 118, [1] = 125, [2] = 114, [3] = 117, [4] = 118, [5] = 114, [6] = 116, [7] = 109 }, [3] = { [0] = 114, [1] = 119, [2] = 106, [3] = 104, [4] = 106, [5] = 114, [6] = 114, [7] = 114 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 26, [2] = 18, [3] = 17, [4] = 13, [5] = 22, [6] = 20, [7] = 13 }, [1] = { [0] = 117, [1] = 113, [2] = 112, [3] = 113, [4] = 109, [5] = 113, [6] = 115, [7] = 108 }, [2] = { [0] = 112, [1] = 109, [2] = 109, [3] = 110, [4] = 108, [5] = 111, [6] = 118, [7] = 109 }, [3] = { [0] = 14, [1] = 22, [2] = 15, [3] = 9, [4] = 5, [5] = 14, [6] = 15, [7] = 7 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 23, [2] = 24, [3] = 28, [4] = 30, [5] = 25, [6] = 20, [7] = 15 }, [1] = { [0] = 33, [1] = 20, [2] = 20, [3] = 24, [4] = 24, [5] = 24, [6] = 23, [7] = 13 }, [2] = { [0] = 119, [1] = 125, [2] = 114, [3] = 118, [4] = 118, [5] = 115, [6] = 116, [7] = 109 }, [3] = { [0] = 115, [1] = 119, [2] = 106, [3] = 105, [4] = 106, [5] = 115, [6] = 114, [7] = 114 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 31, [2] = 24, [3] = 17, [4] = 20, [5] = 22, [6] = 21, [7] = 14 }, [1] = { [0] = 117, [1] = 118, [2] = 118, [3] = 113, [4] = 116, [5] = 113, [6] = 116, [7] = 109 }, [2] = { [0] = 112, [1] = 114, [2] = 115, [3] = 110, [4] = 115, [5] = 111, [6] = 119, [7] = 110 }, [3] = { [0] = 14, [1] = 27, [2] = 21, [3] = 9, [4] = 12, [5] = 14, [6] = 16, [7] = 8 } })[R[23]][R[14]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 23, [2] = 25, [3] = 29, [4] = 30, [5] = 25, [6] = 24, [7] = 15 }, [1] = { [0] = 34, [1] = 20, [2] = 21, [3] = 25, [4] = 24, [5] = 24, [6] = 27, [7] = 13 }, [2] = { [0] = 120, [1] = 125, [2] = 115, [3] = 119, [4] = 118, [5] = 115, [6] = 120, [7] = 109 }, [3] = { [0] = 116, [1] = 119, [2] = 107, [3] = 106, [4] = 106, [5] = 115, [6] = 118, [7] = 114 } })[R[23]][R[14]], ({ [0] = { [0] = 19, [1] = 32, [2] = 18, [3] = 17, [4] = 28, [5] = 23, [6] = 23, [7] = 15 }, [1] = { [0] = 117, [1] = 119, [2] = 112, [3] = 113, [4] = 124, [5] = 114, [6] = 118, [7] = 110 }, [2] = { [0] = 112, [1] = 115, [2] = 109, [3] = 110, [4] = 123, [5] = 112, [6] = 121, [7] = 111 }, [3] = { [0] = 14, [1] = 28, [2] = 15, [3] = 9, [4] = 20, [5] = 15, [6] = 18, [7] = 9 } })[R[23]][R[14]] })
    if R[14] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[23]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[23]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[23]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[23]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[23]] })
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [2] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 } })[R[59]][R[23]], ({ [0] = { [0] = 13, [1] = 111, [2] = 106, [3] = 8 }, [1] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [2] = { [0] = 25, [1] = 123, [2] = 118, [3] = 20 } })[R[59]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[23]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[23]] })
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 11, [2] = 116, [3] = 110 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 } })[R[60]][R[23]], ({ [0] = { [0] = 28, [1] = 115, [2] = 111, [3] = 24 }, [1] = { [0] = 30, [1] = 117, [2] = 113, [3] = 26 }, [2] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 } })[R[60]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 12, [2] = 106, [3] = 98 }, [1] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [2] = { [0] = 34, [1] = 30, [2] = 124, [3] = 116 } })[R[61]][R[23]], ({ [0] = { [0] = 12, [1] = 106, [2] = 103, [3] = 9 }, [1] = { [0] = 28, [1] = 122, [2] = 119, [3] = 25 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 } })[R[61]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[23]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[23]] })
        for i = 1, game.initial_units() do
          R[62] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [1] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 92 } })[R[62]][R[23]], ({ [0] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [1] = { [0] = 27, [1] = 123, [2] = 120, [3] = 19 }, [2] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 } })[R[62]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[23]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[23]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[23]] })
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [1] = { [0] = 20, [1] = 14, [2] = 108, [3] = 96 }, [2] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 } })[R[63]][R[23]], ({ [0] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [1] = { [0] = 19, [1] = 115, [2] = 114, [3] = 11 }, [2] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 } })[R[63]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[23]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[23]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[23]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[23]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[23]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [1] = { [0] = 4, [1] = 3, [2] = 94, [3] = 94 }, [2] = { [0] = 26, [1] = 25, [2] = 116, [3] = 116 } })[R[64]][R[23]], ({ [0] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 }, [1] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [2] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 } })[R[64]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[23]] })
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 6, [1] = 9, [2] = 102, [3] = 100 }, [1] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [2] = { [0] = 32, [1] = 35, [2] = 128, [3] = 126 } })[R[65]][R[23]], ({ [0] = { [0] = 13, [1] = 108, [2] = 111, [3] = 8 }, [1] = { [0] = 11, [1] = 106, [2] = 109, [3] = 6 }, [2] = { [0] = 26, [1] = 121, [2] = 124, [3] = 21 } })[R[65]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[14] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[23]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 }, [1] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 }, [2] = { [0] = 7, [1] = 5, [2] = 101, [3] = 106 } })[R[66]][R[23]], ({ [0] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [1] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [2] = { [0] = 30, [1] = 125, [2] = 126, [3] = 24 } })[R[66]][R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[23]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[23]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[23]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[23]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[23]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[23]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[23]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[14]", R[14])
    end
    R[41] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[41]][R[24]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 97 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 11, [1] = 98, [2] = 94, [3] = 7 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    if R[41] == 3 or R[41] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 } })[R[41]][R[24]], ({ [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      if R[41] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[41] == 3 then
      else
        unseen("R[41]", R[41])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 36, [1] = 30, [2] = 124, [3] = 112 } })[R[41]][R[24]], ({ [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      if R[41] == 3 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[41] == 4 then
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
        unseen("R[41]", R[41])
      end
    elseif R[41] == 0 or R[41] == 1 or R[41] == 2 or R[41] == 5 or R[41] == 6 or R[41] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 21, [1] = 24, [2] = 117, [3] = 115 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 18, [1] = 105, [2] = 101, [3] = 14 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 27, [1] = 118, [2] = 116, [3] = 19 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      if R[41] == 0 then
        if LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[24]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[24]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 13, [1] = 16, [2] = 102, [3] = 98 })[R[24]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[41] == 1 then
        if LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 28, [1] = 115, [2] = 111, [3] = 24 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[41] == 2 then
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
      elseif R[41] == 5 then
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
      elseif R[41] == 6 then
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
      elseif R[41] == 7 then
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
        unseen("R[41]", R[41])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 29, [1] = 32, [2] = 125, [3] = 123 }, [7] = { [0] = 23, [1] = 21, [2] = 117, [3] = 122 } })[R[41]][R[24]], ({ [0] = { [0] = 26, [1] = 124, [2] = 119, [3] = 21 }, [1] = { [0] = 36, [1] = 123, [2] = 119, [3] = 32 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      if R[41] == 2 or R[41] == 5 or R[41] == 6 or R[41] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 12, [1] = 15, [2] = 108, [3] = 106 }, [7] = { [0] = 24, [1] = 22, [2] = 118, [3] = 123 } })[R[41]][R[24]], ({ [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 25, [1] = 120, [2] = 121, [3] = 19 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[41] == 0 or R[41] == 1 then
      else
        unseen("R[41]", R[41])
      end
    else
      unseen("R[41]", R[41])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 13, [1] = 16, [2] = 102, [3] = 98 }, [1] = { [0] = 13, [1] = 10, [2] = 115, [3] = 109 }, [2] = { [0] = 35, [1] = 31, [2] = 125, [3] = 117 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 17, [1] = 11, [2] = 105, [3] = 93 }, [5] = { [0] = 5, [1] = 4, [2] = 95, [3] = 95 }, [6] = { [0] = 4, [1] = 7, [2] = 100, [3] = 98 }, [7] = { [0] = 16, [1] = 14, [2] = 110, [3] = 115 } })[R[41]][R[24]], ({ [0] = { [0] = 28, [1] = 126, [2] = 121, [3] = 23 }, [1] = { [0] = 33, [1] = 120, [2] = 116, [3] = 29 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 11, [1] = 107, [2] = 104, [3] = 3 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 29, [1] = 124, [2] = 125, [3] = 23 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 35, [1] = 29, [2] = 123, [3] = 111 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 13, [1] = 104, [2] = 102, [3] = 5 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 17, [1] = 104, [2] = 100, [3] = 13 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[41] == 0 or R[41] == 1 or R[41] == 2 or R[41] == 4 or R[41] == 5 or R[41] == 6 or R[41] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[41] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 36, [1] = 32, [2] = 126, [3] = 113 })[R[24]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 107, [3] = 6 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    else
      unseen("R[41]", R[41])
    end
    U[#U]:set_lights(true)
    if R[41] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[24]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[24]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 29, [1] = 32, [2] = 118, [3] = 114 })[R[24]], ({ [0] = 21, [1] = 119, [2] = 114, [3] = 16 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[24]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[24]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 21, [2] = 107, [3] = 103 })[R[24]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 29, [1] = 32, [2] = 118, [3] = 114 })[R[24]], ({ [0] = 21, [1] = 119, [2] = 114, [3] = 16 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[24]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[24]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[24]], ({ [0] = 15, [1] = 113, [2] = 108, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 15, [1] = 18, [2] = 104, [3] = 100 })[R[24]], ({ [0] = 12, [1] = 110, [2] = 105, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[41] == 1 then
      if LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[24]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[24]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[24]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[24]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[24]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[24]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[24]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[24]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 12, [1] = 9, [2] = 114, [3] = 108 })[R[24]], ({ [0] = 19, [1] = 106, [2] = 102, [3] = 15 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 12, [2] = 117, [3] = 111 })[R[24]], ({ [0] = 13, [1] = 100, [2] = 96, [3] = 9 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 18, [1] = 15, [2] = 120, [3] = 114 })[R[24]], ({ [0] = 10, [1] = 97, [2] = 93, [3] = 6 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[41] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[24]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[24]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 9, [2] = 103, [3] = 95 })[R[24]], ({ [0] = 23, [1] = 117, [2] = 114, [3] = 20 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[24]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[24]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[24]], ({ [0] = 20, [1] = 114, [2] = 111, [3] = 17 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 13, [1] = 9, [2] = 103, [3] = 95 })[R[24]], ({ [0] = 23, [1] = 117, [2] = 114, [3] = 20 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[24]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[24]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 31, [1] = 27, [2] = 121, [3] = 113 })[R[24]], ({ [0] = 26, [1] = 120, [2] = 117, [3] = 23 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[24]], ({ [0] = 27, [1] = 121, [2] = 118, [3] = 24 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[41] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[24]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[24]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[24]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[24]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[24]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 107, [3] = 6 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[24]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[24]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[24]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[24]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 16, [1] = 12, [2] = 106, [3] = 93 })[R[24]], ({ [0] = 18, [1] = 114, [2] = 111, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 18, [2] = 112, [3] = 99 })[R[24]], ({ [0] = 29, [1] = 125, [2] = 122, [3] = 21 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[41] == 4 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 29, [1] = 23, [2] = 117, [3] = 105 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 37, [1] = 31, [2] = 125, [3] = 113 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 29, [1] = 23, [2] = 117, [3] = 105 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 30, [1] = 24, [2] = 118, [3] = 106 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 119, [3] = 16 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 15, [1] = 111, [2] = 110, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[41] == 5 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[24]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[24]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 10, [2] = 101, [3] = 101 })[R[24]], ({ [0] = 23, [1] = 114, [2] = 112, [3] = 15 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[24]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 22, [2] = 113, [3] = 113 })[R[24]], ({ [0] = 15, [1] = 106, [2] = 104, [3] = 7 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 11, [1] = 10, [2] = 101, [3] = 101 })[R[24]], ({ [0] = 23, [1] = 114, [2] = 112, [3] = 15 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[24]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 10, [1] = 9, [2] = 100, [3] = 100 })[R[24]], ({ [0] = 12, [1] = 103, [2] = 101, [3] = 4 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 18, [2] = 109, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[41] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[24]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[24]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 27, [2] = 120, [3] = 118 })[R[24]], ({ [0] = 15, [1] = 110, [2] = 113, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[24]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 9, [1] = 12, [2] = 105, [3] = 103 })[R[24]], ({ [0] = 28, [1] = 123, [2] = 126, [3] = 23 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 24, [1] = 27, [2] = 120, [3] = 118 })[R[24]], ({ [0] = 15, [1] = 110, [2] = 113, [3] = 10 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[24]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 16, [1] = 19, [2] = 112, [3] = 110 })[R[24]], ({ [0] = 25, [1] = 120, [2] = 123, [3] = 20 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 120, [3] = 17 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[41] == 7 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 23, [2] = 119, [3] = 124 })[R[24]], ({ [0] = 14, [1] = 109, [2] = 110, [3] = 8 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[24]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 26, [1] = 24, [2] = 120, [3] = 125 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 23, [2] = 119, [3] = 124 })[R[24]], ({ [0] = 14, [1] = 109, [2] = 110, [3] = 8 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[24]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 10, [1] = 8, [2] = 104, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 5, [1] = 3, [2] = 99, [3] = 104 })[R[24]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[24]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    else
      unseen("R[41]", R[41])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 38, [1] = 32, [2] = 126, [3] = 114 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 } })[R[41]][R[24]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 15, [1] = 111, [2] = 108, [3] = 7 }, [4] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [5] = { [0] = 29, [1] = 120, [2] = 118, [3] = 21 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[41]][R[24]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 19, [2] = 105, [3] = 101 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 }, [5] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 16, [1] = 111, [2] = 112, [3] = 10 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 19, [1] = 15, [2] = 109, [3] = 101 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 25, [1] = 121, [2] = 118, [3] = 17 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 19, [1] = 110, [2] = 108, [3] = 11 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 17, [1] = 14, [2] = 119, [3] = 113 }, [2] = { [0] = 20, [1] = 16, [2] = 110, [3] = 102 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 26, [1] = 122, [2] = 119, [3] = 18 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 18, [1] = 113, [2] = 114, [3] = 12 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 22, [2] = 108, [3] = 104 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 15, [1] = 109, [2] = 106, [3] = 12 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 17, [1] = 113, [2] = 112, [3] = 9 }, [5] = { [0] = 24, [1] = 115, [2] = 113, [3] = 16 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 19, [1] = 16, [2] = 121, [3] = 115 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 16, [1] = 110, [2] = 107, [3] = 13 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 114, [2] = 113, [3] = 10 }, [5] = { [0] = 25, [1] = 116, [2] = 114, [3] = 17 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 24, [2] = 110, [3] = 106 }, [1] = { [0] = 20, [1] = 17, [2] = 122, [3] = 116 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 14, [1] = 17, [2] = 110, [3] = 108 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 17, [1] = 111, [2] = 108, [3] = 14 }, [3] = { [0] = 21, [1] = 117, [2] = 114, [3] = 13 }, [4] = { [0] = 22, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 26, [1] = 117, [2] = 115, [3] = 18 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 21, [1] = 116, [2] = 117, [3] = 15 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 25, [2] = 111, [3] = 107 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 22, [1] = 118, [2] = 115, [3] = 14 }, [4] = { [0] = 23, [1] = 119, [2] = 118, [3] = 15 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 14, [1] = 112, [2] = 107, [3] = 9 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 19, [1] = 113, [2] = 110, [3] = 16 }, [3] = { [0] = 23, [1] = 119, [2] = 116, [3] = 15 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 23, [1] = 118, [2] = 119, [3] = 17 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[41]][R[24]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 14, [1] = 101, [2] = 97, [3] = 10 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 25, [1] = 121, [2] = 120, [3] = 17 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 24, [1] = 119, [2] = 120, [3] = 18 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[41]][R[24]], ({ [0] = { [0] = 16, [1] = 114, [2] = 109, [3] = 11 }, [1] = { [0] = 15, [1] = 102, [2] = 98, [3] = 11 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 26, [1] = 122, [2] = 121, [3] = 18 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[41]][R[24]], ({ [0] = { [0] = 17, [1] = 115, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 103, [2] = 99, [3] = 12 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[41]][R[24]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 23, [1] = 19, [2] = 113, [3] = 100 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[41]][R[24]], ({ [0] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [1] = { [0] = 21, [1] = 108, [2] = 104, [3] = 17 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[41]][R[24]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[41]][R[24]], ({ [0] = { [0] = 24, [1] = 122, [2] = 117, [3] = 19 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 30, [2] = 116, [3] = 112 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 25, [1] = 21, [2] = 115, [3] = 102 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 31, [2] = 117, [3] = 113 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 25, [1] = 112, [2] = 108, [3] = 21 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 24, [1] = 23, [2] = 114, [3] = 114 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 26, [1] = 113, [2] = 109, [3] = 22 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 13, [1] = 109, [2] = 108, [3] = 5 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 31, [1] = 118, [2] = 114, [3] = 27 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[41]][R[24]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 34, [2] = 120, [3] = 116 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 25, [1] = 21, [2] = 115, [3] = 107 }, [3] = { [0] = 29, [1] = 25, [2] = 119, [3] = 106 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[41]][R[24]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 32, [1] = 119, [2] = 115, [3] = 28 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 15, [1] = 110, [2] = 111, [3] = 9 } })[R[41]][R[24]] })
    if R[41] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[24]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[24]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[24]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[24]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[24]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [2] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 } })[R[67]][R[24]], ({ [0] = { [0] = 13, [1] = 111, [2] = 106, [3] = 8 }, [1] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [2] = { [0] = 25, [1] = 123, [2] = 118, [3] = 20 } })[R[67]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[24]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[24]] })
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 11, [2] = 116, [3] = 110 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 } })[R[68]][R[24]], ({ [0] = { [0] = 28, [1] = 115, [2] = 111, [3] = 24 }, [1] = { [0] = 30, [1] = 117, [2] = 113, [3] = 26 }, [2] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 } })[R[68]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 16, [1] = 12, [2] = 106, [3] = 98 }, [1] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [2] = { [0] = 34, [1] = 30, [2] = 124, [3] = 116 } })[R[69]][R[24]], ({ [0] = { [0] = 12, [1] = 106, [2] = 103, [3] = 9 }, [1] = { [0] = 28, [1] = 122, [2] = 119, [3] = 25 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 } })[R[69]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[24]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[24]] })
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [1] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 92 } })[R[70]][R[24]], ({ [0] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [1] = { [0] = 27, [1] = 123, [2] = 120, [3] = 19 }, [2] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 } })[R[70]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[24]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[24]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[24]] })
        for i = 1, game.initial_units() do
          R[71] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [1] = { [0] = 20, [1] = 14, [2] = 108, [3] = 96 }, [2] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 } })[R[71]][R[24]], ({ [0] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [1] = { [0] = 19, [1] = 115, [2] = 114, [3] = 11 }, [2] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 } })[R[71]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[24]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[24]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[24]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[24]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[24]] })
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [1] = { [0] = 4, [1] = 3, [2] = 94, [3] = 94 }, [2] = { [0] = 26, [1] = 25, [2] = 116, [3] = 116 } })[R[72]][R[24]], ({ [0] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 }, [1] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [2] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 } })[R[72]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[24]] })
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 6, [1] = 9, [2] = 102, [3] = 100 }, [1] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [2] = { [0] = 32, [1] = 35, [2] = 128, [3] = 126 } })[R[73]][R[24]], ({ [0] = { [0] = 13, [1] = 108, [2] = 111, [3] = 8 }, [1] = { [0] = 11, [1] = 106, [2] = 109, [3] = 6 }, [2] = { [0] = 26, [1] = 121, [2] = 124, [3] = 21 } })[R[73]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[41] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[24]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[24]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[24]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[24]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[24]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[24]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[24]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[24]] })
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 }, [1] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 }, [2] = { [0] = 7, [1] = 5, [2] = 101, [3] = 106 } })[R[74]][R[24]], ({ [0] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [1] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [2] = { [0] = 30, [1] = 125, [2] = 126, [3] = 24 } })[R[74]][R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[41]", R[41])
    end
    R[75] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 13, [1] = 107, [2] = 104, [3] = 10 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[75]][R[50]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 97 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[75]][R[50]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 11, [1] = 98, [2] = 94, [3] = 7 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
    if R[75] == 0 or R[75] == 1 or R[75] == 2 or R[75] == 5 or R[75] == 6 or R[75] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 21, [1] = 24, [2] = 117, [3] = 115 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 18, [1] = 105, [2] = 101, [3] = 14 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 27, [1] = 118, [2] = 116, [3] = 19 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      if R[75] == 0 then
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
      elseif R[75] == 1 then
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
      elseif R[75] == 2 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[50]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[50]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 27, [1] = 23, [2] = 117, [3] = 109 })[R[50]], ({ [0] = 18, [1] = 112, [2] = 109, [3] = 15 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[75] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[50]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[50]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[50]], ({ [0] = 20, [1] = 111, [2] = 109, [3] = 12 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[75] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 29, [1] = 32, [2] = 125, [3] = 123 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[75] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[75]", R[75])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = { [0] = 13, [1] = 16, [2] = 102, [3] = 98 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 12, [1] = 15, [2] = 108, [3] = 106 }, [7] = { [0] = 24, [1] = 22, [2] = 118, [3] = 123 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 28, [1] = 115, [2] = 111, [3] = 24 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 25, [1] = 120, [2] = 121, [3] = 19 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      if R[75] == 0 or R[75] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 } })[R[75]][R[50]], ({ [0] = { [0] = 26, [1] = 124, [2] = 119, [3] = 21 }, [1] = { [0] = 36, [1] = 123, [2] = 119, [3] = 32 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[75] == 2 or R[75] == 5 or R[75] == 6 or R[75] == 7 then
      else
        unseen("R[75]", R[75])
      end
    elseif R[75] == 3 or R[75] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 } })[R[75]][R[50]], ({ [3] = { [0] = 28, [1] = 124, [2] = 121, [3] = 20 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      if R[75] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[50]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[75] == 3 then
      else
        unseen("R[75]", R[75])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 36, [1] = 30, [2] = 124, [3] = 112 } })[R[75]][R[50]], ({ [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      if R[75] == 3 then
        if LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[50]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[50]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[50]], ({ [0] = 17, [1] = 113, [2] = 110, [3] = 9 })[R[50]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[75] == 4 then
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
        unseen("R[75]", R[75])
      end
    else
      unseen("R[75]", R[75])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = { [0] = 13, [1] = 16, [2] = 102, [3] = 98 }, [1] = { [0] = 13, [1] = 10, [2] = 115, [3] = 109 }, [2] = { [0] = 35, [1] = 31, [2] = 125, [3] = 117 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 17, [1] = 11, [2] = 105, [3] = 93 }, [5] = { [0] = 5, [1] = 4, [2] = 95, [3] = 95 }, [6] = { [0] = 4, [1] = 7, [2] = 100, [3] = 98 }, [7] = { [0] = 16, [1] = 14, [2] = 110, [3] = 115 } })[R[75]][R[50]], ({ [0] = { [0] = 28, [1] = 126, [2] = 121, [3] = 23 }, [1] = { [0] = 33, [1] = 120, [2] = 116, [3] = 29 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 11, [1] = 107, [2] = 104, [3] = 3 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 29, [1] = 124, [2] = 125, [3] = 23 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 35, [1] = 29, [2] = 123, [3] = 111 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[75]][R[50]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 13, [1] = 104, [2] = 102, [3] = 5 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[75]][R[50]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 17, [1] = 104, [2] = 100, [3] = 13 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[4].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 36, [1] = 32, [2] = 126, [3] = 113 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[75]][R[50]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[75]][R[50]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[75]][R[50]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[75]][R[50]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[75]][R[50]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 10, [1] = 9, [2] = 100, [3] = 100 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 10, [1] = 8, [2] = 104, [3] = 109 } })[R[75]][R[50]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 26, [1] = 120, [2] = 117, [3] = 23 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 12, [1] = 103, [2] = 101, [3] = 4 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 32, [1] = 26, [2] = 120, [3] = 108 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 5, [1] = 3, [2] = 99, [3] = 104 } })[R[75]][R[50]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 10, [1] = 97, [2] = 93, [3] = 6 }, [2] = { [0] = 27, [1] = 121, [2] = 118, [3] = 24 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 22, [1] = 117, [2] = 120, [3] = 17 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 36, [1] = 32, [2] = 126, [3] = 113 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[75]][R[50]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[75]][R[50]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 12, [1] = 9, [2] = 114, [3] = 108 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 37, [1] = 31, [2] = 125, [3] = 113 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 9, [1] = 12, [2] = 105, [3] = 103 }, [7] = { [0] = 26, [1] = 24, [2] = 120, [3] = 125 } })[R[75]][R[50]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 15, [1] = 106, [2] = 104, [3] = 7 }, [6] = { [0] = 28, [1] = 123, [2] = 126, [3] = 23 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[75]][R[50]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 16, [1] = 12, [2] = 106, [3] = 93 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 10, [1] = 9, [2] = 100, [3] = 100 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 10, [1] = 8, [2] = 104, [3] = 109 } })[R[75]][R[50]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 26, [1] = 120, [2] = 117, [3] = 23 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 12, [1] = 103, [2] = 101, [3] = 4 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 32, [1] = 26, [2] = 120, [3] = 108 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 5, [1] = 3, [2] = 99, [3] = 104 } })[R[75]][R[50]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 10, [1] = 97, [2] = 93, [3] = 6 }, [2] = { [0] = 27, [1] = 121, [2] = 118, [3] = 24 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 22, [1] = 117, [2] = 120, [3] = 17 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 36, [1] = 32, [2] = 126, [3] = 113 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[75]][R[50]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 18, [1] = 114, [2] = 111, [3] = 10 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 13, [1] = 9, [2] = 103, [3] = 95 }, [3] = { [0] = 34, [1] = 30, [2] = 124, [3] = 111 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 25, [1] = 23, [2] = 119, [3] = 124 } })[R[75]][R[50]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 19, [1] = 106, [2] = 102, [3] = 15 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 14, [1] = 110, [2] = 107, [3] = 6 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 31, [1] = 27, [2] = 121, [3] = 113 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 10, [1] = 9, [2] = 100, [3] = 100 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 10, [1] = 8, [2] = 104, [3] = 109 } })[R[75]][R[50]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 26, [1] = 120, [2] = 117, [3] = 23 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 12, [1] = 103, [2] = 101, [3] = 4 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[75]], player = players[4], at = { ({ [0] = { [0] = 15, [1] = 18, [2] = 104, [3] = 100 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 27, [1] = 23, [2] = 117, [3] = 109 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 32, [1] = 26, [2] = 120, [3] = 108 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 5, [1] = 3, [2] = 99, [3] = 104 } })[R[75]][R[50]], ({ [0] = { [0] = 12, [1] = 110, [2] = 105, [3] = 7 }, [1] = { [0] = 10, [1] = 97, [2] = 93, [3] = 6 }, [2] = { [0] = 27, [1] = 121, [2] = 118, [3] = 24 }, [3] = { [0] = 29, [1] = 125, [2] = 122, [3] = 21 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 22, [1] = 117, [2] = 120, [3] = 17 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 36, [1] = 39, [2] = 125, [3] = 121 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 38, [1] = 32, [2] = 126, [3] = 114 }, [5] = { [0] = 11, [1] = 10, [2] = 101, [3] = 101 }, [6] = { [0] = 25, [1] = 28, [2] = 121, [3] = 119 }, [7] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 } })[R[75]][R[50]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 15, [1] = 111, [2] = 108, [3] = 7 }, [4] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [5] = { [0] = 29, [1] = 120, [2] = 118, [3] = 21 }, [6] = { [0] = 25, [1] = 120, [2] = 123, [3] = 20 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[75]][R[50]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 16, [1] = 19, [2] = 105, [3] = 101 }, [1] = { [0] = 15, [1] = 12, [2] = 117, [3] = 111 }, [2] = { [0] = 18, [1] = 14, [2] = 108, [3] = 100 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 }, [5] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 16, [1] = 111, [2] = 112, [3] = 10 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 19, [1] = 15, [2] = 109, [3] = 101 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 25, [1] = 121, [2] = 118, [3] = 17 }, [4] = { [0] = 15, [1] = 111, [2] = 110, [3] = 7 }, [5] = { [0] = 19, [1] = 110, [2] = 108, [3] = 11 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 17, [1] = 112, [2] = 113, [3] = 11 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 18, [1] = 21, [2] = 107, [3] = 103 }, [1] = { [0] = 17, [1] = 14, [2] = 119, [3] = 113 }, [2] = { [0] = 20, [1] = 16, [2] = 110, [3] = 102 }, [3] = { [0] = 18, [1] = 14, [2] = 108, [3] = 95 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 26, [1] = 122, [2] = 119, [3] = 18 }, [4] = { [0] = 16, [1] = 112, [2] = 111, [3] = 8 }, [5] = { [0] = 20, [1] = 111, [2] = 109, [3] = 12 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 18, [1] = 113, [2] = 114, [3] = 12 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 19, [1] = 22, [2] = 108, [3] = 104 }, [1] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 19, [1] = 15, [2] = 109, [3] = 96 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 15, [1] = 109, [2] = 106, [3] = 12 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 17, [1] = 113, [2] = 112, [3] = 9 }, [5] = { [0] = 24, [1] = 115, [2] = 113, [3] = 16 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 19, [1] = 114, [2] = 115, [3] = 13 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 20, [1] = 23, [2] = 109, [3] = 105 }, [1] = { [0] = 19, [1] = 16, [2] = 121, [3] = 115 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 16, [1] = 110, [2] = 107, [3] = 13 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 18, [1] = 114, [2] = 113, [3] = 10 }, [5] = { [0] = 25, [1] = 116, [2] = 114, [3] = 17 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 20, [1] = 115, [2] = 116, [3] = 14 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 21, [1] = 24, [2] = 110, [3] = 106 }, [1] = { [0] = 20, [1] = 17, [2] = 122, [3] = 116 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 15, [1] = 14, [2] = 105, [3] = 105 }, [6] = { [0] = 14, [1] = 17, [2] = 110, [3] = 108 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 17, [1] = 111, [2] = 108, [3] = 14 }, [3] = { [0] = 21, [1] = 117, [2] = 114, [3] = 13 }, [4] = { [0] = 22, [1] = 118, [2] = 117, [3] = 14 }, [5] = { [0] = 26, [1] = 117, [2] = 115, [3] = 18 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 21, [1] = 116, [2] = 117, [3] = 15 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 22, [1] = 25, [2] = 111, [3] = 107 }, [1] = { [0] = 21, [1] = 18, [2] = 123, [3] = 117 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 22, [1] = 118, [2] = 115, [3] = 14 }, [4] = { [0] = 23, [1] = 119, [2] = 118, [3] = 15 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 22, [1] = 117, [2] = 118, [3] = 16 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 18, [1] = 17, [2] = 108, [3] = 108 }, [6] = { [0] = 15, [1] = 18, [2] = 111, [3] = 109 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[75]][R[50]], ({ [0] = { [0] = 14, [1] = 112, [2] = 107, [3] = 9 }, [1] = { [0] = 13, [1] = 100, [2] = 96, [3] = 9 }, [2] = { [0] = 19, [1] = 113, [2] = 110, [3] = 16 }, [3] = { [0] = 23, [1] = 119, [2] = 116, [3] = 15 }, [4] = { [0] = 24, [1] = 120, [2] = 119, [3] = 16 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 23, [1] = 118, [2] = 119, [3] = 17 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 20, [1] = 16, [2] = 110, [3] = 97 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 8, [1] = 6, [2] = 102, [3] = 107 } })[R[75]][R[50]], ({ [0] = { [0] = 15, [1] = 113, [2] = 108, [3] = 10 }, [1] = { [0] = 14, [1] = 101, [2] = 97, [3] = 10 }, [2] = { [0] = 20, [1] = 114, [2] = 111, [3] = 17 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 25, [1] = 121, [2] = 120, [3] = 17 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 24, [1] = 119, [2] = 120, [3] = 18 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 25, [1] = 19, [2] = 113, [3] = 101 }, [5] = { [0] = 19, [1] = 18, [2] = 109, [3] = 109 }, [6] = { [0] = 16, [1] = 19, [2] = 112, [3] = 110 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[75]][R[50]], ({ [0] = { [0] = 16, [1] = 114, [2] = 109, [3] = 11 }, [1] = { [0] = 15, [1] = 102, [2] = 98, [3] = 11 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 }, [3] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [4] = { [0] = 26, [1] = 122, [2] = 121, [3] = 18 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 21, [1] = 17, [2] = 111, [3] = 98 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 11, [1] = 9, [2] = 105, [3] = 110 } })[R[75]][R[50]], ({ [0] = { [0] = 17, [1] = 115, [2] = 110, [3] = 12 }, [1] = { [0] = 16, [1] = 103, [2] = 99, [3] = 12 }, [2] = { [0] = 22, [1] = 116, [2] = 113, [3] = 19 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 22, [1] = 19, [2] = 124, [3] = 118 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 22, [1] = 18, [2] = 112, [3] = 99 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 20, [1] = 19, [2] = 110, [3] = 110 }, [6] = { [0] = 17, [1] = 20, [2] = 113, [3] = 111 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[75]][R[50]], ({ [0] = { [0] = 21, [1] = 119, [2] = 114, [3] = 16 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 23, [1] = 117, [2] = 114, [3] = 20 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [3] = { [0] = 23, [1] = 19, [2] = 113, [3] = 100 }, [4] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 12, [1] = 10, [2] = 106, [3] = 111 } })[R[75]][R[50]], ({ [0] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [1] = { [0] = 21, [1] = 108, [2] = 104, [3] = 17 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 15, [1] = 110, [2] = 113, [3] = 10 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [6] = { [0] = 18, [1] = 21, [2] = 114, [3] = 112 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[75]][R[50]], ({ [0] = { [0] = 23, [1] = 121, [2] = 116, [3] = 18 }, [1] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 27, [2] = 113, [3] = 109 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 22, [1] = 18, [2] = 112, [3] = 104 }, [3] = { [0] = 24, [1] = 20, [2] = 114, [3] = 101 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 } })[R[75]][R[50]], ({ [0] = { [0] = 24, [1] = 122, [2] = 117, [3] = 19 }, [1] = { [0] = 23, [1] = 110, [2] = 106, [3] = 19 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 17, [1] = 112, [2] = 115, [3] = 12 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 30, [2] = 116, [3] = 112 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 25, [1] = 21, [2] = 115, [3] = 102 }, [4] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [5] = { [0] = 22, [1] = 21, [2] = 112, [3] = 112 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 24, [1] = 111, [2] = 107, [3] = 20 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 28, [1] = 119, [2] = 117, [3] = 20 }, [6] = { [0] = 18, [1] = 113, [2] = 116, [3] = 13 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 31, [2] = 117, [3] = 113 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 23, [1] = 19, [2] = 113, [3] = 105 }, [3] = { [0] = 26, [1] = 22, [2] = 116, [3] = 103 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 23, [1] = 22, [2] = 113, [3] = 113 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 14, [1] = 12, [2] = 108, [3] = 113 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 25, [1] = 112, [2] = 108, [3] = 21 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 12, [1] = 108, [2] = 107, [3] = 4 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 19, [1] = 114, [2] = 117, [3] = 14 }, [7] = { [0] = 26, [1] = 121, [2] = 122, [3] = 20 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 24, [1] = 23, [2] = 114, [3] = 114 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 26, [1] = 113, [2] = 109, [3] = 22 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 13, [1] = 109, [2] = 108, [3] = 5 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 20, [1] = 115, [2] = 118, [3] = 15 }, [7] = { [0] = 13, [1] = 108, [2] = 109, [3] = 7 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 24, [1] = 20, [2] = 114, [3] = 106 }, [3] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 20, [1] = 23, [2] = 116, [3] = 114 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 31, [1] = 118, [2] = 114, [3] = 27 }, [2] = { [0] = 24, [1] = 118, [2] = 115, [3] = 21 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 20, [1] = 116, [2] = 115, [3] = 12 }, [5] = { [0] = 22, [1] = 113, [2] = 111, [3] = 14 }, [6] = { [0] = 21, [1] = 116, [2] = 119, [3] = 16 }, [7] = { [0] = 14, [1] = 109, [2] = 110, [3] = 8 } })[R[75]][R[50]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 34, [2] = 120, [3] = 116 }, [1] = { [0] = 23, [1] = 20, [2] = 125, [3] = 119 }, [2] = { [0] = 25, [1] = 21, [2] = 115, [3] = 107 }, [3] = { [0] = 29, [1] = 25, [2] = 119, [3] = 106 }, [4] = { [0] = 30, [1] = 24, [2] = 118, [3] = 106 }, [5] = { [0] = 25, [1] = 24, [2] = 115, [3] = 115 }, [6] = { [0] = 24, [1] = 27, [2] = 120, [3] = 118 }, [7] = { [0] = 15, [1] = 13, [2] = 109, [3] = 114 } })[R[75]][R[50]], ({ [0] = { [0] = 19, [1] = 117, [2] = 112, [3] = 14 }, [1] = { [0] = 32, [1] = 119, [2] = 115, [3] = 28 }, [2] = { [0] = 18, [1] = 112, [2] = 109, [3] = 15 }, [3] = { [0] = 17, [1] = 113, [2] = 110, [3] = 9 }, [4] = { [0] = 28, [1] = 124, [2] = 123, [3] = 20 }, [5] = { [0] = 23, [1] = 114, [2] = 112, [3] = 15 }, [6] = { [0] = 23, [1] = 118, [2] = 121, [3] = 18 }, [7] = { [0] = 15, [1] = 110, [2] = 111, [3] = 9 } })[R[75]][R[50]] })
    if R[75] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[50]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[50]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[50]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 32, [1] = 35, [2] = 121, [3] = 117 })[R[50]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 36, [2] = 122, [3] = 118 })[R[50]], ({ [0] = 19, [1] = 117, [2] = 112, [3] = 14 })[R[50]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 30, [1] = 33, [2] = 119, [3] = 115 }, [1] = { [0] = 17, [1] = 20, [2] = 106, [3] = 102 }, [2] = { [0] = 29, [1] = 32, [2] = 118, [3] = 114 } })[R[76]][R[50]], ({ [0] = { [0] = 13, [1] = 111, [2] = 106, [3] = 8 }, [1] = { [0] = 22, [1] = 120, [2] = 115, [3] = 17 }, [2] = { [0] = 25, [1] = 123, [2] = 118, [3] = 20 } })[R[76]][R[50]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[50]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[50]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[50]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[50]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[50]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[50]], ({ [0] = 33, [1] = 120, [2] = 116, [3] = 29 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 20, [2] = 125, [3] = 119 })[R[50]], ({ [0] = 34, [1] = 121, [2] = 117, [3] = 30 })[R[50]] })
        for i = 1, game.initial_units() do
          R[77] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 14, [1] = 11, [2] = 116, [3] = 110 }, [1] = { [0] = 16, [1] = 13, [2] = 118, [3] = 112 }, [2] = { [0] = 18, [1] = 15, [2] = 120, [3] = 114 } })[R[77]][R[50]], ({ [0] = { [0] = 28, [1] = 115, [2] = 111, [3] = 24 }, [1] = { [0] = 30, [1] = 117, [2] = 113, [3] = 26 }, [2] = { [0] = 22, [1] = 109, [2] = 105, [3] = 18 } })[R[77]][R[50]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[78] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 16, [1] = 12, [2] = 106, [3] = 98 }, [1] = { [0] = 21, [1] = 17, [2] = 111, [3] = 103 }, [2] = { [0] = 34, [1] = 30, [2] = 124, [3] = 116 } })[R[78]][R[50]], ({ [0] = { [0] = 12, [1] = 106, [2] = 103, [3] = 9 }, [1] = { [0] = 28, [1] = 122, [2] = 119, [3] = 25 }, [2] = { [0] = 21, [1] = 115, [2] = 112, [3] = 18 } })[R[78]][R[50]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[50]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[50]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[50]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[50]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[50]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[50]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 29, [1] = 25, [2] = 119, [3] = 106 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 30, [1] = 26, [2] = 120, [3] = 107 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 31, [1] = 27, [2] = 121, [3] = 108 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 32, [1] = 28, [2] = 122, [3] = 109 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 113, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[50]], ({ [0] = 21, [1] = 117, [2] = 114, [3] = 13 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[50]], ({ [0] = 22, [1] = 118, [2] = 115, [3] = 14 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[50]], ({ [0] = 23, [1] = 119, [2] = 116, [3] = 15 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 29, [2] = 123, [3] = 110 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[50]], ({ [0] = 24, [1] = 120, [2] = 117, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[50]], ({ [0] = 25, [1] = 121, [2] = 118, [3] = 17 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 30, [2] = 124, [3] = 111 })[R[50]], ({ [0] = 26, [1] = 122, [2] = 119, [3] = 18 })[R[50]] })
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 27, [1] = 23, [2] = 117, [3] = 104 }, [1] = { [0] = 28, [1] = 24, [2] = 118, [3] = 105 }, [2] = { [0] = 15, [1] = 11, [2] = 105, [3] = 92 } })[R[79]][R[50]], ({ [0] = { [0] = 20, [1] = 116, [2] = 113, [3] = 12 }, [1] = { [0] = 27, [1] = 123, [2] = 120, [3] = 19 }, [2] = { [0] = 24, [1] = 120, [2] = 117, [3] = 16 } })[R[79]][R[50]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[50]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[50]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[50]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[50]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[50]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[50]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[50]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[50]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[50]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[50]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[50]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[50]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[50]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[50]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[50]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[50]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[50]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[50]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[50]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[50]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[50]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[50]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[50]], ({ [0] = 13, [1] = 109, [2] = 108, [3] = 5 })[R[50]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[50]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[50]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 31, [1] = 25, [2] = 119, [3] = 107 })[R[50]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[50]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[50]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 32, [1] = 26, [2] = 120, [3] = 108 })[R[50]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[50]], ({ [0] = 14, [1] = 110, [2] = 109, [3] = 6 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 33, [1] = 27, [2] = 121, [3] = 109 })[R[50]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 20, [1] = 116, [2] = 115, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 21, [1] = 117, [2] = 116, [3] = 13 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 22, [1] = 118, [2] = 117, [3] = 14 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[50]] })
        game.create_tube({ ({ [0] = 34, [1] = 28, [2] = 122, [3] = 110 })[R[50]], ({ [0] = 28, [1] = 124, [2] = 123, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[50]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[50]] })
        game.create_tube({ ({ [0] = 35, [1] = 29, [2] = 123, [3] = 111 })[R[50]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[50]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[50]], ({ [0] = 17, [1] = 113, [2] = 112, [3] = 9 })[R[50]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[50]], ({ [0] = 18, [1] = 114, [2] = 113, [3] = 10 })[R[50]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[50]], ({ [0] = 19, [1] = 115, [2] = 114, [3] = 11 })[R[50]] })
        game.create_tube({ ({ [0] = 36, [1] = 30, [2] = 124, [3] = 112 })[R[50]], ({ [0] = 27, [1] = 123, [2] = 122, [3] = 19 })[R[50]] })
        for i = 1, game.initial_units() do
          R[80] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 29, [1] = 23, [2] = 117, [3] = 105 }, [1] = { [0] = 20, [1] = 14, [2] = 108, [3] = 96 }, [2] = { [0] = 28, [1] = 22, [2] = 116, [3] = 104 } })[R[80]][R[50]], ({ [0] = { [0] = 11, [1] = 107, [2] = 106, [3] = 3 }, [1] = { [0] = 19, [1] = 115, [2] = 114, [3] = 11 }, [2] = { [0] = 14, [1] = 110, [2] = 109, [3] = 6 } })[R[80]][R[50]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[50]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[50]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[50]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[50]], ({ [0] = 24, [1] = 115, [2] = 113, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 25, [1] = 24, [2] = 115, [3] = 115 })[R[50]], ({ [0] = 25, [1] = 116, [2] = 114, [3] = 17 })[R[50]] })
        for i = 1, game.initial_units() do
          R[81] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 21, [1] = 20, [2] = 111, [3] = 111 }, [1] = { [0] = 4, [1] = 3, [2] = 94, [3] = 94 }, [2] = { [0] = 26, [1] = 25, [2] = 116, [3] = 116 } })[R[81]][R[50]], ({ [0] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 }, [1] = { [0] = 18, [1] = 109, [2] = 107, [3] = 10 }, [2] = { [0] = 31, [1] = 122, [2] = 120, [3] = 23 } })[R[81]][R[50]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[50]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[50]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[50]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 25, [1] = 28, [2] = 121, [3] = 119 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[50]] })
        game.create_tube({ ({ [0] = 26, [1] = 29, [2] = 122, [3] = 120 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[50]] })
        game.create_tube({ ({ [0] = 27, [1] = 30, [2] = 123, [3] = 121 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 121, [3] = 18 })[R[50]] })
        for i = 1, game.initial_units() do
          R[82] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 6, [1] = 9, [2] = 102, [3] = 100 }, [1] = { [0] = 11, [1] = 14, [2] = 107, [3] = 105 }, [2] = { [0] = 32, [1] = 35, [2] = 128, [3] = 126 } })[R[82]][R[50]], ({ [0] = { [0] = 13, [1] = 108, [2] = 111, [3] = 8 }, [1] = { [0] = 11, [1] = 106, [2] = 109, [3] = 6 }, [2] = { [0] = 26, [1] = 121, [2] = 124, [3] = 21 } })[R[82]][R[50]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[50]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 24, [1] = 119, [2] = 120, [3] = 18 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 25, [1] = 120, [2] = 121, [3] = 19 })[R[50]] })
        game.create_tube({ ({ [0] = 15, [1] = 13, [2] = 109, [3] = 114 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 16, [1] = 14, [2] = 110, [3] = 115 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 17, [1] = 15, [2] = 111, [3] = 116 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 18, [1] = 16, [2] = 112, [3] = 117 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 19, [1] = 17, [2] = 113, [3] = 118 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 20, [1] = 18, [2] = 114, [3] = 119 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[50]], ({ [0] = 13, [1] = 108, [2] = 109, [3] = 7 })[R[50]] })
        game.create_tube({ ({ [0] = 21, [1] = 19, [2] = 115, [3] = 120 })[R[50]], ({ [0] = 26, [1] = 121, [2] = 122, [3] = 20 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 15, [1] = 110, [2] = 111, [3] = 9 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 16, [1] = 111, [2] = 112, [3] = 10 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 17, [1] = 112, [2] = 113, [3] = 11 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 18, [1] = 113, [2] = 114, [3] = 12 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 19, [1] = 114, [2] = 115, [3] = 13 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 20, [1] = 115, [2] = 116, [3] = 14 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 21, [1] = 116, [2] = 117, [3] = 15 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 22, [1] = 117, [2] = 118, [3] = 16 })[R[50]] })
        game.create_tube({ ({ [0] = 23, [1] = 21, [2] = 117, [3] = 122 })[R[50]], ({ [0] = 23, [1] = 118, [2] = 119, [3] = 17 })[R[50]] })
        for i = 1, game.initial_units() do
          R[83] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 13, [1] = 11, [2] = 107, [3] = 112 }, [1] = { [0] = 19, [1] = 17, [2] = 113, [3] = 118 }, [2] = { [0] = 7, [1] = 5, [2] = 101, [3] = 106 } })[R[83]][R[50]], ({ [0] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [1] = { [0] = 9, [1] = 104, [2] = 105, [3] = 3 }, [2] = { [0] = 30, [1] = 125, [2] = 126, [3] = 24 } })[R[83]][R[50]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[75]", R[75])
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
    trigger.time{min = 18000, max = 36000, one_shot = false, on = Meteor}  -- after 180 to 360 marks
    trigger.time{min = 12000, max = 18000, one_shot = false, on = Storm}  -- after 120 to 180 marks
  end
  return true
end
