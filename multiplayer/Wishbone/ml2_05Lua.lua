-- ml2_05Lua.lua  -  2 Player, LastOne, 'Wishbone' map. (Lua)
--
-- Converted by op2dll from ml2_05.dll ("2 Player, LastOne, 'Wishbone' map."): its setup replayed. `on_init` makes the original's
-- draws of the game's random numbers in its order and, from them and the lobby, the same units,
-- beacons, walls and settings in the same order, as the original's setup did in every game
-- sampled (every player count, the lobby's colonies, resource levels, vehicles, day and night,
-- morale and disasters). Anything not converted is listed at the end. Coordinates are the in-game
-- status-bar ones (map file tile + 1).

-- Where lava may flow from an eruption, as areas { x1, y1, x2, y2 }.
local LAVA_POSSIBLE = {
  { 64, 8, 64, 8 }, { 60, 9, 60, 9 }, { 63, 9, 64, 9 }, { 60, 10, 63, 11 }, { 60, 12, 65, 12 }, { 61, 13, 67, 13 },
  { 61, 14, 68, 14 }, { 58, 15, 67, 17 }, { 57, 18, 67, 18 }, { 56, 19, 68, 19 }, { 57, 20, 67, 20 }, { 58, 21, 65, 21 },
  { 59, 22, 65, 22 }, { 57, 23, 64, 23 }, { 58, 24, 62, 24 }, { 64, 24, 65, 24 }, { 58, 25, 58, 25 }, { 60, 25, 61, 26 },
  { 65, 25, 66, 25 }, { 66, 26, 67, 26 }, { 60, 27, 62, 27 }, { 65, 27, 67, 27 }, { 61, 28, 61, 28 }, { 64, 28, 65, 28 },
  { 67, 28, 68, 28 },
}

-- The setup's draws (R) and the units it made (U), in order.
local R, U = {}, {}
local LEVEL_OF = { Easy = 0, Normal = 1, Hard = 2 }
local DIRS = { "East", "SouthEast", "South", "SouthWest", "West", "NorthWest", "North", "NorthEast" }
-- A branch of the setup no sampled game took: logged, so a game that differs from the original says where.
         local function unseen(what, value)
  print("replay: " .. what .. " = " .. tostring(value) .. ": a way no sampled game took")
end
-- A value of 0 to range - 1, redrawn while it's one of `taken`.
             local function draw_avoid(range, taken)
  local no, left = {}, range
  for _, t in ipairs(taken) do
    if t >= 0 and t < range and not no[t] then no[t] = true; left = left - 1 end
  end
  if left == 0 then
    print("replay: draw_avoid(" .. range .. "): every value taken, a way no sampled game took")
    return game.rand(range)
  end
  local v
  repeat v = game.rand(range) until not no[v]
  return v
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
local Lava, Lava2, Quake, Storm

function Lava(t)
  trigger.time{time = 3000, on = Lava2}  -- after 30 marks
end

function Lava2(t)
  game.set_tile({ 62, 7 }, 1169)
  game.set_tile({ 62, 8 }, 1192)
  game.set_tile({ 63, 7 }, 1181)
  game.set_tile({ 63, 8 }, 1203)
  game.create_eruption({ 63, 9 }, 200)
end

function Quake(t)
  local r1 = game.rand(5)
  local r2 = game.rand(26)
  local r3 = game.rand(36)
  game.create_earthquake({ r3 + 48, r2 + 6 }, r1)
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
      game.create_lightning({ r3 + 1, 64 }, nil, r2 + 10)
    end
  end
end

function on_init()
  local n = game.num_players()
  for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 3, 24 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 77, 58 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 61, 19 } }
  R[0] = game.rand(7)
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 65, [1] = 12, [2] = 43, [3] = 43, [4] = 24, [5] = 40, [6] = 9 })[R[0]], ({ [0] = 3, [1] = 57, [2] = 4, [3] = 33, [4] = 30, [5] = 16, [6] = 40 })[R[0]] } }
  R[1] = game.rand(7)
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 125, [1] = 75, [2] = 106, [3] = 95, [4] = 94, [5] = 54, [6] = 88 })[R[1]], ({ [0] = 8, [1] = 40, [2] = 37, [3] = 8, [4] = 26, [5] = 39, [6] = 50 })[R[1]] } }
  R[2] = draw_avoid(7, { R[0] })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 65, [1] = 12, [2] = 43, [3] = 43, [4] = 24, [5] = 40, [6] = 9 })[R[2]], ({ [0] = 3, [1] = 57, [2] = 4, [3] = 33, [4] = 30, [5] = 16, [6] = 40 })[R[2]] } }
  R[3] = draw_avoid(7, { R[1] })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 125, [1] = 75, [2] = 106, [3] = 95, [4] = 94, [5] = 54, [6] = 88 })[R[3]], ({ [0] = 8, [1] = 40, [2] = 37, [3] = 8, [4] = 26, [5] = 39, [6] = 50 })[R[3]] } }
  R[4] = draw_avoid(7, { R[2], R[0] })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 65, [1] = 12, [2] = 43, [3] = 43, [4] = 24, [5] = 40, [6] = 9 })[R[4]], ({ [0] = 3, [1] = 57, [2] = 4, [3] = 33, [4] = 30, [5] = 16, [6] = 40 })[R[4]] } }
  R[5] = draw_avoid(7, { R[3], R[1] })
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 125, [1] = 75, [2] = 106, [3] = 95, [4] = 94, [5] = 54, [6] = 88 })[R[5]], ({ [0] = 8, [1] = 40, [2] = 37, [3] = 8, [4] = 26, [5] = 39, [6] = 50 })[R[5]] } }
  game.initial_set_tile({ 3, 5 }, 32)
  game.initial_set_tile({ 3, 6 }, 11)
  game.initial_set_tile({ 4, 5 }, 11)
  game.initial_set_tile({ 4, 6 }, 32)
  game.initial_set_tile({ 6, 13 }, 31)
  game.initial_set_tile({ 6, 14 }, 11)
  game.initial_set_tile({ 6, 15 }, 32)
  game.initial_set_tile({ 7, 13 }, 32)
  game.initial_set_tile({ 7, 14 }, 31)
  game.initial_set_tile({ 7, 15 }, 31)
  game.set_cell_type({ 8, 5 }, 7)
  game.initial_set_tile({ 8, 5 }, 11)
  game.set_cell_type({ 8, 6 }, 7)
  game.initial_set_tile({ 8, 6 }, 31)
  game.set_cell_type({ 9, 5 }, 7)
  game.initial_set_tile({ 9, 5 }, 31)
  game.set_cell_type({ 9, 6 }, 7)
  game.initial_set_tile({ 9, 6 }, 32)
  game.initial_set_tile({ 9, 13 }, 11)
  game.initial_set_tile({ 9, 14 }, 31)
  game.initial_set_tile({ 10, 13 }, 11)
  game.initial_set_tile({ 10, 14 }, 32)
  game.initial_set_tile({ 12, 16 }, 31)
  game.initial_set_tile({ 15, 9 }, 32)
  game.initial_set_tile({ 15, 10 }, 31)
  game.initial_set_tile({ 15, 11 }, 11)
  game.initial_set_tile({ 16, 2 }, 31)
  game.initial_set_tile({ 17, 2 }, 31)
  game.initial_set_tile({ 53, 58 }, 10)
  game.initial_set_tile({ 53, 59 }, 23)
  game.initial_set_tile({ 54, 58 }, 23)
  game.initial_set_tile({ 54, 59 }, 10)
  game.initial_set_tile({ 55, 54 }, 23)
  game.initial_set_tile({ 56, 54 }, 10)
  game.initial_set_tile({ 58, 45 }, 23)
  game.initial_set_tile({ 59, 45 }, 1)
  game.initial_set_tile({ 59, 46 }, 23)
  game.set_cell_type({ 60, 50 }, 7)
  game.initial_set_tile({ 60, 50 }, 23)
  game.set_cell_type({ 60, 51 }, 7)
  game.initial_set_tile({ 60, 51 }, 1)
  game.set_cell_type({ 60, 52 }, 7)
  game.initial_set_tile({ 60, 52 }, 23)
  game.set_cell_type({ 61, 50 }, 7)
  game.initial_set_tile({ 61, 50 }, 1)
  game.set_cell_type({ 61, 51 }, 7)
  game.initial_set_tile({ 61, 51 }, 10)
  game.set_cell_type({ 61, 52 }, 7)
  game.initial_set_tile({ 61, 52 }, 10)
  game.set_cell_type({ 62, 50 }, 7)
  game.initial_set_tile({ 62, 50 }, 10)
  game.set_cell_type({ 62, 51 }, 7)
  game.initial_set_tile({ 62, 51 }, 1)
  game.set_cell_type({ 62, 52 }, 7)
  game.initial_set_tile({ 62, 52 }, 23)
  game.initial_set_tile({ 65, 60 }, 23)
  game.initial_set_tile({ 65, 61 }, 10)
  game.initial_set_tile({ 66, 60 }, 10)
  game.initial_set_tile({ 66, 61 }, 23)
  game.initial_set_tile({ 67, 60 }, 10)
  game.initial_set_tile({ 67, 61 }, 1)
  game.initial_set_tile({ 68, 60 }, 1)
  game.initial_set_tile({ 68, 61 }, 10)
  pick(2, 2, { 6, 7 })
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 65, [1] = 30 })[R[7]], ({ [0] = 36, [1] = 7 })[R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
  if R[7] == 1 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 18, 7 }, direction = "East", lights = false, exact = true }[1]
  elseif R[7] == 0 then
  else
    unseen("R[7]", R[7])
  end
  R[8] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 60, [1] = 10 }, [1] = { [0] = 64, [1] = 14 }, [2] = { [0] = 64, [1] = 14 }, [3] = { [0] = 56, [1] = 6 }, [4] = { [0] = 60, [1] = 10 }, [5] = { [0] = 59, [1] = 9 }, [6] = { [0] = 56, [1] = 6 }, [7] = { [0] = 62, [1] = 12 } })[R[8]][R[7]], ({ [0] = { [0] = 54, [1] = 10 }, [1] = { [0] = 50, [1] = 6 }, [2] = { [0] = 54, [1] = 10 }, [3] = { [0] = 50, [1] = 6 }, [4] = { [0] = 53, [1] = 9 }, [5] = { [0] = 51, [1] = 7 }, [6] = { [0] = 48, [1] = 4 }, [7] = { [0] = 51, [1] = 7 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
  players[1]:center_view({ ({ [0] = { [0] = 60, [1] = 10 }, [1] = { [0] = 64, [1] = 14 }, [2] = { [0] = 64, [1] = 14 }, [3] = { [0] = 56, [1] = 6 }, [4] = { [0] = 60, [1] = 10 }, [5] = { [0] = 59, [1] = 9 }, [6] = { [0] = 56, [1] = 6 }, [7] = { [0] = 62, [1] = 12 } })[R[8]][R[7]], ({ [0] = { [0] = 54, [1] = 10 }, [1] = { [0] = 50, [1] = 6 }, [2] = { [0] = 54, [1] = 10 }, [3] = { [0] = 50, [1] = 6 }, [4] = { [0] = 53, [1] = 9 }, [5] = { [0] = 51, [1] = 7 }, [6] = { [0] = 48, [1] = 4 }, [7] = { [0] = 51, [1] = 7 } })[R[8]][R[7]] })
  if R[8] == 1 or R[8] == 2 or R[8] == 3 or R[8] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 64, [1] = 14 }, [2] = { [0] = 57, [1] = 7 }, [3] = { [0] = 61, [1] = 11 }, [4] = { [0] = 57, [1] = 7 } })[R[8]][R[7]], ({ [0] = 57, [1] = 13 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    if R[8] == 1 or R[8] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 55, [1] = 5 }, [2] = { [0] = 56, [1] = 6 } })[R[8]][R[7]], ({ [0] = 48, [1] = 4 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 64, [1] = 14 })[R[7]], ({ [1] = { [0] = 53, [1] = 9 }, [2] = { [0] = 57, [1] = 13 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 59, [1] = 9 }, [2] = { [0] = 60, [1] = 10 } })[R[8]][R[7]], ({ [1] = { [0] = 58, [1] = 14 }, [2] = { [0] = 54, [1] = 10 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 59, [1] = 9 }, [2] = { [0] = 64, [1] = 14 } })[R[8]][R[7]], ({ [1] = { [0] = 54, [1] = 10 }, [2] = { [0] = 51, [1] = 7 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 65, [1] = 15 }, [2] = { [0] = 63, [1] = 13 } })[R[8]][R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 66, [1] = 16 }, [2] = { [0] = 65, [1] = 15 } })[R[8]][R[7]], ({ [1] = { [0] = 58, [1] = 14 }, [2] = { [0] = 59, [1] = 15 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[8] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 6 })[R[7]], ({ [0] = 58, [1] = 14 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 54, [1] = 10 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 57, [1] = 7 })[R[7]], ({ [0] = 53, [1] = 9 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 65, [1] = 15 })[R[7]], ({ [0] = 48, [1] = 4 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 62, [1] = 12 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 58, [1] = 14 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[8] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 57, [1] = 7 })[R[7]], ({ [0] = 49, [1] = 5 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 61, [1] = 11 })[R[7]], ({ [0] = 50, [1] = 6 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 6 })[R[7]], ({ [0] = 53, [1] = 9 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 65, [1] = 15 })[R[7]], ({ [0] = 58, [1] = 14 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 47, [1] = 3 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[1].difficulty] == 2 then
      elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 60, [1] = 10 })[R[7]], ({ [0] = 48, [1] = 4 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[8]", R[8])
    end
    U[#U]:set_lights(true)
    if R[8] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[8] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 61, [1] = 11 })[R[7]], ({ [0] = 58, [1] = 14 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[8] == 3 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 64, [1] = 14 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[8] == 4 then
      if LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 60, [1] = 10 })[R[7]], ({ [0] = 48, [1] = 4 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 54, [1] = 4 })[R[7]], ({ [0] = 55, [1] = 11 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[8]", R[8])
    end
    U[#U]:set_lights(true)
    if R[8] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 66, [1] = 16 })[R[7]], ({ [0] = 55, [1] = 11 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[8] == 2 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 8 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[8] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 8 })[R[7]], ({ [0] = 55, [1] = 11 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[8] == 4 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 8 })[R[7]], ({ [0] = 51, [1] = 7 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 54, [1] = 4 })[R[7]], ({ [0] = 55, [1] = 11 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[8]", R[8])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 66, [1] = 16 }, [2] = { [0] = 58, [1] = 8 }, [3] = { [0] = 58, [1] = 8 }, [4] = { [0] = 58, [1] = 8 } })[R[8]][R[7]], ({ [1] = { [0] = 55, [1] = 11 }, [2] = { [0] = 59, [1] = 15 }, [3] = { [0] = 55, [1] = 11 }, [4] = { [0] = 51, [1] = 7 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[8] == 5 or R[8] == 6 or R[8] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 56, [1] = 6 }, [6] = { [0] = 65, [1] = 15 }, [7] = { [0] = 56, [1] = 6 } })[R[8]][R[7]], ({ [0] = 58, [1] = 14 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 64, [1] = 14 }, [6] = { [0] = 56, [1] = 6 }, [7] = { [0] = 64, [1] = 14 } })[R[8]][R[7]], ({ [5] = { [0] = 52, [1] = 8 }, [6] = { [0] = 57, [1] = 13 }, [7] = { [0] = 57, [1] = 13 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
    if R[8] == 5 or R[8] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 64, [1] = 14 }, [7] = { [0] = 57, [1] = 7 } })[R[8]][R[7]], ({ [0] = 48, [1] = 4 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      if R[8] == 5 then
        if LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[8] == 7 then
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
        unseen("R[8]", R[8])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 59, [1] = 9 }, [7] = { [0] = 61, [1] = 11 } })[R[8]][R[7]], ({ [0] = 48, [1] = 4 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      if R[8] == 7 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 62, [1] = 12 })[R[7]], ({ [0] = 54, [1] = 10 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[8] == 5 then
      else
        unseen("R[8]", R[8])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [5] = { [0] = 54, [1] = 10 }, [7] = { [0] = 51, [1] = 7 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 60, [1] = 10 })[R[7]], ({ [5] = { [0] = 53, [1] = 9 }, [7] = { [0] = 52, [1] = 8 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 60, [1] = 10 }, [7] = { [0] = 65, [1] = 15 } })[R[8]][R[7]], ({ [5] = { [0] = 55, [1] = 11 }, [7] = { [0] = 52, [1] = 8 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[8] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 56, [1] = 6 })[R[7]], ({ [0] = 54, [1] = 10 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 6 })[R[7]], ({ [0] = 51, [1] = 7 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 11 })[R[7]], ({ [0] = 49, [1] = 5 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
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
      unseen("R[8]", R[8])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 66, [1] = 16 }, [6] = { [0] = 63, [1] = 13 }, [7] = { [0] = 59, [1] = 9 } })[R[8]][R[7]], ({ [5] = { [0] = 50, [1] = 6 }, [6] = { [0] = 51, [1] = 7 }, [7] = { [0] = 49, [1] = 5 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
    if R[8] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 66, [1] = 16 })[R[7]], ({ [0] = 50, [1] = 6 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[8] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 51, [1] = 7 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 51, [1] = 7 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 8 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 58, [1] = 14 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[8] == 7 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 49, [1] = 5 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[8]", R[8])
    end
  elseif R[8] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 57, [1] = 7 })[R[7]], ({ [0] = 57, [1] = 13 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 62, [1] = 12 })[R[7]], ({ [0] = 57, [1] = 13 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 6 })[R[7]], ({ [0] = 54, [1] = 10 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 64, [1] = 14 })[R[7]], ({ [0] = 54, [1] = 10 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 65, [1] = 15 })[R[7]], ({ [0] = 48, [1] = 4 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 64, [1] = 14 })[R[7]], ({ [0] = 58, [1] = 14 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 66, [1] = 16 })[R[7]], ({ [0] = 57, [1] = 13 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[8]", R[8])
  end
  U[#U]:set_lights(true)
  if R[8] == 0 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 55, [1] = 5 })[R[7]], ({ [0] = 50, [1] = 6 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 55, [1] = 5 })[R[7]], ({ [0] = 50, [1] = 6 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[8] == 1 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 66, [1] = 16 })[R[7]], ({ [0] = 55, [1] = 11 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 6 })[R[7]], ({ [0] = 54, [1] = 10 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 6 })[R[7]], ({ [0] = 54, [1] = 10 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[8] == 2 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 8 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 60, [1] = 10 })[R[7]], ({ [0] = 50, [1] = 6 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 60, [1] = 10 })[R[7]], ({ [0] = 50, [1] = 6 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[8] == 3 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 8 })[R[7]], ({ [0] = 55, [1] = 11 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 51, [1] = 7 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 51, [1] = 7 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[8] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 58, [1] = 8 })[R[7]], ({ [0] = 51, [1] = 7 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 5 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[8] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 66, [1] = 16 })[R[7]], ({ [0] = 50, [1] = 6 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 66, [1] = 16 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[8] == 6 then
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 51, [1] = 7 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 8 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 58, [1] = 14 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 61, [1] = 11 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 52, [1] = 8 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 61, [1] = 11 })[R[7]], ({ [0] = 59, [1] = 15 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 52, [1] = 8 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif R[8] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 49, [1] = 5 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 66, [1] = 16 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[8]", R[8])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[8]], player = players[1], at = { ({ [0] = { [0] = 56, [1] = 6 }, [1] = { [0] = 55, [1] = 5 }, [2] = { [0] = 61, [1] = 11 }, [3] = { [0] = 60, [1] = 10 }, [4] = { [0] = 58, [1] = 8 }, [5] = { [0] = 65, [1] = 15 }, [6] = { [0] = 60, [1] = 10 }, [7] = { [0] = 65, [1] = 15 } })[R[8]][R[7]], ({ [0] = { [0] = 51, [1] = 7 }, [1] = { [0] = 53, [1] = 9 }, [2] = { [0] = 49, [1] = 5 }, [3] = { [0] = 50, [1] = 6 }, [4] = { [0] = 59, [1] = 15 }, [5] = { [0] = 54, [1] = 10 }, [6] = { [0] = 53, [1] = 9 }, [7] = { [0] = 59, [1] = 15 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[8]], player = players[1], at = { ({ [0] = { [0] = 57, [1] = 7 }, [1] = { [0] = 57, [1] = 7 }, [2] = { [0] = 60, [1] = 10 }, [3] = { [0] = 59, [1] = 9 }, [4] = { [0] = 59, [1] = 9 }, [5] = { [0] = 66, [1] = 16 }, [6] = { [0] = 61, [1] = 11 }, [7] = { [0] = 66, [1] = 16 } })[R[8]][R[7]], ({ [0] = { [0] = 51, [1] = 7 }, [1] = { [0] = 52, [1] = 8 }, [2] = { [0] = 48, [1] = 4 }, [3] = { [0] = 49, [1] = 5 }, [4] = { [0] = 58, [1] = 14 }, [5] = { [0] = 53, [1] = 9 }, [6] = { [0] = 52, [1] = 8 }, [7] = { [0] = 59, [1] = 15 } })[R[8]][R[7]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[8] == 0 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[9] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 55, [1] = 5 }, [1] = { [0] = 60, [1] = 10 }, [2] = { [0] = 65, [1] = 15 } })[R[9]][R[7]], ({ [0] = { [0] = 47, [1] = 3 }, [1] = { [0] = 50, [1] = 6 }, [2] = { [0] = 56, [1] = 12 } })[R[9]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[8] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 59, [1] = 9 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] })
      for i = 1, game.initial_units() do
        R[10] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 55, [1] = 5 }, [1] = { [0] = 59, [1] = 9 }, [2] = { [0] = 62, [1] = 12 } })[R[10]][R[7]], ({ [0] = { [0] = 57, [1] = 13 }, [1] = { [0] = 51, [1] = 7 }, [2] = { [0] = 47, [1] = 3 } })[R[10]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[8] == 2 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 60, [1] = 10 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] })
      game.create_tube({ ({ [0] = 60, [1] = 10 })[R[7]], ({ [0] = 57, [1] = 13 })[R[7]] })
      game.create_tube({ ({ [0] = 61, [1] = 11 })[R[7]], ({ [0] = 57, [1] = 13 })[R[7]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 60, [1] = 10 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] })
      game.create_tube({ ({ [0] = 60, [1] = 10 })[R[7]], ({ [0] = 57, [1] = 13 })[R[7]] })
      game.create_tube({ ({ [0] = 61, [1] = 11 })[R[7]], ({ [0] = 57, [1] = 13 })[R[7]] })
      for i = 1, game.initial_units() do
        R[11] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 64, [1] = 14 }, [1] = { [0] = 56, [1] = 6 }, [2] = { [0] = 60, [1] = 10 } })[R[11]][R[7]], ({ [0] = { [0] = 47, [1] = 3 }, [1] = { [0] = 52, [1] = 8 }, [2] = { [0] = 57, [1] = 13 } })[R[11]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[8] == 3 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 57, [1] = 7 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] })
      game.create_tube({ ({ [0] = 60, [1] = 10 })[R[7]], ({ [0] = 53, [1] = 9 })[R[7]] })
      game.create_tube({ ({ [0] = 61, [1] = 11 })[R[7]], ({ [0] = 53, [1] = 9 })[R[7]] })
      game.create_tube({ ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] })
      game.create_tube({ ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 57, [1] = 13 })[R[7]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 57, [1] = 7 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] })
      game.create_tube({ ({ [0] = 60, [1] = 10 })[R[7]], ({ [0] = 53, [1] = 9 })[R[7]] })
      game.create_tube({ ({ [0] = 61, [1] = 11 })[R[7]], ({ [0] = 53, [1] = 9 })[R[7]] })
      game.create_tube({ ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 56, [1] = 12 })[R[7]] })
      game.create_tube({ ({ [0] = 63, [1] = 13 })[R[7]], ({ [0] = 57, [1] = 13 })[R[7]] })
      for i = 1, game.initial_units() do
        R[12] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 65, [1] = 15 }, [1] = { [0] = 61, [1] = 11 }, [2] = { [0] = 57, [1] = 7 } })[R[12]][R[7]], ({ [0] = { [0] = 58, [1] = 14 }, [1] = { [0] = 52, [1] = 8 }, [2] = { [0] = 47, [1] = 3 } })[R[12]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[8] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 56, [1] = 6 })[R[7]], ({ [0] = 55, [1] = 11 })[R[7]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 56, [1] = 6 })[R[7]], ({ [0] = 55, [1] = 11 })[R[7]] })
      for i = 1, game.initial_units() do
        R[13] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 64, [1] = 14 }, [1] = { [0] = 65, [1] = 15 }, [2] = { [0] = 61, [1] = 11 } })[R[13]][R[7]], ({ [0] = { [0] = 47, [1] = 3 }, [1] = { [0] = 53, [1] = 9 }, [2] = { [0] = 57, [1] = 13 } })[R[13]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[8] == 5 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[14] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 61, [1] = 11 }, [1] = { [0] = 55, [1] = 5 }, [2] = { [0] = 55, [1] = 5 } })[R[14]][R[7]], ({ [0] = { [0] = 58, [1] = 14 }, [1] = { [0] = 53, [1] = 9 }, [2] = { [0] = 48, [1] = 4 } })[R[14]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[8] == 6 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[15] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 65, [1] = 15 }, [1] = { [0] = 64, [1] = 14 }, [2] = { [0] = 61, [1] = 11 } })[R[15]][R[7]], ({ [0] = { [0] = 48, [1] = 4 }, [1] = { [0] = 54, [1] = 10 }, [2] = { [0] = 55, [1] = 11 } })[R[15]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[8] == 7 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[16] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 9 }, [1] = { [0] = 55, [1] = 5 }, [2] = { [0] = 65, [1] = 15 } })[R[16]][R[7]], ({ [0] = { [0] = 57, [1] = 13 }, [1] = { [0] = 53, [1] = 9 }, [2] = { [0] = 48, [1] = 4 } })[R[16]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[8]", R[8])
  end
  U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 30, [1] = 65 })[R[7]], ({ [0] = 7, [1] = 36 })[R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
  if R[7] == 1 then
  elseif R[7] == 0 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 18, 7 }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[7]", R[7])
  end
  R[17] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 10, [1] = 60 }, [1] = { [0] = 14, [1] = 64 }, [2] = { [0] = 14, [1] = 64 }, [3] = { [0] = 6, [1] = 56 }, [4] = { [0] = 10, [1] = 60 }, [5] = { [0] = 9, [1] = 59 }, [6] = { [0] = 6, [1] = 56 }, [7] = { [0] = 12, [1] = 62 } })[R[17]][R[7]], ({ [0] = { [0] = 10, [1] = 54 }, [1] = { [0] = 6, [1] = 50 }, [2] = { [0] = 10, [1] = 54 }, [3] = { [0] = 6, [1] = 50 }, [4] = { [0] = 9, [1] = 53 }, [5] = { [0] = 7, [1] = 51 }, [6] = { [0] = 4, [1] = 48 }, [7] = { [0] = 7, [1] = 51 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
  players[2]:center_view({ ({ [0] = { [0] = 10, [1] = 60 }, [1] = { [0] = 14, [1] = 64 }, [2] = { [0] = 14, [1] = 64 }, [3] = { [0] = 6, [1] = 56 }, [4] = { [0] = 10, [1] = 60 }, [5] = { [0] = 9, [1] = 59 }, [6] = { [0] = 6, [1] = 56 }, [7] = { [0] = 12, [1] = 62 } })[R[17]][R[7]], ({ [0] = { [0] = 10, [1] = 54 }, [1] = { [0] = 6, [1] = 50 }, [2] = { [0] = 10, [1] = 54 }, [3] = { [0] = 6, [1] = 50 }, [4] = { [0] = 9, [1] = 53 }, [5] = { [0] = 7, [1] = 51 }, [6] = { [0] = 4, [1] = 48 }, [7] = { [0] = 7, [1] = 51 } })[R[17]][R[7]] })
  if R[17] == 1 or R[17] == 2 or R[17] == 3 or R[17] == 4 then
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 14, [1] = 64 }, [2] = { [0] = 7, [1] = 57 }, [3] = { [0] = 11, [1] = 61 }, [4] = { [0] = 7, [1] = 57 } })[R[17]][R[7]], ({ [0] = 13, [1] = 57 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    if R[17] == 3 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 6, [1] = 56 })[R[7]], ({ [0] = 14, [1] = 58 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 10, [1] = 54 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 7, [1] = 57 })[R[7]], ({ [0] = 9, [1] = 53 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 15, [1] = 65 })[R[7]], ({ [0] = 4, [1] = 48 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 12, [1] = 62 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 14, [1] = 58 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 7, [1] = 57 })[R[7]], ({ [0] = 5, [1] = 49 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 11, [1] = 61 })[R[7]], ({ [0] = 6, [1] = 50 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 6, [1] = 56 })[R[7]], ({ [0] = 9, [1] = 53 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 15, [1] = 65 })[R[7]], ({ [0] = 14, [1] = 58 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 3, [1] = 47 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 10, [1] = 60 })[R[7]], ({ [0] = 4, [1] = 48 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[17] == 1 or R[17] == 2 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 5, [1] = 55 }, [2] = { [0] = 6, [1] = 56 } })[R[17]][R[7]], ({ [0] = 4, [1] = 48 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 64 })[R[7]], ({ [1] = { [0] = 9, [1] = 53 }, [2] = { [0] = 13, [1] = 57 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 9, [1] = 59 }, [2] = { [0] = 10, [1] = 60 } })[R[17]][R[7]], ({ [1] = { [0] = 14, [1] = 58 }, [2] = { [0] = 10, [1] = 54 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 9, [1] = 59 }, [2] = { [0] = 14, [1] = 64 } })[R[17]][R[7]], ({ [1] = { [0] = 10, [1] = 54 }, [2] = { [0] = 7, [1] = 51 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 15, [1] = 65 }, [2] = { [0] = 13, [1] = 63 } })[R[17]][R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 16, [1] = 66 }, [2] = { [0] = 15, [1] = 65 } })[R[17]][R[7]], ({ [1] = { [0] = 14, [1] = 58 }, [2] = { [0] = 15, [1] = 59 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    if R[17] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 11, [1] = 61 })[R[7]], ({ [0] = 14, [1] = 58 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 3 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 64 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 4, [1] = 54 })[R[7]], ({ [0] = 11, [1] = 55 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 10, [1] = 60 })[R[7]], ({ [0] = 4, [1] = 48 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    if R[17] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 66 })[R[7]], ({ [0] = 11, [1] = 55 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 2 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 8, [1] = 58 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 8, [1] = 58 })[R[7]], ({ [0] = 11, [1] = 55 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 8, [1] = 58 })[R[7]], ({ [0] = 7, [1] = 51 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 4, [1] = 54 })[R[7]], ({ [0] = 11, [1] = 55 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 16, [1] = 66 }, [2] = { [0] = 8, [1] = 58 }, [3] = { [0] = 8, [1] = 58 }, [4] = { [0] = 8, [1] = 58 } })[R[17]][R[7]], ({ [1] = { [0] = 11, [1] = 55 }, [2] = { [0] = 15, [1] = 59 }, [3] = { [0] = 11, [1] = 55 }, [4] = { [0] = 7, [1] = 51 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[17] == 0 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 7, [1] = 57 })[R[7]], ({ [0] = 13, [1] = 57 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 12, [1] = 62 })[R[7]], ({ [0] = 13, [1] = 57 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 6, [1] = 56 })[R[7]], ({ [0] = 10, [1] = 54 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 14, [1] = 64 })[R[7]], ({ [0] = 10, [1] = 54 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 15, [1] = 65 })[R[7]], ({ [0] = 4, [1] = 48 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 64 })[R[7]], ({ [0] = 14, [1] = 58 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 66 })[R[7]], ({ [0] = 13, [1] = 57 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[17] == 5 or R[17] == 6 or R[17] == 7 then
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 6, [1] = 56 }, [6] = { [0] = 15, [1] = 65 }, [7] = { [0] = 6, [1] = 56 } })[R[17]][R[7]], ({ [0] = 14, [1] = 58 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 14, [1] = 64 }, [6] = { [0] = 6, [1] = 56 }, [7] = { [0] = 14, [1] = 64 } })[R[17]][R[7]], ({ [5] = { [0] = 8, [1] = 52 }, [6] = { [0] = 13, [1] = 57 }, [7] = { [0] = 13, [1] = 57 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
    if R[17] == 5 or R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 14, [1] = 64 }, [7] = { [0] = 7, [1] = 57 } })[R[17]][R[7]], ({ [0] = 4, [1] = 48 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 5 then
        if LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[17] == 7 then
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
        unseen("R[17]", R[17])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 9, [1] = 59 }, [7] = { [0] = 11, [1] = 61 } })[R[17]][R[7]], ({ [0] = 4, [1] = 48 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 7 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 12, [1] = 62 })[R[7]], ({ [0] = 10, [1] = 54 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 5 then
      else
        unseen("R[17]", R[17])
      end
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [5] = { [0] = 10, [1] = 54 }, [7] = { [0] = 7, [1] = 51 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 10, [1] = 60 })[R[7]], ({ [5] = { [0] = 9, [1] = 53 }, [7] = { [0] = 8, [1] = 52 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 10, [1] = 60 }, [7] = { [0] = 15, [1] = 65 } })[R[17]][R[7]], ({ [5] = { [0] = 11, [1] = 55 }, [7] = { [0] = 8, [1] = 52 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[17] == 6 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 6, [1] = 56 })[R[7]], ({ [0] = 10, [1] = 54 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 6, [1] = 56 })[R[7]], ({ [0] = 7, [1] = 51 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 11, [1] = 61 })[R[7]], ({ [0] = 5, [1] = 49 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
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
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 16, [1] = 66 }, [6] = { [0] = 13, [1] = 63 }, [7] = { [0] = 9, [1] = 59 } })[R[17]][R[7]], ({ [5] = { [0] = 6, [1] = 50 }, [6] = { [0] = 7, [1] = 51 }, [7] = { [0] = 5, [1] = 49 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
    if R[17] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 66 })[R[7]], ({ [0] = 6, [1] = 50 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[17] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 7, [1] = 51 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 7, [1] = 51 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 8, [1] = 58 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 14, [1] = 58 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[17] == 7 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 5, [1] = 49 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[17]", R[17])
    end
  else
    unseen("R[17]", R[17])
  end
  U[#U]:set_lights(true)
  if R[17] == 0 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 5, [1] = 55 })[R[7]], ({ [0] = 6, [1] = 50 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 5, [1] = 55 })[R[7]], ({ [0] = 6, [1] = 50 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[17] == 1 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 66 })[R[7]], ({ [0] = 11, [1] = 55 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 6, [1] = 56 })[R[7]], ({ [0] = 10, [1] = 54 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 6, [1] = 56 })[R[7]], ({ [0] = 10, [1] = 54 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[17] == 2 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 8, [1] = 58 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 60 })[R[7]], ({ [0] = 6, [1] = 50 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 10, [1] = 60 })[R[7]], ({ [0] = 6, [1] = 50 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[17] == 3 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 8, [1] = 58 })[R[7]], ({ [0] = 11, [1] = 55 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 7, [1] = 51 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 7, [1] = 51 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[17] == 4 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 8, [1] = 58 })[R[7]], ({ [0] = 7, [1] = 51 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 5, [1] = 55 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[17] == 5 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 16, [1] = 66 })[R[7]], ({ [0] = 6, [1] = 50 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 66 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
  elseif R[17] == 6 then
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 7, [1] = 51 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 8, [1] = 58 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 14, [1] = 58 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 11, [1] = 61 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 8, [1] = 52 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 11, [1] = 61 })[R[7]], ({ [0] = 15, [1] = 59 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 8, [1] = 52 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif R[17] == 7 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 5, [1] = 49 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 16, [1] = 66 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("R[17]", R[17])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[17]], player = players[2], at = { ({ [0] = { [0] = 6, [1] = 56 }, [1] = { [0] = 5, [1] = 55 }, [2] = { [0] = 11, [1] = 61 }, [3] = { [0] = 10, [1] = 60 }, [4] = { [0] = 8, [1] = 58 }, [5] = { [0] = 15, [1] = 65 }, [6] = { [0] = 10, [1] = 60 }, [7] = { [0] = 15, [1] = 65 } })[R[17]][R[7]], ({ [0] = { [0] = 7, [1] = 51 }, [1] = { [0] = 9, [1] = 53 }, [2] = { [0] = 5, [1] = 49 }, [3] = { [0] = 6, [1] = 50 }, [4] = { [0] = 15, [1] = 59 }, [5] = { [0] = 10, [1] = 54 }, [6] = { [0] = 9, [1] = 53 }, [7] = { [0] = 15, [1] = 59 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[17]], player = players[2], at = { ({ [0] = { [0] = 7, [1] = 57 }, [1] = { [0] = 7, [1] = 57 }, [2] = { [0] = 10, [1] = 60 }, [3] = { [0] = 9, [1] = 59 }, [4] = { [0] = 9, [1] = 59 }, [5] = { [0] = 16, [1] = 66 }, [6] = { [0] = 11, [1] = 61 }, [7] = { [0] = 16, [1] = 66 } })[R[17]][R[7]], ({ [0] = { [0] = 7, [1] = 51 }, [1] = { [0] = 8, [1] = 52 }, [2] = { [0] = 4, [1] = 48 }, [3] = { [0] = 5, [1] = 49 }, [4] = { [0] = 14, [1] = 58 }, [5] = { [0] = 9, [1] = 53 }, [6] = { [0] = 8, [1] = 52 }, [7] = { [0] = 15, [1] = 59 } })[R[17]][R[7]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if R[17] == 0 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[18] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 5, [1] = 55 }, [1] = { [0] = 10, [1] = 60 }, [2] = { [0] = 15, [1] = 65 } })[R[18]][R[7]], ({ [0] = { [0] = 3, [1] = 47 }, [1] = { [0] = 6, [1] = 50 }, [2] = { [0] = 12, [1] = 56 } })[R[18]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[17] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 9, [1] = 59 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] })
      for i = 1, game.initial_units() do
        R[19] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 5, [1] = 55 }, [1] = { [0] = 9, [1] = 59 }, [2] = { [0] = 12, [1] = 62 } })[R[19]][R[7]], ({ [0] = { [0] = 13, [1] = 57 }, [1] = { [0] = 7, [1] = 51 }, [2] = { [0] = 3, [1] = 47 } })[R[19]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[17] == 2 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 10, [1] = 60 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] })
      game.create_tube({ ({ [0] = 10, [1] = 60 })[R[7]], ({ [0] = 13, [1] = 57 })[R[7]] })
      game.create_tube({ ({ [0] = 11, [1] = 61 })[R[7]], ({ [0] = 13, [1] = 57 })[R[7]] })
      for i = 1, game.initial_units() do
        R[20] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 64 }, [1] = { [0] = 6, [1] = 56 }, [2] = { [0] = 10, [1] = 60 } })[R[20]][R[7]], ({ [0] = { [0] = 3, [1] = 47 }, [1] = { [0] = 8, [1] = 52 }, [2] = { [0] = 13, [1] = 57 } })[R[20]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 10, [1] = 60 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] })
      game.create_tube({ ({ [0] = 10, [1] = 60 })[R[7]], ({ [0] = 13, [1] = 57 })[R[7]] })
      game.create_tube({ ({ [0] = 11, [1] = 61 })[R[7]], ({ [0] = 13, [1] = 57 })[R[7]] })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[17] == 3 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 7, [1] = 57 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] })
      game.create_tube({ ({ [0] = 10, [1] = 60 })[R[7]], ({ [0] = 9, [1] = 53 })[R[7]] })
      game.create_tube({ ({ [0] = 11, [1] = 61 })[R[7]], ({ [0] = 9, [1] = 53 })[R[7]] })
      game.create_tube({ ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] })
      game.create_tube({ ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 13, [1] = 57 })[R[7]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 7, [1] = 57 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] })
      game.create_tube({ ({ [0] = 10, [1] = 60 })[R[7]], ({ [0] = 9, [1] = 53 })[R[7]] })
      game.create_tube({ ({ [0] = 11, [1] = 61 })[R[7]], ({ [0] = 9, [1] = 53 })[R[7]] })
      game.create_tube({ ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 12, [1] = 56 })[R[7]] })
      game.create_tube({ ({ [0] = 13, [1] = 63 })[R[7]], ({ [0] = 13, [1] = 57 })[R[7]] })
      for i = 1, game.initial_units() do
        R[21] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 15, [1] = 65 }, [1] = { [0] = 11, [1] = 61 }, [2] = { [0] = 7, [1] = 57 } })[R[21]][R[7]], ({ [0] = { [0] = 14, [1] = 58 }, [1] = { [0] = 8, [1] = 52 }, [2] = { [0] = 3, [1] = 47 } })[R[21]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[17] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 6, [1] = 56 })[R[7]], ({ [0] = 11, [1] = 55 })[R[7]] })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 6, [1] = 56 })[R[7]], ({ [0] = 11, [1] = 55 })[R[7]] })
      for i = 1, game.initial_units() do
        R[22] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 64 }, [1] = { [0] = 15, [1] = 65 }, [2] = { [0] = 11, [1] = 61 } })[R[22]][R[7]], ({ [0] = { [0] = 3, [1] = 47 }, [1] = { [0] = 9, [1] = 53 }, [2] = { [0] = 13, [1] = 57 } })[R[22]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[17] == 5 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[23] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 11, [1] = 61 }, [1] = { [0] = 5, [1] = 55 }, [2] = { [0] = 5, [1] = 55 } })[R[23]][R[7]], ({ [0] = { [0] = 14, [1] = 58 }, [1] = { [0] = 9, [1] = 53 }, [2] = { [0] = 4, [1] = 48 } })[R[23]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[17] == 6 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[24] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 15, [1] = 65 }, [1] = { [0] = 14, [1] = 64 }, [2] = { [0] = 11, [1] = 61 } })[R[24]][R[7]], ({ [0] = { [0] = 4, [1] = 48 }, [1] = { [0] = 10, [1] = 54 }, [2] = { [0] = 11, [1] = 55 } })[R[24]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[17] == 7 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[25] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 9, [1] = 59 }, [1] = { [0] = 5, [1] = 55 }, [2] = { [0] = 15, [1] = 65 } })[R[25]][R[7]], ({ [0] = { [0] = 13, [1] = 57 }, [1] = { [0] = 9, [1] = 53 }, [2] = { [0] = 4, [1] = 48 } })[R[25]][R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[17]", R[17])
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
    trigger.time{min = 24000, max = 48000, one_shot = false, on = Storm}  -- after 240 to 480 marks
    trigger.count{type = "CommonOreMine", cargo = "None", compare = ">=", count = 2, one_shot = true, on = Lava}
  end
  return true
end
