-- ml2_03Lua.lua  -  2 Player, LastOne, 'River of Fire' map. (Lua)
--
-- Converted by op2dll from ml2_03.dll ("2 Player, LastOne, 'River of Fire' map."): its setup replayed. `on_init` makes the original's
-- draws of the game's random numbers in its order and, from them and the lobby, the same units,
-- beacons, walls and settings in the same order, as the original's setup did in every game
-- sampled (every player count, the lobby's colonies, resource levels, vehicles, day and night,
-- morale and disasters). Anything not converted is listed at the end. Coordinates are the in-game
-- status-bar ones (map file tile + 1).

-- Where lava may flow from an eruption, as areas { x1, y1, x2, y2 }.
local LAVA_POSSIBLE = {
  { 14, 6, 14, 6 }, { 11, 7, 14, 7 }, { 11, 8, 13, 8 }, { 10, 9, 12, 10 }, { 10, 11, 13, 11 }, { 10, 12, 15, 12 },
  { 12, 13, 18, 13 }, { 13, 14, 19, 15 }, { 15, 16, 20, 16 }, { 16, 17, 20, 17 }, { 17, 18, 20, 18 }, { 17, 19, 19, 19 },
  { 15, 20, 19, 20 }, { 15, 21, 18, 22 }, { 15, 23, 17, 23 }, { 13, 24, 17, 24 }, { 12, 25, 17, 26 }, { 12, 27, 18, 28 },
  { 27, 28, 27, 28 }, { 12, 29, 13, 29 }, { 16, 29, 21, 29 }, { 26, 29, 28, 29 }, { 16, 30, 30, 32 }, { 16, 33, 31, 33 },
  { 15, 34, 31, 35 }, { 13, 36, 32, 36 }, { 12, 37, 34, 37 }, { 9, 38, 34, 38 }, { 8, 39, 33, 39 }, { 8, 40, 16, 40 },
  { 22, 40, 23, 40 }, { 29, 40, 33, 40 }, { 30, 41, 34, 41 }, { 32, 42, 36, 42 }, { 32, 43, 37, 46 }, { 33, 47, 38, 47 },
  { 33, 48, 39, 48 }, { 32, 49, 40, 49 }, { 32, 50, 41, 51 }, { 32, 52, 40, 52 }, { 34, 53, 40, 54 }, { 35, 55, 39, 55 },
  { 45, 55, 46, 55 }, { 36, 56, 39, 56 }, { 44, 56, 47, 56 }, { 37, 57, 47, 57 }, { 37, 58, 48, 58 }, { 38, 59, 49, 59 },
  { 33, 60, 35, 60 }, { 39, 60, 50, 61 }, { 32, 61, 36, 61 }, { 32, 62, 50, 62 }, { 31, 63, 50, 63 }, { 29, 64, 50, 64 },
  { 28, 65, 50, 65 }, { 27, 66, 43, 66 }, { 46, 66, 50, 66 }, { 26, 67, 42, 67 }, { 46, 67, 52, 67 }, { 25, 68, 37, 68 },
  { 47, 68, 54, 68 }, { 27, 69, 36, 69 }, { 47, 69, 55, 70 }, { 28, 70, 36, 70 }, { 29, 71, 36, 71 }, { 46, 71, 55, 71 },
  { 30, 72, 36, 72 }, { 44, 72, 55, 72 }, { 30, 73, 38, 73 }, { 45, 73, 54, 73 }, { 30, 74, 37, 74 }, { 47, 74, 54, 75 },
  { 29, 75, 36, 77 }, { 47, 76, 53, 77 }, { 29, 78, 38, 78 }, { 44, 78, 51, 78 }, { 30, 79, 39, 79 }, { 42, 79, 51, 79 },
  { 31, 80, 52, 80 }, { 32, 81, 53, 81 }, { 33, 82, 53, 83 }, { 33, 84, 52, 85 }, { 34, 86, 52, 86 }, { 35, 87, 35, 87 },
  { 39, 87, 51, 87 }, { 39, 88, 49, 88 }, { 40, 89, 49, 89 }, { 41, 90, 47, 90 }, { 41, 91, 46, 92 }, { 41, 93, 47, 93 },
  { 41, 94, 48, 94 }, { 43, 95, 49, 95 }, { 44, 96, 49, 96 }, { 44, 97, 50, 98 }, { 45, 99, 51, 100 }, { 47, 101, 51, 101 },
  { 47, 102, 50, 102 }, { 47, 103, 49, 105 }, { 47, 106, 50, 108 }, { 47, 109, 52, 109 }, { 48, 110, 55, 110 },
}

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
local Boom, OneMine, Quake, TwoMine

function Boom(t)
  game.create_eruption({ 37, 73 }, 200)
  game.create_eruption({ 45, 72 }, 200)
end

function OneMine(t)
  trigger.count{type = "CommonOreMine", cargo = "None", compare = ">=", count = 1, player = 2, one_shot = true, on = TwoMine}
end

function Quake(t)
  local r1 = game.rand(18)
  game.create_earthquake({ ({ 21, 22, 22, 62, 37, 12, 24, 20, 48, 41, 43, 60, 41, 60, 6, 13, 28, 55 })[r1 + 1], ({ 7, 9, 11, 4, 123, 78, 58, 26, 41, 63, 85, 123, 70, 126, 8, 73, 72, 81 })[r1 + 1] }, ({ 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4 })[r1 + 1])
end

function TwoMine(t)
  trigger.time{min = 2400, max = 12000, on = Boom}  -- after 24 to 120 marks
end

function on_init()
  local n = game.num_players()
  for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 45, 50 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 24, 24 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 55, 99 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 52, 39 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 20, 26 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 22, 11 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 63, 3 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 16, 41 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 24, 57 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 37, 122 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 5, 115 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 28, 4 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 56, 50 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 53, 105 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 10, 17 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 26, 46 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 6, 76 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 9, 126 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 52, 115 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 52, 72 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 27, 30 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 42, 91 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 58, 26 } }
  game.initial_set_tile({ 38, 72 }, 1095)
  game.initial_set_tile({ 38, 73 }, 1118)
  game.initial_set_tile({ 39, 72 }, 1107)
  game.initial_set_tile({ 39, 73 }, 1129)
  game.initial_set_tile({ 43, 71 }, 1161)
  game.initial_set_tile({ 43, 72 }, 1184)
  game.initial_set_tile({ 44, 71 }, 1172)
  game.initial_set_tile({ 44, 72 }, 1195)
  pick(2, 2, { 0, 1 })
  R[2] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 32 }, [1] = { [0] = 18, [1] = 36 }, [2] = { [0] = 18, [1] = 36 }, [3] = { [0] = 10, [1] = 28 }, [4] = { [0] = 14, [1] = 32 }, [5] = { [0] = 13, [1] = 31 }, [6] = { [0] = 10, [1] = 28 }, [7] = { [0] = 16, [1] = 34 } })[R[2]][R[1]], ({ [0] = { [0] = 111, [1] = 18 }, [1] = { [0] = 107, [1] = 14 }, [2] = { [0] = 111, [1] = 18 }, [3] = { [0] = 107, [1] = 14 }, [4] = { [0] = 110, [1] = 17 }, [5] = { [0] = 108, [1] = 15 }, [6] = { [0] = 105, [1] = 12 }, [7] = { [0] = 108, [1] = 15 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  players[1]:center_view({ ({ [0] = { [0] = 14, [1] = 32 }, [1] = { [0] = 18, [1] = 36 }, [2] = { [0] = 18, [1] = 36 }, [3] = { [0] = 10, [1] = 28 }, [4] = { [0] = 14, [1] = 32 }, [5] = { [0] = 13, [1] = 31 }, [6] = { [0] = 10, [1] = 28 }, [7] = { [0] = 16, [1] = 34 } })[R[2]][R[1]], ({ [0] = { [0] = 111, [1] = 18 }, [1] = { [0] = 107, [1] = 14 }, [2] = { [0] = 111, [1] = 18 }, [3] = { [0] = 107, [1] = 14 }, [4] = { [0] = 110, [1] = 17 }, [5] = { [0] = 108, [1] = 15 }, [6] = { [0] = 105, [1] = 12 }, [7] = { [0] = 108, [1] = 15 } })[R[2]][R[1]] })
  if R[2] == 1 or R[2] == 2 or R[2] == 3 or R[2] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 36 }, [2] = { [0] = 11, [1] = 29 }, [3] = { [0] = 15, [1] = 33 }, [4] = { [0] = 11, [1] = 29 } })[R[2]][R[1]], ({ [0] = 114, [1] = 21 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 1 or R[2] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 9, [1] = 27 }, [2] = { [0] = 10, [1] = 28 } })[R[2]][R[1]], ({ [0] = 105, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 18, [1] = 36 })[R[1]], ({ [1] = { [0] = 110, [1] = 17 }, [2] = { [0] = 114, [1] = 21 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 13, [1] = 31 }, [2] = { [0] = 14, [1] = 32 } })[R[2]][R[1]], ({ [1] = { [0] = 115, [1] = 22 }, [2] = { [0] = 111, [1] = 18 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 13, [1] = 31 }, [2] = { [0] = 18, [1] = 36 } })[R[2]][R[1]], ({ [1] = { [0] = 111, [1] = 18 }, [2] = { [0] = 108, [1] = 15 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 19, [1] = 37 }, [2] = { [0] = 17, [1] = 35 } })[R[2]][R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 20, [1] = 38 }, [2] = { [0] = 19, [1] = 37 } })[R[2]][R[1]], ({ [1] = { [0] = 115, [1] = 22 }, [2] = { [0] = 116, [1] = 23 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 11, [1] = 29 })[R[1]], ({ [0] = 106, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 107, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 10, [1] = 28 })[R[1]], ({ [0] = 110, [1] = 17 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 19, [1] = 37 })[R[1]], ({ [0] = 115, [1] = 22 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 104, [1] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 14, [1] = 32 })[R[1]], ({ [0] = 105, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 10, [1] = 28 })[R[1]], ({ [0] = 115, [1] = 22 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 17, [1] = 35 })[R[1]], ({ [0] = 111, [1] = 18 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 11, [1] = 29 })[R[1]], ({ [0] = 110, [1] = 17 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 19, [1] = 37 })[R[1]], ({ [0] = 105, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 16, [1] = 34 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 35 })[R[1]], ({ [0] = 115, [1] = 22 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    if R[2] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 35 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 115, [1] = 22 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 36 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 8, [1] = 26 })[R[1]], ({ [0] = 112, [1] = 19 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 14, [1] = 32 })[R[1]], ({ [0] = 105, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    if R[2] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 38 })[R[1]], ({ [0] = 112, [1] = 19 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 2 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 12, [1] = 30 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 12, [1] = 30 })[R[1]], ({ [0] = 112, [1] = 19 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 12, [1] = 30 })[R[1]], ({ [0] = 108, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 8, [1] = 26 })[R[1]], ({ [0] = 112, [1] = 19 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 20, [1] = 38 }, [2] = { [0] = 12, [1] = 30 }, [3] = { [0] = 12, [1] = 30 }, [4] = { [0] = 12, [1] = 30 } })[R[2]][R[1]], ({ [1] = { [0] = 112, [1] = 19 }, [2] = { [0] = 116, [1] = 23 }, [3] = { [0] = 112, [1] = 19 }, [4] = { [0] = 108, [1] = 15 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[2] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 11, [1] = 29 })[R[1]], ({ [0] = 114, [1] = 21 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 16, [1] = 34 })[R[1]], ({ [0] = 114, [1] = 21 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 10, [1] = 28 })[R[1]], ({ [0] = 111, [1] = 18 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 18, [1] = 36 })[R[1]], ({ [0] = 111, [1] = 18 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 19, [1] = 37 })[R[1]], ({ [0] = 105, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 35 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 36 })[R[1]], ({ [0] = 115, [1] = 22 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 38 })[R[1]], ({ [0] = 114, [1] = 21 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[2] == 5 or R[2] == 6 or R[2] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 10, [1] = 28 }, [6] = { [0] = 19, [1] = 37 }, [7] = { [0] = 10, [1] = 28 } })[R[2]][R[1]], ({ [0] = 115, [1] = 22 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 18, [1] = 36 }, [6] = { [0] = 10, [1] = 28 }, [7] = { [0] = 18, [1] = 36 } })[R[2]][R[1]], ({ [5] = { [0] = 109, [1] = 16 }, [6] = { [0] = 114, [1] = 21 }, [7] = { [0] = 114, [1] = 21 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 5 or R[2] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 18, [1] = 36 }, [7] = { [0] = 11, [1] = 29 } })[R[2]][R[1]], ({ [0] = 105, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 5 then
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
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 105, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 105, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 105, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 17, [1] = 35 }, [7] = { [0] = 16, [1] = 34 } })[R[2]][R[1]], ({ [5] = { [0] = 113, [1] = 20 }, [7] = { [0] = 111, [1] = 18 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 5 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 105, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 7 then
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [5] = { [0] = 111, [1] = 18 }, [7] = { [0] = 108, [1] = 15 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 14, [1] = 32 })[R[1]], ({ [5] = { [0] = 110, [1] = 17 }, [7] = { [0] = 109, [1] = 16 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 14, [1] = 32 }, [7] = { [0] = 19, [1] = 37 } })[R[2]][R[1]], ({ [5] = { [0] = 112, [1] = 19 }, [7] = { [0] = 109, [1] = 16 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[2] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 10, [1] = 28 })[R[1]], ({ [0] = 111, [1] = 18 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 10, [1] = 28 })[R[1]], ({ [0] = 108, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 106, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 20, [1] = 38 }, [6] = { [0] = 17, [1] = 35 }, [7] = { [0] = 13, [1] = 31 } })[R[2]][R[1]], ({ [5] = { [0] = 107, [1] = 14 }, [6] = { [0] = 108, [1] = 15 }, [7] = { [0] = 106, [1] = 13 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 38 })[R[1]], ({ [0] = 107, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 35 })[R[1]], ({ [0] = 108, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 35 })[R[1]], ({ [0] = 108, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 30 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 115, [1] = 22 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 106, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
  U[#U]:set_lights(true)
  if R[2] == 0 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 9, [1] = 27 })[R[1]], ({ [0] = 107, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 9, [1] = 27 })[R[1]], ({ [0] = 107, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[2] == 1 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 38 })[R[1]], ({ [0] = 112, [1] = 19 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 28 })[R[1]], ({ [0] = 111, [1] = 18 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 10, [1] = 28 })[R[1]], ({ [0] = 111, [1] = 18 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[2] == 2 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 12, [1] = 30 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 32 })[R[1]], ({ [0] = 107, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 32 })[R[1]], ({ [0] = 107, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[2] == 3 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 12, [1] = 30 })[R[1]], ({ [0] = 112, [1] = 19 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 108, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 108, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[2] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 12, [1] = 30 })[R[1]], ({ [0] = 108, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 9, [1] = 27 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[2] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 20, [1] = 38 })[R[1]], ({ [0] = 107, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 38 })[R[1]], ({ [0] = 113, [1] = 20 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[2] == 6 then
    if LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 109, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 35 })[R[1]], ({ [0] = 108, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 12, [1] = 30 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 115, [1] = 22 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 116, [1] = 23 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 109, [1] = 16 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[2] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 106, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 38 })[R[1]], ({ [0] = 113, [1] = 20 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[2]", R[2])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 10, [1] = 28 }, [1] = { [0] = 9, [1] = 27 }, [2] = { [0] = 15, [1] = 33 }, [3] = { [0] = 14, [1] = 32 }, [4] = { [0] = 12, [1] = 30 }, [5] = { [0] = 19, [1] = 37 }, [6] = { [0] = 14, [1] = 32 }, [7] = { [0] = 19, [1] = 37 } })[R[2]][R[1]], ({ [0] = { [0] = 108, [1] = 15 }, [1] = { [0] = 110, [1] = 17 }, [2] = { [0] = 106, [1] = 13 }, [3] = { [0] = 107, [1] = 14 }, [4] = { [0] = 116, [1] = 23 }, [5] = { [0] = 111, [1] = 18 }, [6] = { [0] = 110, [1] = 17 }, [7] = { [0] = 116, [1] = 23 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 11, [1] = 29 }, [1] = { [0] = 11, [1] = 29 }, [2] = { [0] = 14, [1] = 32 }, [3] = { [0] = 13, [1] = 31 }, [4] = { [0] = 13, [1] = 31 }, [5] = { [0] = 20, [1] = 38 }, [6] = { [0] = 15, [1] = 33 }, [7] = { [0] = 20, [1] = 38 } })[R[2]][R[1]], ({ [0] = { [0] = 108, [1] = 15 }, [1] = { [0] = 109, [1] = 16 }, [2] = { [0] = 105, [1] = 12 }, [3] = { [0] = 106, [1] = 13 }, [4] = { [0] = 115, [1] = 22 }, [5] = { [0] = 110, [1] = 17 }, [6] = { [0] = 109, [1] = 16 }, [7] = { [0] = 116, [1] = 23 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[2] == 0 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[3] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 9, [1] = 27 }, [1] = { [0] = 14, [1] = 32 }, [2] = { [0] = 19, [1] = 37 } })[R[3]][R[1]], ({ [0] = { [0] = 104, [1] = 11 }, [1] = { [0] = 107, [1] = 14 }, [2] = { [0] = 113, [1] = 20 } })[R[3]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 113, [1] = 20 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 13, [1] = 31 })[R[1]], ({ [0] = 113, [1] = 20 })[R[1]] })
      for i = 1, game.initial_units() do
        R[4] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 9, [1] = 27 }, [1] = { [0] = 13, [1] = 31 }, [2] = { [0] = 16, [1] = 34 } })[R[4]][R[1]], ({ [0] = { [0] = 114, [1] = 21 }, [1] = { [0] = 108, [1] = 15 }, [2] = { [0] = 104, [1] = 11 } })[R[4]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 2 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 14, [1] = 32 })[R[1]], ({ [0] = 113, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 14, [1] = 32 })[R[1]], ({ [0] = 114, [1] = 21 })[R[1]] })
      game.create_tube({ ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 114, [1] = 21 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 14, [1] = 32 })[R[1]], ({ [0] = 113, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 14, [1] = 32 })[R[1]], ({ [0] = 114, [1] = 21 })[R[1]] })
      game.create_tube({ ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 114, [1] = 21 })[R[1]] })
      for i = 1, game.initial_units() do
        R[5] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 36 }, [1] = { [0] = 10, [1] = 28 }, [2] = { [0] = 14, [1] = 32 } })[R[5]][R[1]], ({ [0] = { [0] = 104, [1] = 11 }, [1] = { [0] = 109, [1] = 16 }, [2] = { [0] = 114, [1] = 21 } })[R[5]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 3 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 11, [1] = 29 })[R[1]], ({ [0] = 113, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 14, [1] = 32 })[R[1]], ({ [0] = 110, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 110, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 35 })[R[1]], ({ [0] = 113, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 35 })[R[1]], ({ [0] = 114, [1] = 21 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 11, [1] = 29 })[R[1]], ({ [0] = 113, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 14, [1] = 32 })[R[1]], ({ [0] = 110, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 15, [1] = 33 })[R[1]], ({ [0] = 110, [1] = 17 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 35 })[R[1]], ({ [0] = 113, [1] = 20 })[R[1]] })
      game.create_tube({ ({ [0] = 17, [1] = 35 })[R[1]], ({ [0] = 114, [1] = 21 })[R[1]] })
      for i = 1, game.initial_units() do
        R[6] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 37 }, [1] = { [0] = 15, [1] = 33 }, [2] = { [0] = 11, [1] = 29 } })[R[6]][R[1]], ({ [0] = { [0] = 115, [1] = 22 }, [1] = { [0] = 109, [1] = 16 }, [2] = { [0] = 104, [1] = 11 } })[R[6]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 10, [1] = 28 })[R[1]], ({ [0] = 112, [1] = 19 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 10, [1] = 28 })[R[1]], ({ [0] = 112, [1] = 19 })[R[1]] })
      for i = 1, game.initial_units() do
        R[7] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 36 }, [1] = { [0] = 19, [1] = 37 }, [2] = { [0] = 15, [1] = 33 } })[R[7]][R[1]], ({ [0] = { [0] = 104, [1] = 11 }, [1] = { [0] = 110, [1] = 17 }, [2] = { [0] = 114, [1] = 21 } })[R[7]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 5 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[8] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 15, [1] = 33 }, [1] = { [0] = 9, [1] = 27 }, [2] = { [0] = 9, [1] = 27 } })[R[8]][R[1]], ({ [0] = { [0] = 115, [1] = 22 }, [1] = { [0] = 110, [1] = 17 }, [2] = { [0] = 105, [1] = 12 } })[R[8]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 6 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[9] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 37 }, [1] = { [0] = 18, [1] = 36 }, [2] = { [0] = 15, [1] = 33 } })[R[9]][R[1]], ({ [0] = { [0] = 105, [1] = 12 }, [1] = { [0] = 111, [1] = 18 }, [2] = { [0] = 112, [1] = 19 } })[R[9]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 7 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[10] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 13, [1] = 31 }, [1] = { [0] = 9, [1] = 27 }, [2] = { [0] = 19, [1] = 37 } })[R[10]][R[1]], ({ [0] = { [0] = 114, [1] = 21 }, [1] = { [0] = 110, [1] = 17 }, [2] = { [0] = 105, [1] = 12 } })[R[10]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[2]", R[2])
  end
  R[11] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 14 }, [1] = { [0] = 36, [1] = 18 }, [2] = { [0] = 36, [1] = 18 }, [3] = { [0] = 28, [1] = 10 }, [4] = { [0] = 32, [1] = 14 }, [5] = { [0] = 31, [1] = 13 }, [6] = { [0] = 28, [1] = 10 }, [7] = { [0] = 34, [1] = 16 } })[R[11]][R[1]], ({ [0] = { [0] = 18, [1] = 111 }, [1] = { [0] = 14, [1] = 107 }, [2] = { [0] = 18, [1] = 111 }, [3] = { [0] = 14, [1] = 107 }, [4] = { [0] = 17, [1] = 110 }, [5] = { [0] = 15, [1] = 108 }, [6] = { [0] = 12, [1] = 105 }, [7] = { [0] = 15, [1] = 108 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  players[2]:center_view({ ({ [0] = { [0] = 32, [1] = 14 }, [1] = { [0] = 36, [1] = 18 }, [2] = { [0] = 36, [1] = 18 }, [3] = { [0] = 28, [1] = 10 }, [4] = { [0] = 32, [1] = 14 }, [5] = { [0] = 31, [1] = 13 }, [6] = { [0] = 28, [1] = 10 }, [7] = { [0] = 34, [1] = 16 } })[R[11]][R[1]], ({ [0] = { [0] = 18, [1] = 111 }, [1] = { [0] = 14, [1] = 107 }, [2] = { [0] = 18, [1] = 111 }, [3] = { [0] = 14, [1] = 107 }, [4] = { [0] = 17, [1] = 110 }, [5] = { [0] = 15, [1] = 108 }, [6] = { [0] = 12, [1] = 105 }, [7] = { [0] = 15, [1] = 108 } })[R[11]][R[1]] })
  if R[11] == 1 or R[11] == 2 or R[11] == 3 or R[11] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 36, [1] = 18 }, [2] = { [0] = 29, [1] = 11 }, [3] = { [0] = 33, [1] = 15 }, [4] = { [0] = 29, [1] = 11 } })[R[11]][R[1]], ({ [0] = 21, [1] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 29, [1] = 11 })[R[1]], ({ [0] = 13, [1] = 106 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 33, [1] = 15 })[R[1]], ({ [0] = 14, [1] = 107 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 28, [1] = 10 })[R[1]], ({ [0] = 17, [1] = 110 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 37, [1] = 19 })[R[1]], ({ [0] = 22, [1] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 11, [1] = 104 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 32, [1] = 14 })[R[1]], ({ [0] = 12, [1] = 105 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 1 or R[11] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 27, [1] = 9 }, [2] = { [0] = 28, [1] = 10 } })[R[11]][R[1]], ({ [0] = 12, [1] = 105 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 36, [1] = 18 })[R[1]], ({ [1] = { [0] = 17, [1] = 110 }, [2] = { [0] = 21, [1] = 114 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 31, [1] = 13 }, [2] = { [0] = 32, [1] = 14 } })[R[11]][R[1]], ({ [1] = { [0] = 22, [1] = 115 }, [2] = { [0] = 18, [1] = 111 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 31, [1] = 13 }, [2] = { [0] = 36, [1] = 18 } })[R[11]][R[1]], ({ [1] = { [0] = 18, [1] = 111 }, [2] = { [0] = 15, [1] = 108 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 37, [1] = 19 }, [2] = { [0] = 35, [1] = 17 } })[R[11]][R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 38, [1] = 20 }, [2] = { [0] = 37, [1] = 19 } })[R[11]][R[1]], ({ [1] = { [0] = 22, [1] = 115 }, [2] = { [0] = 23, [1] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 28, [1] = 10 })[R[1]], ({ [0] = 22, [1] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 18, [1] = 111 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 29, [1] = 11 })[R[1]], ({ [0] = 17, [1] = 110 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 37, [1] = 19 })[R[1]], ({ [0] = 12, [1] = 105 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 34, [1] = 16 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 22, [1] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    if R[11] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 33, [1] = 15 })[R[1]], ({ [0] = 22, [1] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 3 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 36, [1] = 18 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 26, [1] = 8 })[R[1]], ({ [0] = 19, [1] = 112 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 32, [1] = 14 })[R[1]], ({ [0] = 12, [1] = 105 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    if R[11] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 38, [1] = 20 })[R[1]], ({ [0] = 19, [1] = 112 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 2 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 30, [1] = 12 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 30, [1] = 12 })[R[1]], ({ [0] = 19, [1] = 112 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[11] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 30, [1] = 12 })[R[1]], ({ [0] = 15, [1] = 108 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 26, [1] = 8 })[R[1]], ({ [0] = 19, [1] = 112 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 38, [1] = 20 }, [2] = { [0] = 30, [1] = 12 }, [3] = { [0] = 30, [1] = 12 }, [4] = { [0] = 30, [1] = 12 } })[R[11]][R[1]], ({ [1] = { [0] = 19, [1] = 112 }, [2] = { [0] = 23, [1] = 116 }, [3] = { [0] = 19, [1] = 112 }, [4] = { [0] = 15, [1] = 108 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[11] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 29, [1] = 11 })[R[1]], ({ [0] = 21, [1] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 34, [1] = 16 })[R[1]], ({ [0] = 21, [1] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 28, [1] = 10 })[R[1]], ({ [0] = 18, [1] = 111 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 36, [1] = 18 })[R[1]], ({ [0] = 18, [1] = 111 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 37, [1] = 19 })[R[1]], ({ [0] = 12, [1] = 105 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 36, [1] = 18 })[R[1]], ({ [0] = 22, [1] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 38, [1] = 20 })[R[1]], ({ [0] = 21, [1] = 114 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[11] == 5 or R[11] == 6 or R[11] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 28, [1] = 10 }, [6] = { [0] = 37, [1] = 19 }, [7] = { [0] = 28, [1] = 10 } })[R[11]][R[1]], ({ [0] = 22, [1] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 36, [1] = 18 }, [6] = { [0] = 28, [1] = 10 }, [7] = { [0] = 36, [1] = 18 } })[R[11]][R[1]], ({ [5] = { [0] = 16, [1] = 109 }, [6] = { [0] = 21, [1] = 114 }, [7] = { [0] = 21, [1] = 114 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 5 or R[11] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 36, [1] = 18 }, [7] = { [0] = 29, [1] = 11 } })[R[11]][R[1]], ({ [0] = 12, [1] = 105 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[11] == 7 then
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 31, [1] = 13 }, [7] = { [0] = 33, [1] = 15 } })[R[11]][R[1]], ({ [0] = 12, [1] = 105 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[11] == 5 then
      elseif R[11] == 7 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 34, [1] = 16 })[R[1]], ({ [0] = 18, [1] = 111 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[11]", R[11])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [5] = { [0] = 18, [1] = 111 }, [7] = { [0] = 15, [1] = 108 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 32, [1] = 14 })[R[1]], ({ [5] = { [0] = 17, [1] = 110 }, [7] = { [0] = 16, [1] = 109 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 32, [1] = 14 }, [7] = { [0] = 37, [1] = 19 } })[R[11]][R[1]], ({ [5] = { [0] = 19, [1] = 112 }, [7] = { [0] = 16, [1] = 109 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[11] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 28, [1] = 10 })[R[1]], ({ [0] = 18, [1] = 111 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 28, [1] = 10 })[R[1]], ({ [0] = 15, [1] = 108 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 33, [1] = 15 })[R[1]], ({ [0] = 13, [1] = 106 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 38, [1] = 20 }, [6] = { [0] = 35, [1] = 17 }, [7] = { [0] = 31, [1] = 13 } })[R[11]][R[1]], ({ [5] = { [0] = 14, [1] = 107 }, [6] = { [0] = 15, [1] = 108 }, [7] = { [0] = 13, [1] = 106 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 38, [1] = 20 })[R[1]], ({ [0] = 14, [1] = 107 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 15, [1] = 108 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 15, [1] = 108 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 30, [1] = 12 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 22, [1] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[11] == 7 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 13, [1] = 106 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[11]", R[11])
    end
  else
    unseen("R[11]", R[11])
  end
  U[#U]:set_lights(true)
  if R[11] == 0 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 27, [1] = 9 })[R[1]], ({ [0] = 14, [1] = 107 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 27, [1] = 9 })[R[1]], ({ [0] = 14, [1] = 107 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[11] == 1 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 38, [1] = 20 })[R[1]], ({ [0] = 19, [1] = 112 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 28, [1] = 10 })[R[1]], ({ [0] = 18, [1] = 111 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 28, [1] = 10 })[R[1]], ({ [0] = 18, [1] = 111 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[11] == 2 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 30, [1] = 12 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 32, [1] = 14 })[R[1]], ({ [0] = 14, [1] = 107 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 32, [1] = 14 })[R[1]], ({ [0] = 14, [1] = 107 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[11] == 3 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 30, [1] = 12 })[R[1]], ({ [0] = 19, [1] = 112 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 15, [1] = 108 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 15, [1] = 108 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[11] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 30, [1] = 12 })[R[1]], ({ [0] = 15, [1] = 108 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 27, [1] = 9 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[11] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 38, [1] = 20 })[R[1]], ({ [0] = 14, [1] = 107 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 38, [1] = 20 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[11] == 6 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 15, [1] = 108 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 30, [1] = 12 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 22, [1] = 115 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 33, [1] = 15 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 16, [1] = 109 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 33, [1] = 15 })[R[1]], ({ [0] = 23, [1] = 116 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 16, [1] = 109 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[11] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 13, [1] = 106 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 38, [1] = 20 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[11]", R[11])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 28, [1] = 10 }, [1] = { [0] = 27, [1] = 9 }, [2] = { [0] = 33, [1] = 15 }, [3] = { [0] = 32, [1] = 14 }, [4] = { [0] = 30, [1] = 12 }, [5] = { [0] = 37, [1] = 19 }, [6] = { [0] = 32, [1] = 14 }, [7] = { [0] = 37, [1] = 19 } })[R[11]][R[1]], ({ [0] = { [0] = 15, [1] = 108 }, [1] = { [0] = 17, [1] = 110 }, [2] = { [0] = 13, [1] = 106 }, [3] = { [0] = 14, [1] = 107 }, [4] = { [0] = 23, [1] = 116 }, [5] = { [0] = 18, [1] = 111 }, [6] = { [0] = 17, [1] = 110 }, [7] = { [0] = 23, [1] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 29, [1] = 11 }, [1] = { [0] = 29, [1] = 11 }, [2] = { [0] = 32, [1] = 14 }, [3] = { [0] = 31, [1] = 13 }, [4] = { [0] = 31, [1] = 13 }, [5] = { [0] = 38, [1] = 20 }, [6] = { [0] = 33, [1] = 15 }, [7] = { [0] = 38, [1] = 20 } })[R[11]][R[1]], ({ [0] = { [0] = 15, [1] = 108 }, [1] = { [0] = 16, [1] = 109 }, [2] = { [0] = 12, [1] = 105 }, [3] = { [0] = 13, [1] = 106 }, [4] = { [0] = 22, [1] = 115 }, [5] = { [0] = 17, [1] = 110 }, [6] = { [0] = 16, [1] = 109 }, [7] = { [0] = 23, [1] = 116 } })[R[11]][R[1]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[11] == 0 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[12] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 27, [1] = 9 }, [1] = { [0] = 32, [1] = 14 }, [2] = { [0] = 37, [1] = 19 } })[R[12]][R[1]], ({ [0] = { [0] = 11, [1] = 104 }, [1] = { [0] = 14, [1] = 107 }, [2] = { [0] = 20, [1] = 113 } })[R[12]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 31, [1] = 13 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] })
      for i = 1, game.initial_units() do
        R[13] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 27, [1] = 9 }, [1] = { [0] = 31, [1] = 13 }, [2] = { [0] = 34, [1] = 16 } })[R[13]][R[1]], ({ [0] = { [0] = 21, [1] = 114 }, [1] = { [0] = 15, [1] = 108 }, [2] = { [0] = 11, [1] = 104 } })[R[13]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 2 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 32, [1] = 14 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 14 })[R[1]], ({ [0] = 21, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 15 })[R[1]], ({ [0] = 21, [1] = 114 })[R[1]] })
      for i = 1, game.initial_units() do
        R[14] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 18 }, [1] = { [0] = 28, [1] = 10 }, [2] = { [0] = 32, [1] = 14 } })[R[14]][R[1]], ({ [0] = { [0] = 11, [1] = 104 }, [1] = { [0] = 16, [1] = 109 }, [2] = { [0] = 21, [1] = 114 } })[R[14]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 32, [1] = 14 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 14 })[R[1]], ({ [0] = 21, [1] = 114 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 15 })[R[1]], ({ [0] = 21, [1] = 114 })[R[1]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 3 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 29, [1] = 11 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 14 })[R[1]], ({ [0] = 17, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 15 })[R[1]], ({ [0] = 17, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 21, [1] = 114 })[R[1]] })
      for i = 1, game.initial_units() do
        R[15] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 37, [1] = 19 }, [1] = { [0] = 33, [1] = 15 }, [2] = { [0] = 29, [1] = 11 } })[R[15]][R[1]], ({ [0] = { [0] = 22, [1] = 115 }, [1] = { [0] = 16, [1] = 109 }, [2] = { [0] = 11, [1] = 104 } })[R[15]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 29, [1] = 11 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 32, [1] = 14 })[R[1]], ({ [0] = 17, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 33, [1] = 15 })[R[1]], ({ [0] = 17, [1] = 110 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 20, [1] = 113 })[R[1]] })
      game.create_tube({ ({ [0] = 35, [1] = 17 })[R[1]], ({ [0] = 21, [1] = 114 })[R[1]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 28, [1] = 10 })[R[1]], ({ [0] = 19, [1] = 112 })[R[1]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 28, [1] = 10 })[R[1]], ({ [0] = 19, [1] = 112 })[R[1]] })
      for i = 1, game.initial_units() do
        R[16] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 18 }, [1] = { [0] = 37, [1] = 19 }, [2] = { [0] = 33, [1] = 15 } })[R[16]][R[1]], ({ [0] = { [0] = 11, [1] = 104 }, [1] = { [0] = 17, [1] = 110 }, [2] = { [0] = 21, [1] = 114 } })[R[16]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 33, [1] = 15 }, [1] = { [0] = 27, [1] = 9 }, [2] = { [0] = 27, [1] = 9 } })[R[17]][R[1]], ({ [0] = { [0] = 22, [1] = 115 }, [1] = { [0] = 17, [1] = 110 }, [2] = { [0] = 12, [1] = 105 } })[R[17]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 37, [1] = 19 }, [1] = { [0] = 36, [1] = 18 }, [2] = { [0] = 33, [1] = 15 } })[R[18]][R[1]], ({ [0] = { [0] = 12, [1] = 105 }, [1] = { [0] = 18, [1] = 111 }, [2] = { [0] = 19, [1] = 112 } })[R[18]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 13 }, [1] = { [0] = 27, [1] = 9 }, [2] = { [0] = 37, [1] = 19 } })[R[19]][R[1]], ({ [0] = { [0] = 21, [1] = 114 }, [1] = { [0] = 17, [1] = 110 }, [2] = { [0] = 12, [1] = 105 } })[R[19]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    trigger.time{min = 9600, max = 26400, one_shot = false, on = Quake}  -- after 96 to 264 marks
    trigger.count{type = "CommonOreMine", cargo = "None", compare = ">=", count = 1, player = 1, one_shot = true, on = OneMine}
  end
  return true
end
