-- mf2_01Lua.lua  -  2 Player, SpaceRace, 'Close Encounter' map. (Lua)
--
-- Converted by op2dll from mf2_01.dll ("2 Player, SpaceRace, 'Close Encounter' map."): its setup replayed. `on_init` makes the original's
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
local Lava, Meteor, Quake, Storm, Tornado

function Lava(t)
  game.set_tile({ 52, 4 }, 1147)
  game.set_tile({ 52, 5 }, 1158)
  game.create_eruption({ 52, 6 }, 200)
end

function Meteor(t)
  local r1 = game.rand(60)
  local r2 = game.rand(128)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
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

function Tornado(t)
  local r1 = game.rand(60)
  local r2 = game.rand(128)
  local r3 = game.rand(8)
  local r4 = game.rand(60)
  local r5 = game.rand(128)
  game.create_tornado({ r5 + 1, r4 + 2 }, { r2 + 1, r1 + 2 }, r3 + 12)
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
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 34, 5 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 13, 61 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 103, 59 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 51, 62 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 42, 40 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 89, 30 } }
  pick(2, 2, { 0, 1 })
  R[2] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 101, [1] = 3 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 117, [1] = 19 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 113, [1] = 15 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 110, [1] = 12 } })[R[2]][R[1]], ({ [0] = 12, [1] = 18, [2] = 9, [3] = 22, [4] = 16, [5] = 17, [6] = 11, [7] = 16 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
  players[1]:center_view({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 101, [1] = 3 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 117, [1] = 19 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 113, [1] = 15 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 110, [1] = 12 } })[R[2]][R[1]], ({ [0] = 12, [1] = 18, [2] = 9, [3] = 22, [4] = 16, [5] = 17, [6] = 11, [7] = 16 })[R[2]] })
  U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[1], at = { ({ [0] = { [0] = 118, [1] = 20 }, [1] = { [0] = 105, [1] = 7 }, [2] = { [0] = 109, [1] = 11 }, [3] = { [0] = 117, [1] = 19 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 117, [1] = 19 }, [6] = { [0] = 115, [1] = 17 }, [7] = { [0] = 107, [1] = 9 } })[R[2]][R[1]], ({ [0] = 10, [1] = 16, [2] = 12, [3] = 19, [4] = 14, [5] = 15, [6] = 14, [7] = 15 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 111, [1] = 13 }, [2] = { [0] = 105, [1] = 7 }, [3] = { [0] = 125, [1] = 27 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 113, [1] = 15 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 103, [1] = 5 } })[R[2]][R[1]], ({ [0] = 5, [1] = 5, [2] = 14, [3] = 26, [4] = 24, [5] = 23, [6] = 11, [7] = 22 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
  if R[2] == 0 or R[2] == 1 or R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 126, [1] = 28 }, [1] = { [0] = 112, [1] = 14 }, [2] = { [0] = 108, [1] = 10 }, [5] = { [0] = 123, [1] = 25 }, [6] = { [0] = 118, [1] = 20 }, [7] = { [0] = 103, [1] = 5 } })[R[2]][R[1]], ({ [0] = 12, [1] = 12, [2] = 20, [5] = 22, [6] = 19, [7] = 9 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 0 then
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
    elseif R[2] == 1 then
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
    elseif R[2] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U]:set_factory_cargo(4, "VehicleFactory")
        U[#U]:set_factory_cargo(5, "RobotCommand")
        U[#U]:set_factory_cargo(6, "Residence")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 117, [1] = 19 })[R[1]], 14 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 117, [1] = 19 })[R[1]], 14 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 117, [1] = 19 })[R[1]], 14 }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 123, [1] = 25 })[R[1]], 15 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 123, [1] = 25 })[R[1]], 15 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 123, [1] = 25 })[R[1]], 15 }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 126, [1] = 28 })[R[1]], 19 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 126, [1] = 28 })[R[1]], 19 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 126, [1] = 28 })[R[1]], 19 }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 118, [1] = 20 })[R[1]], 9 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 118, [1] = 20 })[R[1]], 9 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 118, [1] = 20 })[R[1]], 9 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 5 }, [1] = { [0] = 112, [1] = 14 }, [2] = { [0] = 117, [1] = 19 }, [5] = { [0] = 113, [1] = 15 }, [6] = { [0] = 109, [1] = 11 }, [7] = { [0] = 119, [1] = 21 } })[R[2]][R[1]], ({ [0] = 12, [1] = 22, [2] = 20, [5] = 10, [6] = 19, [7] = 21 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 2 or R[2] == 5 or R[2] == 6 or R[2] == 7 then
    elseif R[2] == 0 or R[2] == 1 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 111, [1] = 13 } })[R[2]][R[1]], ({ [0] = 19, [1] = 30 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
  elseif R[2] == 3 or R[2] == 4 then
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 109, [1] = 11 })[R[1]], ({ [3] = 26, [4] = 8 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 112, [1] = 14 })[R[1]], 15 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 123, [1] = 25 })[R[1]], 15 }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 120, [1] = 22 })[R[1]], 10 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 120, [1] = 22 })[R[1]], 20 }, direction = "East", lights = false, exact = true }[1]
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
      unseen("R[2]", R[2])
    end
  else
    unseen("R[2]", R[2])
  end
  U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 102, [1] = 4 }, [2] = { [0] = 125, [1] = 27 }, [3] = { [0] = 118, [1] = 20 }, [4] = { [0] = 101, [1] = 3 }, [5] = { [0] = 103, [1] = 5 }, [6] = { [0] = 101, [1] = 3 }, [7] = { [0] = 111, [1] = 13 } })[R[2]][R[1]], ({ [0] = 19, [1] = 27, [2] = 14, [3] = 9, [4] = 12, [5] = 17, [6] = 19, [7] = 25 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 12 }, [1] = { [0] = 101, [1] = 3 }, [2] = { [0] = 121, [1] = 23 }, [3] = { [0] = 107, [1] = 9 }, [4] = { [0] = 119, [1] = 21 }, [5] = { [0] = 121, [1] = 23 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 121, [1] = 23 } })[R[2]][R[1]], ({ [0] = 8, [1] = 13, [2] = 18, [3] = 16, [4] = 16, [5] = 8, [6] = 24, [7] = 16 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 108, [1] = 10 }, [1] = { [0] = 101, [1] = 3 }, [2] = { [0] = 121, [1] = 23 }, [3] = { [0] = 110, [1] = 12 }, [4] = { [0] = 121, [1] = 23 }, [5] = { [0] = 121, [1] = 23 }, [6] = { [0] = 106, [1] = 8 }, [7] = { [0] = 121, [1] = 23 } })[R[2]][R[1]], ({ [0] = 8, [1] = 11, [2] = 16, [3] = 12, [4] = 16, [5] = 10, [6] = 24, [7] = 18 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 104, [1] = 6 }, [2] = { [0] = 103, [1] = 5 }, [3] = { [0] = 127, [1] = 29 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 109, [1] = 11 }, [6] = { [0] = 121, [1] = 23 }, [7] = { [0] = 120, [1] = 22 } })[R[2]][R[1]], ({ [0] = 14, [1] = 13, [2] = 19, [3] = 16, [4] = 24, [5] = 18, [6] = 11, [7] = 10 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 104, [1] = 6 }, [2] = { [0] = 103, [1] = 5 }, [3] = { [0] = 125, [1] = 27 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 109, [1] = 11 }, [6] = { [0] = 121, [1] = 23 }, [7] = { [0] = 120, [1] = 22 } })[R[2]][R[1]], ({ [0] = 14, [1] = 13, [2] = 19, [3] = 12, [4] = 24, [5] = 18, [6] = 11, [7] = 10 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 104, [1] = 6 }, [2] = { [0] = 103, [1] = 5 }, [3] = { [0] = 113, [1] = 15 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 109, [1] = 11 }, [6] = { [0] = 121, [1] = 23 }, [7] = { [0] = 120, [1] = 22 } })[R[2]][R[1]], ({ [0] = 14, [1] = 13, [2] = 19, [3] = 27, [4] = 24, [5] = 18, [6] = 11, [7] = 10 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 104, [1] = 6 }, [2] = { [0] = 121, [1] = 23 }, [3] = { [0] = 113, [1] = 15 }, [4] = { [0] = 114, [1] = 16 }, [5] = { [0] = 108, [1] = 10 }, [6] = { [0] = 113, [1] = 15 }, [7] = { [0] = 105, [1] = 7 } })[R[2]][R[1]], ({ [0] = 8, [1] = 7, [2] = 22, [3] = 27, [4] = 20, [5] = 7, [6] = 21, [7] = 16 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 117, [1] = 19 }, [3] = { [0] = 113, [1] = 15 }, [4] = { [0] = 116, [1] = 18 }, [5] = { [0] = 117, [1] = 19 }, [6] = { [0] = 122, [1] = 24 }, [7] = { [0] = 100, [1] = 2 } })[R[2]][R[1]], ({ [0] = 5, [1] = 4, [2] = 23, [3] = 27, [4] = 11, [5] = 15, [6] = 18, [7] = 13 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[1].difficulty] == 2 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 104, [1] = 6 }, [2] = { [0] = 121, [1] = 23 }, [3] = { [0] = 113, [1] = 15 }, [4] = { [0] = 114, [1] = 16 }, [5] = { [0] = 108, [1] = 10 }, [6] = { [0] = 113, [1] = 15 }, [7] = { [0] = 105, [1] = 7 } })[R[2]][R[1]], ({ [0] = 8, [1] = 7, [2] = 22, [3] = 27, [4] = 20, [5] = 7, [6] = 21, [7] = 16 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 105, [1] = 7 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 117, [1] = 19 }, [3] = { [0] = 113, [1] = 15 }, [4] = { [0] = 116, [1] = 18 }, [5] = { [0] = 117, [1] = 19 }, [6] = { [0] = 122, [1] = 24 }, [7] = { [0] = 100, [1] = 2 } })[R[2]][R[1]], ({ [0] = 5, [1] = 4, [2] = 23, [3] = 27, [4] = 11, [5] = 15, [6] = 18, [7] = 13 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 126, [1] = 28 }, [1] = { [0] = 110, [1] = 12 }, [2] = { [0] = 113, [1] = 15 }, [3] = { [0] = 117, [1] = 19 }, [4] = { [0] = 122, [1] = 24 }, [5] = { [0] = 109, [1] = 11 }, [6] = { [0] = 122, [1] = 24 }, [7] = { [0] = 114, [1] = 16 } })[R[2]][R[1]], ({ [0] = 16, [1] = 17, [2] = 16, [3] = 13, [4] = 7, [5] = 24, [6] = 21, [7] = 15 })[R[2]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  game.create_tube({ ({ [0] = { [0] = 106, [1] = 8 }, [1] = { [0] = 104, [1] = 6 }, [2] = { [0] = 108, [1] = 10 }, [3] = { [0] = 109, [1] = 11 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 113, [1] = 15 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 103, [1] = 5 } })[R[2]][R[1]], ({ [0] = 12, [1] = 18, [2] = 14, [3] = 22, [4] = 10, [5] = 13, [6] = 13, [7] = 12 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 107, [1] = 9 }, [1] = { [0] = 105, [1] = 7 }, [2] = { [0] = 109, [1] = 11 }, [3] = { [0] = 109, [1] = 11 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 113, [1] = 15 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 103, [1] = 5 } })[R[2]][R[1]], ({ [0] = 12, [1] = 18, [2] = 14, [3] = 23, [4] = 11, [5] = 14, [6] = 14, [7] = 13 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 108, [1] = 10 }, [1] = { [0] = 106, [1] = 8 }, [2] = { [0] = 110, [1] = 12 }, [3] = { [0] = 109, [1] = 11 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 113, [1] = 15 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 103, [1] = 5 } })[R[2]][R[1]], ({ [0] = 12, [1] = 18, [2] = 14, [3] = 24, [4] = 12, [5] = 15, [6] = 15, [7] = 14 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 109, [1] = 11 }, [1] = { [0] = 107, [1] = 9 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 110, [1] = 12 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 113, [1] = 15 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 103, [1] = 5 } })[R[2]][R[1]], ({ [0] = 12, [1] = 18, [2] = 11, [3] = 22, [4] = 13, [5] = 19, [6] = 16, [7] = 15 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 110, [1] = 12 }, [1] = { [0] = 108, [1] = 10 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 111, [1] = 13 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 113, [1] = 15 }, [6] = { [0] = 108, [1] = 10 }, [7] = { [0] = 103, [1] = 5 } })[R[2]][R[1]], ({ [0] = 12, [1] = 18, [2] = 12, [3] = 18, [4] = 14, [5] = 20, [6] = 17, [7] = 16 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 111, [1] = 13 }, [1] = { [0] = 109, [1] = 11 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 111, [1] = 13 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 113, [1] = 15 }, [6] = { [0] = 111, [1] = 13 }, [7] = { [0] = 103, [1] = 5 } })[R[2]][R[1]], ({ [0] = 12, [1] = 18, [2] = 13, [3] = 19, [4] = 18, [5] = 21, [6] = 11, [7] = 17 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 112, [1] = 14 }, [1] = { [0] = 110, [1] = 12 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 111, [1] = 13 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 116, [1] = 18 }, [6] = { [0] = 112, [1] = 14 }, [7] = { [0] = 103, [1] = 5 } })[R[2]][R[1]], ({ [0] = 12, [1] = 18, [2] = 14, [3] = 20, [4] = 19, [5] = 17, [6] = 11, [7] = 18 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 111, [1] = 13 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 111, [1] = 13 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 116, [1] = 18 }, [6] = { [0] = 112, [1] = 14 }, [7] = { [0] = 103, [1] = 5 } })[R[2]][R[1]], ({ [0] = 7, [1] = 7, [2] = 15, [3] = 21, [4] = 20, [5] = 23, [6] = 19, [7] = 19 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 111, [1] = 13 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 111, [1] = 13 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 117, [1] = 19 }, [6] = { [0] = 113, [1] = 15 }, [7] = { [0] = 103, [1] = 5 } })[R[2]][R[1]], ({ [0] = 8, [1] = 8, [2] = 16, [3] = 22, [4] = 21, [5] = 17, [6] = 11, [7] = 20 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 111, [1] = 13 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 112, [1] = 14 }, [4] = { [0] = 109, [1] = 11 }, [5] = { [0] = 117, [1] = 19 }, [6] = { [0] = 113, [1] = 15 }, [7] = { [0] = 106, [1] = 8 } })[R[2]][R[1]], ({ [0] = 9, [1] = 9, [2] = 17, [3] = 18, [4] = 22, [5] = 23, [6] = 19, [7] = 9 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 111, [1] = 13 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 112, [1] = 14 }, [4] = { [0] = 112, [1] = 14 }, [5] = { [0] = 118, [1] = 20 }, [6] = { [0] = 114, [1] = 16 }, [7] = { [0] = 106, [1] = 8 } })[R[2]][R[1]], ({ [0] = 10, [1] = 10, [2] = 18, [3] = 22, [4] = 8, [5] = 17, [6] = 11, [7] = 22 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 111, [1] = 13 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 113, [1] = 15 }, [4] = { [0] = 112, [1] = 14 }, [5] = { [0] = 118, [1] = 20 }, [6] = { [0] = 114, [1] = 16 }, [7] = { [0] = 107, [1] = 9 } })[R[2]][R[1]], ({ [0] = 14, [1] = 18, [2] = 19, [3] = 22, [4] = 16, [5] = 23, [6] = 19, [7] = 9 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 112, [1] = 14 }, [2] = { [0] = 111, [1] = 13 }, [3] = { [0] = 114, [1] = 16 }, [4] = { [0] = 112, [1] = 14 }, [5] = { [0] = 119, [1] = 21 }, [6] = { [0] = 115, [1] = 17 }, [7] = { [0] = 107, [1] = 9 } })[R[2]][R[1]], ({ [0] = 15, [1] = 15, [2] = 20, [3] = 22, [4] = 24, [5] = 17, [6] = 11, [7] = 22 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 112, [1] = 14 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 115, [1] = 17 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 119, [1] = 21 }, [6] = { [0] = 115, [1] = 17 }, [7] = { [0] = 108, [1] = 10 } })[R[2]][R[1]], ({ [0] = 16, [1] = 16, [2] = 14, [3] = 15, [4] = 8, [5] = 23, [6] = 19, [7] = 9 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 114, [1] = 16 }, [1] = { [0] = 112, [1] = 14 }, [2] = { [0] = 112, [1] = 14 }, [3] = { [0] = 115, [1] = 17 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 120, [1] = 22 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 108, [1] = 10 } })[R[2]][R[1]], ({ [0] = 17, [1] = 17, [2] = 20, [3] = 22, [4] = 16, [5] = 17, [6] = 13, [7] = 22 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 117, [1] = 19 }, [1] = { [0] = 112, [1] = 14 }, [2] = { [0] = 113, [1] = 15 }, [3] = { [0] = 116, [1] = 18 }, [4] = { [0] = 113, [1] = 15 }, [5] = { [0] = 120, [1] = 22 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 109, [1] = 11 } })[R[2]][R[1]], ({ [0] = 12, [1] = 18, [2] = 14, [3] = 15, [4] = 24, [5] = 23, [6] = 14, [7] = 9 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 118, [1] = 20 }, [1] = { [0] = 112, [1] = 14 }, [2] = { [0] = 113, [1] = 15 }, [3] = { [0] = 117, [1] = 19 }, [4] = { [0] = 114, [1] = 16 }, [5] = { [0] = 121, [1] = 23 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 109, [1] = 11 } })[R[2]][R[1]], ({ [0] = 12, [1] = 19, [2] = 20, [3] = 15, [4] = 8, [5] = 17, [6] = 15, [7] = 22 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 112, [1] = 14 }, [2] = { [0] = 114, [1] = 16 }, [3] = { [0] = 118, [1] = 20 }, [4] = { [0] = 114, [1] = 16 }, [5] = { [0] = 122, [1] = 24 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 110, [1] = 12 } })[R[2]][R[1]], ({ [0] = 12, [1] = 20, [2] = 14, [3] = 15, [4] = 9, [5] = 17, [6] = 16, [7] = 9 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 120, [1] = 22 }, [1] = { [0] = 112, [1] = 14 }, [2] = { [0] = 114, [1] = 16 }, [3] = { [0] = 119, [1] = 21 }, [4] = { [0] = 114, [1] = 16 }, [5] = { [0] = 123, [1] = 25 }, [6] = { [0] = 117, [1] = 19 }, [7] = { [0] = 110, [1] = 12 } })[R[2]][R[1]], ({ [0] = 12, [1] = 25, [2] = 20, [3] = 15, [4] = 16, [5] = 17, [6] = 17, [7] = 10 })[R[2]] })
  game.create_tube({ ({ [0] = { [0] = 121, [1] = 23 }, [1] = { [0] = 112, [1] = 14 }, [2] = { [0] = 115, [1] = 17 }, [3] = { [0] = 120, [1] = 22 }, [4] = { [0] = 114, [1] = 16 }, [5] = { [0] = 123, [1] = 25 }, [6] = { [0] = 121, [1] = 23 }, [7] = { [0] = 110, [1] = 12 } })[R[2]][R[1]], ({ [0] = 12, [1] = 26, [2] = 14, [3] = 15, [4] = 24, [5] = 18, [6] = 19, [7] = 11 })[R[2]] })
  if R[2] == 0 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 12 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 12 })
      for i = 1, game.initial_units() do
        R[3] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 120, [1] = 22 }, [1] = { [0] = 122, [1] = 24 }, [2] = { [0] = 109, [1] = 11 } })[R[3]][R[1]], ({ [0] = 6, [1] = 6, [2] = 17 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 112, [1] = 14 })[R[1]], 27 })
      game.create_tube({ ({ [0] = 112, [1] = 14 })[R[1]], 27 })
      game.create_tube({ ({ [0] = 112, [1] = 14 })[R[1]], 28 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 112, [1] = 14 })[R[1]], 27 })
      game.create_tube({ ({ [0] = 112, [1] = 14 })[R[1]], 27 })
      game.create_tube({ ({ [0] = 112, [1] = 14 })[R[1]], 28 })
      for i = 1, game.initial_units() do
        R[4] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 5 }, [1] = { [0] = 105, [1] = 7 }, [2] = { [0] = 107, [1] = 9 } })[R[4]][R[1]], ({ [0] = 22, [1] = 31, [2] = 16 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 106, [1] = 8 }, [1] = { [0] = 116, [1] = 18 }, [2] = { [0] = 111, [1] = 13 } })[R[5]][R[1]], ({ [0] = 8, [1] = 8, [2] = 24 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 3 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 20 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 21 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 125, [1] = 27 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 125, [1] = 27 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 125, [1] = 27 })[R[1]], 24 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 121, [1] = 23 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 20 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 21 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 125, [1] = 27 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 125, [1] = 27 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 125, [1] = 27 })[R[1]], 24 })
      for i = 1, game.initial_units() do
        R[6] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 117, [1] = 19 }, [1] = { [0] = 119, [1] = 21 }, [2] = { [0] = 106, [1] = 8 } })[R[6]][R[1]], ({ [0] = 18, [1] = 25, [2] = 22 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 17 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], 23 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 117, [1] = 19 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 17 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 119, [1] = 21 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 120, [1] = 22 })[R[1]], 23 })
      for i = 1, game.initial_units() do
        R[7] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 113, [1] = 15 }, [1] = { [0] = 106, [1] = 8 }, [2] = { [0] = 102, [1] = 4 } })[R[7]][R[1]], ({ [0] = 7, [1] = 7, [2] = 16 })[R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 5 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 20 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 20 })
      for i = 1, game.initial_units() do
        R[8] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 119, [1] = 21 }, [1] = { [0] = 124, [1] = 26 }, [2] = { [0] = 102, [1] = 4 } })[R[8]][R[1]], ({ [0] = 26, [1] = 26, [2] = 13 })[R[8]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 6 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 19 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 122, [1] = 24 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 123, [1] = 25 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 124, [1] = 26 })[R[1]], 19 })
      for i = 1, game.initial_units() do
        R[9] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 5 }, [1] = { [0] = 108, [1] = 10 }, [2] = { [0] = 131, [1] = 33 } })[R[9]][R[1]], ({ [0] = 9, [1] = 7, [2] = 20 })[R[9]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[2] == 7 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 20 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 21 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 111, [1] = 13 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 111, [1] = 13 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 112, [1] = 14 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 112, [1] = 14 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 113, [1] = 15 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 113, [1] = 15 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 11 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 17 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 19 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 20 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 21 })
      game.create_tube({ ({ [0] = 110, [1] = 12 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 111, [1] = 13 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 111, [1] = 13 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 112, [1] = 14 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 112, [1] = 14 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 113, [1] = 15 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 113, [1] = 15 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 114, [1] = 16 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 115, [1] = 17 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 116, [1] = 18 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 11 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 17 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 118, [1] = 20 })[R[1]], 19 })
      for i = 1, game.initial_units() do
        R[10] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 108, [1] = 10 }, [1] = { [0] = 114, [1] = 16 }, [2] = { [0] = 104, [1] = 6 } })[R[10]][R[1]], ({ [0] = 5, [1] = 5, [2] = 26 })[R[10]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[2]", R[2])
  end
  R[11] = game.rand(8)
  U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 3, [1] = 101 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 19, [1] = 117 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 15, [1] = 113 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 12, [1] = 110 } })[R[11]][R[1]], ({ [0] = 12, [1] = 18, [2] = 9, [3] = 22, [4] = 16, [5] = 17, [6] = 11, [7] = 16 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
  players[2]:center_view({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 3, [1] = 101 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 19, [1] = 117 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 15, [1] = 113 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 12, [1] = 110 } })[R[11]][R[1]], ({ [0] = 12, [1] = 18, [2] = 9, [3] = 22, [4] = 16, [5] = 17, [6] = 11, [7] = 16 })[R[11]] })
  U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 118 }, [1] = { [0] = 7, [1] = 105 }, [2] = { [0] = 11, [1] = 109 }, [3] = { [0] = 19, [1] = 117 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 19, [1] = 117 }, [6] = { [0] = 17, [1] = 115 }, [7] = { [0] = 9, [1] = 107 } })[R[11]][R[1]], ({ [0] = 10, [1] = 16, [2] = 12, [3] = 19, [4] = 14, [5] = 15, [6] = 14, [7] = 15 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 13, [1] = 111 }, [2] = { [0] = 7, [1] = 105 }, [3] = { [0] = 27, [1] = 125 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 15, [1] = 113 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 5, [1] = 103 } })[R[11]][R[1]], ({ [0] = 5, [1] = 5, [2] = 14, [3] = 26, [4] = 24, [5] = 23, [6] = 11, [7] = 22 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
  if R[11] == 0 or R[11] == 1 or R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 126 }, [1] = { [0] = 14, [1] = 112 }, [2] = { [0] = 10, [1] = 108 }, [5] = { [0] = 25, [1] = 123 }, [6] = { [0] = 20, [1] = 118 }, [7] = { [0] = 5, [1] = 103 } })[R[11]][R[1]], ({ [0] = 12, [1] = 12, [2] = 20, [5] = 22, [6] = 19, [7] = 9 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 19, [1] = 117 })[R[1]], 14 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 19, [1] = 117 })[R[1]], 14 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 19, [1] = 117 })[R[1]], 14 }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 123 })[R[1]], 15 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 123 })[R[1]], 15 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 25, [1] = 123 })[R[1]], 15 }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 28, [1] = 126 })[R[1]], 19 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 28, [1] = 126 })[R[1]], 19 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 28, [1] = 126 })[R[1]], 19 }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 118 })[R[1]], 9 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 118 })[R[1]], 9 }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U]:set_factory_cargo(1, "Tokamak")
        U[#U]:set_factory_cargo(2, "Nursery")
        U[#U]:set_factory_cargo(3, "University")
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 118 })[R[1]], 9 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[11]", R[11])
    end
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 5, [1] = 103 }, [1] = { [0] = 14, [1] = 112 }, [2] = { [0] = 19, [1] = 117 }, [5] = { [0] = 15, [1] = 113 }, [6] = { [0] = 11, [1] = 109 }, [7] = { [0] = 21, [1] = 119 } })[R[11]][R[1]], ({ [0] = 12, [1] = 22, [2] = 20, [5] = 10, [6] = 19, [7] = 21 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 2 or R[11] == 5 or R[11] == 6 or R[11] == 7 then
    elseif R[11] == 0 or R[11] == 1 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 13, [1] = 111 } })[R[11]][R[1]], ({ [0] = 19, [1] = 30 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
  elseif R[11] == 3 or R[11] == 4 then
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 11, [1] = 109 })[R[1]], ({ [3] = 26, [4] = 8 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    if R[11] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 22, [1] = 120 })[R[1]], 10 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 22, [1] = 120 })[R[1]], 20 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 14, [1] = 112 })[R[1]], 15 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 25, [1] = 123 })[R[1]], 15 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[11]", R[11])
    end
  else
    unseen("R[11]", R[11])
  end
  U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 4, [1] = 102 }, [2] = { [0] = 27, [1] = 125 }, [3] = { [0] = 20, [1] = 118 }, [4] = { [0] = 3, [1] = 101 }, [5] = { [0] = 5, [1] = 103 }, [6] = { [0] = 3, [1] = 101 }, [7] = { [0] = 13, [1] = 111 } })[R[11]][R[1]], ({ [0] = 19, [1] = 27, [2] = 14, [3] = 9, [4] = 12, [5] = 17, [6] = 19, [7] = 25 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 12, [1] = 110 }, [1] = { [0] = 3, [1] = 101 }, [2] = { [0] = 23, [1] = 121 }, [3] = { [0] = 9, [1] = 107 }, [4] = { [0] = 21, [1] = 119 }, [5] = { [0] = 23, [1] = 121 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 23, [1] = 121 } })[R[11]][R[1]], ({ [0] = 8, [1] = 13, [2] = 18, [3] = 16, [4] = 16, [5] = 8, [6] = 24, [7] = 16 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 10, [1] = 108 }, [1] = { [0] = 3, [1] = 101 }, [2] = { [0] = 23, [1] = 121 }, [3] = { [0] = 12, [1] = 110 }, [4] = { [0] = 23, [1] = 121 }, [5] = { [0] = 23, [1] = 121 }, [6] = { [0] = 8, [1] = 106 }, [7] = { [0] = 23, [1] = 121 } })[R[11]][R[1]], ({ [0] = 8, [1] = 11, [2] = 16, [3] = 12, [4] = 16, [5] = 10, [6] = 24, [7] = 18 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 6, [1] = 104 }, [2] = { [0] = 5, [1] = 103 }, [3] = { [0] = 29, [1] = 127 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 11, [1] = 109 }, [6] = { [0] = 23, [1] = 121 }, [7] = { [0] = 22, [1] = 120 } })[R[11]][R[1]], ({ [0] = 14, [1] = 13, [2] = 19, [3] = 16, [4] = 24, [5] = 18, [6] = 11, [7] = 10 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 6, [1] = 104 }, [2] = { [0] = 5, [1] = 103 }, [3] = { [0] = 27, [1] = 125 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 11, [1] = 109 }, [6] = { [0] = 23, [1] = 121 }, [7] = { [0] = 22, [1] = 120 } })[R[11]][R[1]], ({ [0] = 14, [1] = 13, [2] = 19, [3] = 12, [4] = 24, [5] = 18, [6] = 11, [7] = 10 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 6, [1] = 104 }, [2] = { [0] = 5, [1] = 103 }, [3] = { [0] = 15, [1] = 113 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 11, [1] = 109 }, [6] = { [0] = 23, [1] = 121 }, [7] = { [0] = 22, [1] = 120 } })[R[11]][R[1]], ({ [0] = 14, [1] = 13, [2] = 19, [3] = 27, [4] = 24, [5] = 18, [6] = 11, [7] = 10 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 6, [1] = 104 }, [2] = { [0] = 23, [1] = 121 }, [3] = { [0] = 15, [1] = 113 }, [4] = { [0] = 16, [1] = 114 }, [5] = { [0] = 10, [1] = 108 }, [6] = { [0] = 15, [1] = 113 }, [7] = { [0] = 7, [1] = 105 } })[R[11]][R[1]], ({ [0] = 8, [1] = 7, [2] = 22, [3] = 27, [4] = 20, [5] = 7, [6] = 21, [7] = 16 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 19, [1] = 117 }, [3] = { [0] = 15, [1] = 113 }, [4] = { [0] = 18, [1] = 116 }, [5] = { [0] = 19, [1] = 117 }, [6] = { [0] = 24, [1] = 122 }, [7] = { [0] = 2, [1] = 100 } })[R[11]][R[1]], ({ [0] = 5, [1] = 4, [2] = 23, [3] = 27, [4] = 11, [5] = 15, [6] = 18, [7] = 13 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
  elseif LEVEL_OF[players[2].difficulty] == 2 then
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 6, [1] = 104 }, [2] = { [0] = 23, [1] = 121 }, [3] = { [0] = 15, [1] = 113 }, [4] = { [0] = 16, [1] = 114 }, [5] = { [0] = 10, [1] = 108 }, [6] = { [0] = 15, [1] = 113 }, [7] = { [0] = 7, [1] = 105 } })[R[11]][R[1]], ({ [0] = 8, [1] = 7, [2] = 22, [3] = 27, [4] = 20, [5] = 7, [6] = 21, [7] = 16 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[11]], player = players[2], at = { ({ [0] = { [0] = 7, [1] = 105 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 19, [1] = 117 }, [3] = { [0] = 15, [1] = 113 }, [4] = { [0] = 18, [1] = 116 }, [5] = { [0] = 19, [1] = 117 }, [6] = { [0] = 24, [1] = 122 }, [7] = { [0] = 2, [1] = 100 } })[R[11]][R[1]], ({ [0] = 5, [1] = 4, [2] = 23, [3] = 27, [4] = 11, [5] = 15, [6] = 18, [7] = 13 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
  else
    unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
  end
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 126 }, [1] = { [0] = 12, [1] = 110 }, [2] = { [0] = 15, [1] = 113 }, [3] = { [0] = 19, [1] = 117 }, [4] = { [0] = 24, [1] = 122 }, [5] = { [0] = 11, [1] = 109 }, [6] = { [0] = 24, [1] = 122 }, [7] = { [0] = 16, [1] = 114 } })[R[11]][R[1]], ({ [0] = 16, [1] = 17, [2] = 16, [3] = 13, [4] = 7, [5] = 24, [6] = 21, [7] = 15 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  game.create_tube({ ({ [0] = { [0] = 8, [1] = 106 }, [1] = { [0] = 6, [1] = 104 }, [2] = { [0] = 10, [1] = 108 }, [3] = { [0] = 11, [1] = 109 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 15, [1] = 113 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 5, [1] = 103 } })[R[11]][R[1]], ({ [0] = 12, [1] = 18, [2] = 14, [3] = 22, [4] = 10, [5] = 13, [6] = 13, [7] = 12 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 9, [1] = 107 }, [1] = { [0] = 7, [1] = 105 }, [2] = { [0] = 11, [1] = 109 }, [3] = { [0] = 11, [1] = 109 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 15, [1] = 113 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 5, [1] = 103 } })[R[11]][R[1]], ({ [0] = 12, [1] = 18, [2] = 14, [3] = 23, [4] = 11, [5] = 14, [6] = 14, [7] = 13 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 10, [1] = 108 }, [1] = { [0] = 8, [1] = 106 }, [2] = { [0] = 12, [1] = 110 }, [3] = { [0] = 11, [1] = 109 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 15, [1] = 113 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 5, [1] = 103 } })[R[11]][R[1]], ({ [0] = 12, [1] = 18, [2] = 14, [3] = 24, [4] = 12, [5] = 15, [6] = 15, [7] = 14 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 11, [1] = 109 }, [1] = { [0] = 9, [1] = 107 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 12, [1] = 110 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 15, [1] = 113 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 5, [1] = 103 } })[R[11]][R[1]], ({ [0] = 12, [1] = 18, [2] = 11, [3] = 22, [4] = 13, [5] = 19, [6] = 16, [7] = 15 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 12, [1] = 110 }, [1] = { [0] = 10, [1] = 108 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 13, [1] = 111 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 15, [1] = 113 }, [6] = { [0] = 10, [1] = 108 }, [7] = { [0] = 5, [1] = 103 } })[R[11]][R[1]], ({ [0] = 12, [1] = 18, [2] = 12, [3] = 18, [4] = 14, [5] = 20, [6] = 17, [7] = 16 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 13, [1] = 111 }, [1] = { [0] = 11, [1] = 109 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 13, [1] = 111 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 15, [1] = 113 }, [6] = { [0] = 13, [1] = 111 }, [7] = { [0] = 5, [1] = 103 } })[R[11]][R[1]], ({ [0] = 12, [1] = 18, [2] = 13, [3] = 19, [4] = 18, [5] = 21, [6] = 11, [7] = 17 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 14, [1] = 112 }, [1] = { [0] = 12, [1] = 110 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 13, [1] = 111 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 18, [1] = 116 }, [6] = { [0] = 14, [1] = 112 }, [7] = { [0] = 5, [1] = 103 } })[R[11]][R[1]], ({ [0] = 12, [1] = 18, [2] = 14, [3] = 20, [4] = 19, [5] = 17, [6] = 11, [7] = 18 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 13, [1] = 111 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 13, [1] = 111 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 18, [1] = 116 }, [6] = { [0] = 14, [1] = 112 }, [7] = { [0] = 5, [1] = 103 } })[R[11]][R[1]], ({ [0] = 7, [1] = 7, [2] = 15, [3] = 21, [4] = 20, [5] = 23, [6] = 19, [7] = 19 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 13, [1] = 111 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 13, [1] = 111 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 19, [1] = 117 }, [6] = { [0] = 15, [1] = 113 }, [7] = { [0] = 5, [1] = 103 } })[R[11]][R[1]], ({ [0] = 8, [1] = 8, [2] = 16, [3] = 22, [4] = 21, [5] = 17, [6] = 11, [7] = 20 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 13, [1] = 111 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 14, [1] = 112 }, [4] = { [0] = 11, [1] = 109 }, [5] = { [0] = 19, [1] = 117 }, [6] = { [0] = 15, [1] = 113 }, [7] = { [0] = 8, [1] = 106 } })[R[11]][R[1]], ({ [0] = 9, [1] = 9, [2] = 17, [3] = 18, [4] = 22, [5] = 23, [6] = 19, [7] = 9 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 13, [1] = 111 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 14, [1] = 112 }, [4] = { [0] = 14, [1] = 112 }, [5] = { [0] = 20, [1] = 118 }, [6] = { [0] = 16, [1] = 114 }, [7] = { [0] = 8, [1] = 106 } })[R[11]][R[1]], ({ [0] = 10, [1] = 10, [2] = 18, [3] = 22, [4] = 8, [5] = 17, [6] = 11, [7] = 22 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 13, [1] = 111 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 15, [1] = 113 }, [4] = { [0] = 14, [1] = 112 }, [5] = { [0] = 20, [1] = 118 }, [6] = { [0] = 16, [1] = 114 }, [7] = { [0] = 9, [1] = 107 } })[R[11]][R[1]], ({ [0] = 14, [1] = 18, [2] = 19, [3] = 22, [4] = 16, [5] = 23, [6] = 19, [7] = 9 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 14, [1] = 112 }, [2] = { [0] = 13, [1] = 111 }, [3] = { [0] = 16, [1] = 114 }, [4] = { [0] = 14, [1] = 112 }, [5] = { [0] = 21, [1] = 119 }, [6] = { [0] = 17, [1] = 115 }, [7] = { [0] = 9, [1] = 107 } })[R[11]][R[1]], ({ [0] = 15, [1] = 15, [2] = 20, [3] = 22, [4] = 24, [5] = 17, [6] = 11, [7] = 22 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 14, [1] = 112 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 17, [1] = 115 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 21, [1] = 119 }, [6] = { [0] = 17, [1] = 115 }, [7] = { [0] = 10, [1] = 108 } })[R[11]][R[1]], ({ [0] = 16, [1] = 16, [2] = 14, [3] = 15, [4] = 8, [5] = 23, [6] = 19, [7] = 9 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 16, [1] = 114 }, [1] = { [0] = 14, [1] = 112 }, [2] = { [0] = 14, [1] = 112 }, [3] = { [0] = 17, [1] = 115 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 22, [1] = 120 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 10, [1] = 108 } })[R[11]][R[1]], ({ [0] = 17, [1] = 17, [2] = 20, [3] = 22, [4] = 16, [5] = 17, [6] = 13, [7] = 22 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 19, [1] = 117 }, [1] = { [0] = 14, [1] = 112 }, [2] = { [0] = 15, [1] = 113 }, [3] = { [0] = 18, [1] = 116 }, [4] = { [0] = 15, [1] = 113 }, [5] = { [0] = 22, [1] = 120 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 11, [1] = 109 } })[R[11]][R[1]], ({ [0] = 12, [1] = 18, [2] = 14, [3] = 15, [4] = 24, [5] = 23, [6] = 14, [7] = 9 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 20, [1] = 118 }, [1] = { [0] = 14, [1] = 112 }, [2] = { [0] = 15, [1] = 113 }, [3] = { [0] = 19, [1] = 117 }, [4] = { [0] = 16, [1] = 114 }, [5] = { [0] = 23, [1] = 121 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 11, [1] = 109 } })[R[11]][R[1]], ({ [0] = 12, [1] = 19, [2] = 20, [3] = 15, [4] = 8, [5] = 17, [6] = 15, [7] = 22 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 14, [1] = 112 }, [2] = { [0] = 16, [1] = 114 }, [3] = { [0] = 20, [1] = 118 }, [4] = { [0] = 16, [1] = 114 }, [5] = { [0] = 24, [1] = 122 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 12, [1] = 110 } })[R[11]][R[1]], ({ [0] = 12, [1] = 20, [2] = 14, [3] = 15, [4] = 9, [5] = 17, [6] = 16, [7] = 9 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 22, [1] = 120 }, [1] = { [0] = 14, [1] = 112 }, [2] = { [0] = 16, [1] = 114 }, [3] = { [0] = 21, [1] = 119 }, [4] = { [0] = 16, [1] = 114 }, [5] = { [0] = 25, [1] = 123 }, [6] = { [0] = 19, [1] = 117 }, [7] = { [0] = 12, [1] = 110 } })[R[11]][R[1]], ({ [0] = 12, [1] = 25, [2] = 20, [3] = 15, [4] = 16, [5] = 17, [6] = 17, [7] = 10 })[R[11]] })
  game.create_tube({ ({ [0] = { [0] = 23, [1] = 121 }, [1] = { [0] = 14, [1] = 112 }, [2] = { [0] = 17, [1] = 115 }, [3] = { [0] = 22, [1] = 120 }, [4] = { [0] = 16, [1] = 114 }, [5] = { [0] = 25, [1] = 123 }, [6] = { [0] = 23, [1] = 121 }, [7] = { [0] = 12, [1] = 110 } })[R[11]][R[1]], ({ [0] = 12, [1] = 26, [2] = 14, [3] = 15, [4] = 24, [5] = 18, [6] = 19, [7] = 11 })[R[11]] })
  if R[11] == 0 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 12 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 12 })
      for i = 1, game.initial_units() do
        R[12] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 120 }, [1] = { [0] = 24, [1] = 122 }, [2] = { [0] = 11, [1] = 109 } })[R[12]][R[1]], ({ [0] = 6, [1] = 6, [2] = 17 })[R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 1 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 14, [1] = 112 })[R[1]], 27 })
      game.create_tube({ ({ [0] = 14, [1] = 112 })[R[1]], 27 })
      game.create_tube({ ({ [0] = 14, [1] = 112 })[R[1]], 28 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 14, [1] = 112 })[R[1]], 27 })
      game.create_tube({ ({ [0] = 14, [1] = 112 })[R[1]], 27 })
      game.create_tube({ ({ [0] = 14, [1] = 112 })[R[1]], 28 })
      for i = 1, game.initial_units() do
        R[13] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 5, [1] = 103 }, [1] = { [0] = 7, [1] = 105 }, [2] = { [0] = 9, [1] = 107 } })[R[13]][R[1]], ({ [0] = 22, [1] = 31, [2] = 16 })[R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 2 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[14] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 8, [1] = 106 }, [1] = { [0] = 18, [1] = 116 }, [2] = { [0] = 13, [1] = 111 } })[R[14]][R[1]], ({ [0] = 8, [1] = 8, [2] = 24 })[R[14]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 3 then
    if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 20 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 21 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 27, [1] = 125 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 27, [1] = 125 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 27, [1] = 125 })[R[1]], 24 })
      for i = 1, game.initial_units() do
        R[15] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 117 }, [1] = { [0] = 21, [1] = 119 }, [2] = { [0] = 8, [1] = 106 } })[R[15]][R[1]], ({ [0] = 18, [1] = 25, [2] = 22 })[R[15]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    elseif game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 23, [1] = 121 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 20 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 21 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 27, [1] = 125 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 27, [1] = 125 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 27, [1] = 125 })[R[1]], 24 })
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 4 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 17 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], 23 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], 10 })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 19, [1] = 117 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 17 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 24 })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 21, [1] = 119 })[R[1]], 23 })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 22, [1] = 120 })[R[1]], 23 })
      for i = 1, game.initial_units() do
        R[16] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 15, [1] = 113 }, [1] = { [0] = 8, [1] = 106 }, [2] = { [0] = 4, [1] = 102 } })[R[16]][R[1]], ({ [0] = 7, [1] = 7, [2] = 16 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 5 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 20 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 20 })
      for i = 1, game.initial_units() do
        R[17] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 119 }, [1] = { [0] = 26, [1] = 124 }, [2] = { [0] = 4, [1] = 102 } })[R[17]][R[1]], ({ [0] = 26, [1] = 26, [2] = 13 })[R[17]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 6 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 19 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 24, [1] = 122 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 25, [1] = 123 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 26, [1] = 124 })[R[1]], 19 })
      for i = 1, game.initial_units() do
        R[18] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 5, [1] = 103 }, [1] = { [0] = 10, [1] = 108 }, [2] = { [0] = 33, [1] = 131 } })[R[18]][R[1]], ({ [0] = 9, [1] = 7, [2] = 20 })[R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif R[11] == 7 then
    if game.initial_units() == 0 then
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 20 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 21 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 13, [1] = 111 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 13, [1] = 111 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 14, [1] = 112 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 14, [1] = 112 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 15, [1] = 113 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 15, [1] = 113 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 11 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 17 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 19 })
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 19 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 20 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 21 })
      game.create_tube({ ({ [0] = 12, [1] = 110 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 13, [1] = 111 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 13, [1] = 111 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 14, [1] = 112 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 14, [1] = 112 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 15, [1] = 113 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 15, [1] = 113 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 16, [1] = 114 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 17, [1] = 115 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], 9 })
      game.create_tube({ ({ [0] = 18, [1] = 116 })[R[1]], 22 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 11 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 12 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 13 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 14 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 15 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 16 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 17 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 18 })
      game.create_tube({ ({ [0] = 20, [1] = 118 })[R[1]], 19 })
      for i = 1, game.initial_units() do
        R[19] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 10, [1] = 108 }, [1] = { [0] = 16, [1] = 114 }, [2] = { [0] = 6, [1] = 104 } })[R[19]][R[1]], ({ [0] = 5, [1] = 5, [2] = 26 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("R[11]", R[11])
  end
  players[1]:ally_with(players[2])
  players[2]:ally_with(players[1])
  players[1]:mark_research(3303)
  players[1].workers = 28 - 3 * LEVEL_OF[players[1].difficulty]
  players[1].scientists = 20 - 3 * LEVEL_OF[players[1].difficulty]
  players[1].kids = 18 - 2 * LEVEL_OF[players[1].difficulty]
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
  players[2].workers = 28 - 3 * LEVEL_OF[players[2].difficulty]
  players[2].scientists = 20 - 3 * LEVEL_OF[players[2].difficulty]
  players[2].kids = 18 - 2 * LEVEL_OF[players[2].difficulty]
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
  local t4 = trigger.count{type = "IonDriveModule", compare = ">=", count = 1}
  mission.victory(t4, "Launch the Ion Drive Module.")
  local t6 = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1}
  mission.victory(t6, "Launch the Fusion Drive Module.")
  local t8 = trigger.count{type = "CommandModule", compare = ">=", count = 1}
  mission.victory(t8, "Launch the Command Module.")
  local t10 = trigger.count{type = "FuelingSystems", compare = ">=", count = 1}
  mission.victory(t10, "Launch the Fueling Systems.")
  local t12 = trigger.count{type = "HabitatRing", compare = ">=", count = 1}
  mission.victory(t12, "Launch the Habitat Ring.")
  local t14 = trigger.count{type = "SensorPackage", compare = ">=", count = 1}
  mission.victory(t14, "Launch the Sensor Package.")
  local t16 = trigger.count{type = "Skydock", compare = ">=", count = 1}
  mission.victory(t16, "Launch the Skydock.")
  local t18 = trigger.count{type = "StasisSystems", compare = ">=", count = 1}
  mission.victory(t18, "Launch the Stasis Systems.")
  local t20 = trigger.count{type = "OrbitalPackage", compare = ">=", count = 1}
  mission.victory(t20, "Launch the Orbital Package.")
  local t22 = trigger.count{type = "PhoenixModule", compare = ">=", count = 1}
  mission.victory(t22, "Launch the Phoenix Module.")
  if game.disasters_enabled() then
    trigger.time{min = 18000, max = 36000, one_shot = false, on = Quake}  -- after 180 to 360 marks
    trigger.time{min = 12000, max = 18000, one_shot = false, on = Storm}  -- after 120 to 180 marks
    trigger.time{min = 2400, max = 3600, one_shot = false, on = Meteor}  -- after 24 to 36 marks
    trigger.time{min = 9600, max = 12000, one_shot = false, on = Tornado}  -- after 96 to 120 marks
    trigger.resource{resource = "Colonists", compare = ">=", amount = 80, one_shot = true, on = Lava}
  end
  return true
end
