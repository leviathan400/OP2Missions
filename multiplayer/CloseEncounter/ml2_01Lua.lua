-- ml2_01Lua.lua  -  2 Player, LastOne, 'Close Encounter' map. (Lua)
--
-- Converted by op2dll from ml2_01.dll ("2 Player, LastOne, 'Close Encounter' map."): its setup replayed. `on_init` makes the original's
-- draws of the game's random numbers in its order and, from them and the lobby, the same units,
-- beacons, walls and settings in the same order, as the original's setup did in every game
-- sampled (every player count, the lobby's colonies, resource levels, vehicles, day and night,
-- morale and disasters). Anything not converted is listed at the end. Coordinates are the in-game
-- status-bar ones (map file tile + 1).

-- Where lava may flow from an eruption, as areas { x1, y1, x2, y2 }.
local LAVA_POSSIBLE = {
  { 44, 1, 45, 1 }, { 54, 1, 55, 1 }, { 44, 2, 46, 2 }, { 55, 2, 55, 2 }, { 46, 3, 47, 3 }, { 56, 3, 57, 4 },
  { 46, 4, 46, 4 }, { 48, 4, 48, 4 }, { 47, 5, 48, 5 }, { 52, 5, 52, 5 }, { 55, 5, 62, 5 }, { 47, 6, 47, 6 },
  { 49, 6, 49, 6 }, { 52, 6, 63, 6 }, { 48, 7, 66, 7 }, { 48, 8, 68, 8 }, { 49, 9, 68, 9 }, { 50, 10, 52, 10 },
  { 55, 10, 69, 10 }, { 56, 11, 70, 11 }, { 57, 12, 71, 12 }, { 58, 13, 73, 13 }, { 60, 14, 74, 14 }, { 61, 15, 75, 17 },
  { 62, 18, 77, 18 }, { 61, 19, 78, 19 }, { 61, 20, 79, 20 }, { 60, 21, 80, 21 }, { 60, 22, 81, 22 }, { 59, 23, 82, 24 },
  { 58, 25, 82, 25 }, { 58, 26, 80, 27 }, { 59, 28, 79, 28 }, { 59, 29, 78, 29 }, { 59, 30, 76, 30 }, { 60, 31, 75, 31 },
  { 60, 32, 74, 32 }, { 61, 33, 73, 33 }, { 62, 34, 71, 34 }, { 62, 35, 66, 35 },
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
local Lava, Quake, Storm

local Lava_done  -- Lava does nothing more once it has acted
function Lava(t)
  if Lava_done then return end
  local r1 = game.rand(100)
  if r1 < 40 then
    game.set_tile({ 52, 4 }, 1147)
    game.set_tile({ 52, 5 }, 1158)
    game.create_eruption({ 52, 6 }, 200)
    Lava_done = true
  end
end

function Quake(t)
  local r1 = game.rand(10)
  local r2 = game.rand(5)
  game.create_earthquake({ ({ 55, 69, 67, 82, 58, 44, 76, 52, 64, 50 })[r1 + 1], ({ 7, 6, 16, 23, 31, 47, 32, 3, 36, 39 })[r1 + 1] }, r2)
end

function Storm(t)
  local r1 = game.rand(4)
  local r2 = game.rand(7)
  if r1 < 2 then
    local r3 = game.rand(64)
    if r1 == 0 then
      game.create_lightning({ 1, r3 + 1 }, nil, r2 + 10)
    else
      game.create_lightning({ 129, r3 + 1 }, nil, r2 + 10)
    end
  else
    local r3 = game.rand(128)
    if r1 == 2 then
      game.create_lightning({ r3 + 1, 2 }, nil, r2 + 10)
    else
      game.create_lightning({ r3 + 1, 65 }, nil, r2 + 10)
    end
  end
end

function on_init()
  local n = game.num_players()
  for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
  game.initial_set_tile({ 52, 4 }, 1140)
  game.initial_set_tile({ 52, 5 }, 1150)
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 74, 26 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 50, 37 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 61, 24 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 57, 13 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 89, 18 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 45, 47 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 68, 32 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 121, 38 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 91, 6 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 34, 5 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 60, 47 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 13, 61 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 92, 54 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 51, 62 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 30, 33 } }
  pick(3, 2, { 0, 1 })
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 74, [1] = 66, [2] = 70 })[R[1]], ({ [0] = 50, [1] = 60, [2] = 23 })[R[1]] } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 74, [1] = 66, [2] = 70 })[R[0]], ({ [0] = 50, [1] = 60, [2] = 23 })[R[0]] } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 42, 40 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 97, 40 } }
  pick(2, 2, { 2, 3 })
  game.create_wall("Wall", { ({ [0] = 86, [1] = 38 })[R[3]], ({ [0] = 18, [1] = 47 })[R[3]] })
  game.create_wall("Wall", { ({ [0] = 86, [1] = 38 })[R[3]], ({ [0] = 19, [1] = 48 })[R[3]] })
  game.create_wall("Wall", { ({ [0] = 86, [1] = 39 })[R[3]], ({ [0] = 20, [1] = 48 })[R[3]] })
  game.create_wall("Wall", { ({ [0] = 88, [1] = 39 })[R[3]], ({ [0] = 22, [1] = 49 })[R[3]] })
  game.create_wall("Wall", { ({ [0] = 89, [1] = 42 })[R[3]], ({ [0] = 22, [1] = 50 })[R[3]] })
  game.create_wall("Wall", { ({ [0] = 90, [1] = 42 })[R[3]], ({ [0] = 22, [1] = 51 })[R[3]] })
  game.create_wall("Wall", { ({ [0] = 111, [1] = 43 })[R[3]], ({ [0] = 39, [1] = 51 })[R[3]] })
  if R[3] == 0 then
    game.create_wall("Wall", { 111, 40 })
    game.create_wall("Wall", { 111, 41 })
    game.create_wall("Wall", { 111, 42 })
  elseif R[3] == 1 then
  else
    unseen("R[3]", R[3])
  end
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 88, [1] = 40 })[R[3]], ({ [0] = 20, [1] = 51 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 113, [1] = 44 })[R[3]], ({ [0] = 44, [1] = 13 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
  R[4] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 12 }, [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 114, [1] = 16 }, [3] = { [0] = 106, [1] = 8 }, [4] = { [0] = 110, [1] = 12 }, [5] = { [0] = 109, [1] = 11 }, [6] = { [0] = 106, [1] = 8 }, [7] = { [0] = 112, [1] = 14 } })[R[4]][R[3]], ({ [0] = 12, [1] = 8, [2] = 12, [3] = 8, [4] = 11, [5] = 9, [6] = 6, [7] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
  players[1]:center_view({ ({ [0] = { [0] = 110, [1] = 12 }, [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 114, [1] = 16 }, [3] = { [0] = 106, [1] = 8 }, [4] = { [0] = 110, [1] = 12 }, [5] = { [0] = 109, [1] = 11 }, [6] = { [0] = 106, [1] = 8 }, [7] = { [0] = 112, [1] = 14 } })[R[4]][R[3]], ({ [0] = 12, [1] = 8, [2] = 12, [3] = 8, [4] = 11, [5] = 9, [6] = 6, [7] = 9 })[R[4]] })
  if R[4] == 1 or R[4] == 2 or R[4] == 3 or R[4] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 107, [1] = 9 }, [3] = { [0] = 111, [1] = 13 }, [4] = { [0] = 107, [1] = 9 } })[R[4]][R[3]], 15 }, direction = "East", lights = false, exact = true }[1]
    if R[4] == 1 or R[4] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 105, [1] = 7 }, [2] = { [0] = 106, [1] = 8 } })[R[4]][R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 114, [1] = 16 })[R[3]], ({ [1] = 11, [2] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 109, [1] = 11 }, [2] = { [0] = 110, [1] = 12 } })[R[4]][R[3]], ({ [1] = 16, [2] = 12 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 109, [1] = 11 }, [2] = { [0] = 114, [1] = 16 } })[R[4]][R[3]], ({ [1] = 12, [2] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 113, [1] = 15 } })[R[4]][R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 116, [1] = 18 }, [2] = { [0] = 115, [1] = 17 } })[R[4]][R[3]], ({ [1] = 16, [2] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[4] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 107, [1] = 9 })[R[3]], 7 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 111, [1] = 13 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 106, [1] = 8 })[R[3]], 11 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 115, [1] = 17 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 5 }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 110, [1] = 12 })[R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[4] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 106, [1] = 8 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 113, [1] = 15 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 107, [1] = 9 })[R[3]], 11 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 115, [1] = 17 })[R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 112, [1] = 14 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 113, [1] = 15 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[4]", R[4])
    end
    U[#U]:set_lights(true)
    if R[4] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 113, [1] = 15 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
    elseif R[4] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 111, [1] = 13 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
    elseif R[4] == 3 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 114, [1] = 16 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
    elseif R[4] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 104, [1] = 6 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 110, [1] = 12 })[R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[4]", R[4])
    end
    U[#U]:set_lights(true)
    if R[4] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 116, [1] = 18 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
    elseif R[4] == 2 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 108, [1] = 10 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
    elseif R[4] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 108, [1] = 10 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
    elseif R[4] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 108, [1] = 10 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 104, [1] = 6 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[4]", R[4])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 116, [1] = 18 }, [2] = { [0] = 108, [1] = 10 }, [3] = { [0] = 108, [1] = 10 }, [4] = { [0] = 108, [1] = 10 } })[R[4]][R[3]], ({ [1] = 13, [2] = 17, [3] = 13, [4] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[4] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 107, [1] = 9 })[R[3]], 15 }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 112, [1] = 14 })[R[3]], 15 }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 106, [1] = 8 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 114, [1] = 16 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 115, [1] = 17 })[R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 113, [1] = 15 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 114, [1] = 16 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 116, [1] = 18 })[R[3]], 15 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
  elseif R[4] == 5 or R[4] == 6 or R[4] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 106, [1] = 8 }, [6] = { [0] = 115, [1] = 17 }, [7] = { [0] = 106, [1] = 8 } })[R[4]][R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 114, [1] = 16 }, [6] = { [0] = 106, [1] = 8 }, [7] = { [0] = 114, [1] = 16 } })[R[4]][R[3]], ({ [5] = 10, [6] = 15, [7] = 15 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    if R[4] == 5 or R[4] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 114, [1] = 16 }, [7] = { [0] = 107, [1] = 9 } })[R[4]][R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      if R[4] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 113, [1] = 15 })[R[3]], 14 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 113, [1] = 15 })[R[3]], 14 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 113, [1] = 15 })[R[3]], 14 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[4] == 7 then
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
        unseen("R[4]", R[4])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 109, [1] = 11 }, [7] = { [0] = 111, [1] = 13 } })[R[4]][R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      if R[4] == 7 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 112, [1] = 14 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
      elseif R[4] == 5 then
      else
        unseen("R[4]", R[4])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], ({ [5] = 12, [7] = 9 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 110, [1] = 12 })[R[3]], ({ [5] = 11, [7] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 110, [1] = 12 }, [7] = { [0] = 115, [1] = 17 } })[R[4]][R[3]], ({ [5] = 13, [7] = 10 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[4] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 106, [1] = 8 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 106, [1] = 8 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 111, [1] = 13 })[R[3]], 7 }, direction = "East", lights = false, exact = true }[1]
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
      unseen("R[4]", R[4])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 116, [1] = 18 }, [6] = { [0] = 113, [1] = 15 }, [7] = { [0] = 109, [1] = 11 } })[R[4]][R[3]], ({ [5] = 8, [6] = 9, [7] = 7 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
    if R[4] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 116, [1] = 18 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[4] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 113, [1] = 15 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 113, [1] = 15 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 108, [1] = 10 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[4] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 7 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[4]", R[4])
    end
  else
    unseen("R[4]", R[4])
  end
  U[#U]:set_lights(true)
  if R[4] == 0 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 105, [1] = 7 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 105, [1] = 7 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[4] == 1 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 116, [1] = 18 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 106, [1] = 8 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 106, [1] = 8 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[4] == 2 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 108, [1] = 10 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 110, [1] = 12 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 110, [1] = 12 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[4] == 3 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 108, [1] = 10 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[4] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 108, [1] = 10 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 105, [1] = 7 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
  elseif R[4] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 116, [1] = 18 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 116, [1] = 18 })[R[3]], 14 }, direction = "East", lights = false, exact = true }[1]
  elseif R[4] == 6 then
    if LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 111, [1] = 13 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 10 }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 113, [1] = 15 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 108, [1] = 10 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 111, [1] = 13 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 10 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[4] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[3]], 7 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 116, [1] = 18 })[R[3]], 14 }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[4]", R[4])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[4]], player = players[1], at = { ({ [0] = { [0] = 106, [1] = 8 }, [1] = { [0] = 105, [1] = 7 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 110, [1] = 12 }, [4] = { [0] = 108, [1] = 10 }, [5] = { [0] = 115, [1] = 17 }, [6] = { [0] = 110, [1] = 12 }, [7] = { [0] = 115, [1] = 17 } })[R[4]][R[3]], ({ [0] = 9, [1] = 11, [2] = 7, [3] = 8, [4] = 17, [5] = 12, [6] = 11, [7] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[4]], player = players[1], at = { ({ [0] = { [0] = 107, [1] = 9 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 110, [1] = 12 }, [3] = { [0] = 109, [1] = 11 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 116, [1] = 18 }, [6] = { [0] = 111, [1] = 13 }, [7] = { [0] = 116, [1] = 18 } })[R[4]][R[3]], ({ [0] = 9, [1] = 10, [2] = 6, [3] = 7, [4] = 16, [5] = 11, [6] = 10, [7] = 17 })[R[4]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[4] == 0 then
    if game.initial_units() == 0 then
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 47, [1] = 18 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 19 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 20 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 88 })[R[3]], ({ [0] = 49, [1] = 22 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 42, [1] = 89 })[R[3]], ({ [0] = 50, [1] = 22 })[R[3]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[5] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 110, [1] = 12 }, [2] = { [0] = 115, [1] = 17 } })[R[5]][R[3]], ({ [0] = 5, [1] = 8, [2] = 14 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[4] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 109, [1] = 11 })[R[3]], 14 })
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 47, [1] = 18 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 19 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 20 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 88 })[R[3]], ({ [0] = 49, [1] = 22 })[R[3]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 109, [1] = 11 })[R[3]], 14 })
      for i = 1, game.initial_units() do
        R[6] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 109, [1] = 11 }, [2] = { [0] = 112, [1] = 14 } })[R[6]][R[3]], ({ [0] = 15, [1] = 9, [2] = 5 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[4] == 2 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[3]], 15 })
      game.create_tube({ ({ [0] = 111, [1] = 13 })[R[3]], 15 })
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 47, [1] = 18 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 19 })[R[3]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[3]], 15 })
      game.create_tube({ ({ [0] = 111, [1] = 13 })[R[3]], 15 })
      for i = 1, game.initial_units() do
        R[7] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 106, [1] = 8 }, [2] = { [0] = 110, [1] = 12 } })[R[7]][R[3]], 5 + 5 * R[7] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[4] == 3 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 107, [1] = 9 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[3]], 11 })
      game.create_tube({ ({ [0] = 111, [1] = 13 })[R[3]], 11 })
      game.create_tube({ ({ [0] = 113, [1] = 15 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 113, [1] = 15 })[R[3]], 15 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 107, [1] = 9 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[3]], 11 })
      game.create_tube({ ({ [0] = 111, [1] = 13 })[R[3]], 11 })
      game.create_tube({ ({ [0] = 113, [1] = 15 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 113, [1] = 15 })[R[3]], 15 })
      for i = 1, game.initial_units() do
        R[8] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 115, [1] = 17 }, [1] = { [0] = 111, [1] = 13 }, [2] = { [0] = 107, [1] = 9 } })[R[8]][R[3]], ({ [0] = 16, [1] = 10, [2] = 5 })[R[8]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[4] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 106, [1] = 8 })[R[3]], 13 })
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 47, [1] = 18 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 19 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 20 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 88 })[R[3]], ({ [0] = 49, [1] = 22 })[R[3]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 106, [1] = 8 })[R[3]], 13 })
      for i = 1, game.initial_units() do
        R[9] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 115, [1] = 17 }, [2] = { [0] = 111, [1] = 13 } })[R[9]][R[3]], ({ [0] = 5, [1] = 11, [2] = 15 })[R[9]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[4] == 5 then
    if game.initial_units() == 0 then
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 47, [1] = 18 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 19 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 20 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 88 })[R[3]], ({ [0] = 49, [1] = 22 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 42, [1] = 89 })[R[3]], ({ [0] = 50, [1] = 22 })[R[3]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[10] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 111, [1] = 13 }, [1] = { [0] = 105, [1] = 7 }, [2] = { [0] = 105, [1] = 7 } })[R[10]][R[3]], 16 - 5 * R[10] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[4] == 6 then
    if game.initial_units() == 0 then
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 47, [1] = 18 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 19 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 20 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 88 })[R[3]], ({ [0] = 49, [1] = 22 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 42, [1] = 89 })[R[3]], ({ [0] = 50, [1] = 22 })[R[3]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[11] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 115, [1] = 17 }, [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 111, [1] = 13 } })[R[11]][R[3]], ({ [0] = 6, [1] = 12, [2] = 13 })[R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[4] == 7 then
    if game.initial_units() == 0 then
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 47, [1] = 18 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 38, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 19 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 86 })[R[3]], ({ [0] = 48, [1] = 20 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 39, [1] = 88 })[R[3]], ({ [0] = 49, [1] = 22 })[R[3]] })
      game.create_wall("Wall", { ({ [0] = 42, [1] = 89 })[R[3]], ({ [0] = 50, [1] = 22 })[R[3]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[12] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 109, [1] = 11 }, [1] = { [0] = 105, [1] = 7 }, [2] = { [0] = 115, [1] = 17 } })[R[12]][R[3]], ({ [0] = 15, [1] = 11, [2] = 6 })[R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[4]", R[4])
  end
  if R[3] == 0 then
    if R[4] == 0 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 47 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 42, 51 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 1 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 42, 50 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 47 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 47 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 39, 48 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 3 then
      game.create_wall("Wall", { 38, 47 })
    elseif R[4] == 4 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 42, 50 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 47 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 5 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 47 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 42, 51 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 6 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 47 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 42, 51 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 47 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 42, 51 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[4]", R[4])
    end
  elseif R[3] == 1 then
    if R[4] == 0 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 90, 22 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 18 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 1 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 89, 22 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 18 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 18 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 86, 20 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 3 then
      game.create_wall("Wall", { 86, 18 })
    elseif R[4] == 4 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 89, 22 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 18 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 5 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 90, 22 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 18 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 6 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 90, 22 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 18 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 7 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 90, 22 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 18 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[4]", R[4])
    end
  else
    unseen("R[3]", R[3])
  end
  if R[3] == 0 then
    if R[4] == 0 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 48 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 43, 51 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 1 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 42, 51 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 48 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 48 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 39, 49 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 3 then
      game.create_wall("Wall", { 38, 48 })
    elseif R[4] == 4 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 42, 51 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 48 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 5 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 48 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 43, 51 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 6 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 48 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 43, 51 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 38, 48 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 43, 51 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[4]", R[4])
    end
  elseif R[3] == 1 then
    if R[4] == 0 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 111, 39 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 19 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 1 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 90, 22 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 19 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 19 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 88, 22 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 3 then
      game.create_wall("Wall", { 86, 19 })
    elseif R[4] == 4 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 90, 22 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 19 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 5 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 111, 39 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 19 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 6 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 111, 39 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 19 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 7 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 111, 39 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 86, 19 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[4]", R[4])
    end
  else
    unseen("R[3]", R[3])
  end
  if R[3] == 0 then
    if R[4] == 0 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 39, 48 })
        game.create_wall("Wall", { 39, 49 })
        game.create_wall("Wall", { 42, 50 })
        game.create_wall("Wall", { 42, 51 })
        game.create_wall("Wall", { 43, 51 })
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 1 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 43, 51 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 39, 48 })
        game.create_wall("Wall", { 39, 49 })
        game.create_wall("Wall", { 42, 50 })
        game.create_wall("Wall", { 42, 51 })
        game.create_wall("Wall", { 43, 51 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 2 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 42, 50 })
        game.create_wall("Wall", { 42, 51 })
        game.create_wall("Wall", { 43, 51 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 39, 48 })
        game.create_wall("Wall", { 39, 49 })
        game.create_wall("Wall", { 42, 50 })
        game.create_wall("Wall", { 42, 51 })
        game.create_wall("Wall", { 43, 51 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 3 then
      game.create_wall("Wall", { 39, 48 })
      game.create_wall("Wall", { 39, 49 })
      game.create_wall("Wall", { 42, 50 })
      game.create_wall("Wall", { 42, 51 })
      game.create_wall("Wall", { 43, 51 })
    elseif R[4] == 4 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 43, 51 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 39, 48 })
        game.create_wall("Wall", { 39, 49 })
        game.create_wall("Wall", { 42, 50 })
        game.create_wall("Wall", { 42, 51 })
        game.create_wall("Wall", { 43, 51 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 5 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 39, 48 })
        game.create_wall("Wall", { 39, 49 })
        game.create_wall("Wall", { 42, 50 })
        game.create_wall("Wall", { 42, 51 })
        game.create_wall("Wall", { 43, 51 })
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 6 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 39, 48 })
        game.create_wall("Wall", { 39, 49 })
        game.create_wall("Wall", { 42, 50 })
        game.create_wall("Wall", { 42, 51 })
        game.create_wall("Wall", { 43, 51 })
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 39, 48 })
        game.create_wall("Wall", { 39, 49 })
        game.create_wall("Wall", { 42, 50 })
        game.create_wall("Wall", { 42, 51 })
        game.create_wall("Wall", { 43, 51 })
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[4]", R[4])
    end
  elseif R[3] == 1 then
    game.create_wall("Wall", { ({ [0] = { [0] = 111, [4] = 86, [8] = 86, [12] = 86 }, [1] = { [0] = 111, [4] = 86, [8] = 86, [12] = 86 }, [2] = { [0] = 89, [4] = 86, [8] = 86, [12] = 86 }, [3] = { [0] = 86, [4] = 86, [8] = 86, [12] = 86 }, [4] = { [0] = 111, [4] = 86, [8] = 86, [12] = 86 }, [5] = { [0] = 111, [4] = 86, [8] = 86, [12] = 86 }, [6] = { [0] = 111, [4] = 86, [8] = 86, [12] = 86 }, [7] = { [0] = 111, [4] = 86, [8] = 86, [12] = 86 } })[R[4]][game.initial_units()], ({ [0] = { [0] = 40, [4] = 20, [8] = 20, [12] = 20 }, [1] = { [0] = 39, [4] = 20, [8] = 20, [12] = 20 }, [2] = { [0] = 22, [4] = 20, [8] = 20, [12] = 20 }, [3] = { [0] = 20, [4] = 20, [8] = 20, [12] = 20 }, [4] = { [0] = 39, [4] = 20, [8] = 20, [12] = 20 }, [5] = { [0] = 40, [4] = 20, [8] = 20, [12] = 20 }, [6] = { [0] = 40, [4] = 20, [8] = 20, [12] = 20 }, [7] = { [0] = 40, [4] = 20, [8] = 20, [12] = 20 } })[R[4]][game.initial_units()] })
    game.create_wall("Wall", { ({ [0] = { [0] = 111, [4] = 88, [8] = 88, [12] = 88 }, [1] = { [0] = 111, [4] = 88, [8] = 88, [12] = 88 }, [2] = { [0] = 90, [4] = 88, [8] = 88, [12] = 88 }, [3] = { [0] = 88, [4] = 88, [8] = 88, [12] = 88 }, [4] = { [0] = 111, [4] = 88, [8] = 88, [12] = 88 }, [5] = { [0] = 111, [4] = 88, [8] = 88, [12] = 88 }, [6] = { [0] = 111, [4] = 88, [8] = 88, [12] = 88 }, [7] = { [0] = 111, [4] = 88, [8] = 88, [12] = 88 } })[R[4]][game.initial_units()], ({ [0] = { [0] = 41, [4] = 22, [8] = 22, [12] = 22 }, [1] = { [0] = 40, [4] = 22, [8] = 22, [12] = 22 }, [2] = { [0] = 22, [4] = 22, [8] = 22, [12] = 22 }, [3] = { [0] = 22, [4] = 22, [8] = 22, [12] = 22 }, [4] = { [0] = 40, [4] = 22, [8] = 22, [12] = 22 }, [5] = { [0] = 41, [4] = 22, [8] = 22, [12] = 22 }, [6] = { [0] = 41, [4] = 22, [8] = 22, [12] = 22 }, [7] = { [0] = 41, [4] = 22, [8] = 22, [12] = 22 } })[R[4]][game.initial_units()] })
    if R[4] == 0 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 111, 42 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 89, 22 })
        game.create_wall("Wall", { 90, 22 })
        game.create_wall("Wall", { 111, 39 })
        game.create_wall("Wall", { 111, 40 })
        game.create_wall("Wall", { 111, 41 })
        game.create_wall("Wall", { 111, 42 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 1 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 111, 41 })
        game.create_wall("Wall", { 111, 42 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 89, 22 })
        game.create_wall("Wall", { 90, 22 })
        game.create_wall("Wall", { 111, 39 })
        game.create_wall("Wall", { 111, 40 })
        game.create_wall("Wall", { 111, 41 })
        game.create_wall("Wall", { 111, 42 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 89, 22 })
        game.create_wall("Wall", { 90, 22 })
        game.create_wall("Wall", { 111, 39 })
        game.create_wall("Wall", { 111, 40 })
        game.create_wall("Wall", { 111, 41 })
        game.create_wall("Wall", { 111, 42 })
      elseif game.initial_units() == 0 then
        game.create_wall("Wall", { 111, 39 })
        game.create_wall("Wall", { 111, 40 })
        game.create_wall("Wall", { 111, 41 })
        game.create_wall("Wall", { 111, 42 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 3 then
      game.create_wall("Wall", { 89, 22 })
      game.create_wall("Wall", { 90, 22 })
      game.create_wall("Wall", { 111, 39 })
      game.create_wall("Wall", { 111, 40 })
      game.create_wall("Wall", { 111, 41 })
      game.create_wall("Wall", { 111, 42 })
    elseif R[4] == 4 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 111, 41 })
        game.create_wall("Wall", { 111, 42 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 89, 22 })
        game.create_wall("Wall", { 90, 22 })
        game.create_wall("Wall", { 111, 39 })
        game.create_wall("Wall", { 111, 40 })
        game.create_wall("Wall", { 111, 41 })
        game.create_wall("Wall", { 111, 42 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 5 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 111, 42 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 89, 22 })
        game.create_wall("Wall", { 90, 22 })
        game.create_wall("Wall", { 111, 39 })
        game.create_wall("Wall", { 111, 40 })
        game.create_wall("Wall", { 111, 41 })
        game.create_wall("Wall", { 111, 42 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 6 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 111, 42 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 89, 22 })
        game.create_wall("Wall", { 90, 22 })
        game.create_wall("Wall", { 111, 39 })
        game.create_wall("Wall", { 111, 40 })
        game.create_wall("Wall", { 111, 41 })
        game.create_wall("Wall", { 111, 42 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[4] == 7 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { 111, 42 })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_wall("Wall", { 89, 22 })
        game.create_wall("Wall", { 90, 22 })
        game.create_wall("Wall", { 111, 39 })
        game.create_wall("Wall", { 111, 40 })
        game.create_wall("Wall", { 111, 41 })
        game.create_wall("Wall", { 111, 42 })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[4]", R[4])
    end
  else
    unseen("R[3]", R[3])
  end
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 40, [1] = 88 })[R[3]], ({ [0] = 51, [1] = 20 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 44, [1] = 113 })[R[3]], ({ [0] = 13, [1] = 44 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
  R[13] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 110 }, [1] = { [0] = 16, [1] = 114 }, [2] = { [0] = 16, [1] = 114 }, [3] = { [0] = 8, [1] = 106 }, [4] = { [0] = 12, [1] = 110 }, [5] = { [0] = 11, [1] = 109 }, [6] = { [0] = 8, [1] = 106 }, [7] = { [0] = 14, [1] = 112 } })[R[13]][R[3]], ({ [0] = 12, [1] = 8, [2] = 12, [3] = 8, [4] = 11, [5] = 9, [6] = 6, [7] = 9 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
  players[2]:center_view({ ({ [0] = { [0] = 12, [1] = 110 }, [1] = { [0] = 16, [1] = 114 }, [2] = { [0] = 16, [1] = 114 }, [3] = { [0] = 8, [1] = 106 }, [4] = { [0] = 12, [1] = 110 }, [5] = { [0] = 11, [1] = 109 }, [6] = { [0] = 8, [1] = 106 }, [7] = { [0] = 14, [1] = 112 } })[R[13]][R[3]], ({ [0] = 12, [1] = 8, [2] = 12, [3] = 8, [4] = 11, [5] = 9, [6] = 6, [7] = 9 })[R[13]] })
  if R[13] == 1 or R[13] == 2 or R[13] == 3 or R[13] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 16, [1] = 114 }, [2] = { [0] = 9, [1] = 107 }, [3] = { [0] = 13, [1] = 111 }, [4] = { [0] = 9, [1] = 107 } })[R[13]][R[3]], 15 }, direction = "East", lights = false, exact = true }[1]
    if R[13] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 9, [1] = 107 })[R[3]], 7 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 111 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 8, [1] = 106 })[R[3]], 11 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 17, [1] = 115 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 5 }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 12, [1] = 110 })[R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[13] == 1 or R[13] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 7, [1] = 105 }, [2] = { [0] = 8, [1] = 106 } })[R[13]][R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 114 })[R[3]], ({ [1] = 11, [2] = 15 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 11, [1] = 109 }, [2] = { [0] = 12, [1] = 110 } })[R[13]][R[3]], ({ [1] = 16, [2] = 12 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 11, [1] = 109 }, [2] = { [0] = 16, [1] = 114 } })[R[13]][R[3]], ({ [1] = 12, [2] = 9 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 15, [1] = 113 } })[R[13]][R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 18, [1] = 116 }, [2] = { [0] = 17, [1] = 115 } })[R[13]][R[3]], ({ [1] = 16, [2] = 17 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[13] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 8, [1] = 106 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 15, [1] = 113 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 9, [1] = 107 })[R[3]], 11 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 17, [1] = 115 })[R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 112 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 113 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[13]", R[13])
    end
    U[#U]:set_lights(true)
    if R[13] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 113 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
    elseif R[13] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 111 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
    elseif R[13] == 3 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 114 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
    elseif R[13] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 6, [1] = 104 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 12, [1] = 110 })[R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[13]", R[13])
    end
    U[#U]:set_lights(true)
    if R[13] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 116 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
    elseif R[13] == 2 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 108 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
    elseif R[13] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 108 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
    elseif R[13] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 108 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 6, [1] = 104 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[13]", R[13])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 18, [1] = 116 }, [2] = { [0] = 10, [1] = 108 }, [3] = { [0] = 10, [1] = 108 }, [4] = { [0] = 10, [1] = 108 } })[R[13]][R[3]], ({ [1] = 13, [2] = 17, [3] = 13, [4] = 9 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[13] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 9, [1] = 107 })[R[3]], 15 }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 14, [1] = 112 })[R[3]], 15 }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 8, [1] = 106 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 16, [1] = 114 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 17, [1] = 115 })[R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 15, [1] = 113 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 114 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 116 })[R[3]], 15 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
  elseif R[13] == 5 or R[13] == 6 or R[13] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 8, [1] = 106 }, [6] = { [0] = 17, [1] = 115 }, [7] = { [0] = 8, [1] = 106 } })[R[13]][R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 16, [1] = 114 }, [6] = { [0] = 8, [1] = 106 }, [7] = { [0] = 16, [1] = 114 } })[R[13]][R[3]], ({ [5] = 10, [6] = 15, [7] = 15 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    if R[13] == 5 or R[13] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 16, [1] = 114 }, [7] = { [0] = 9, [1] = 107 } })[R[13]][R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      if R[13] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 15, [1] = 113 })[R[3]], 14 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 15, [1] = 113 })[R[3]], 14 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 15, [1] = 113 })[R[3]], 14 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[13] == 7 then
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
        unseen("R[13]", R[13])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 11, [1] = 109 }, [7] = { [0] = 13, [1] = 111 } })[R[13]][R[3]], 6 }, direction = "East", lights = false, exact = true }[1]
      if R[13] == 5 then
      elseif R[13] == 7 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 14, [1] = 112 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[13]", R[13])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], ({ [5] = 12, [7] = 9 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 12, [1] = 110 })[R[3]], ({ [5] = 11, [7] = 10 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 12, [1] = 110 }, [7] = { [0] = 17, [1] = 115 } })[R[13]][R[3]], ({ [5] = 13, [7] = 10 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[13] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 8, [1] = 106 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 8, [1] = 106 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 13, [1] = 111 })[R[3]], 7 }, direction = "East", lights = false, exact = true }[1]
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
      unseen("R[13]", R[13])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 18, [1] = 116 }, [6] = { [0] = 15, [1] = 113 }, [7] = { [0] = 11, [1] = 109 } })[R[13]][R[3]], ({ [5] = 8, [6] = 9, [7] = 7 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
    if R[13] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 116 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[13] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 113 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 113 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 10, [1] = 108 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[13] == 7 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 7 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[13]", R[13])
    end
  else
    unseen("R[13]", R[13])
  end
  U[#U]:set_lights(true)
  if R[13] == 0 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 7, [1] = 105 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 7, [1] = 105 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[13] == 1 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 116 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 106 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 106 })[R[3]], 12 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[13] == 2 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 108 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 110 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 12, [1] = 110 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[13] == 3 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 108 })[R[3]], 13 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[13] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 10, [1] = 108 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 7, [1] = 105 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
  elseif R[13] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 116 })[R[3]], 8 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 116 })[R[3]], 14 }, direction = "East", lights = false, exact = true }[1]
  elseif R[13] == 6 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 15, [1] = 113 })[R[3]], 9 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 10, [1] = 108 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 16 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 111 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 10 }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 111 })[R[3]], 17 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 10 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[13] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[3]], 7 }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 116 })[R[3]], 14 }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[13]", R[13])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[13]], player = players[2], at = { ({ [0] = { [0] = 8, [1] = 106 }, [1] = { [0] = 7, [1] = 105 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 12, [1] = 110 }, [4] = { [0] = 10, [1] = 108 }, [5] = { [0] = 17, [1] = 115 }, [6] = { [0] = 12, [1] = 110 }, [7] = { [0] = 17, [1] = 115 } })[R[13]][R[3]], ({ [0] = 9, [1] = 11, [2] = 7, [3] = 8, [4] = 17, [5] = 12, [6] = 11, [7] = 17 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[13]], player = players[2], at = { ({ [0] = { [0] = 9, [1] = 107 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 12, [1] = 110 }, [3] = { [0] = 11, [1] = 109 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 18, [1] = 116 }, [6] = { [0] = 13, [1] = 111 }, [7] = { [0] = 18, [1] = 116 } })[R[13]][R[3]], ({ [0] = 9, [1] = 10, [2] = 6, [3] = 7, [4] = 16, [5] = 11, [6] = 10, [7] = 17 })[R[13]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[13] == 0 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[14] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 12, [1] = 110 }, [2] = { [0] = 17, [1] = 115 } })[R[14]][R[3]], ({ [0] = 5, [1] = 8, [2] = 14 })[R[14]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[13] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 11, [1] = 109 })[R[3]], 14 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 11, [1] = 109 })[R[3]], 14 })
      for i = 1, game.initial_units() do
        R[15] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 11, [1] = 109 }, [2] = { [0] = 14, [1] = 112 } })[R[15]][R[3]], ({ [0] = 15, [1] = 9, [2] = 5 })[R[15]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[13] == 2 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[3]], 15 })
      game.create_tube({ ({ [0] = 13, [1] = 111 })[R[3]], 15 })
      for i = 1, game.initial_units() do
        R[16] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 8, [1] = 106 }, [2] = { [0] = 12, [1] = 110 } })[R[16]][R[3]], 5 + 5 * R[16] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[3]], 15 })
      game.create_tube({ ({ [0] = 13, [1] = 111 })[R[3]], 15 })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[13] == 3 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 9, [1] = 107 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[3]], 11 })
      game.create_tube({ ({ [0] = 13, [1] = 111 })[R[3]], 11 })
      game.create_tube({ ({ [0] = 15, [1] = 113 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 15, [1] = 113 })[R[3]], 15 })
      for i = 1, game.initial_units() do
        R[17] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 115 }, [1] = { [0] = 13, [1] = 111 }, [2] = { [0] = 9, [1] = 107 } })[R[17]][R[3]], ({ [0] = 16, [1] = 10, [2] = 5 })[R[17]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 9, [1] = 107 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[3]], 11 })
      game.create_tube({ ({ [0] = 13, [1] = 111 })[R[3]], 11 })
      game.create_tube({ ({ [0] = 15, [1] = 113 })[R[3]], 14 })
      game.create_tube({ ({ [0] = 15, [1] = 113 })[R[3]], 15 })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[13] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 8, [1] = 106 })[R[3]], 13 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 8, [1] = 106 })[R[3]], 13 })
      for i = 1, game.initial_units() do
        R[18] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 17, [1] = 115 }, [2] = { [0] = 13, [1] = 111 } })[R[18]][R[3]], ({ [0] = 5, [1] = 11, [2] = 15 })[R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[13] == 5 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[19] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 13, [1] = 111 }, [1] = { [0] = 7, [1] = 105 }, [2] = { [0] = 7, [1] = 105 } })[R[19]][R[3]], 16 - 5 * R[19] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[13] == 6 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[20] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 17, [1] = 115 }, [1] = { [0] = 16, [1] = 114 }, [2] = { [0] = 13, [1] = 111 } })[R[20]][R[3]], ({ [0] = 6, [1] = 12, [2] = 13 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[13] == 7 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[21] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 11, [1] = 109 }, [1] = { [0] = 7, [1] = 105 }, [2] = { [0] = 17, [1] = 115 } })[R[21]][R[3]], ({ [0] = 15, [1] = 11, [2] = 6 })[R[21]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[13]", R[13])
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
    trigger.time{min = 18000, max = 36000, one_shot = false, on = Quake}  -- after 180 to 360 marks
    trigger.time{min = 12000, max = 18000, one_shot = false, on = Storm}  -- after 120 to 180 marks
    for id = 1, n do trigger.count{type = "Lynx", compare = ">=", count = 10, player = id, one_shot = true, on = Lava} end
  end
  return true
end
