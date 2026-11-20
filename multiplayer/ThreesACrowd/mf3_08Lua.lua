-- mf3_08Lua.lua  -  3 Player, SpaceRace, 'Three's a Crowd' map. (Lua)
--
-- Converted by op2dll from mf3_08.dll ("3 Player, SpaceRace, 'Three's a Crowd' map."): its setup replayed. `on_init` makes the original's
-- draws of the game's random numbers in its order and, from them and the lobby, the same units,
-- beacons, walls and settings in the same order, as the original's setup did in every game
-- sampled (every player count, the lobby's colonies, resource levels, vehicles, day and night,
-- morale and disasters). Anything not converted is listed at the end. Coordinates are the in-game
-- status-bar ones (map file tile + 1).

-- Where lava may flow from an eruption, as areas { x1, y1, x2, y2 }.
local LAVA_POSSIBLE = {
  { 59, 1, 64, 1 }, { 59, 2, 65, 3 }, { 59, 4, 61, 5 }, { 58, 6, 61, 6 }, { 56, 7, 60, 7 }, { 55, 8, 59, 9 },
  { 52, 10, 58, 11 }, { 53, 12, 59, 12 }, { 53, 13, 60, 14 }, { 52, 15, 62, 15 }, { 46, 16, 63, 16 }, { 46, 17, 67, 17 },
  { 45, 18, 71, 18 }, { 45, 19, 72, 19 }, { 45, 20, 73, 20 }, { 44, 21, 51, 21 }, { 58, 21, 73, 21 }, { 44, 22, 47, 23 },
  { 59, 22, 74, 22 }, { 60, 23, 75, 23 }, { 45, 24, 46, 24 }, { 60, 24, 76, 24 }, { 60, 25, 64, 25 }, { 70, 25, 76, 25 },
  { 60, 26, 63, 26 }, { 72, 26, 76, 26 }, { 60, 27, 61, 28 }, { 74, 27, 75, 27 }, { 38, 41, 38, 41 }, { 22, 42, 22, 42 },
  { 35, 42, 40, 42 }, { 18, 43, 23, 43 }, { 29, 43, 41, 43 }, { 17, 44, 41, 44 }, { 16, 45, 39, 45 }, { 16, 46, 26, 46 },
  { 30, 46, 35, 46 }, { 37, 46, 37, 46 }, { 15, 47, 24, 47 }, { 31, 47, 34, 47 }, { 11, 48, 24, 48 }, { 33, 48, 34, 49 },
  { 9, 49, 24, 49 }, { 7, 50, 13, 50 }, { 16, 50, 24, 52 }, { 32, 50, 34, 50 }, { 1, 51, 12, 52 }, { 32, 51, 33, 51 },
  { 1, 53, 9, 53 }, { 18, 53, 23, 53 }, { 1, 54, 6, 55 }, { 1, 56, 5, 56 }, { 1, 57, 3, 57 },
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
local Lava1, Lava2, Meteors, Tornados

function Lava1(t)
  game.create_eruption({ 52, 10 }, 200)
end

function Lava2(t)
  game.create_eruption({ 38, 41 }, 200)
end

function Meteors(t)
  local r1 = game.rand(127)
  local r2 = game.rand(127)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function Tornados(t)
  local r1 = game.rand(127)
  local r2 = game.rand(127)
  local r3 = game.rand(10)
  local r4 = game.rand(127)
  local r5 = game.rand(127)
  game.create_tornado({ r5 + 1, r4 + 2 }, { r2 + 1, r1 + 2 }, r3 + 10)
end

function on_init()
  local n = game.num_players()
  for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
  game.initial_set_tile({ 38, 40 }, 1140)
  game.initial_set_tile({ 38, 41 }, 1150)
  game.initial_set_tile({ 51, 9 }, 1161)
  game.initial_set_tile({ 51, 10 }, 1184)
  game.initial_set_tile({ 52, 9 }, 1172)
  game.initial_set_tile({ 52, 10 }, 1195)
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 13, 3 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 26, 73 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 86, 2 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 111, 98 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 54, 121 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 105, 42 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 59 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 81, 53 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 30 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 73 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 65, 7 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 9, 46 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 89, 62 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 51, 44 } }
  if n == 2 then
    pick(2, 2, { 0, 1 })
    R[2] = game.rand(7)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 42 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 97, [1] = 41 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 103, [1] = 35 }, [5] = { [0] = 97, [1] = 31 }, [6] = { [0] = 101, [1] = 36 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 4, [1] = 80 }, [2] = { [0] = 16, [1] = 91 }, [3] = { [0] = 11, [1] = 90 }, [4] = { [0] = 12, [1] = 85 }, [5] = { [0] = 7, [1] = 77 }, [6] = { [0] = 11, [1] = 92 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 103, [1] = 42 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 97, [1] = 41 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 103, [1] = 35 }, [5] = { [0] = 97, [1] = 31 }, [6] = { [0] = 101, [1] = 36 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 4, [1] = 80 }, [2] = { [0] = 16, [1] = 91 }, [3] = { [0] = 11, [1] = 90 }, [4] = { [0] = 12, [1] = 85 }, [5] = { [0] = 7, [1] = 77 }, [6] = { [0] = 11, [1] = 92 } })[R[2]][R[1]] })
    U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[1], at = { ({ [0] = { [0] = 107, [1] = 46 }, [1] = { [0] = 99, [1] = 34 }, [2] = { [0] = 97, [1] = 41 }, [3] = { [0] = 107, [1] = 40 }, [4] = { [0] = 107, [1] = 39 }, [5] = { [0] = 104, [1] = 38 }, [6] = { [0] = 98, [1] = 33 } })[R[2]][R[1]], ({ [0] = { [0] = 9, [1] = 88 }, [1] = { [0] = 7, [1] = 83 }, [2] = { [0] = 13, [1] = 88 }, [3] = { [0] = 9, [1] = 88 }, [4] = { [0] = 10, [1] = 83 }, [5] = { [0] = 10, [1] = 80 }, [6] = { [0] = 10, [1] = 91 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 42 }, [1] = { [0] = 95, [1] = 30 }, [2] = { [0] = 105, [1] = 49 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 103, [1] = 35 }, [5] = { [0] = 106, [1] = 40 }, [6] = { [0] = 94, [1] = 29 } })[R[2]][R[1]], ({ [0] = { [0] = 4, [1] = 83 }, [1] = { [0] = 9, [1] = 85 }, [2] = { [0] = 20, [1] = 95 }, [3] = { [0] = 19, [1] = 98 }, [4] = { [0] = 18, [1] = 91 }, [5] = { [0] = 7, [1] = 77 }, [6] = { [0] = 17, [1] = 98 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 0 or R[2] == 1 or R[2] == 4 or R[2] == 5 or R[2] == 6 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 115, [1] = 54 }, [1] = { [0] = 98, [1] = 33 }, [4] = { [0] = 113, [1] = 45 }, [5] = { [0] = 107, [1] = 41 }, [6] = { [0] = 94, [1] = 29 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 15, [1] = 91 }, [4] = { [0] = 17, [1] = 90 }, [5] = { [0] = 15, [1] = 85 }, [6] = { [0] = 4, [1] = 85 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 107, [1] = 42 })[R[1]], ({ [0] = 9, [1] = 85 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 107, [1] = 42 })[R[1]], ({ [0] = 9, [1] = 85 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 107, [1] = 42 })[R[1]], ({ [0] = 9, [1] = 85 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 113, [1] = 45 })[R[1]], ({ [0] = 10, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 113, [1] = 45 })[R[1]], ({ [0] = 10, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 113, [1] = 45 })[R[1]], ({ [0] = 10, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 115, [1] = 49 })[R[1]], ({ [0] = 15, [1] = 85 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 115, [1] = 49 })[R[1]], ({ [0] = 15, [1] = 85 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 115, [1] = 49 })[R[1]], ({ [0] = 15, [1] = 85 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 92, [1] = 31 }, [1] = { [0] = 107, [1] = 42 }, [4] = { [0] = 103, [1] = 35 }, [5] = { [0] = 98, [1] = 32 }, [6] = { [0] = 110, [1] = 45 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 15, [1] = 91 }, [4] = { [0] = 5, [1] = 78 }, [5] = { [0] = 15, [1] = 85 }, [6] = { [0] = 16, [1] = 97 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 1 or R[2] == 4 or R[2] == 5 or R[2] == 6 then
      elseif R[2] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 103, [1] = 42 })[R[1]], ({ [0] = 18, [1] = 97 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[2]", R[2])
      end
    elseif R[2] == 2 or R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [2] = { [0] = 89, [1] = 33 }, [3] = { [0] = 103, [1] = 36 } })[R[2]][R[1]], ({ [2] = { [0] = 20, [1] = 95 }, [3] = { [0] = 3, [1] = 82 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 2 then
      elseif R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 114, [1] = 47 })[R[1]], ({ [0] = 5, [1] = 84 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [2] = { [0] = 92, [1] = 36 }, [3] = { [0] = 114, [1] = 47 } })[R[2]][R[1]], ({ [2] = { [0] = 9, [1] = 84 }, [3] = { [0] = 15, [1] = 94 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 103, [1] = 47 })[R[1]], ({ [0] = 9, [1] = 84 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 103, [1] = 47 })[R[1]], ({ [0] = 9, [1] = 84 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 103, [1] = 47 })[R[1]], ({ [0] = 9, [1] = 84 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 3 then
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
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 94, [1] = 33 }, [1] = { [0] = 115, [1] = 50 }, [2] = { [0] = 98, [1] = 42 }, [3] = { [0] = 95, [1] = 28 }, [4] = { [0] = 93, [1] = 25 }, [5] = { [0] = 90, [1] = 24 }, [6] = { [0] = 102, [1] = 37 } })[R[2]][R[1]], ({ [0] = { [0] = 18, [1] = 97 }, [1] = { [0] = 9, [1] = 85 }, [2] = { [0] = 3, [1] = 78 }, [3] = { [0] = 7, [1] = 86 }, [4] = { [0] = 12, [1] = 85 }, [5] = { [0] = 15, [1] = 85 }, [6] = { [0] = 20, [1] = 101 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 99, [1] = 38 }, [1] = { [0] = 111, [1] = 46 }, [2] = { [0] = 87, [1] = 31 }, [3] = { [0] = 113, [1] = 46 }, [4] = { [0] = 111, [1] = 43 }, [5] = { [0] = 97, [1] = 31 }, [6] = { [0] = 112, [1] = 47 } })[R[2]][R[1]], ({ [0] = { [0] = 7, [1] = 86 }, [1] = { [0] = 13, [1] = 89 }, [2] = { [0] = 10, [1] = 85 }, [3] = { [0] = 11, [1] = 90 }, [4] = { [0] = 3, [1] = 76 }, [5] = { [0] = 20, [1] = 90 }, [6] = { [0] = 11, [1] = 92 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 97, [1] = 36 }, [1] = { [0] = 111, [1] = 46 }, [2] = { [0] = 90, [1] = 34 }, [3] = { [0] = 115, [1] = 48 }, [4] = { [0] = 111, [1] = 43 }, [5] = { [0] = 95, [1] = 29 }, [6] = { [0] = 112, [1] = 47 } })[R[2]][R[1]], ({ [0] = { [0] = 7, [1] = 86 }, [1] = { [0] = 11, [1] = 87 }, [2] = { [0] = 6, [1] = 81 }, [3] = { [0] = 11, [1] = 90 }, [4] = { [0] = 5, [1] = 78 }, [5] = { [0] = 20, [1] = 90 }, [6] = { [0] = 13, [1] = 94 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 108, [1] = 47 }, [1] = { [0] = 93, [1] = 28 }, [2] = { [0] = 107, [1] = 51 }, [3] = { [0] = 107, [1] = 40 }, [4] = { [0] = 99, [1] = 31 }, [5] = { [0] = 110, [1] = 44 }, [6] = { [0] = 111, [1] = 46 } })[R[2]][R[1]], ({ [0] = { [0] = 13, [1] = 92 }, [1] = { [0] = 14, [1] = 90 }, [2] = { [0] = 10, [1] = 85 }, [3] = { [0] = 19, [1] = 98 }, [4] = { [0] = 13, [1] = 86 }, [5] = { [0] = 7, [1] = 77 }, [6] = { [0] = 5, [1] = 86 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 108, [1] = 47 }, [1] = { [0] = 93, [1] = 28 }, [2] = { [0] = 105, [1] = 49 }, [3] = { [0] = 107, [1] = 40 }, [4] = { [0] = 99, [1] = 31 }, [5] = { [0] = 110, [1] = 44 }, [6] = { [0] = 111, [1] = 46 } })[R[2]][R[1]], ({ [0] = { [0] = 13, [1] = 92 }, [1] = { [0] = 14, [1] = 90 }, [2] = { [0] = 6, [1] = 81 }, [3] = { [0] = 19, [1] = 98 }, [4] = { [0] = 13, [1] = 86 }, [5] = { [0] = 7, [1] = 77 }, [6] = { [0] = 5, [1] = 86 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 108, [1] = 47 }, [1] = { [0] = 93, [1] = 28 }, [2] = { [0] = 93, [1] = 37 }, [3] = { [0] = 107, [1] = 40 }, [4] = { [0] = 99, [1] = 31 }, [5] = { [0] = 110, [1] = 44 }, [6] = { [0] = 111, [1] = 46 } })[R[2]][R[1]], ({ [0] = { [0] = 13, [1] = 92 }, [1] = { [0] = 14, [1] = 90 }, [2] = { [0] = 21, [1] = 96 }, [3] = { [0] = 19, [1] = 98 }, [4] = { [0] = 13, [1] = 86 }, [5] = { [0] = 7, [1] = 77 }, [6] = { [0] = 5, [1] = 86 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 94, [1] = 33 }, [1] = { [0] = 111, [1] = 46 }, [2] = { [0] = 93, [1] = 37 }, [3] = { [0] = 108, [1] = 41 }, [4] = { [0] = 98, [1] = 30 }, [5] = { [0] = 102, [1] = 36 }, [6] = { [0] = 96, [1] = 31 } })[R[2]][R[1]], ({ [0] = { [0] = 7, [1] = 86 }, [1] = { [0] = 17, [1] = 93 }, [2] = { [0] = 21, [1] = 96 }, [3] = { [0] = 15, [1] = 94 }, [4] = { [0] = 2, [1] = 75 }, [5] = { [0] = 17, [1] = 87 }, [6] = { [0] = 11, [1] = 92 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 94, [1] = 33 }, [1] = { [0] = 107, [1] = 42 }, [2] = { [0] = 93, [1] = 37 }, [3] = { [0] = 110, [1] = 43 }, [4] = { [0] = 107, [1] = 39 }, [5] = { [0] = 111, [1] = 45 }, [6] = { [0] = 91, [1] = 26 } })[R[2]][R[1]], ({ [0] = { [0] = 4, [1] = 83 }, [1] = { [0] = 18, [1] = 94 }, [2] = { [0] = 21, [1] = 96 }, [3] = { [0] = 6, [1] = 85 }, [4] = { [0] = 10, [1] = 83 }, [5] = { [0] = 14, [1] = 84 }, [6] = { [0] = 8, [1] = 89 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 94, [1] = 33 }, [1] = { [0] = 111, [1] = 46 }, [2] = { [0] = 93, [1] = 37 }, [3] = { [0] = 108, [1] = 41 }, [4] = { [0] = 98, [1] = 30 }, [5] = { [0] = 102, [1] = 36 }, [6] = { [0] = 96, [1] = 31 } })[R[2]][R[1]], ({ [0] = { [0] = 7, [1] = 86 }, [1] = { [0] = 17, [1] = 93 }, [2] = { [0] = 21, [1] = 96 }, [3] = { [0] = 15, [1] = 94 }, [4] = { [0] = 2, [1] = 75 }, [5] = { [0] = 17, [1] = 87 }, [6] = { [0] = 11, [1] = 92 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 94, [1] = 33 }, [1] = { [0] = 107, [1] = 42 }, [2] = { [0] = 93, [1] = 37 }, [3] = { [0] = 110, [1] = 43 }, [4] = { [0] = 107, [1] = 39 }, [5] = { [0] = 111, [1] = 45 }, [6] = { [0] = 91, [1] = 26 } })[R[2]][R[1]], ({ [0] = { [0] = 4, [1] = 83 }, [1] = { [0] = 18, [1] = 94 }, [2] = { [0] = 21, [1] = 96 }, [3] = { [0] = 6, [1] = 85 }, [4] = { [0] = 10, [1] = 83 }, [5] = { [0] = 14, [1] = 84 }, [6] = { [0] = 8, [1] = 89 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 115, [1] = 54 }, [1] = { [0] = 103, [1] = 38 }, [2] = { [0] = 97, [1] = 41 }, [3] = { [0] = 116, [1] = 49 }, [4] = { [0] = 99, [1] = 31 }, [5] = { [0] = 111, [1] = 45 }, [6] = { [0] = 105, [1] = 40 } })[R[2]][R[1]], ({ [0] = { [0] = 15, [1] = 94 }, [1] = { [0] = 11, [1] = 87 }, [2] = { [0] = 7, [1] = 82 }, [3] = { [0] = 2, [1] = 81 }, [4] = { [0] = 19, [1] = 92 }, [5] = { [0] = 17, [1] = 87 }, [6] = { [0] = 10, [1] = 91 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 95, [1] = 34 }, [1] = { [0] = 98, [1] = 33 }, [2] = { [0] = 89, [1] = 33 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 103, [1] = 35 }, [5] = { [0] = 97, [1] = 31 }, [6] = { [0] = 94, [1] = 29 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 9, [1] = 85 }, [2] = { [0] = 16, [1] = 91 }, [3] = { [0] = 5, [1] = 84 }, [4] = { [0] = 8, [1] = 81 }, [5] = { [0] = 9, [1] = 79 }, [6] = { [0] = 7, [1] = 88 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 96, [1] = 35 }, [1] = { [0] = 99, [1] = 34 }, [2] = { [0] = 89, [1] = 33 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 103, [1] = 35 }, [5] = { [0] = 97, [1] = 31 }, [6] = { [0] = 94, [1] = 29 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 9, [1] = 85 }, [2] = { [0] = 17, [1] = 92 }, [3] = { [0] = 6, [1] = 85 }, [4] = { [0] = 9, [1] = 82 }, [5] = { [0] = 10, [1] = 80 }, [6] = { [0] = 8, [1] = 89 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 97, [1] = 36 }, [1] = { [0] = 100, [1] = 35 }, [2] = { [0] = 89, [1] = 33 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 103, [1] = 35 }, [5] = { [0] = 97, [1] = 31 }, [6] = { [0] = 94, [1] = 29 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 9, [1] = 85 }, [2] = { [0] = 18, [1] = 93 }, [3] = { [0] = 7, [1] = 86 }, [4] = { [0] = 10, [1] = 83 }, [5] = { [0] = 11, [1] = 81 }, [6] = { [0] = 9, [1] = 90 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 98, [1] = 37 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 90, [1] = 34 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 103, [1] = 35 }, [5] = { [0] = 97, [1] = 31 }, [6] = { [0] = 94, [1] = 29 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 6, [1] = 82 }, [2] = { [0] = 16, [1] = 91 }, [3] = { [0] = 8, [1] = 87 }, [4] = { [0] = 14, [1] = 87 }, [5] = { [0] = 12, [1] = 82 }, [6] = { [0] = 10, [1] = 91 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 99, [1] = 38 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 91, [1] = 35 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 103, [1] = 35 }, [5] = { [0] = 97, [1] = 31 }, [6] = { [0] = 94, [1] = 29 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 7, [1] = 83 }, [2] = { [0] = 12, [1] = 87 }, [3] = { [0] = 9, [1] = 88 }, [4] = { [0] = 15, [1] = 88 }, [5] = { [0] = 13, [1] = 83 }, [6] = { [0] = 11, [1] = 92 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 100, [1] = 39 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 91, [1] = 35 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 103, [1] = 35 }, [5] = { [0] = 100, [1] = 34 }, [6] = { [0] = 94, [1] = 29 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 8, [1] = 84 }, [2] = { [0] = 13, [1] = 88 }, [3] = { [0] = 13, [1] = 92 }, [4] = { [0] = 16, [1] = 89 }, [5] = { [0] = 7, [1] = 77 }, [6] = { [0] = 12, [1] = 93 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 101, [1] = 40 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 91, [1] = 35 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 106, [1] = 38 }, [5] = { [0] = 101, [1] = 35 }, [6] = { [0] = 94, [1] = 29 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 9, [1] = 85 }, [2] = { [0] = 14, [1] = 89 }, [3] = { [0] = 14, [1] = 93 }, [4] = { [0] = 12, [1] = 85 }, [5] = { [0] = 7, [1] = 77 }, [6] = { [0] = 13, [1] = 94 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 103, [1] = 42 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 91, [1] = 35 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 106, [1] = 38 }, [5] = { [0] = 101, [1] = 35 }, [6] = { [0] = 94, [1] = 29 } })[R[2]][R[1]], ({ [0] = { [0] = 6, [1] = 85 }, [1] = { [0] = 10, [1] = 86 }, [2] = { [0] = 15, [1] = 90 }, [3] = { [0] = 15, [1] = 94 }, [4] = { [0] = 18, [1] = 91 }, [5] = { [0] = 15, [1] = 85 }, [6] = { [0] = 14, [1] = 95 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 103, [1] = 42 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 91, [1] = 35 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 107, [1] = 39 }, [5] = { [0] = 102, [1] = 36 }, [6] = { [0] = 94, [1] = 29 } })[R[2]][R[1]], ({ [0] = { [0] = 7, [1] = 86 }, [1] = { [0] = 11, [1] = 87 }, [2] = { [0] = 16, [1] = 91 }, [3] = { [0] = 16, [1] = 95 }, [4] = { [0] = 12, [1] = 85 }, [5] = { [0] = 7, [1] = 77 }, [6] = { [0] = 15, [1] = 96 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 103, [1] = 42 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 92, [1] = 36 }, [3] = { [0] = 103, [1] = 36 }, [4] = { [0] = 107, [1] = 39 }, [5] = { [0] = 102, [1] = 36 }, [6] = { [0] = 97, [1] = 32 } })[R[2]][R[1]], ({ [0] = { [0] = 8, [1] = 87 }, [1] = { [0] = 12, [1] = 88 }, [2] = { [0] = 12, [1] = 87 }, [3] = { [0] = 17, [1] = 96 }, [4] = { [0] = 18, [1] = 91 }, [5] = { [0] = 15, [1] = 85 }, [6] = { [0] = 4, [1] = 85 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 103, [1] = 42 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 92, [1] = 36 }, [3] = { [0] = 106, [1] = 39 }, [4] = { [0] = 108, [1] = 40 }, [5] = { [0] = 103, [1] = 37 }, [6] = { [0] = 97, [1] = 32 } })[R[2]][R[1]], ({ [0] = { [0] = 9, [1] = 88 }, [1] = { [0] = 13, [1] = 89 }, [2] = { [0] = 16, [1] = 91 }, [3] = { [0] = 3, [1] = 82 }, [4] = { [0] = 12, [1] = 85 }, [5] = { [0] = 7, [1] = 77 }, [6] = { [0] = 17, [1] = 98 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 103, [1] = 42 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 93, [1] = 37 }, [3] = { [0] = 106, [1] = 39 }, [4] = { [0] = 108, [1] = 40 }, [5] = { [0] = 103, [1] = 37 }, [6] = { [0] = 98, [1] = 33 } })[R[2]][R[1]], ({ [0] = { [0] = 13, [1] = 92 }, [1] = { [0] = 14, [1] = 90 }, [2] = { [0] = 16, [1] = 91 }, [3] = { [0] = 11, [1] = 90 }, [4] = { [0] = 18, [1] = 91 }, [5] = { [0] = 15, [1] = 85 }, [6] = { [0] = 4, [1] = 85 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 103, [1] = 42 }, [1] = { [0] = 101, [1] = 36 }, [2] = { [0] = 94, [1] = 38 }, [3] = { [0] = 106, [1] = 39 }, [4] = { [0] = 109, [1] = 41 }, [5] = { [0] = 104, [1] = 38 }, [6] = { [0] = 98, [1] = 33 } })[R[2]][R[1]], ({ [0] = { [0] = 14, [1] = 93 }, [1] = { [0] = 15, [1] = 91 }, [2] = { [0] = 16, [1] = 91 }, [3] = { [0] = 19, [1] = 98 }, [4] = { [0] = 12, [1] = 85 }, [5] = { [0] = 7, [1] = 77 }, [6] = { [0] = 17, [1] = 98 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 103, [1] = 42 }, [1] = { [0] = 102, [1] = 37 }, [2] = { [0] = 95, [1] = 39 }, [3] = { [0] = 107, [1] = 40 }, [4] = { [0] = 109, [1] = 41 }, [5] = { [0] = 104, [1] = 38 }, [6] = { [0] = 99, [1] = 34 } })[R[2]][R[1]], ({ [0] = { [0] = 15, [1] = 94 }, [1] = { [0] = 9, [1] = 85 }, [2] = { [0] = 9, [1] = 84 }, [3] = { [0] = 3, [1] = 82 }, [4] = { [0] = 18, [1] = 91 }, [5] = { [0] = 15, [1] = 85 }, [6] = { [0] = 4, [1] = 85 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 103, [1] = 42 }, [1] = { [0] = 102, [1] = 37 }, [2] = { [0] = 95, [1] = 39 }, [3] = { [0] = 107, [1] = 40 }, [4] = { [0] = 110, [1] = 42 }, [5] = { [0] = 106, [1] = 40 }, [6] = { [0] = 99, [1] = 34 } })[R[2]][R[1]], ({ [0] = { [0] = 16, [1] = 95 }, [1] = { [0] = 15, [1] = 91 }, [2] = { [0] = 16, [1] = 91 }, [3] = { [0] = 11, [1] = 90 }, [4] = { [0] = 12, [1] = 85 }, [5] = { [0] = 9, [1] = 79 }, [6] = { [0] = 17, [1] = 98 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 106, [1] = 45 }, [1] = { [0] = 103, [1] = 38 }, [2] = { [0] = 96, [1] = 40 }, [3] = { [0] = 107, [1] = 40 }, [4] = { [0] = 110, [1] = 42 }, [5] = { [0] = 106, [1] = 40 }, [6] = { [0] = 100, [1] = 35 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 9, [1] = 85 }, [2] = { [0] = 9, [1] = 84 }, [3] = { [0] = 19, [1] = 98 }, [4] = { [0] = 18, [1] = 91 }, [5] = { [0] = 10, [1] = 80 }, [6] = { [0] = 4, [1] = 85 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 107, [1] = 46 }, [1] = { [0] = 103, [1] = 38 }, [2] = { [0] = 97, [1] = 41 }, [3] = { [0] = 108, [1] = 41 }, [4] = { [0] = 111, [1] = 43 }, [5] = { [0] = 106, [1] = 40 }, [6] = { [0] = 100, [1] = 35 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 15, [1] = 91 }, [2] = { [0] = 9, [1] = 84 }, [3] = { [0] = 3, [1] = 82 }, [4] = { [0] = 12, [1] = 85 }, [5] = { [0] = 11, [1] = 81 }, [6] = { [0] = 17, [1] = 98 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 108, [1] = 47 }, [1] = { [0] = 104, [1] = 39 }, [2] = { [0] = 98, [1] = 42 }, [3] = { [0] = 108, [1] = 41 }, [4] = { [0] = 112, [1] = 44 }, [5] = { [0] = 106, [1] = 40 }, [6] = { [0] = 101, [1] = 36 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 9, [1] = 85 }, [2] = { [0] = 9, [1] = 84 }, [3] = { [0] = 4, [1] = 83 }, [4] = { [0] = 12, [1] = 85 }, [5] = { [0] = 12, [1] = 82 }, [6] = { [0] = 4, [1] = 85 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 109, [1] = 48 }, [1] = { [0] = 104, [1] = 39 }, [2] = { [0] = 99, [1] = 43 }, [3] = { [0] = 108, [1] = 41 }, [4] = { [0] = 113, [1] = 45 }, [5] = { [0] = 106, [1] = 40 }, [6] = { [0] = 101, [1] = 36 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 15, [1] = 91 }, [2] = { [0] = 9, [1] = 84 }, [3] = { [0] = 11, [1] = 90 }, [4] = { [0] = 12, [1] = 85 }, [5] = { [0] = 13, [1] = 83 }, [6] = { [0] = 5, [1] = 86 } })[R[2]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 110, [1] = 49 }, [1] = { [0] = 105, [1] = 40 }, [2] = { [0] = 100, [1] = 44 }, [3] = { [0] = 108, [1] = 41 }, [4] = { [0] = 113, [1] = 45 }, [5] = { [0] = 110, [1] = 44 }, [6] = { [0] = 101, [1] = 36 } })[R[2]][R[1]], ({ [0] = { [0] = 11, [1] = 90 }, [1] = { [0] = 9, [1] = 85 }, [2] = { [0] = 9, [1] = 84 }, [3] = { [0] = 19, [1] = 98 }, [4] = { [0] = 13, [1] = 86 }, [5] = { [0] = 15, [1] = 85 }, [6] = { [0] = 6, [1] = 87 } })[R[2]][R[1]] })
    if R[2] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 111, [1] = 50 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 51 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 111, [1] = 50 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 51 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
        for i = 1, game.initial_units() do
          R[3] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 109, [1] = 48 }, [1] = { [0] = 111, [1] = 50 }, [2] = { [0] = 98, [1] = 37 } })[R[3]][R[1]], ({ [0] = { [0] = 5, [1] = 84 }, [1] = { [0] = 5, [1] = 84 }, [2] = { [0] = 16, [1] = 95 } })[R[3]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 1 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[4] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 96, [1] = 31 }, [1] = { [0] = 106, [1] = 41 }, [2] = { [0] = 101, [1] = 36 } })[R[4]][R[1]], ({ [0] = { [0] = 3, [1] = 79 }, [1] = { [0] = 3, [1] = 79 }, [2] = { [0] = 19, [1] = 95 } })[R[4]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 100, [1] = 44 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 45 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 102, [1] = 46 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 103, [1] = 47 })[R[1]], ({ [0] = 12, [1] = 87 })[R[1]] })
        game.create_tube({ ({ [0] = 103, [1] = 47 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 48 })[R[1]], ({ [0] = 12, [1] = 87 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 48 })[R[1]], ({ [0] = 13, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 48 })[R[1]], ({ [0] = 14, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 48 })[R[1]], ({ [0] = 15, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 48 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 105, [1] = 49 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 105, [1] = 49 })[R[1]], ({ [0] = 17, [1] = 92 })[R[1]] })
        game.create_tube({ ({ [0] = 105, [1] = 49 })[R[1]], ({ [0] = 18, [1] = 93 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 100, [1] = 44 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 45 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 102, [1] = 46 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 103, [1] = 47 })[R[1]], ({ [0] = 12, [1] = 87 })[R[1]] })
        game.create_tube({ ({ [0] = 103, [1] = 47 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 48 })[R[1]], ({ [0] = 12, [1] = 87 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 48 })[R[1]], ({ [0] = 13, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 48 })[R[1]], ({ [0] = 14, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 48 })[R[1]], ({ [0] = 15, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 48 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 105, [1] = 49 })[R[1]], ({ [0] = 16, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 105, [1] = 49 })[R[1]], ({ [0] = 17, [1] = 92 })[R[1]] })
        game.create_tube({ ({ [0] = 105, [1] = 49 })[R[1]], ({ [0] = 18, [1] = 93 })[R[1]] })
        for i = 1, game.initial_units() do
          R[5] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 97, [1] = 41 }, [1] = { [0] = 99, [1] = 43 }, [2] = { [0] = 86, [1] = 30 } })[R[5]][R[1]], ({ [0] = { [0] = 12, [1] = 87 }, [1] = { [0] = 19, [1] = 94 }, [2] = { [0] = 16, [1] = 91 } })[R[5]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 109, [1] = 42 })[R[1]], ({ [0] = 4, [1] = 83 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 42 })[R[1]], ({ [0] = 5, [1] = 84 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 42 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 42 })[R[1]], ({ [0] = 19, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 110, [1] = 43 })[R[1]], ({ [0] = 5, [1] = 84 })[R[1]] })
        game.create_tube({ ({ [0] = 110, [1] = 43 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 110, [1] = 43 })[R[1]], ({ [0] = 19, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 111, [1] = 44 })[R[1]], ({ [0] = 5, [1] = 84 })[R[1]] })
        game.create_tube({ ({ [0] = 111, [1] = 44 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 111, [1] = 44 })[R[1]], ({ [0] = 19, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 10, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 12, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 13, [1] = 92 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 18, [1] = 97 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 19, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 113, [1] = 46 })[R[1]], ({ [0] = 10, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 113, [1] = 46 })[R[1]], ({ [0] = 18, [1] = 97 })[R[1]] })
        game.create_tube({ ({ [0] = 114, [1] = 47 })[R[1]], ({ [0] = 8, [1] = 87 })[R[1]] })
        game.create_tube({ ({ [0] = 114, [1] = 47 })[R[1]], ({ [0] = 9, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 114, [1] = 47 })[R[1]], ({ [0] = 10, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 114, [1] = 47 })[R[1]], ({ [0] = 18, [1] = 97 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 109, [1] = 42 })[R[1]], ({ [0] = 4, [1] = 83 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 42 })[R[1]], ({ [0] = 5, [1] = 84 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 42 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 42 })[R[1]], ({ [0] = 19, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 110, [1] = 43 })[R[1]], ({ [0] = 5, [1] = 84 })[R[1]] })
        game.create_tube({ ({ [0] = 110, [1] = 43 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 110, [1] = 43 })[R[1]], ({ [0] = 19, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 111, [1] = 44 })[R[1]], ({ [0] = 5, [1] = 84 })[R[1]] })
        game.create_tube({ ({ [0] = 111, [1] = 44 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 111, [1] = 44 })[R[1]], ({ [0] = 19, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 10, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 11, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 12, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 13, [1] = 92 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 18, [1] = 97 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 45 })[R[1]], ({ [0] = 19, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 113, [1] = 46 })[R[1]], ({ [0] = 10, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 113, [1] = 46 })[R[1]], ({ [0] = 18, [1] = 97 })[R[1]] })
        game.create_tube({ ({ [0] = 114, [1] = 47 })[R[1]], ({ [0] = 8, [1] = 87 })[R[1]] })
        game.create_tube({ ({ [0] = 114, [1] = 47 })[R[1]], ({ [0] = 9, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 114, [1] = 47 })[R[1]], ({ [0] = 10, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 114, [1] = 47 })[R[1]], ({ [0] = 18, [1] = 97 })[R[1]] })
        for i = 1, game.initial_units() do
          R[6] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 107, [1] = 40 }, [1] = { [0] = 100, [1] = 33 }, [2] = { [0] = 96, [1] = 29 } })[R[6]][R[1]], ({ [0] = { [0] = 2, [1] = 81 }, [1] = { [0] = 2, [1] = 81 }, [2] = { [0] = 11, [1] = 90 } })[R[6]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 113, [1] = 45 })[R[1]], ({ [0] = 14, [1] = 87 })[R[1]] })
        game.create_tube({ ({ [0] = 113, [1] = 45 })[R[1]], ({ [0] = 15, [1] = 88 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 113, [1] = 45 })[R[1]], ({ [0] = 14, [1] = 87 })[R[1]] })
        game.create_tube({ ({ [0] = 113, [1] = 45 })[R[1]], ({ [0] = 15, [1] = 88 })[R[1]] })
        for i = 1, game.initial_units() do
          R[7] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 109, [1] = 41 }, [1] = { [0] = 114, [1] = 46 }, [2] = { [0] = 92, [1] = 24 } })[R[7]][R[1]], ({ [0] = { [0] = 21, [1] = 94 }, [1] = { [0] = 21, [1] = 94 }, [2] = { [0] = 8, [1] = 81 } })[R[7]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 111, [1] = 45 })[R[1]], ({ [0] = 15, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 46 })[R[1]], ({ [0] = 15, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 113, [1] = 47 })[R[1]], ({ [0] = 15, [1] = 85 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 111, [1] = 45 })[R[1]], ({ [0] = 15, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 112, [1] = 46 })[R[1]], ({ [0] = 15, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 113, [1] = 47 })[R[1]], ({ [0] = 15, [1] = 85 })[R[1]] })
        for i = 1, game.initial_units() do
          R[8] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 92, [1] = 26 }, [1] = { [0] = 97, [1] = 31 }, [2] = { [0] = 120, [1] = 54 } })[R[8]][R[1]], ({ [0] = { [0] = 5, [1] = 75 }, [1] = { [0] = 3, [1] = 73 }, [2] = { [0] = 16, [1] = 86 } })[R[8]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 7, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 8, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 9, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 13, [1] = 94 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 14, [1] = 95 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 15, [1] = 96 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 16, [1] = 97 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 102, [1] = 37 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 102, [1] = 37 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 103, [1] = 38 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 103, [1] = 38 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 39 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 39 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 105, [1] = 40 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 105, [1] = 40 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 106, [1] = 41 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 106, [1] = 41 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 107, [1] = 42 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 107, [1] = 42 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 6, [1] = 87 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 7, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 8, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 9, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 10, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 11, [1] = 92 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 12, [1] = 93 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 13, [1] = 94 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 14, [1] = 95 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 7, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 8, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 9, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 13, [1] = 94 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 14, [1] = 95 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 15, [1] = 96 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 16, [1] = 97 })[R[1]] })
        game.create_tube({ ({ [0] = 101, [1] = 36 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 102, [1] = 37 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 102, [1] = 37 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 103, [1] = 38 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 103, [1] = 38 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 39 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 104, [1] = 39 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 105, [1] = 40 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 105, [1] = 40 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 106, [1] = 41 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 106, [1] = 41 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 107, [1] = 42 })[R[1]], ({ [0] = 4, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 107, [1] = 42 })[R[1]], ({ [0] = 17, [1] = 98 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 6, [1] = 87 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 7, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 8, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 9, [1] = 90 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 10, [1] = 91 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 11, [1] = 92 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 12, [1] = 93 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 13, [1] = 94 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 44 })[R[1]], ({ [0] = 14, [1] = 95 })[R[1]] })
        for i = 1, game.initial_units() do
          R[9] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 99, [1] = 34 }, [1] = { [0] = 105, [1] = 40 }, [2] = { [0] = 95, [1] = 30 } })[R[9]][R[1]], ({ [0] = { [0] = 0, [1] = 81 }, [1] = { [0] = 0, [1] = 81 }, [2] = { [0] = 21, [1] = 102 } })[R[9]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[2]", R[2])
    end
    R[10] = game.rand(7)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 103 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 41, [1] = 97 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 35, [1] = 103 }, [5] = { [0] = 31, [1] = 97 }, [6] = { [0] = 36, [1] = 101 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 80, [1] = 4 }, [2] = { [0] = 91, [1] = 16 }, [3] = { [0] = 90, [1] = 11 }, [4] = { [0] = 85, [1] = 12 }, [5] = { [0] = 77, [1] = 7 }, [6] = { [0] = 92, [1] = 11 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 42, [1] = 103 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 41, [1] = 97 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 35, [1] = 103 }, [5] = { [0] = 31, [1] = 97 }, [6] = { [0] = 36, [1] = 101 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 80, [1] = 4 }, [2] = { [0] = 91, [1] = 16 }, [3] = { [0] = 90, [1] = 11 }, [4] = { [0] = 85, [1] = 12 }, [5] = { [0] = 77, [1] = 7 }, [6] = { [0] = 92, [1] = 11 } })[R[10]][R[1]] })
    U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[2], at = { ({ [0] = { [0] = 46, [1] = 107 }, [1] = { [0] = 34, [1] = 99 }, [2] = { [0] = 41, [1] = 97 }, [3] = { [0] = 40, [1] = 107 }, [4] = { [0] = 39, [1] = 107 }, [5] = { [0] = 38, [1] = 104 }, [6] = { [0] = 33, [1] = 98 } })[R[10]][R[1]], ({ [0] = { [0] = 88, [1] = 9 }, [1] = { [0] = 83, [1] = 7 }, [2] = { [0] = 88, [1] = 13 }, [3] = { [0] = 88, [1] = 9 }, [4] = { [0] = 83, [1] = 10 }, [5] = { [0] = 80, [1] = 10 }, [6] = { [0] = 91, [1] = 10 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 103 }, [1] = { [0] = 30, [1] = 95 }, [2] = { [0] = 49, [1] = 105 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 35, [1] = 103 }, [5] = { [0] = 40, [1] = 106 }, [6] = { [0] = 29, [1] = 94 } })[R[10]][R[1]], ({ [0] = { [0] = 83, [1] = 4 }, [1] = { [0] = 85, [1] = 9 }, [2] = { [0] = 95, [1] = 20 }, [3] = { [0] = 98, [1] = 19 }, [4] = { [0] = 91, [1] = 18 }, [5] = { [0] = 77, [1] = 7 }, [6] = { [0] = 98, [1] = 17 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 2 or R[10] == 3 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [2] = { [0] = 33, [1] = 89 }, [3] = { [0] = 36, [1] = 103 } })[R[10]][R[1]], ({ [2] = { [0] = 95, [1] = 20 }, [3] = { [0] = 82, [1] = 3 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 47, [1] = 114 })[R[1]], ({ [0] = 84, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [2] = { [0] = 36, [1] = 92 }, [3] = { [0] = 47, [1] = 114 } })[R[10]][R[1]], ({ [2] = { [0] = 84, [1] = 9 }, [3] = { [0] = 94, [1] = 15 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 47, [1] = 103 })[R[1]], ({ [0] = 84, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 47, [1] = 103 })[R[1]], ({ [0] = 84, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 47, [1] = 103 })[R[1]], ({ [0] = 84, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 3 then
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
    elseif R[10] == 0 or R[10] == 1 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 54, [1] = 115 }, [1] = { [0] = 33, [1] = 98 }, [4] = { [0] = 45, [1] = 113 }, [5] = { [0] = 41, [1] = 107 }, [6] = { [0] = 29, [1] = 94 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 91, [1] = 15 }, [4] = { [0] = 90, [1] = 17 }, [5] = { [0] = 85, [1] = 15 }, [6] = { [0] = 85, [1] = 4 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 42, [1] = 107 })[R[1]], ({ [0] = 85, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 42, [1] = 107 })[R[1]], ({ [0] = 85, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 42, [1] = 107 })[R[1]], ({ [0] = 85, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 45, [1] = 113 })[R[1]], ({ [0] = 83, [1] = 10 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 45, [1] = 113 })[R[1]], ({ [0] = 83, [1] = 10 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 45, [1] = 113 })[R[1]], ({ [0] = 83, [1] = 10 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 49, [1] = 115 })[R[1]], ({ [0] = 85, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 49, [1] = 115 })[R[1]], ({ [0] = 85, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 49, [1] = 115 })[R[1]], ({ [0] = 85, [1] = 15 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 92 }, [1] = { [0] = 42, [1] = 107 }, [4] = { [0] = 35, [1] = 103 }, [5] = { [0] = 32, [1] = 98 }, [6] = { [0] = 45, [1] = 110 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 91, [1] = 15 }, [4] = { [0] = 78, [1] = 5 }, [5] = { [0] = 85, [1] = 15 }, [6] = { [0] = 97, [1] = 16 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
      elseif R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 42, [1] = 103 })[R[1]], ({ [0] = 97, [1] = 18 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 33, [1] = 94 }, [1] = { [0] = 50, [1] = 115 }, [2] = { [0] = 42, [1] = 98 }, [3] = { [0] = 28, [1] = 95 }, [4] = { [0] = 25, [1] = 93 }, [5] = { [0] = 24, [1] = 90 }, [6] = { [0] = 37, [1] = 102 } })[R[10]][R[1]], ({ [0] = { [0] = 97, [1] = 18 }, [1] = { [0] = 85, [1] = 9 }, [2] = { [0] = 78, [1] = 3 }, [3] = { [0] = 86, [1] = 7 }, [4] = { [0] = 85, [1] = 12 }, [5] = { [0] = 85, [1] = 15 }, [6] = { [0] = 101, [1] = 20 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 38, [1] = 99 }, [1] = { [0] = 46, [1] = 111 }, [2] = { [0] = 31, [1] = 87 }, [3] = { [0] = 46, [1] = 113 }, [4] = { [0] = 43, [1] = 111 }, [5] = { [0] = 31, [1] = 97 }, [6] = { [0] = 47, [1] = 112 } })[R[10]][R[1]], ({ [0] = { [0] = 86, [1] = 7 }, [1] = { [0] = 89, [1] = 13 }, [2] = { [0] = 85, [1] = 10 }, [3] = { [0] = 90, [1] = 11 }, [4] = { [0] = 76, [1] = 3 }, [5] = { [0] = 90, [1] = 20 }, [6] = { [0] = 92, [1] = 11 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 97 }, [1] = { [0] = 46, [1] = 111 }, [2] = { [0] = 34, [1] = 90 }, [3] = { [0] = 48, [1] = 115 }, [4] = { [0] = 43, [1] = 111 }, [5] = { [0] = 29, [1] = 95 }, [6] = { [0] = 47, [1] = 112 } })[R[10]][R[1]], ({ [0] = { [0] = 86, [1] = 7 }, [1] = { [0] = 87, [1] = 11 }, [2] = { [0] = 81, [1] = 6 }, [3] = { [0] = 90, [1] = 11 }, [4] = { [0] = 78, [1] = 5 }, [5] = { [0] = 90, [1] = 20 }, [6] = { [0] = 94, [1] = 13 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 108 }, [1] = { [0] = 28, [1] = 93 }, [2] = { [0] = 51, [1] = 107 }, [3] = { [0] = 40, [1] = 107 }, [4] = { [0] = 31, [1] = 99 }, [5] = { [0] = 44, [1] = 110 }, [6] = { [0] = 46, [1] = 111 } })[R[10]][R[1]], ({ [0] = { [0] = 92, [1] = 13 }, [1] = { [0] = 90, [1] = 14 }, [2] = { [0] = 85, [1] = 10 }, [3] = { [0] = 98, [1] = 19 }, [4] = { [0] = 86, [1] = 13 }, [5] = { [0] = 77, [1] = 7 }, [6] = { [0] = 86, [1] = 5 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 108 }, [1] = { [0] = 28, [1] = 93 }, [2] = { [0] = 49, [1] = 105 }, [3] = { [0] = 40, [1] = 107 }, [4] = { [0] = 31, [1] = 99 }, [5] = { [0] = 44, [1] = 110 }, [6] = { [0] = 46, [1] = 111 } })[R[10]][R[1]], ({ [0] = { [0] = 92, [1] = 13 }, [1] = { [0] = 90, [1] = 14 }, [2] = { [0] = 81, [1] = 6 }, [3] = { [0] = 98, [1] = 19 }, [4] = { [0] = 86, [1] = 13 }, [5] = { [0] = 77, [1] = 7 }, [6] = { [0] = 86, [1] = 5 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 47, [1] = 108 }, [1] = { [0] = 28, [1] = 93 }, [2] = { [0] = 37, [1] = 93 }, [3] = { [0] = 40, [1] = 107 }, [4] = { [0] = 31, [1] = 99 }, [5] = { [0] = 44, [1] = 110 }, [6] = { [0] = 46, [1] = 111 } })[R[10]][R[1]], ({ [0] = { [0] = 92, [1] = 13 }, [1] = { [0] = 90, [1] = 14 }, [2] = { [0] = 96, [1] = 21 }, [3] = { [0] = 98, [1] = 19 }, [4] = { [0] = 86, [1] = 13 }, [5] = { [0] = 77, [1] = 7 }, [6] = { [0] = 86, [1] = 5 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 94 }, [1] = { [0] = 46, [1] = 111 }, [2] = { [0] = 37, [1] = 93 }, [3] = { [0] = 41, [1] = 108 }, [4] = { [0] = 30, [1] = 98 }, [5] = { [0] = 36, [1] = 102 }, [6] = { [0] = 31, [1] = 96 } })[R[10]][R[1]], ({ [0] = { [0] = 86, [1] = 7 }, [1] = { [0] = 93, [1] = 17 }, [2] = { [0] = 96, [1] = 21 }, [3] = { [0] = 94, [1] = 15 }, [4] = { [0] = 75, [1] = 2 }, [5] = { [0] = 87, [1] = 17 }, [6] = { [0] = 92, [1] = 11 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 94 }, [1] = { [0] = 42, [1] = 107 }, [2] = { [0] = 37, [1] = 93 }, [3] = { [0] = 43, [1] = 110 }, [4] = { [0] = 39, [1] = 107 }, [5] = { [0] = 45, [1] = 111 }, [6] = { [0] = 26, [1] = 91 } })[R[10]][R[1]], ({ [0] = { [0] = 83, [1] = 4 }, [1] = { [0] = 94, [1] = 18 }, [2] = { [0] = 96, [1] = 21 }, [3] = { [0] = 85, [1] = 6 }, [4] = { [0] = 83, [1] = 10 }, [5] = { [0] = 84, [1] = 14 }, [6] = { [0] = 89, [1] = 8 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 94 }, [1] = { [0] = 46, [1] = 111 }, [2] = { [0] = 37, [1] = 93 }, [3] = { [0] = 41, [1] = 108 }, [4] = { [0] = 30, [1] = 98 }, [5] = { [0] = 36, [1] = 102 }, [6] = { [0] = 31, [1] = 96 } })[R[10]][R[1]], ({ [0] = { [0] = 86, [1] = 7 }, [1] = { [0] = 93, [1] = 17 }, [2] = { [0] = 96, [1] = 21 }, [3] = { [0] = 94, [1] = 15 }, [4] = { [0] = 75, [1] = 2 }, [5] = { [0] = 87, [1] = 17 }, [6] = { [0] = 92, [1] = 11 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 94 }, [1] = { [0] = 42, [1] = 107 }, [2] = { [0] = 37, [1] = 93 }, [3] = { [0] = 43, [1] = 110 }, [4] = { [0] = 39, [1] = 107 }, [5] = { [0] = 45, [1] = 111 }, [6] = { [0] = 26, [1] = 91 } })[R[10]][R[1]], ({ [0] = { [0] = 83, [1] = 4 }, [1] = { [0] = 94, [1] = 18 }, [2] = { [0] = 96, [1] = 21 }, [3] = { [0] = 85, [1] = 6 }, [4] = { [0] = 83, [1] = 10 }, [5] = { [0] = 84, [1] = 14 }, [6] = { [0] = 89, [1] = 8 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 54, [1] = 115 }, [1] = { [0] = 38, [1] = 103 }, [2] = { [0] = 41, [1] = 97 }, [3] = { [0] = 49, [1] = 116 }, [4] = { [0] = 31, [1] = 99 }, [5] = { [0] = 45, [1] = 111 }, [6] = { [0] = 40, [1] = 105 } })[R[10]][R[1]], ({ [0] = { [0] = 94, [1] = 15 }, [1] = { [0] = 87, [1] = 11 }, [2] = { [0] = 82, [1] = 7 }, [3] = { [0] = 81, [1] = 2 }, [4] = { [0] = 92, [1] = 19 }, [5] = { [0] = 87, [1] = 17 }, [6] = { [0] = 91, [1] = 10 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 95 }, [1] = { [0] = 33, [1] = 98 }, [2] = { [0] = 33, [1] = 89 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 35, [1] = 103 }, [5] = { [0] = 31, [1] = 97 }, [6] = { [0] = 29, [1] = 94 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 85, [1] = 9 }, [2] = { [0] = 91, [1] = 16 }, [3] = { [0] = 84, [1] = 5 }, [4] = { [0] = 81, [1] = 8 }, [5] = { [0] = 79, [1] = 9 }, [6] = { [0] = 88, [1] = 7 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 96 }, [1] = { [0] = 34, [1] = 99 }, [2] = { [0] = 33, [1] = 89 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 35, [1] = 103 }, [5] = { [0] = 31, [1] = 97 }, [6] = { [0] = 29, [1] = 94 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 85, [1] = 9 }, [2] = { [0] = 92, [1] = 17 }, [3] = { [0] = 85, [1] = 6 }, [4] = { [0] = 82, [1] = 9 }, [5] = { [0] = 80, [1] = 10 }, [6] = { [0] = 89, [1] = 8 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 97 }, [1] = { [0] = 35, [1] = 100 }, [2] = { [0] = 33, [1] = 89 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 35, [1] = 103 }, [5] = { [0] = 31, [1] = 97 }, [6] = { [0] = 29, [1] = 94 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 85, [1] = 9 }, [2] = { [0] = 93, [1] = 18 }, [3] = { [0] = 86, [1] = 7 }, [4] = { [0] = 83, [1] = 10 }, [5] = { [0] = 81, [1] = 11 }, [6] = { [0] = 90, [1] = 9 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 98 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 34, [1] = 90 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 35, [1] = 103 }, [5] = { [0] = 31, [1] = 97 }, [6] = { [0] = 29, [1] = 94 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 82, [1] = 6 }, [2] = { [0] = 91, [1] = 16 }, [3] = { [0] = 87, [1] = 8 }, [4] = { [0] = 87, [1] = 14 }, [5] = { [0] = 82, [1] = 12 }, [6] = { [0] = 91, [1] = 10 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 99 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 35, [1] = 91 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 35, [1] = 103 }, [5] = { [0] = 31, [1] = 97 }, [6] = { [0] = 29, [1] = 94 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 83, [1] = 7 }, [2] = { [0] = 87, [1] = 12 }, [3] = { [0] = 88, [1] = 9 }, [4] = { [0] = 88, [1] = 15 }, [5] = { [0] = 83, [1] = 13 }, [6] = { [0] = 92, [1] = 11 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 100 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 35, [1] = 91 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 35, [1] = 103 }, [5] = { [0] = 34, [1] = 100 }, [6] = { [0] = 29, [1] = 94 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 84, [1] = 8 }, [2] = { [0] = 88, [1] = 13 }, [3] = { [0] = 92, [1] = 13 }, [4] = { [0] = 89, [1] = 16 }, [5] = { [0] = 77, [1] = 7 }, [6] = { [0] = 93, [1] = 12 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 101 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 35, [1] = 91 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 38, [1] = 106 }, [5] = { [0] = 35, [1] = 101 }, [6] = { [0] = 29, [1] = 94 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 85, [1] = 9 }, [2] = { [0] = 89, [1] = 14 }, [3] = { [0] = 93, [1] = 14 }, [4] = { [0] = 85, [1] = 12 }, [5] = { [0] = 77, [1] = 7 }, [6] = { [0] = 94, [1] = 13 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 35, [1] = 91 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 38, [1] = 106 }, [5] = { [0] = 35, [1] = 101 }, [6] = { [0] = 29, [1] = 94 } })[R[10]][R[1]], ({ [0] = { [0] = 85, [1] = 6 }, [1] = { [0] = 86, [1] = 10 }, [2] = { [0] = 90, [1] = 15 }, [3] = { [0] = 94, [1] = 15 }, [4] = { [0] = 91, [1] = 18 }, [5] = { [0] = 85, [1] = 15 }, [6] = { [0] = 95, [1] = 14 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 35, [1] = 91 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 39, [1] = 107 }, [5] = { [0] = 36, [1] = 102 }, [6] = { [0] = 29, [1] = 94 } })[R[10]][R[1]], ({ [0] = { [0] = 86, [1] = 7 }, [1] = { [0] = 87, [1] = 11 }, [2] = { [0] = 91, [1] = 16 }, [3] = { [0] = 95, [1] = 16 }, [4] = { [0] = 85, [1] = 12 }, [5] = { [0] = 77, [1] = 7 }, [6] = { [0] = 96, [1] = 15 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 36, [1] = 92 }, [3] = { [0] = 36, [1] = 103 }, [4] = { [0] = 39, [1] = 107 }, [5] = { [0] = 36, [1] = 102 }, [6] = { [0] = 32, [1] = 97 } })[R[10]][R[1]], ({ [0] = { [0] = 87, [1] = 8 }, [1] = { [0] = 88, [1] = 12 }, [2] = { [0] = 87, [1] = 12 }, [3] = { [0] = 96, [1] = 17 }, [4] = { [0] = 91, [1] = 18 }, [5] = { [0] = 85, [1] = 15 }, [6] = { [0] = 85, [1] = 4 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 36, [1] = 92 }, [3] = { [0] = 39, [1] = 106 }, [4] = { [0] = 40, [1] = 108 }, [5] = { [0] = 37, [1] = 103 }, [6] = { [0] = 32, [1] = 97 } })[R[10]][R[1]], ({ [0] = { [0] = 88, [1] = 9 }, [1] = { [0] = 89, [1] = 13 }, [2] = { [0] = 91, [1] = 16 }, [3] = { [0] = 82, [1] = 3 }, [4] = { [0] = 85, [1] = 12 }, [5] = { [0] = 77, [1] = 7 }, [6] = { [0] = 98, [1] = 17 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 37, [1] = 93 }, [3] = { [0] = 39, [1] = 106 }, [4] = { [0] = 40, [1] = 108 }, [5] = { [0] = 37, [1] = 103 }, [6] = { [0] = 33, [1] = 98 } })[R[10]][R[1]], ({ [0] = { [0] = 92, [1] = 13 }, [1] = { [0] = 90, [1] = 14 }, [2] = { [0] = 91, [1] = 16 }, [3] = { [0] = 90, [1] = 11 }, [4] = { [0] = 91, [1] = 18 }, [5] = { [0] = 85, [1] = 15 }, [6] = { [0] = 85, [1] = 4 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103 }, [1] = { [0] = 36, [1] = 101 }, [2] = { [0] = 38, [1] = 94 }, [3] = { [0] = 39, [1] = 106 }, [4] = { [0] = 41, [1] = 109 }, [5] = { [0] = 38, [1] = 104 }, [6] = { [0] = 33, [1] = 98 } })[R[10]][R[1]], ({ [0] = { [0] = 93, [1] = 14 }, [1] = { [0] = 91, [1] = 15 }, [2] = { [0] = 91, [1] = 16 }, [3] = { [0] = 98, [1] = 19 }, [4] = { [0] = 85, [1] = 12 }, [5] = { [0] = 77, [1] = 7 }, [6] = { [0] = 98, [1] = 17 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103 }, [1] = { [0] = 37, [1] = 102 }, [2] = { [0] = 39, [1] = 95 }, [3] = { [0] = 40, [1] = 107 }, [4] = { [0] = 41, [1] = 109 }, [5] = { [0] = 38, [1] = 104 }, [6] = { [0] = 34, [1] = 99 } })[R[10]][R[1]], ({ [0] = { [0] = 94, [1] = 15 }, [1] = { [0] = 85, [1] = 9 }, [2] = { [0] = 84, [1] = 9 }, [3] = { [0] = 82, [1] = 3 }, [4] = { [0] = 91, [1] = 18 }, [5] = { [0] = 85, [1] = 15 }, [6] = { [0] = 85, [1] = 4 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103 }, [1] = { [0] = 37, [1] = 102 }, [2] = { [0] = 39, [1] = 95 }, [3] = { [0] = 40, [1] = 107 }, [4] = { [0] = 42, [1] = 110 }, [5] = { [0] = 40, [1] = 106 }, [6] = { [0] = 34, [1] = 99 } })[R[10]][R[1]], ({ [0] = { [0] = 95, [1] = 16 }, [1] = { [0] = 91, [1] = 15 }, [2] = { [0] = 91, [1] = 16 }, [3] = { [0] = 90, [1] = 11 }, [4] = { [0] = 85, [1] = 12 }, [5] = { [0] = 79, [1] = 9 }, [6] = { [0] = 98, [1] = 17 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 106 }, [1] = { [0] = 38, [1] = 103 }, [2] = { [0] = 40, [1] = 96 }, [3] = { [0] = 40, [1] = 107 }, [4] = { [0] = 42, [1] = 110 }, [5] = { [0] = 40, [1] = 106 }, [6] = { [0] = 35, [1] = 100 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 85, [1] = 9 }, [2] = { [0] = 84, [1] = 9 }, [3] = { [0] = 98, [1] = 19 }, [4] = { [0] = 91, [1] = 18 }, [5] = { [0] = 80, [1] = 10 }, [6] = { [0] = 85, [1] = 4 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 107 }, [1] = { [0] = 38, [1] = 103 }, [2] = { [0] = 41, [1] = 97 }, [3] = { [0] = 41, [1] = 108 }, [4] = { [0] = 43, [1] = 111 }, [5] = { [0] = 40, [1] = 106 }, [6] = { [0] = 35, [1] = 100 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 91, [1] = 15 }, [2] = { [0] = 84, [1] = 9 }, [3] = { [0] = 82, [1] = 3 }, [4] = { [0] = 85, [1] = 12 }, [5] = { [0] = 81, [1] = 11 }, [6] = { [0] = 98, [1] = 17 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 108 }, [1] = { [0] = 39, [1] = 104 }, [2] = { [0] = 42, [1] = 98 }, [3] = { [0] = 41, [1] = 108 }, [4] = { [0] = 44, [1] = 112 }, [5] = { [0] = 40, [1] = 106 }, [6] = { [0] = 36, [1] = 101 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 85, [1] = 9 }, [2] = { [0] = 84, [1] = 9 }, [3] = { [0] = 83, [1] = 4 }, [4] = { [0] = 85, [1] = 12 }, [5] = { [0] = 82, [1] = 12 }, [6] = { [0] = 85, [1] = 4 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 109 }, [1] = { [0] = 39, [1] = 104 }, [2] = { [0] = 43, [1] = 99 }, [3] = { [0] = 41, [1] = 108 }, [4] = { [0] = 45, [1] = 113 }, [5] = { [0] = 40, [1] = 106 }, [6] = { [0] = 36, [1] = 101 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 91, [1] = 15 }, [2] = { [0] = 84, [1] = 9 }, [3] = { [0] = 90, [1] = 11 }, [4] = { [0] = 85, [1] = 12 }, [5] = { [0] = 83, [1] = 13 }, [6] = { [0] = 86, [1] = 5 } })[R[10]][R[1]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 110 }, [1] = { [0] = 40, [1] = 105 }, [2] = { [0] = 44, [1] = 100 }, [3] = { [0] = 41, [1] = 108 }, [4] = { [0] = 45, [1] = 113 }, [5] = { [0] = 44, [1] = 110 }, [6] = { [0] = 36, [1] = 101 } })[R[10]][R[1]], ({ [0] = { [0] = 90, [1] = 11 }, [1] = { [0] = 85, [1] = 9 }, [2] = { [0] = 84, [1] = 9 }, [3] = { [0] = 98, [1] = 19 }, [4] = { [0] = 86, [1] = 13 }, [5] = { [0] = 85, [1] = 15 }, [6] = { [0] = 87, [1] = 6 } })[R[10]][R[1]] })
    if R[10] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 111 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 51, [1] = 112 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 111 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 51, [1] = 112 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
        for i = 1, game.initial_units() do
          R[11] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 48, [1] = 109 }, [1] = { [0] = 50, [1] = 111 }, [2] = { [0] = 37, [1] = 98 } })[R[11]][R[1]], ({ [0] = { [0] = 84, [1] = 5 }, [1] = { [0] = 84, [1] = 5 }, [2] = { [0] = 95, [1] = 16 } })[R[11]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[12] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 96 }, [1] = { [0] = 41, [1] = 106 }, [2] = { [0] = 36, [1] = 101 } })[R[12]][R[1]], ({ [0] = { [0] = 79, [1] = 3 }, [1] = { [0] = 79, [1] = 3 }, [2] = { [0] = 95, [1] = 19 } })[R[12]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 44, [1] = 100 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 101 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 46, [1] = 102 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 103 })[R[1]], ({ [0] = 87, [1] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 103 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 48, [1] = 104 })[R[1]], ({ [0] = 87, [1] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 48, [1] = 104 })[R[1]], ({ [0] = 88, [1] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 48, [1] = 104 })[R[1]], ({ [0] = 89, [1] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 48, [1] = 104 })[R[1]], ({ [0] = 90, [1] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 48, [1] = 104 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 49, [1] = 105 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 49, [1] = 105 })[R[1]], ({ [0] = 92, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 49, [1] = 105 })[R[1]], ({ [0] = 93, [1] = 18 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 44, [1] = 100 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 101 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 46, [1] = 102 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 103 })[R[1]], ({ [0] = 87, [1] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 103 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 48, [1] = 104 })[R[1]], ({ [0] = 87, [1] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 48, [1] = 104 })[R[1]], ({ [0] = 88, [1] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 48, [1] = 104 })[R[1]], ({ [0] = 89, [1] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 48, [1] = 104 })[R[1]], ({ [0] = 90, [1] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 48, [1] = 104 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 49, [1] = 105 })[R[1]], ({ [0] = 91, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 49, [1] = 105 })[R[1]], ({ [0] = 92, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 49, [1] = 105 })[R[1]], ({ [0] = 93, [1] = 18 })[R[1]] })
        for i = 1, game.initial_units() do
          R[13] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 41, [1] = 97 }, [1] = { [0] = 43, [1] = 99 }, [2] = { [0] = 30, [1] = 86 } })[R[13]][R[1]], ({ [0] = { [0] = 87, [1] = 12 }, [1] = { [0] = 94, [1] = 19 }, [2] = { [0] = 91, [1] = 16 } })[R[13]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 42, [1] = 109 })[R[1]], ({ [0] = 83, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 42, [1] = 109 })[R[1]], ({ [0] = 84, [1] = 5 })[R[1]] })
        game.create_tube({ ({ [0] = 42, [1] = 109 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 42, [1] = 109 })[R[1]], ({ [0] = 98, [1] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 43, [1] = 110 })[R[1]], ({ [0] = 84, [1] = 5 })[R[1]] })
        game.create_tube({ ({ [0] = 43, [1] = 110 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 43, [1] = 110 })[R[1]], ({ [0] = 98, [1] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 111 })[R[1]], ({ [0] = 84, [1] = 5 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 111 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 111 })[R[1]], ({ [0] = 98, [1] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 89, [1] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 91, [1] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 92, [1] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 97, [1] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 98, [1] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 46, [1] = 113 })[R[1]], ({ [0] = 89, [1] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 46, [1] = 113 })[R[1]], ({ [0] = 97, [1] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 114 })[R[1]], ({ [0] = 87, [1] = 8 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 114 })[R[1]], ({ [0] = 88, [1] = 9 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 114 })[R[1]], ({ [0] = 89, [1] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 114 })[R[1]], ({ [0] = 97, [1] = 18 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 42, [1] = 109 })[R[1]], ({ [0] = 83, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 42, [1] = 109 })[R[1]], ({ [0] = 84, [1] = 5 })[R[1]] })
        game.create_tube({ ({ [0] = 42, [1] = 109 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 42, [1] = 109 })[R[1]], ({ [0] = 98, [1] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 43, [1] = 110 })[R[1]], ({ [0] = 84, [1] = 5 })[R[1]] })
        game.create_tube({ ({ [0] = 43, [1] = 110 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 43, [1] = 110 })[R[1]], ({ [0] = 98, [1] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 111 })[R[1]], ({ [0] = 84, [1] = 5 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 111 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 111 })[R[1]], ({ [0] = 98, [1] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 89, [1] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 90, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 91, [1] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 92, [1] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 97, [1] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 112 })[R[1]], ({ [0] = 98, [1] = 19 })[R[1]] })
        game.create_tube({ ({ [0] = 46, [1] = 113 })[R[1]], ({ [0] = 89, [1] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 46, [1] = 113 })[R[1]], ({ [0] = 97, [1] = 18 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 114 })[R[1]], ({ [0] = 87, [1] = 8 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 114 })[R[1]], ({ [0] = 88, [1] = 9 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 114 })[R[1]], ({ [0] = 89, [1] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 114 })[R[1]], ({ [0] = 97, [1] = 18 })[R[1]] })
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 40, [1] = 107 }, [1] = { [0] = 33, [1] = 100 }, [2] = { [0] = 29, [1] = 96 } })[R[14]][R[1]], ({ [0] = { [0] = 81, [1] = 2 }, [1] = { [0] = 81, [1] = 2 }, [2] = { [0] = 90, [1] = 11 } })[R[14]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 45, [1] = 113 })[R[1]], ({ [0] = 87, [1] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 113 })[R[1]], ({ [0] = 88, [1] = 15 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 45, [1] = 113 })[R[1]], ({ [0] = 87, [1] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 45, [1] = 113 })[R[1]], ({ [0] = 88, [1] = 15 })[R[1]] })
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 41, [1] = 109 }, [1] = { [0] = 46, [1] = 114 }, [2] = { [0] = 24, [1] = 92 } })[R[15]][R[1]], ({ [0] = { [0] = 94, [1] = 21 }, [1] = { [0] = 94, [1] = 21 }, [2] = { [0] = 81, [1] = 8 } })[R[15]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 45, [1] = 111 })[R[1]], ({ [0] = 85, [1] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 46, [1] = 112 })[R[1]], ({ [0] = 85, [1] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 113 })[R[1]], ({ [0] = 85, [1] = 15 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 45, [1] = 111 })[R[1]], ({ [0] = 85, [1] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 46, [1] = 112 })[R[1]], ({ [0] = 85, [1] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 47, [1] = 113 })[R[1]], ({ [0] = 85, [1] = 15 })[R[1]] })
        for i = 1, game.initial_units() do
          R[16] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 92 }, [1] = { [0] = 31, [1] = 97 }, [2] = { [0] = 54, [1] = 120 } })[R[16]][R[1]], ({ [0] = { [0] = 75, [1] = 5 }, [1] = { [0] = 73, [1] = 3 }, [2] = { [0] = 86, [1] = 16 } })[R[16]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 88, [1] = 7 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 89, [1] = 8 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 90, [1] = 9 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 94, [1] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 95, [1] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 96, [1] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 97, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 37, [1] = 102 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 37, [1] = 102 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 103 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 103 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 39, [1] = 104 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 39, [1] = 104 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 40, [1] = 105 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 40, [1] = 105 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 41, [1] = 106 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 41, [1] = 106 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 42, [1] = 107 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 42, [1] = 107 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 87, [1] = 6 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 88, [1] = 7 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 89, [1] = 8 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 90, [1] = 9 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 91, [1] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 92, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 93, [1] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 94, [1] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 95, [1] = 14 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 88, [1] = 7 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 89, [1] = 8 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 90, [1] = 9 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 94, [1] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 95, [1] = 14 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 96, [1] = 15 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 97, [1] = 16 })[R[1]] })
        game.create_tube({ ({ [0] = 36, [1] = 101 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 37, [1] = 102 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 37, [1] = 102 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 103 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 103 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 39, [1] = 104 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 39, [1] = 104 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 40, [1] = 105 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 40, [1] = 105 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 41, [1] = 106 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 41, [1] = 106 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 42, [1] = 107 })[R[1]], ({ [0] = 85, [1] = 4 })[R[1]] })
        game.create_tube({ ({ [0] = 42, [1] = 107 })[R[1]], ({ [0] = 98, [1] = 17 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 87, [1] = 6 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 88, [1] = 7 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 89, [1] = 8 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 90, [1] = 9 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 91, [1] = 10 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 92, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 93, [1] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 94, [1] = 13 })[R[1]] })
        game.create_tube({ ({ [0] = 44, [1] = 109 })[R[1]], ({ [0] = 95, [1] = 14 })[R[1]] })
        for i = 1, game.initial_units() do
          R[17] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 34, [1] = 99 }, [1] = { [0] = 40, [1] = 105 }, [2] = { [0] = 30, [1] = 95 } })[R[17]][R[1]], ({ [0] = { [0] = 81, [1] = 0 }, [1] = { [0] = 81, [1] = 0 }, [2] = { [0] = 102, [1] = 21 } })[R[17]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
  elseif n == 3 then
    pick(3, 3, { 18, 19, 20 })
    R[2] = game.rand(7)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 36, [2] = 41, [3] = 36, [4] = 35, [5] = 31, [6] = 36 }, [1] = { [0] = 103, [1] = 101, [2] = 97, [3] = 103, [4] = 103, [5] = 97, [6] = 101 }, [2] = { [0] = 25, [1] = 18, [2] = 18, [3] = 17, [4] = 13, [5] = 16, [6] = 14 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 80, [2] = 91, [3] = 90, [4] = 85, [5] = 77, [6] = 92 }, [1] = { [0] = 11, [1] = 4, [2] = 16, [3] = 11, [4] = 12, [5] = 7, [6] = 11 }, [2] = { [0] = 24, [1] = 17, [2] = 25, [3] = 21, [4] = 21, [5] = 8, [6] = 23 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 42, [1] = 36, [2] = 41, [3] = 36, [4] = 35, [5] = 31, [6] = 36 }, [1] = { [0] = 103, [1] = 101, [2] = 97, [3] = 103, [4] = 103, [5] = 97, [6] = 101 }, [2] = { [0] = 25, [1] = 18, [2] = 18, [3] = 17, [4] = 13, [5] = 16, [6] = 14 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 80, [2] = 91, [3] = 90, [4] = 85, [5] = 77, [6] = 92 }, [1] = { [0] = 11, [1] = 4, [2] = 16, [3] = 11, [4] = 12, [5] = 7, [6] = 11 }, [2] = { [0] = 24, [1] = 17, [2] = 25, [3] = 21, [4] = 21, [5] = 8, [6] = 23 } })[R[18]][R[2]] })
    U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[1], at = { ({ [0] = { [0] = 46, [1] = 34, [2] = 41, [3] = 40, [4] = 39, [5] = 38, [6] = 33 }, [1] = { [0] = 107, [1] = 99, [2] = 97, [3] = 107, [4] = 107, [5] = 104, [6] = 98 }, [2] = { [0] = 29, [1] = 16, [2] = 18, [3] = 21, [4] = 17, [5] = 23, [6] = 11 } })[R[18]][R[2]], ({ [0] = { [0] = 88, [1] = 83, [2] = 88, [3] = 88, [4] = 83, [5] = 80, [6] = 91 }, [1] = { [0] = 9, [1] = 7, [2] = 13, [3] = 9, [4] = 10, [5] = 10, [6] = 10 }, [2] = { [0] = 22, [1] = 20, [2] = 22, [3] = 19, [4] = 19, [5] = 11, [6] = 22 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 30, [2] = 49, [3] = 36, [4] = 35, [5] = 40, [6] = 29 }, [1] = { [0] = 103, [1] = 95, [2] = 105, [3] = 103, [4] = 103, [5] = 106, [6] = 94 }, [2] = { [0] = 25, [1] = 12, [2] = 26, [3] = 17, [4] = 13, [5] = 25, [6] = 7 } })[R[18]][R[2]], ({ [0] = { [0] = 83, [1] = 85, [2] = 95, [3] = 98, [4] = 91, [5] = 77, [6] = 98 }, [1] = { [0] = 4, [1] = 9, [2] = 20, [3] = 19, [4] = 18, [5] = 7, [6] = 17 }, [2] = { [0] = 17, [1] = 22, [2] = 29, [3] = 29, [4] = 27, [5] = 8, [6] = 29 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    if R[2] == 0 or R[2] == 1 or R[2] == 4 or R[2] == 5 or R[2] == 6 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 54, [1] = 33, [4] = 45, [5] = 41, [6] = 29 }, [1] = { [0] = 115, [1] = 98, [4] = 113, [5] = 107, [6] = 94 }, [2] = { [0] = 37, [1] = 15, [4] = 23, [5] = 26, [6] = 7 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 91, [4] = 90, [5] = 85, [6] = 85 }, [1] = { [0] = 11, [1] = 15, [4] = 17, [5] = 15, [6] = 4 }, [2] = { [0] = 24, [1] = 28, [4] = 26, [5] = 16, [6] = 16 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 42, [1] = 107, [2] = 24 })[R[18]], ({ [0] = 85, [1] = 9, [2] = 22 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 42, [1] = 107, [2] = 24 })[R[18]], ({ [0] = 85, [1] = 9, [2] = 22 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 42, [1] = 107, [2] = 24 })[R[18]], ({ [0] = 85, [1] = 9, [2] = 22 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 45, [1] = 113, [2] = 23 })[R[18]], ({ [0] = 83, [1] = 10, [2] = 19 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 45, [1] = 113, [2] = 23 })[R[18]], ({ [0] = 83, [1] = 10, [2] = 19 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 45, [1] = 113, [2] = 23 })[R[18]], ({ [0] = 83, [1] = 10, [2] = 19 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 49, [1] = 115, [2] = 34 })[R[18]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 49, [1] = 115, [2] = 34 })[R[18]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 49, [1] = 115, [2] = 34 })[R[18]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 31, [1] = 42, [4] = 35, [5] = 32, [6] = 45 }, [1] = { [0] = 92, [1] = 107, [4] = 103, [5] = 98, [6] = 110 }, [2] = { [0] = 14, [1] = 24, [4] = 13, [5] = 17, [6] = 23 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 91, [4] = 78, [5] = 85, [6] = 97 }, [1] = { [0] = 11, [1] = 15, [4] = 5, [5] = 15, [6] = 16 }, [2] = { [0] = 24, [1] = 28, [4] = 14, [5] = 16, [6] = 28 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 1 or R[2] == 4 or R[2] == 5 or R[2] == 6 then
      elseif R[2] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 42, [1] = 103, [2] = 25 })[R[18]], ({ [0] = 97, [1] = 18, [2] = 31 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[2]", R[2])
      end
    elseif R[2] == 2 or R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [2] = 33, [3] = 36 }, [1] = { [2] = 89, [3] = 103 }, [2] = { [2] = 10, [3] = 17 } })[R[18]][R[2]], ({ [0] = { [2] = 95, [3] = 82 }, [1] = { [2] = 20, [3] = 3 }, [2] = { [2] = 29, [3] = 13 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 47, [1] = 114, [2] = 28 })[R[18]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 2 then
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [2] = 36, [3] = 47 }, [1] = { [2] = 92, [3] = 114 }, [2] = { [2] = 13, [3] = 28 } })[R[18]][R[2]], ({ [0] = { [2] = 84, [3] = 94 }, [1] = { [2] = 9, [3] = 15 }, [2] = { [2] = 18, [3] = 25 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 47, [1] = 103, [2] = 24 })[R[18]], ({ [0] = 84, [1] = 9, [2] = 18 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 47, [1] = 103, [2] = 24 })[R[18]], ({ [0] = 84, [1] = 9, [2] = 18 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 47, [1] = 103, [2] = 24 })[R[18]], ({ [0] = 84, [1] = 9, [2] = 18 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 3 then
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
    else
      unseen("R[2]", R[2])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 33, [1] = 50, [2] = 42, [3] = 28, [4] = 25, [5] = 24, [6] = 37 }, [1] = { [0] = 94, [1] = 115, [2] = 98, [3] = 95, [4] = 93, [5] = 90, [6] = 102 }, [2] = { [0] = 16, [1] = 32, [2] = 19, [3] = 9, [4] = 3, [5] = 9, [6] = 15 } })[R[18]][R[2]], ({ [0] = { [0] = 97, [1] = 85, [2] = 78, [3] = 86, [4] = 85, [5] = 85, [6] = 101 }, [1] = { [0] = 18, [1] = 9, [2] = 3, [3] = 7, [4] = 12, [5] = 15, [6] = 20 }, [2] = { [0] = 31, [1] = 22, [2] = 12, [3] = 17, [4] = 21, [5] = 16, [6] = 32 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 46, [2] = 31, [3] = 46, [4] = 43, [5] = 31, [6] = 47 }, [1] = { [0] = 99, [1] = 111, [2] = 87, [3] = 113, [4] = 111, [5] = 97, [6] = 112 }, [2] = { [0] = 21, [1] = 28, [2] = 8, [3] = 27, [4] = 21, [5] = 16, [6] = 25 } })[R[18]][R[2]], ({ [0] = { [0] = 86, [1] = 89, [2] = 85, [3] = 90, [4] = 76, [5] = 90, [6] = 92 }, [1] = { [0] = 7, [1] = 13, [2] = 10, [3] = 11, [4] = 3, [5] = 20, [6] = 11 }, [2] = { [0] = 20, [1] = 26, [2] = 19, [3] = 21, [4] = 12, [5] = 21, [6] = 23 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 46, [2] = 34, [3] = 48, [4] = 43, [5] = 29, [6] = 47 }, [1] = { [0] = 97, [1] = 111, [2] = 90, [3] = 115, [4] = 111, [5] = 95, [6] = 112 }, [2] = { [0] = 19, [1] = 28, [2] = 11, [3] = 29, [4] = 21, [5] = 14, [6] = 25 } })[R[18]][R[2]], ({ [0] = { [0] = 86, [1] = 87, [2] = 81, [3] = 90, [4] = 78, [5] = 90, [6] = 94 }, [1] = { [0] = 7, [1] = 11, [2] = 6, [3] = 11, [4] = 5, [5] = 20, [6] = 13 }, [2] = { [0] = 20, [1] = 24, [2] = 15, [3] = 21, [4] = 14, [5] = 21, [6] = 25 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 47, [1] = 28, [2] = 51, [3] = 40, [4] = 31, [5] = 44, [6] = 46 }, [1] = { [0] = 108, [1] = 93, [2] = 107, [3] = 107, [4] = 99, [5] = 110, [6] = 111 }, [2] = { [0] = 30, [1] = 10, [2] = 28, [3] = 21, [4] = 9, [5] = 29, [6] = 24 } })[R[18]][R[2]], ({ [0] = { [0] = 92, [1] = 90, [2] = 85, [3] = 98, [4] = 86, [5] = 77, [6] = 86 }, [1] = { [0] = 13, [1] = 14, [2] = 10, [3] = 19, [4] = 13, [5] = 7, [6] = 5 }, [2] = { [0] = 26, [1] = 27, [2] = 19, [3] = 29, [4] = 22, [5] = 8, [6] = 17 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 47, [1] = 28, [2] = 49, [3] = 40, [4] = 31, [5] = 44, [6] = 46 }, [1] = { [0] = 108, [1] = 93, [2] = 105, [3] = 107, [4] = 99, [5] = 110, [6] = 111 }, [2] = { [0] = 30, [1] = 10, [2] = 26, [3] = 21, [4] = 9, [5] = 29, [6] = 24 } })[R[18]][R[2]], ({ [0] = { [0] = 92, [1] = 90, [2] = 81, [3] = 98, [4] = 86, [5] = 77, [6] = 86 }, [1] = { [0] = 13, [1] = 14, [2] = 6, [3] = 19, [4] = 13, [5] = 7, [6] = 5 }, [2] = { [0] = 26, [1] = 27, [2] = 15, [3] = 29, [4] = 22, [5] = 8, [6] = 17 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 47, [1] = 28, [2] = 37, [3] = 40, [4] = 31, [5] = 44, [6] = 46 }, [1] = { [0] = 108, [1] = 93, [2] = 93, [3] = 107, [4] = 99, [5] = 110, [6] = 111 }, [2] = { [0] = 30, [1] = 10, [2] = 14, [3] = 21, [4] = 9, [5] = 29, [6] = 24 } })[R[18]][R[2]], ({ [0] = { [0] = 92, [1] = 90, [2] = 96, [3] = 98, [4] = 86, [5] = 77, [6] = 86 }, [1] = { [0] = 13, [1] = 14, [2] = 21, [3] = 19, [4] = 13, [5] = 7, [6] = 5 }, [2] = { [0] = 26, [1] = 27, [2] = 30, [3] = 29, [4] = 22, [5] = 8, [6] = 17 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 33, [1] = 46, [2] = 37, [3] = 41, [4] = 30, [5] = 36, [6] = 31 }, [1] = { [0] = 94, [1] = 111, [2] = 93, [3] = 108, [4] = 98, [5] = 102, [6] = 96 }, [2] = { [0] = 16, [1] = 28, [2] = 14, [3] = 22, [4] = 8, [5] = 21, [6] = 9 } })[R[18]][R[2]], ({ [0] = { [0] = 86, [1] = 93, [2] = 96, [3] = 94, [4] = 75, [5] = 87, [6] = 92 }, [1] = { [0] = 7, [1] = 17, [2] = 21, [3] = 15, [4] = 2, [5] = 17, [6] = 11 }, [2] = { [0] = 20, [1] = 30, [2] = 30, [3] = 25, [4] = 11, [5] = 18, [6] = 23 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 33, [1] = 42, [2] = 37, [3] = 43, [4] = 39, [5] = 45, [6] = 26 }, [1] = { [0] = 94, [1] = 107, [2] = 93, [3] = 110, [4] = 107, [5] = 111, [6] = 91 }, [2] = { [0] = 16, [1] = 24, [2] = 14, [3] = 24, [4] = 17, [5] = 30, [6] = 4 } })[R[18]][R[2]], ({ [0] = { [0] = 83, [1] = 94, [2] = 96, [3] = 85, [4] = 83, [5] = 84, [6] = 89 }, [1] = { [0] = 4, [1] = 18, [2] = 21, [3] = 6, [4] = 10, [5] = 14, [6] = 8 }, [2] = { [0] = 17, [1] = 31, [2] = 30, [3] = 16, [4] = 19, [5] = 15, [6] = 20 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 33, [1] = 46, [2] = 37, [3] = 41, [4] = 30, [5] = 36, [6] = 31 }, [1] = { [0] = 94, [1] = 111, [2] = 93, [3] = 108, [4] = 98, [5] = 102, [6] = 96 }, [2] = { [0] = 16, [1] = 28, [2] = 14, [3] = 22, [4] = 8, [5] = 21, [6] = 9 } })[R[18]][R[2]], ({ [0] = { [0] = 86, [1] = 93, [2] = 96, [3] = 94, [4] = 75, [5] = 87, [6] = 92 }, [1] = { [0] = 7, [1] = 17, [2] = 21, [3] = 15, [4] = 2, [5] = 17, [6] = 11 }, [2] = { [0] = 20, [1] = 30, [2] = 30, [3] = 25, [4] = 11, [5] = 18, [6] = 23 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 33, [1] = 42, [2] = 37, [3] = 43, [4] = 39, [5] = 45, [6] = 26 }, [1] = { [0] = 94, [1] = 107, [2] = 93, [3] = 110, [4] = 107, [5] = 111, [6] = 91 }, [2] = { [0] = 16, [1] = 24, [2] = 14, [3] = 24, [4] = 17, [5] = 30, [6] = 4 } })[R[18]][R[2]], ({ [0] = { [0] = 83, [1] = 94, [2] = 96, [3] = 85, [4] = 83, [5] = 84, [6] = 89 }, [1] = { [0] = 4, [1] = 18, [2] = 21, [3] = 6, [4] = 10, [5] = 14, [6] = 8 }, [2] = { [0] = 17, [1] = 31, [2] = 30, [3] = 16, [4] = 19, [5] = 15, [6] = 20 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 54, [1] = 38, [2] = 41, [3] = 49, [4] = 31, [5] = 45, [6] = 40 }, [1] = { [0] = 115, [1] = 103, [2] = 97, [3] = 116, [4] = 99, [5] = 111, [6] = 105 }, [2] = { [0] = 37, [1] = 20, [2] = 18, [3] = 30, [4] = 9, [5] = 30, [6] = 18 } })[R[18]][R[2]], ({ [0] = { [0] = 94, [1] = 87, [2] = 82, [3] = 81, [4] = 92, [5] = 87, [6] = 91 }, [1] = { [0] = 15, [1] = 11, [2] = 7, [3] = 2, [4] = 19, [5] = 17, [6] = 10 }, [2] = { [0] = 28, [1] = 24, [2] = 16, [3] = 12, [4] = 28, [5] = 18, [6] = 22 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 33, [2] = 33, [3] = 36, [4] = 35, [5] = 31, [6] = 29 }, [1] = { [0] = 95, [1] = 98, [2] = 89, [3] = 103, [4] = 103, [5] = 97, [6] = 94 }, [2] = { [0] = 17, [1] = 15, [2] = 10, [3] = 17, [4] = 13, [5] = 16, [6] = 7 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 85, [2] = 91, [3] = 84, [4] = 81, [5] = 79, [6] = 88 }, [1] = { [0] = 11, [1] = 9, [2] = 16, [3] = 5, [4] = 8, [5] = 9, [6] = 7 }, [2] = { [0] = 24, [1] = 22, [2] = 25, [3] = 15, [4] = 17, [5] = 10, [6] = 19 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 34, [2] = 33, [3] = 36, [4] = 35, [5] = 31, [6] = 29 }, [1] = { [0] = 96, [1] = 99, [2] = 89, [3] = 103, [4] = 103, [5] = 97, [6] = 94 }, [2] = { [0] = 18, [1] = 16, [2] = 10, [3] = 17, [4] = 13, [5] = 16, [6] = 7 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 85, [2] = 92, [3] = 85, [4] = 82, [5] = 80, [6] = 89 }, [1] = { [0] = 11, [1] = 9, [2] = 17, [3] = 6, [4] = 9, [5] = 10, [6] = 8 }, [2] = { [0] = 24, [1] = 22, [2] = 26, [3] = 16, [4] = 18, [5] = 11, [6] = 20 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 35, [2] = 33, [3] = 36, [4] = 35, [5] = 31, [6] = 29 }, [1] = { [0] = 97, [1] = 100, [2] = 89, [3] = 103, [4] = 103, [5] = 97, [6] = 94 }, [2] = { [0] = 19, [1] = 17, [2] = 10, [3] = 17, [4] = 13, [5] = 16, [6] = 7 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 85, [2] = 93, [3] = 86, [4] = 83, [5] = 81, [6] = 90 }, [1] = { [0] = 11, [1] = 9, [2] = 18, [3] = 7, [4] = 10, [5] = 11, [6] = 9 }, [2] = { [0] = 24, [1] = 22, [2] = 27, [3] = 17, [4] = 19, [5] = 12, [6] = 21 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 36, [2] = 34, [3] = 36, [4] = 35, [5] = 31, [6] = 29 }, [1] = { [0] = 98, [1] = 101, [2] = 90, [3] = 103, [4] = 103, [5] = 97, [6] = 94 }, [2] = { [0] = 20, [1] = 18, [2] = 11, [3] = 17, [4] = 13, [5] = 16, [6] = 7 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 82, [2] = 91, [3] = 87, [4] = 87, [5] = 82, [6] = 91 }, [1] = { [0] = 11, [1] = 6, [2] = 16, [3] = 8, [4] = 14, [5] = 12, [6] = 10 }, [2] = { [0] = 24, [1] = 19, [2] = 25, [3] = 18, [4] = 23, [5] = 13, [6] = 22 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 36, [2] = 35, [3] = 36, [4] = 35, [5] = 31, [6] = 29 }, [1] = { [0] = 99, [1] = 101, [2] = 91, [3] = 103, [4] = 103, [5] = 97, [6] = 94 }, [2] = { [0] = 21, [1] = 18, [2] = 12, [3] = 17, [4] = 13, [5] = 16, [6] = 7 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 83, [2] = 87, [3] = 88, [4] = 88, [5] = 83, [6] = 92 }, [1] = { [0] = 11, [1] = 7, [2] = 12, [3] = 9, [4] = 15, [5] = 13, [6] = 11 }, [2] = { [0] = 24, [1] = 20, [2] = 21, [3] = 19, [4] = 24, [5] = 14, [6] = 23 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 36, [2] = 35, [3] = 36, [4] = 35, [5] = 34, [6] = 29 }, [1] = { [0] = 100, [1] = 101, [2] = 91, [3] = 103, [4] = 103, [5] = 100, [6] = 94 }, [2] = { [0] = 22, [1] = 18, [2] = 12, [3] = 17, [4] = 13, [5] = 19, [6] = 7 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 84, [2] = 88, [3] = 92, [4] = 89, [5] = 77, [6] = 93 }, [1] = { [0] = 11, [1] = 8, [2] = 13, [3] = 13, [4] = 16, [5] = 7, [6] = 12 }, [2] = { [0] = 24, [1] = 21, [2] = 22, [3] = 23, [4] = 25, [5] = 8, [6] = 24 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 36, [2] = 35, [3] = 36, [4] = 38, [5] = 35, [6] = 29 }, [1] = { [0] = 101, [1] = 101, [2] = 91, [3] = 103, [4] = 106, [5] = 101, [6] = 94 }, [2] = { [0] = 23, [1] = 18, [2] = 12, [3] = 17, [4] = 16, [5] = 20, [6] = 7 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 85, [2] = 89, [3] = 93, [4] = 85, [5] = 77, [6] = 94 }, [1] = { [0] = 11, [1] = 9, [2] = 14, [3] = 14, [4] = 12, [5] = 7, [6] = 13 }, [2] = { [0] = 24, [1] = 22, [2] = 23, [3] = 24, [4] = 21, [5] = 8, [6] = 25 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 35, [3] = 36, [4] = 38, [5] = 35, [6] = 29 }, [1] = { [0] = 103, [1] = 101, [2] = 91, [3] = 103, [4] = 106, [5] = 101, [6] = 94 }, [2] = { [0] = 25, [1] = 18, [2] = 12, [3] = 17, [4] = 16, [5] = 20, [6] = 7 } })[R[18]][R[2]], ({ [0] = { [0] = 85, [1] = 86, [2] = 90, [3] = 94, [4] = 91, [5] = 85, [6] = 95 }, [1] = { [0] = 6, [1] = 10, [2] = 15, [3] = 15, [4] = 18, [5] = 15, [6] = 14 }, [2] = { [0] = 19, [1] = 23, [2] = 24, [3] = 25, [4] = 27, [5] = 16, [6] = 26 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 35, [3] = 36, [4] = 39, [5] = 36, [6] = 29 }, [1] = { [0] = 103, [1] = 101, [2] = 91, [3] = 103, [4] = 107, [5] = 102, [6] = 94 }, [2] = { [0] = 25, [1] = 18, [2] = 12, [3] = 17, [4] = 17, [5] = 21, [6] = 7 } })[R[18]][R[2]], ({ [0] = { [0] = 86, [1] = 87, [2] = 91, [3] = 95, [4] = 85, [5] = 77, [6] = 96 }, [1] = { [0] = 7, [1] = 11, [2] = 16, [3] = 16, [4] = 12, [5] = 7, [6] = 15 }, [2] = { [0] = 20, [1] = 24, [2] = 25, [3] = 26, [4] = 21, [5] = 8, [6] = 27 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 36, [3] = 36, [4] = 39, [5] = 36, [6] = 32 }, [1] = { [0] = 103, [1] = 101, [2] = 92, [3] = 103, [4] = 107, [5] = 102, [6] = 97 }, [2] = { [0] = 25, [1] = 18, [2] = 13, [3] = 17, [4] = 17, [5] = 21, [6] = 10 } })[R[18]][R[2]], ({ [0] = { [0] = 87, [1] = 88, [2] = 87, [3] = 96, [4] = 91, [5] = 85, [6] = 85 }, [1] = { [0] = 8, [1] = 12, [2] = 12, [3] = 17, [4] = 18, [5] = 15, [6] = 4 }, [2] = { [0] = 21, [1] = 25, [2] = 21, [3] = 27, [4] = 27, [5] = 16, [6] = 16 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 36, [3] = 39, [4] = 40, [5] = 37, [6] = 32 }, [1] = { [0] = 103, [1] = 101, [2] = 92, [3] = 106, [4] = 108, [5] = 103, [6] = 97 }, [2] = { [0] = 25, [1] = 18, [2] = 13, [3] = 20, [4] = 18, [5] = 22, [6] = 10 } })[R[18]][R[2]], ({ [0] = { [0] = 88, [1] = 89, [2] = 91, [3] = 82, [4] = 85, [5] = 77, [6] = 98 }, [1] = { [0] = 9, [1] = 13, [2] = 16, [3] = 3, [4] = 12, [5] = 7, [6] = 17 }, [2] = { [0] = 22, [1] = 26, [2] = 25, [3] = 13, [4] = 21, [5] = 8, [6] = 29 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 37, [3] = 39, [4] = 40, [5] = 37, [6] = 33 }, [1] = { [0] = 103, [1] = 101, [2] = 93, [3] = 106, [4] = 108, [5] = 103, [6] = 98 }, [2] = { [0] = 25, [1] = 18, [2] = 14, [3] = 20, [4] = 18, [5] = 22, [6] = 11 } })[R[18]][R[2]], ({ [0] = { [0] = 92, [1] = 90, [2] = 91, [3] = 90, [4] = 91, [5] = 85, [6] = 85 }, [1] = { [0] = 13, [1] = 14, [2] = 16, [3] = 11, [4] = 18, [5] = 15, [6] = 4 }, [2] = { [0] = 26, [1] = 27, [2] = 25, [3] = 21, [4] = 27, [5] = 16, [6] = 16 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 38, [3] = 39, [4] = 41, [5] = 38, [6] = 33 }, [1] = { [0] = 103, [1] = 101, [2] = 94, [3] = 106, [4] = 109, [5] = 104, [6] = 98 }, [2] = { [0] = 25, [1] = 18, [2] = 15, [3] = 20, [4] = 19, [5] = 23, [6] = 11 } })[R[18]][R[2]], ({ [0] = { [0] = 93, [1] = 91, [2] = 91, [3] = 98, [4] = 85, [5] = 77, [6] = 98 }, [1] = { [0] = 14, [1] = 15, [2] = 16, [3] = 19, [4] = 12, [5] = 7, [6] = 17 }, [2] = { [0] = 27, [1] = 28, [2] = 25, [3] = 29, [4] = 21, [5] = 8, [6] = 29 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 39, [3] = 40, [4] = 41, [5] = 38, [6] = 34 }, [1] = { [0] = 103, [1] = 102, [2] = 95, [3] = 107, [4] = 109, [5] = 104, [6] = 99 }, [2] = { [0] = 25, [1] = 19, [2] = 16, [3] = 21, [4] = 19, [5] = 23, [6] = 12 } })[R[18]][R[2]], ({ [0] = { [0] = 94, [1] = 85, [2] = 84, [3] = 82, [4] = 91, [5] = 85, [6] = 85 }, [1] = { [0] = 15, [1] = 9, [2] = 9, [3] = 3, [4] = 18, [5] = 15, [6] = 4 }, [2] = { [0] = 28, [1] = 22, [2] = 18, [3] = 13, [4] = 27, [5] = 16, [6] = 16 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 39, [3] = 40, [4] = 42, [5] = 40, [6] = 34 }, [1] = { [0] = 103, [1] = 102, [2] = 95, [3] = 107, [4] = 110, [5] = 106, [6] = 99 }, [2] = { [0] = 25, [1] = 19, [2] = 16, [3] = 21, [4] = 20, [5] = 25, [6] = 12 } })[R[18]][R[2]], ({ [0] = { [0] = 95, [1] = 91, [2] = 91, [3] = 90, [4] = 85, [5] = 79, [6] = 98 }, [1] = { [0] = 16, [1] = 15, [2] = 16, [3] = 11, [4] = 12, [5] = 9, [6] = 17 }, [2] = { [0] = 29, [1] = 28, [2] = 25, [3] = 21, [4] = 21, [5] = 10, [6] = 29 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 38, [2] = 40, [3] = 40, [4] = 42, [5] = 40, [6] = 35 }, [1] = { [0] = 106, [1] = 103, [2] = 96, [3] = 107, [4] = 110, [5] = 106, [6] = 100 }, [2] = { [0] = 28, [1] = 20, [2] = 17, [3] = 21, [4] = 20, [5] = 25, [6] = 13 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 85, [2] = 84, [3] = 98, [4] = 91, [5] = 80, [6] = 85 }, [1] = { [0] = 11, [1] = 9, [2] = 9, [3] = 19, [4] = 18, [5] = 10, [6] = 4 }, [2] = { [0] = 24, [1] = 22, [2] = 18, [3] = 29, [4] = 27, [5] = 11, [6] = 16 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 38, [2] = 41, [3] = 41, [4] = 43, [5] = 40, [6] = 35 }, [1] = { [0] = 107, [1] = 103, [2] = 97, [3] = 108, [4] = 111, [5] = 106, [6] = 100 }, [2] = { [0] = 29, [1] = 20, [2] = 18, [3] = 22, [4] = 21, [5] = 25, [6] = 13 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 91, [2] = 84, [3] = 82, [4] = 85, [5] = 81, [6] = 98 }, [1] = { [0] = 11, [1] = 15, [2] = 9, [3] = 3, [4] = 12, [5] = 11, [6] = 17 }, [2] = { [0] = 24, [1] = 28, [2] = 18, [3] = 13, [4] = 21, [5] = 12, [6] = 29 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 39, [2] = 42, [3] = 41, [4] = 44, [5] = 40, [6] = 36 }, [1] = { [0] = 108, [1] = 104, [2] = 98, [3] = 108, [4] = 112, [5] = 106, [6] = 101 }, [2] = { [0] = 30, [1] = 21, [2] = 19, [3] = 22, [4] = 22, [5] = 25, [6] = 14 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 85, [2] = 84, [3] = 83, [4] = 85, [5] = 82, [6] = 85 }, [1] = { [0] = 11, [1] = 9, [2] = 9, [3] = 4, [4] = 12, [5] = 12, [6] = 4 }, [2] = { [0] = 24, [1] = 22, [2] = 18, [3] = 14, [4] = 21, [5] = 13, [6] = 16 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 39, [2] = 43, [3] = 41, [4] = 45, [5] = 40, [6] = 36 }, [1] = { [0] = 109, [1] = 104, [2] = 99, [3] = 108, [4] = 113, [5] = 106, [6] = 101 }, [2] = { [0] = 31, [1] = 21, [2] = 20, [3] = 22, [4] = 23, [5] = 25, [6] = 14 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 91, [2] = 84, [3] = 90, [4] = 85, [5] = 83, [6] = 86 }, [1] = { [0] = 11, [1] = 15, [2] = 9, [3] = 11, [4] = 12, [5] = 13, [6] = 5 }, [2] = { [0] = 24, [1] = 28, [2] = 18, [3] = 21, [4] = 21, [5] = 14, [6] = 17 } })[R[18]][R[2]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 40, [2] = 44, [3] = 41, [4] = 45, [5] = 44, [6] = 36 }, [1] = { [0] = 110, [1] = 105, [2] = 100, [3] = 108, [4] = 113, [5] = 110, [6] = 101 }, [2] = { [0] = 32, [1] = 22, [2] = 21, [3] = 22, [4] = 23, [5] = 29, [6] = 14 } })[R[18]][R[2]], ({ [0] = { [0] = 90, [1] = 85, [2] = 84, [3] = 98, [4] = 86, [5] = 85, [6] = 87 }, [1] = { [0] = 11, [1] = 9, [2] = 9, [3] = 19, [4] = 13, [5] = 15, [6] = 6 }, [2] = { [0] = 24, [1] = 22, [2] = 18, [3] = 29, [4] = 22, [5] = 16, [6] = 18 } })[R[18]][R[2]] })
    if R[2] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 111, [2] = 33 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[18]] })
        game.create_tube({ ({ [0] = 51, [1] = 112, [2] = 34 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[18]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 111, [2] = 33 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[18]] })
        game.create_tube({ ({ [0] = 51, [1] = 112, [2] = 34 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[18]] })
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 48, [1] = 109, [2] = 31 }, [1] = { [0] = 50, [1] = 111, [2] = 33 }, [2] = { [0] = 37, [1] = 98, [2] = 20 } })[R[21]][R[18]], ({ [0] = { [0] = 84, [1] = 5, [2] = 18 }, [1] = { [0] = 84, [1] = 5, [2] = 18 }, [2] = { [0] = 95, [1] = 16, [2] = 29 } })[R[21]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 1 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 31, [1] = 96, [2] = 13 }, [1] = { [0] = 41, [1] = 106, [2] = 23 }, [2] = { [0] = 36, [1] = 101, [2] = 18 } })[R[22]][R[18]], ({ [0] = { [0] = 79, [1] = 3, [2] = 16 }, [1] = { [0] = 79, [1] = 3, [2] = 16 }, [2] = { [0] = 95, [1] = 19, [2] = 32 } })[R[22]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 44, [1] = 100, [2] = 21 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 101, [2] = 22 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 46, [1] = 102, [2] = 23 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[18]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[18]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[18]], ({ [0] = 88, [1] = 13, [2] = 22 })[R[18]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[18]], ({ [0] = 89, [1] = 14, [2] = 23 })[R[18]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[18]], ({ [0] = 90, [1] = 15, [2] = 24 })[R[18]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[18]], ({ [0] = 92, [1] = 17, [2] = 26 })[R[18]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[18]], ({ [0] = 93, [1] = 18, [2] = 27 })[R[18]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 44, [1] = 100, [2] = 21 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 101, [2] = 22 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 46, [1] = 102, [2] = 23 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[18]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[18]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[18]], ({ [0] = 88, [1] = 13, [2] = 22 })[R[18]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[18]], ({ [0] = 89, [1] = 14, [2] = 23 })[R[18]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[18]], ({ [0] = 90, [1] = 15, [2] = 24 })[R[18]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[18]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[18]], ({ [0] = 92, [1] = 17, [2] = 26 })[R[18]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[18]], ({ [0] = 93, [1] = 18, [2] = 27 })[R[18]] })
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 41, [1] = 97, [2] = 18 }, [1] = { [0] = 43, [1] = 99, [2] = 20 }, [2] = { [0] = 30, [1] = 86, [2] = 7 } })[R[23]][R[18]], ({ [0] = { [0] = 87, [1] = 12, [2] = 21 }, [1] = { [0] = 94, [1] = 19, [2] = 28 }, [2] = { [0] = 91, [1] = 16, [2] = 25 } })[R[23]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[18]], ({ [0] = 83, [1] = 4, [2] = 14 })[R[18]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[18]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[18]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[18]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[18]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[18]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[18]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[18]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[18]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 91, [1] = 12, [2] = 22 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 92, [1] = 13, [2] = 23 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[18]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[18]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[18]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[18]], ({ [0] = 87, [1] = 8, [2] = 18 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[18]], ({ [0] = 88, [1] = 9, [2] = 19 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[18]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[18]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[18]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[18]], ({ [0] = 83, [1] = 4, [2] = 14 })[R[18]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[18]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[18]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[18]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[18]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[18]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[18]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[18]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[18]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 91, [1] = 12, [2] = 22 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 92, [1] = 13, [2] = 23 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[18]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[18]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[18]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[18]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[18]], ({ [0] = 87, [1] = 8, [2] = 18 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[18]], ({ [0] = 88, [1] = 9, [2] = 19 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[18]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[18]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[18]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 40, [1] = 107, [2] = 21 }, [1] = { [0] = 33, [1] = 100, [2] = 14 }, [2] = { [0] = 29, [1] = 96, [2] = 10 } })[R[24]][R[18]], ({ [0] = { [0] = 81, [1] = 2, [2] = 12 }, [1] = { [0] = 81, [1] = 2, [2] = 12 }, [2] = { [0] = 90, [1] = 11, [2] = 21 } })[R[24]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[18]], ({ [0] = 87, [1] = 14, [2] = 23 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[18]], ({ [0] = 88, [1] = 15, [2] = 24 })[R[18]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[18]], ({ [0] = 87, [1] = 14, [2] = 23 })[R[18]] })
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[18]], ({ [0] = 88, [1] = 15, [2] = 24 })[R[18]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 41, [1] = 109, [2] = 19 }, [1] = { [0] = 46, [1] = 114, [2] = 24 }, [2] = { [0] = 24, [1] = 92, [2] = 2 } })[R[25]][R[18]], ({ [0] = { [0] = 94, [1] = 21, [2] = 30 }, [1] = { [0] = 94, [1] = 21, [2] = 30 }, [2] = { [0] = 81, [1] = 8, [2] = 17 } })[R[25]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 45, [1] = 111, [2] = 30 })[R[18]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 46, [1] = 112, [2] = 31 })[R[18]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 113, [2] = 32 })[R[18]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[18]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 45, [1] = 111, [2] = 30 })[R[18]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 46, [1] = 112, [2] = 31 })[R[18]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 47, [1] = 113, [2] = 32 })[R[18]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[18]] })
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 26, [1] = 92, [2] = 11 }, [1] = { [0] = 31, [1] = 97, [2] = 16 }, [2] = { [0] = 54, [1] = 120, [2] = 39 } })[R[26]][R[18]], ({ [0] = { [0] = 75, [1] = 5, [2] = 6 }, [1] = { [0] = 73, [1] = 3, [2] = 4 }, [2] = { [0] = 86, [1] = 16, [2] = 17 } })[R[26]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 6 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 96, [1] = 15, [2] = 27 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 97, [1] = 16, [2] = 28 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 87, [1] = 6, [2] = 18 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 91, [1] = 10, [2] = 22 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 92, [1] = 11, [2] = 23 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 93, [1] = 12, [2] = 24 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[18]] })
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 34, [1] = 99, [2] = 12 }, [1] = { [0] = 40, [1] = 105, [2] = 18 }, [2] = { [0] = 30, [1] = 95, [2] = 8 } })[R[27]][R[18]], ({ [0] = { [0] = 81, [1] = 0, [2] = 12 }, [1] = { [0] = 81, [1] = 0, [2] = 12 }, [2] = { [0] = 102, [1] = 21, [2] = 33 } })[R[27]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 96, [1] = 15, [2] = 27 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 97, [1] = 16, [2] = 28 })[R[18]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[18]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[18]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[18]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 87, [1] = 6, [2] = 18 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 91, [1] = 10, [2] = 22 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 92, [1] = 11, [2] = 23 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 93, [1] = 12, [2] = 24 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[18]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[18]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[18]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[2]", R[2])
    end
    R[10] = game.rand(7)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 36, [2] = 41, [3] = 36, [4] = 35, [5] = 31, [6] = 36 }, [1] = { [0] = 103, [1] = 101, [2] = 97, [3] = 103, [4] = 103, [5] = 97, [6] = 101 }, [2] = { [0] = 25, [1] = 18, [2] = 18, [3] = 17, [4] = 13, [5] = 16, [6] = 14 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 80, [2] = 91, [3] = 90, [4] = 85, [5] = 77, [6] = 92 }, [1] = { [0] = 11, [1] = 4, [2] = 16, [3] = 11, [4] = 12, [5] = 7, [6] = 11 }, [2] = { [0] = 24, [1] = 17, [2] = 25, [3] = 21, [4] = 21, [5] = 8, [6] = 23 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 42, [1] = 36, [2] = 41, [3] = 36, [4] = 35, [5] = 31, [6] = 36 }, [1] = { [0] = 103, [1] = 101, [2] = 97, [3] = 103, [4] = 103, [5] = 97, [6] = 101 }, [2] = { [0] = 25, [1] = 18, [2] = 18, [3] = 17, [4] = 13, [5] = 16, [6] = 14 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 80, [2] = 91, [3] = 90, [4] = 85, [5] = 77, [6] = 92 }, [1] = { [0] = 11, [1] = 4, [2] = 16, [3] = 11, [4] = 12, [5] = 7, [6] = 11 }, [2] = { [0] = 24, [1] = 17, [2] = 25, [3] = 21, [4] = 21, [5] = 8, [6] = 23 } })[R[19]][R[10]] })
    U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[2], at = { ({ [0] = { [0] = 46, [1] = 34, [2] = 41, [3] = 40, [4] = 39, [5] = 38, [6] = 33 }, [1] = { [0] = 107, [1] = 99, [2] = 97, [3] = 107, [4] = 107, [5] = 104, [6] = 98 }, [2] = { [0] = 29, [1] = 16, [2] = 18, [3] = 21, [4] = 17, [5] = 23, [6] = 11 } })[R[19]][R[10]], ({ [0] = { [0] = 88, [1] = 83, [2] = 88, [3] = 88, [4] = 83, [5] = 80, [6] = 91 }, [1] = { [0] = 9, [1] = 7, [2] = 13, [3] = 9, [4] = 10, [5] = 10, [6] = 10 }, [2] = { [0] = 22, [1] = 20, [2] = 22, [3] = 19, [4] = 19, [5] = 11, [6] = 22 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 30, [2] = 49, [3] = 36, [4] = 35, [5] = 40, [6] = 29 }, [1] = { [0] = 103, [1] = 95, [2] = 105, [3] = 103, [4] = 103, [5] = 106, [6] = 94 }, [2] = { [0] = 25, [1] = 12, [2] = 26, [3] = 17, [4] = 13, [5] = 25, [6] = 7 } })[R[19]][R[10]], ({ [0] = { [0] = 83, [1] = 85, [2] = 95, [3] = 98, [4] = 91, [5] = 77, [6] = 98 }, [1] = { [0] = 4, [1] = 9, [2] = 20, [3] = 19, [4] = 18, [5] = 7, [6] = 17 }, [2] = { [0] = 17, [1] = 22, [2] = 29, [3] = 29, [4] = 27, [5] = 8, [6] = 29 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 0 or R[10] == 1 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 54, [1] = 33, [4] = 45, [5] = 41, [6] = 29 }, [1] = { [0] = 115, [1] = 98, [4] = 113, [5] = 107, [6] = 94 }, [2] = { [0] = 37, [1] = 15, [4] = 23, [5] = 26, [6] = 7 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 91, [4] = 90, [5] = 85, [6] = 85 }, [1] = { [0] = 11, [1] = 15, [4] = 17, [5] = 15, [6] = 4 }, [2] = { [0] = 24, [1] = 28, [4] = 26, [5] = 16, [6] = 16 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 42, [1] = 107, [2] = 24 })[R[19]], ({ [0] = 85, [1] = 9, [2] = 22 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 42, [1] = 107, [2] = 24 })[R[19]], ({ [0] = 85, [1] = 9, [2] = 22 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 42, [1] = 107, [2] = 24 })[R[19]], ({ [0] = 85, [1] = 9, [2] = 22 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 45, [1] = 113, [2] = 23 })[R[19]], ({ [0] = 83, [1] = 10, [2] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 45, [1] = 113, [2] = 23 })[R[19]], ({ [0] = 83, [1] = 10, [2] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 45, [1] = 113, [2] = 23 })[R[19]], ({ [0] = 83, [1] = 10, [2] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 49, [1] = 115, [2] = 34 })[R[19]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 49, [1] = 115, [2] = 34 })[R[19]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 49, [1] = 115, [2] = 34 })[R[19]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 42, [4] = 35, [5] = 32, [6] = 45 }, [1] = { [0] = 92, [1] = 107, [4] = 103, [5] = 98, [6] = 110 }, [2] = { [0] = 14, [1] = 24, [4] = 13, [5] = 17, [6] = 23 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 91, [4] = 78, [5] = 85, [6] = 97 }, [1] = { [0] = 11, [1] = 15, [4] = 5, [5] = 15, [6] = 16 }, [2] = { [0] = 24, [1] = 28, [4] = 14, [5] = 16, [6] = 28 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 42, [1] = 103, [2] = 25 })[R[19]], ({ [0] = 97, [1] = 18, [2] = 31 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 1 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 2 or R[10] == 3 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [2] = 33, [3] = 36 }, [1] = { [2] = 89, [3] = 103 }, [2] = { [2] = 10, [3] = 17 } })[R[19]][R[10]], ({ [0] = { [2] = 95, [3] = 82 }, [1] = { [2] = 20, [3] = 3 }, [2] = { [2] = 29, [3] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 47, [1] = 114, [2] = 28 })[R[19]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [2] = 36, [3] = 47 }, [1] = { [2] = 92, [3] = 114 }, [2] = { [2] = 13, [3] = 28 } })[R[19]][R[10]], ({ [0] = { [2] = 84, [3] = 94 }, [1] = { [2] = 9, [3] = 15 }, [2] = { [2] = 18, [3] = 25 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 47, [1] = 103, [2] = 24 })[R[19]], ({ [0] = 84, [1] = 9, [2] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 47, [1] = 103, [2] = 24 })[R[19]], ({ [0] = 84, [1] = 9, [2] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 47, [1] = 103, [2] = 24 })[R[19]], ({ [0] = 84, [1] = 9, [2] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 3 then
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
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 33, [1] = 50, [2] = 42, [3] = 28, [4] = 25, [5] = 24, [6] = 37 }, [1] = { [0] = 94, [1] = 115, [2] = 98, [3] = 95, [4] = 93, [5] = 90, [6] = 102 }, [2] = { [0] = 16, [1] = 32, [2] = 19, [3] = 9, [4] = 3, [5] = 9, [6] = 15 } })[R[19]][R[10]], ({ [0] = { [0] = 97, [1] = 85, [2] = 78, [3] = 86, [4] = 85, [5] = 85, [6] = 101 }, [1] = { [0] = 18, [1] = 9, [2] = 3, [3] = 7, [4] = 12, [5] = 15, [6] = 20 }, [2] = { [0] = 31, [1] = 22, [2] = 12, [3] = 17, [4] = 21, [5] = 16, [6] = 32 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 38, [1] = 46, [2] = 31, [3] = 46, [4] = 43, [5] = 31, [6] = 47 }, [1] = { [0] = 99, [1] = 111, [2] = 87, [3] = 113, [4] = 111, [5] = 97, [6] = 112 }, [2] = { [0] = 21, [1] = 28, [2] = 8, [3] = 27, [4] = 21, [5] = 16, [6] = 25 } })[R[19]][R[10]], ({ [0] = { [0] = 86, [1] = 89, [2] = 85, [3] = 90, [4] = 76, [5] = 90, [6] = 92 }, [1] = { [0] = 7, [1] = 13, [2] = 10, [3] = 11, [4] = 3, [5] = 20, [6] = 11 }, [2] = { [0] = 20, [1] = 26, [2] = 19, [3] = 21, [4] = 12, [5] = 21, [6] = 23 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 46, [2] = 34, [3] = 48, [4] = 43, [5] = 29, [6] = 47 }, [1] = { [0] = 97, [1] = 111, [2] = 90, [3] = 115, [4] = 111, [5] = 95, [6] = 112 }, [2] = { [0] = 19, [1] = 28, [2] = 11, [3] = 29, [4] = 21, [5] = 14, [6] = 25 } })[R[19]][R[10]], ({ [0] = { [0] = 86, [1] = 87, [2] = 81, [3] = 90, [4] = 78, [5] = 90, [6] = 94 }, [1] = { [0] = 7, [1] = 11, [2] = 6, [3] = 11, [4] = 5, [5] = 20, [6] = 13 }, [2] = { [0] = 20, [1] = 24, [2] = 15, [3] = 21, [4] = 14, [5] = 21, [6] = 25 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 28, [2] = 51, [3] = 40, [4] = 31, [5] = 44, [6] = 46 }, [1] = { [0] = 108, [1] = 93, [2] = 107, [3] = 107, [4] = 99, [5] = 110, [6] = 111 }, [2] = { [0] = 30, [1] = 10, [2] = 28, [3] = 21, [4] = 9, [5] = 29, [6] = 24 } })[R[19]][R[10]], ({ [0] = { [0] = 92, [1] = 90, [2] = 85, [3] = 98, [4] = 86, [5] = 77, [6] = 86 }, [1] = { [0] = 13, [1] = 14, [2] = 10, [3] = 19, [4] = 13, [5] = 7, [6] = 5 }, [2] = { [0] = 26, [1] = 27, [2] = 19, [3] = 29, [4] = 22, [5] = 8, [6] = 17 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 47, [1] = 28, [2] = 49, [3] = 40, [4] = 31, [5] = 44, [6] = 46 }, [1] = { [0] = 108, [1] = 93, [2] = 105, [3] = 107, [4] = 99, [5] = 110, [6] = 111 }, [2] = { [0] = 30, [1] = 10, [2] = 26, [3] = 21, [4] = 9, [5] = 29, [6] = 24 } })[R[19]][R[10]], ({ [0] = { [0] = 92, [1] = 90, [2] = 81, [3] = 98, [4] = 86, [5] = 77, [6] = 86 }, [1] = { [0] = 13, [1] = 14, [2] = 6, [3] = 19, [4] = 13, [5] = 7, [6] = 5 }, [2] = { [0] = 26, [1] = 27, [2] = 15, [3] = 29, [4] = 22, [5] = 8, [6] = 17 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 47, [1] = 28, [2] = 37, [3] = 40, [4] = 31, [5] = 44, [6] = 46 }, [1] = { [0] = 108, [1] = 93, [2] = 93, [3] = 107, [4] = 99, [5] = 110, [6] = 111 }, [2] = { [0] = 30, [1] = 10, [2] = 14, [3] = 21, [4] = 9, [5] = 29, [6] = 24 } })[R[19]][R[10]], ({ [0] = { [0] = 92, [1] = 90, [2] = 96, [3] = 98, [4] = 86, [5] = 77, [6] = 86 }, [1] = { [0] = 13, [1] = 14, [2] = 21, [3] = 19, [4] = 13, [5] = 7, [6] = 5 }, [2] = { [0] = 26, [1] = 27, [2] = 30, [3] = 29, [4] = 22, [5] = 8, [6] = 17 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 46, [2] = 37, [3] = 41, [4] = 30, [5] = 36, [6] = 31 }, [1] = { [0] = 94, [1] = 111, [2] = 93, [3] = 108, [4] = 98, [5] = 102, [6] = 96 }, [2] = { [0] = 16, [1] = 28, [2] = 14, [3] = 22, [4] = 8, [5] = 21, [6] = 9 } })[R[19]][R[10]], ({ [0] = { [0] = 86, [1] = 93, [2] = 96, [3] = 94, [4] = 75, [5] = 87, [6] = 92 }, [1] = { [0] = 7, [1] = 17, [2] = 21, [3] = 15, [4] = 2, [5] = 17, [6] = 11 }, [2] = { [0] = 20, [1] = 30, [2] = 30, [3] = 25, [4] = 11, [5] = 18, [6] = 23 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 42, [2] = 37, [3] = 43, [4] = 39, [5] = 45, [6] = 26 }, [1] = { [0] = 94, [1] = 107, [2] = 93, [3] = 110, [4] = 107, [5] = 111, [6] = 91 }, [2] = { [0] = 16, [1] = 24, [2] = 14, [3] = 24, [4] = 17, [5] = 30, [6] = 4 } })[R[19]][R[10]], ({ [0] = { [0] = 83, [1] = 94, [2] = 96, [3] = 85, [4] = 83, [5] = 84, [6] = 89 }, [1] = { [0] = 4, [1] = 18, [2] = 21, [3] = 6, [4] = 10, [5] = 14, [6] = 8 }, [2] = { [0] = 17, [1] = 31, [2] = 30, [3] = 16, [4] = 19, [5] = 15, [6] = 20 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 46, [2] = 37, [3] = 41, [4] = 30, [5] = 36, [6] = 31 }, [1] = { [0] = 94, [1] = 111, [2] = 93, [3] = 108, [4] = 98, [5] = 102, [6] = 96 }, [2] = { [0] = 16, [1] = 28, [2] = 14, [3] = 22, [4] = 8, [5] = 21, [6] = 9 } })[R[19]][R[10]], ({ [0] = { [0] = 86, [1] = 93, [2] = 96, [3] = 94, [4] = 75, [5] = 87, [6] = 92 }, [1] = { [0] = 7, [1] = 17, [2] = 21, [3] = 15, [4] = 2, [5] = 17, [6] = 11 }, [2] = { [0] = 20, [1] = 30, [2] = 30, [3] = 25, [4] = 11, [5] = 18, [6] = 23 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 42, [2] = 37, [3] = 43, [4] = 39, [5] = 45, [6] = 26 }, [1] = { [0] = 94, [1] = 107, [2] = 93, [3] = 110, [4] = 107, [5] = 111, [6] = 91 }, [2] = { [0] = 16, [1] = 24, [2] = 14, [3] = 24, [4] = 17, [5] = 30, [6] = 4 } })[R[19]][R[10]], ({ [0] = { [0] = 83, [1] = 94, [2] = 96, [3] = 85, [4] = 83, [5] = 84, [6] = 89 }, [1] = { [0] = 4, [1] = 18, [2] = 21, [3] = 6, [4] = 10, [5] = 14, [6] = 8 }, [2] = { [0] = 17, [1] = 31, [2] = 30, [3] = 16, [4] = 19, [5] = 15, [6] = 20 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 54, [1] = 38, [2] = 41, [3] = 49, [4] = 31, [5] = 45, [6] = 40 }, [1] = { [0] = 115, [1] = 103, [2] = 97, [3] = 116, [4] = 99, [5] = 111, [6] = 105 }, [2] = { [0] = 37, [1] = 20, [2] = 18, [3] = 30, [4] = 9, [5] = 30, [6] = 18 } })[R[19]][R[10]], ({ [0] = { [0] = 94, [1] = 87, [2] = 82, [3] = 81, [4] = 92, [5] = 87, [6] = 91 }, [1] = { [0] = 15, [1] = 11, [2] = 7, [3] = 2, [4] = 19, [5] = 17, [6] = 10 }, [2] = { [0] = 28, [1] = 24, [2] = 16, [3] = 12, [4] = 28, [5] = 18, [6] = 22 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 33, [2] = 33, [3] = 36, [4] = 35, [5] = 31, [6] = 29 }, [1] = { [0] = 95, [1] = 98, [2] = 89, [3] = 103, [4] = 103, [5] = 97, [6] = 94 }, [2] = { [0] = 17, [1] = 15, [2] = 10, [3] = 17, [4] = 13, [5] = 16, [6] = 7 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 85, [2] = 91, [3] = 84, [4] = 81, [5] = 79, [6] = 88 }, [1] = { [0] = 11, [1] = 9, [2] = 16, [3] = 5, [4] = 8, [5] = 9, [6] = 7 }, [2] = { [0] = 24, [1] = 22, [2] = 25, [3] = 15, [4] = 17, [5] = 10, [6] = 19 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 34, [2] = 33, [3] = 36, [4] = 35, [5] = 31, [6] = 29 }, [1] = { [0] = 96, [1] = 99, [2] = 89, [3] = 103, [4] = 103, [5] = 97, [6] = 94 }, [2] = { [0] = 18, [1] = 16, [2] = 10, [3] = 17, [4] = 13, [5] = 16, [6] = 7 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 85, [2] = 92, [3] = 85, [4] = 82, [5] = 80, [6] = 89 }, [1] = { [0] = 11, [1] = 9, [2] = 17, [3] = 6, [4] = 9, [5] = 10, [6] = 8 }, [2] = { [0] = 24, [1] = 22, [2] = 26, [3] = 16, [4] = 18, [5] = 11, [6] = 20 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 35, [2] = 33, [3] = 36, [4] = 35, [5] = 31, [6] = 29 }, [1] = { [0] = 97, [1] = 100, [2] = 89, [3] = 103, [4] = 103, [5] = 97, [6] = 94 }, [2] = { [0] = 19, [1] = 17, [2] = 10, [3] = 17, [4] = 13, [5] = 16, [6] = 7 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 85, [2] = 93, [3] = 86, [4] = 83, [5] = 81, [6] = 90 }, [1] = { [0] = 11, [1] = 9, [2] = 18, [3] = 7, [4] = 10, [5] = 11, [6] = 9 }, [2] = { [0] = 24, [1] = 22, [2] = 27, [3] = 17, [4] = 19, [5] = 12, [6] = 21 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 36, [2] = 34, [3] = 36, [4] = 35, [5] = 31, [6] = 29 }, [1] = { [0] = 98, [1] = 101, [2] = 90, [3] = 103, [4] = 103, [5] = 97, [6] = 94 }, [2] = { [0] = 20, [1] = 18, [2] = 11, [3] = 17, [4] = 13, [5] = 16, [6] = 7 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 82, [2] = 91, [3] = 87, [4] = 87, [5] = 82, [6] = 91 }, [1] = { [0] = 11, [1] = 6, [2] = 16, [3] = 8, [4] = 14, [5] = 12, [6] = 10 }, [2] = { [0] = 24, [1] = 19, [2] = 25, [3] = 18, [4] = 23, [5] = 13, [6] = 22 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 36, [2] = 35, [3] = 36, [4] = 35, [5] = 31, [6] = 29 }, [1] = { [0] = 99, [1] = 101, [2] = 91, [3] = 103, [4] = 103, [5] = 97, [6] = 94 }, [2] = { [0] = 21, [1] = 18, [2] = 12, [3] = 17, [4] = 13, [5] = 16, [6] = 7 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 83, [2] = 87, [3] = 88, [4] = 88, [5] = 83, [6] = 92 }, [1] = { [0] = 11, [1] = 7, [2] = 12, [3] = 9, [4] = 15, [5] = 13, [6] = 11 }, [2] = { [0] = 24, [1] = 20, [2] = 21, [3] = 19, [4] = 24, [5] = 14, [6] = 23 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 36, [2] = 35, [3] = 36, [4] = 35, [5] = 34, [6] = 29 }, [1] = { [0] = 100, [1] = 101, [2] = 91, [3] = 103, [4] = 103, [5] = 100, [6] = 94 }, [2] = { [0] = 22, [1] = 18, [2] = 12, [3] = 17, [4] = 13, [5] = 19, [6] = 7 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 84, [2] = 88, [3] = 92, [4] = 89, [5] = 77, [6] = 93 }, [1] = { [0] = 11, [1] = 8, [2] = 13, [3] = 13, [4] = 16, [5] = 7, [6] = 12 }, [2] = { [0] = 24, [1] = 21, [2] = 22, [3] = 23, [4] = 25, [5] = 8, [6] = 24 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 36, [2] = 35, [3] = 36, [4] = 38, [5] = 35, [6] = 29 }, [1] = { [0] = 101, [1] = 101, [2] = 91, [3] = 103, [4] = 106, [5] = 101, [6] = 94 }, [2] = { [0] = 23, [1] = 18, [2] = 12, [3] = 17, [4] = 16, [5] = 20, [6] = 7 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 85, [2] = 89, [3] = 93, [4] = 85, [5] = 77, [6] = 94 }, [1] = { [0] = 11, [1] = 9, [2] = 14, [3] = 14, [4] = 12, [5] = 7, [6] = 13 }, [2] = { [0] = 24, [1] = 22, [2] = 23, [3] = 24, [4] = 21, [5] = 8, [6] = 25 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 35, [3] = 36, [4] = 38, [5] = 35, [6] = 29 }, [1] = { [0] = 103, [1] = 101, [2] = 91, [3] = 103, [4] = 106, [5] = 101, [6] = 94 }, [2] = { [0] = 25, [1] = 18, [2] = 12, [3] = 17, [4] = 16, [5] = 20, [6] = 7 } })[R[19]][R[10]], ({ [0] = { [0] = 85, [1] = 86, [2] = 90, [3] = 94, [4] = 91, [5] = 85, [6] = 95 }, [1] = { [0] = 6, [1] = 10, [2] = 15, [3] = 15, [4] = 18, [5] = 15, [6] = 14 }, [2] = { [0] = 19, [1] = 23, [2] = 24, [3] = 25, [4] = 27, [5] = 16, [6] = 26 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 35, [3] = 36, [4] = 39, [5] = 36, [6] = 29 }, [1] = { [0] = 103, [1] = 101, [2] = 91, [3] = 103, [4] = 107, [5] = 102, [6] = 94 }, [2] = { [0] = 25, [1] = 18, [2] = 12, [3] = 17, [4] = 17, [5] = 21, [6] = 7 } })[R[19]][R[10]], ({ [0] = { [0] = 86, [1] = 87, [2] = 91, [3] = 95, [4] = 85, [5] = 77, [6] = 96 }, [1] = { [0] = 7, [1] = 11, [2] = 16, [3] = 16, [4] = 12, [5] = 7, [6] = 15 }, [2] = { [0] = 20, [1] = 24, [2] = 25, [3] = 26, [4] = 21, [5] = 8, [6] = 27 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 36, [3] = 36, [4] = 39, [5] = 36, [6] = 32 }, [1] = { [0] = 103, [1] = 101, [2] = 92, [3] = 103, [4] = 107, [5] = 102, [6] = 97 }, [2] = { [0] = 25, [1] = 18, [2] = 13, [3] = 17, [4] = 17, [5] = 21, [6] = 10 } })[R[19]][R[10]], ({ [0] = { [0] = 87, [1] = 88, [2] = 87, [3] = 96, [4] = 91, [5] = 85, [6] = 85 }, [1] = { [0] = 8, [1] = 12, [2] = 12, [3] = 17, [4] = 18, [5] = 15, [6] = 4 }, [2] = { [0] = 21, [1] = 25, [2] = 21, [3] = 27, [4] = 27, [5] = 16, [6] = 16 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 36, [3] = 39, [4] = 40, [5] = 37, [6] = 32 }, [1] = { [0] = 103, [1] = 101, [2] = 92, [3] = 106, [4] = 108, [5] = 103, [6] = 97 }, [2] = { [0] = 25, [1] = 18, [2] = 13, [3] = 20, [4] = 18, [5] = 22, [6] = 10 } })[R[19]][R[10]], ({ [0] = { [0] = 88, [1] = 89, [2] = 91, [3] = 82, [4] = 85, [5] = 77, [6] = 98 }, [1] = { [0] = 9, [1] = 13, [2] = 16, [3] = 3, [4] = 12, [5] = 7, [6] = 17 }, [2] = { [0] = 22, [1] = 26, [2] = 25, [3] = 13, [4] = 21, [5] = 8, [6] = 29 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 37, [3] = 39, [4] = 40, [5] = 37, [6] = 33 }, [1] = { [0] = 103, [1] = 101, [2] = 93, [3] = 106, [4] = 108, [5] = 103, [6] = 98 }, [2] = { [0] = 25, [1] = 18, [2] = 14, [3] = 20, [4] = 18, [5] = 22, [6] = 11 } })[R[19]][R[10]], ({ [0] = { [0] = 92, [1] = 90, [2] = 91, [3] = 90, [4] = 91, [5] = 85, [6] = 85 }, [1] = { [0] = 13, [1] = 14, [2] = 16, [3] = 11, [4] = 18, [5] = 15, [6] = 4 }, [2] = { [0] = 26, [1] = 27, [2] = 25, [3] = 21, [4] = 27, [5] = 16, [6] = 16 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 36, [2] = 38, [3] = 39, [4] = 41, [5] = 38, [6] = 33 }, [1] = { [0] = 103, [1] = 101, [2] = 94, [3] = 106, [4] = 109, [5] = 104, [6] = 98 }, [2] = { [0] = 25, [1] = 18, [2] = 15, [3] = 20, [4] = 19, [5] = 23, [6] = 11 } })[R[19]][R[10]], ({ [0] = { [0] = 93, [1] = 91, [2] = 91, [3] = 98, [4] = 85, [5] = 77, [6] = 98 }, [1] = { [0] = 14, [1] = 15, [2] = 16, [3] = 19, [4] = 12, [5] = 7, [6] = 17 }, [2] = { [0] = 27, [1] = 28, [2] = 25, [3] = 29, [4] = 21, [5] = 8, [6] = 29 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 39, [3] = 40, [4] = 41, [5] = 38, [6] = 34 }, [1] = { [0] = 103, [1] = 102, [2] = 95, [3] = 107, [4] = 109, [5] = 104, [6] = 99 }, [2] = { [0] = 25, [1] = 19, [2] = 16, [3] = 21, [4] = 19, [5] = 23, [6] = 12 } })[R[19]][R[10]], ({ [0] = { [0] = 94, [1] = 85, [2] = 84, [3] = 82, [4] = 91, [5] = 85, [6] = 85 }, [1] = { [0] = 15, [1] = 9, [2] = 9, [3] = 3, [4] = 18, [5] = 15, [6] = 4 }, [2] = { [0] = 28, [1] = 22, [2] = 18, [3] = 13, [4] = 27, [5] = 16, [6] = 16 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 37, [2] = 39, [3] = 40, [4] = 42, [5] = 40, [6] = 34 }, [1] = { [0] = 103, [1] = 102, [2] = 95, [3] = 107, [4] = 110, [5] = 106, [6] = 99 }, [2] = { [0] = 25, [1] = 19, [2] = 16, [3] = 21, [4] = 20, [5] = 25, [6] = 12 } })[R[19]][R[10]], ({ [0] = { [0] = 95, [1] = 91, [2] = 91, [3] = 90, [4] = 85, [5] = 79, [6] = 98 }, [1] = { [0] = 16, [1] = 15, [2] = 16, [3] = 11, [4] = 12, [5] = 9, [6] = 17 }, [2] = { [0] = 29, [1] = 28, [2] = 25, [3] = 21, [4] = 21, [5] = 10, [6] = 29 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 38, [2] = 40, [3] = 40, [4] = 42, [5] = 40, [6] = 35 }, [1] = { [0] = 106, [1] = 103, [2] = 96, [3] = 107, [4] = 110, [5] = 106, [6] = 100 }, [2] = { [0] = 28, [1] = 20, [2] = 17, [3] = 21, [4] = 20, [5] = 25, [6] = 13 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 85, [2] = 84, [3] = 98, [4] = 91, [5] = 80, [6] = 85 }, [1] = { [0] = 11, [1] = 9, [2] = 9, [3] = 19, [4] = 18, [5] = 10, [6] = 4 }, [2] = { [0] = 24, [1] = 22, [2] = 18, [3] = 29, [4] = 27, [5] = 11, [6] = 16 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 38, [2] = 41, [3] = 41, [4] = 43, [5] = 40, [6] = 35 }, [1] = { [0] = 107, [1] = 103, [2] = 97, [3] = 108, [4] = 111, [5] = 106, [6] = 100 }, [2] = { [0] = 29, [1] = 20, [2] = 18, [3] = 22, [4] = 21, [5] = 25, [6] = 13 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 91, [2] = 84, [3] = 82, [4] = 85, [5] = 81, [6] = 98 }, [1] = { [0] = 11, [1] = 15, [2] = 9, [3] = 3, [4] = 12, [5] = 11, [6] = 17 }, [2] = { [0] = 24, [1] = 28, [2] = 18, [3] = 13, [4] = 21, [5] = 12, [6] = 29 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 39, [2] = 42, [3] = 41, [4] = 44, [5] = 40, [6] = 36 }, [1] = { [0] = 108, [1] = 104, [2] = 98, [3] = 108, [4] = 112, [5] = 106, [6] = 101 }, [2] = { [0] = 30, [1] = 21, [2] = 19, [3] = 22, [4] = 22, [5] = 25, [6] = 14 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 85, [2] = 84, [3] = 83, [4] = 85, [5] = 82, [6] = 85 }, [1] = { [0] = 11, [1] = 9, [2] = 9, [3] = 4, [4] = 12, [5] = 12, [6] = 4 }, [2] = { [0] = 24, [1] = 22, [2] = 18, [3] = 14, [4] = 21, [5] = 13, [6] = 16 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 39, [2] = 43, [3] = 41, [4] = 45, [5] = 40, [6] = 36 }, [1] = { [0] = 109, [1] = 104, [2] = 99, [3] = 108, [4] = 113, [5] = 106, [6] = 101 }, [2] = { [0] = 31, [1] = 21, [2] = 20, [3] = 22, [4] = 23, [5] = 25, [6] = 14 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 91, [2] = 84, [3] = 90, [4] = 85, [5] = 83, [6] = 86 }, [1] = { [0] = 11, [1] = 15, [2] = 9, [3] = 11, [4] = 12, [5] = 13, [6] = 5 }, [2] = { [0] = 24, [1] = 28, [2] = 18, [3] = 21, [4] = 21, [5] = 14, [6] = 17 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 40, [2] = 44, [3] = 41, [4] = 45, [5] = 44, [6] = 36 }, [1] = { [0] = 110, [1] = 105, [2] = 100, [3] = 108, [4] = 113, [5] = 110, [6] = 101 }, [2] = { [0] = 32, [1] = 22, [2] = 21, [3] = 22, [4] = 23, [5] = 29, [6] = 14 } })[R[19]][R[10]], ({ [0] = { [0] = 90, [1] = 85, [2] = 84, [3] = 98, [4] = 86, [5] = 85, [6] = 87 }, [1] = { [0] = 11, [1] = 9, [2] = 9, [3] = 19, [4] = 13, [5] = 15, [6] = 6 }, [2] = { [0] = 24, [1] = 22, [2] = 18, [3] = 29, [4] = 22, [5] = 16, [6] = 18 } })[R[19]][R[10]] })
    if R[10] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 111, [2] = 33 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[19]] })
        game.create_tube({ ({ [0] = 51, [1] = 112, [2] = 34 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 111, [2] = 33 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[19]] })
        game.create_tube({ ({ [0] = 51, [1] = 112, [2] = 34 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[19]] })
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 48, [1] = 109, [2] = 31 }, [1] = { [0] = 50, [1] = 111, [2] = 33 }, [2] = { [0] = 37, [1] = 98, [2] = 20 } })[R[28]][R[19]], ({ [0] = { [0] = 84, [1] = 5, [2] = 18 }, [1] = { [0] = 84, [1] = 5, [2] = 18 }, [2] = { [0] = 95, [1] = 16, [2] = 29 } })[R[28]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 96, [2] = 13 }, [1] = { [0] = 41, [1] = 106, [2] = 23 }, [2] = { [0] = 36, [1] = 101, [2] = 18 } })[R[29]][R[19]], ({ [0] = { [0] = 79, [1] = 3, [2] = 16 }, [1] = { [0] = 79, [1] = 3, [2] = 16 }, [2] = { [0] = 95, [1] = 19, [2] = 32 } })[R[29]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 44, [1] = 100, [2] = 21 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 101, [2] = 22 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 46, [1] = 102, [2] = 23 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[19]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[19]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[19]], ({ [0] = 88, [1] = 13, [2] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[19]], ({ [0] = 89, [1] = 14, [2] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[19]], ({ [0] = 90, [1] = 15, [2] = 24 })[R[19]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[19]], ({ [0] = 92, [1] = 17, [2] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[19]], ({ [0] = 93, [1] = 18, [2] = 27 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 44, [1] = 100, [2] = 21 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 101, [2] = 22 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 46, [1] = 102, [2] = 23 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[19]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[19]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[19]], ({ [0] = 88, [1] = 13, [2] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[19]], ({ [0] = 89, [1] = 14, [2] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[19]], ({ [0] = 90, [1] = 15, [2] = 24 })[R[19]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[19]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[19]], ({ [0] = 92, [1] = 17, [2] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[19]], ({ [0] = 93, [1] = 18, [2] = 27 })[R[19]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 41, [1] = 97, [2] = 18 }, [1] = { [0] = 43, [1] = 99, [2] = 20 }, [2] = { [0] = 30, [1] = 86, [2] = 7 } })[R[30]][R[19]], ({ [0] = { [0] = 87, [1] = 12, [2] = 21 }, [1] = { [0] = 94, [1] = 19, [2] = 28 }, [2] = { [0] = 91, [1] = 16, [2] = 25 } })[R[30]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[19]], ({ [0] = 83, [1] = 4, [2] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[19]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[19]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[19]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[19]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[19]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[19]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 91, [1] = 12, [2] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 92, [1] = 13, [2] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[19]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[19]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[19]], ({ [0] = 87, [1] = 8, [2] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[19]], ({ [0] = 88, [1] = 9, [2] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[19]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[19]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[19]], ({ [0] = 83, [1] = 4, [2] = 14 })[R[19]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[19]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[19]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[19]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[19]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[19]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[19]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 91, [1] = 12, [2] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 92, [1] = 13, [2] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[19]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[19]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[19]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[19]], ({ [0] = 87, [1] = 8, [2] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[19]], ({ [0] = 88, [1] = 9, [2] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[19]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[19]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[19]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 40, [1] = 107, [2] = 21 }, [1] = { [0] = 33, [1] = 100, [2] = 14 }, [2] = { [0] = 29, [1] = 96, [2] = 10 } })[R[31]][R[19]], ({ [0] = { [0] = 81, [1] = 2, [2] = 12 }, [1] = { [0] = 81, [1] = 2, [2] = 12 }, [2] = { [0] = 90, [1] = 11, [2] = 21 } })[R[31]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[19]], ({ [0] = 87, [1] = 14, [2] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[19]], ({ [0] = 88, [1] = 15, [2] = 24 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[19]], ({ [0] = 87, [1] = 14, [2] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[19]], ({ [0] = 88, [1] = 15, [2] = 24 })[R[19]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 41, [1] = 109, [2] = 19 }, [1] = { [0] = 46, [1] = 114, [2] = 24 }, [2] = { [0] = 24, [1] = 92, [2] = 2 } })[R[32]][R[19]], ({ [0] = { [0] = 94, [1] = 21, [2] = 30 }, [1] = { [0] = 94, [1] = 21, [2] = 30 }, [2] = { [0] = 81, [1] = 8, [2] = 17 } })[R[32]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 45, [1] = 111, [2] = 30 })[R[19]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 46, [1] = 112, [2] = 31 })[R[19]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 113, [2] = 32 })[R[19]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 45, [1] = 111, [2] = 30 })[R[19]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 46, [1] = 112, [2] = 31 })[R[19]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 47, [1] = 113, [2] = 32 })[R[19]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[19]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 92, [2] = 11 }, [1] = { [0] = 31, [1] = 97, [2] = 16 }, [2] = { [0] = 54, [1] = 120, [2] = 39 } })[R[33]][R[19]], ({ [0] = { [0] = 75, [1] = 5, [2] = 6 }, [1] = { [0] = 73, [1] = 3, [2] = 4 }, [2] = { [0] = 86, [1] = 16, [2] = 17 } })[R[33]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 96, [1] = 15, [2] = 27 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 97, [1] = 16, [2] = 28 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 87, [1] = 6, [2] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 91, [1] = 10, [2] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 92, [1] = 11, [2] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 93, [1] = 12, [2] = 24 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 96, [1] = 15, [2] = 27 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 97, [1] = 16, [2] = 28 })[R[19]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[19]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[19]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[19]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 87, [1] = 6, [2] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 91, [1] = 10, [2] = 22 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 92, [1] = 11, [2] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 93, [1] = 12, [2] = 24 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[19]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[19]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[19]] })
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 34, [1] = 99, [2] = 12 }, [1] = { [0] = 40, [1] = 105, [2] = 18 }, [2] = { [0] = 30, [1] = 95, [2] = 8 } })[R[34]][R[19]], ({ [0] = { [0] = 81, [1] = 0, [2] = 12 }, [1] = { [0] = 81, [1] = 0, [2] = 12 }, [2] = { [0] = 102, [1] = 21, [2] = 33 } })[R[34]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    R[35] = game.rand(7)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 42, [1] = 103, [2] = 25 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 41, [1] = 97, [2] = 18 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 35, [1] = 103, [2] = 13 }, [5] = { [0] = 31, [1] = 97, [2] = 16 }, [6] = { [0] = 36, [1] = 101, [2] = 14 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 80, [1] = 4, [2] = 17 }, [2] = { [0] = 91, [1] = 16, [2] = 25 }, [3] = { [0] = 90, [1] = 11, [2] = 21 }, [4] = { [0] = 85, [1] = 12, [2] = 21 }, [5] = { [0] = 77, [1] = 7, [2] = 8 }, [6] = { [0] = 92, [1] = 11, [2] = 23 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 42, [1] = 103, [2] = 25 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 41, [1] = 97, [2] = 18 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 35, [1] = 103, [2] = 13 }, [5] = { [0] = 31, [1] = 97, [2] = 16 }, [6] = { [0] = 36, [1] = 101, [2] = 14 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 80, [1] = 4, [2] = 17 }, [2] = { [0] = 91, [1] = 16, [2] = 25 }, [3] = { [0] = 90, [1] = 11, [2] = 21 }, [4] = { [0] = 85, [1] = 12, [2] = 21 }, [5] = { [0] = 77, [1] = 7, [2] = 8 }, [6] = { [0] = 92, [1] = 11, [2] = 23 } })[R[35]][R[20]] })
    U[#U + 1] = game.create_unit{ type = "TradeCenter", player = players[3], at = { ({ [0] = { [0] = 46, [1] = 107, [2] = 29 }, [1] = { [0] = 34, [1] = 99, [2] = 16 }, [2] = { [0] = 41, [1] = 97, [2] = 18 }, [3] = { [0] = 40, [1] = 107, [2] = 21 }, [4] = { [0] = 39, [1] = 107, [2] = 17 }, [5] = { [0] = 38, [1] = 104, [2] = 23 }, [6] = { [0] = 33, [1] = 98, [2] = 11 } })[R[35]][R[20]], ({ [0] = { [0] = 88, [1] = 9, [2] = 22 }, [1] = { [0] = 83, [1] = 7, [2] = 20 }, [2] = { [0] = 88, [1] = 13, [2] = 22 }, [3] = { [0] = 88, [1] = 9, [2] = 19 }, [4] = { [0] = 83, [1] = 10, [2] = 19 }, [5] = { [0] = 80, [1] = 10, [2] = 11 }, [6] = { [0] = 91, [1] = 10, [2] = 22 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 42, [1] = 103, [2] = 25 }, [1] = { [0] = 30, [1] = 95, [2] = 12 }, [2] = { [0] = 49, [1] = 105, [2] = 26 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 35, [1] = 103, [2] = 13 }, [5] = { [0] = 40, [1] = 106, [2] = 25 }, [6] = { [0] = 29, [1] = 94, [2] = 7 } })[R[35]][R[20]], ({ [0] = { [0] = 83, [1] = 4, [2] = 17 }, [1] = { [0] = 85, [1] = 9, [2] = 22 }, [2] = { [0] = 95, [1] = 20, [2] = 29 }, [3] = { [0] = 98, [1] = 19, [2] = 29 }, [4] = { [0] = 91, [1] = 18, [2] = 27 }, [5] = { [0] = 77, [1] = 7, [2] = 8 }, [6] = { [0] = 98, [1] = 17, [2] = 29 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    if R[35] == 0 or R[35] == 1 or R[35] == 4 or R[35] == 5 or R[35] == 6 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 54, [1] = 115, [2] = 37 }, [1] = { [0] = 33, [1] = 98, [2] = 15 }, [4] = { [0] = 45, [1] = 113, [2] = 23 }, [5] = { [0] = 41, [1] = 107, [2] = 26 }, [6] = { [0] = 29, [1] = 94, [2] = 7 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 91, [1] = 15, [2] = 28 }, [4] = { [0] = 90, [1] = 17, [2] = 26 }, [5] = { [0] = 85, [1] = 15, [2] = 16 }, [6] = { [0] = 85, [1] = 4, [2] = 16 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[35] == 0 then
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
      elseif R[35] == 1 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 42, [1] = 107, [2] = 24 })[R[20]], ({ [0] = 85, [1] = 9, [2] = 22 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 42, [1] = 107, [2] = 24 })[R[20]], ({ [0] = 85, [1] = 9, [2] = 22 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 42, [1] = 107, [2] = 24 })[R[20]], ({ [0] = 85, [1] = 9, [2] = 22 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[35] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 45, [1] = 113, [2] = 23 })[R[20]], ({ [0] = 83, [1] = 10, [2] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 45, [1] = 113, [2] = 23 })[R[20]], ({ [0] = 83, [1] = 10, [2] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 45, [1] = 113, [2] = 23 })[R[20]], ({ [0] = 83, [1] = 10, [2] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[35] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 49, [1] = 115, [2] = 34 })[R[20]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 49, [1] = 115, [2] = 34 })[R[20]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 49, [1] = 115, [2] = 34 })[R[20]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[35] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[35]", R[35])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = { [0] = 31, [1] = 92, [2] = 14 }, [1] = { [0] = 42, [1] = 107, [2] = 24 }, [4] = { [0] = 35, [1] = 103, [2] = 13 }, [5] = { [0] = 32, [1] = 98, [2] = 17 }, [6] = { [0] = 45, [1] = 110, [2] = 23 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 91, [1] = 15, [2] = 28 }, [4] = { [0] = 78, [1] = 5, [2] = 14 }, [5] = { [0] = 85, [1] = 15, [2] = 16 }, [6] = { [0] = 97, [1] = 16, [2] = 28 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[35] == 1 or R[35] == 4 or R[35] == 5 or R[35] == 6 then
      elseif R[35] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 42, [1] = 103, [2] = 25 })[R[20]], ({ [0] = 97, [1] = 18, [2] = 31 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[35]", R[35])
      end
    elseif R[35] == 2 or R[35] == 3 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [2] = { [0] = 33, [1] = 89, [2] = 10 }, [3] = { [0] = 36, [1] = 103, [2] = 17 } })[R[35]][R[20]], ({ [2] = { [0] = 95, [1] = 20, [2] = 29 }, [3] = { [0] = 82, [1] = 3, [2] = 13 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[35] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 47, [1] = 114, [2] = 28 })[R[20]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[35] == 2 then
      else
        unseen("R[35]", R[35])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [2] = { [0] = 36, [1] = 92, [2] = 13 }, [3] = { [0] = 47, [1] = 114, [2] = 28 } })[R[35]][R[20]], ({ [2] = { [0] = 84, [1] = 9, [2] = 18 }, [3] = { [0] = 94, [1] = 15, [2] = 25 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[35] == 2 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 47, [1] = 103, [2] = 24 })[R[20]], ({ [0] = 84, [1] = 9, [2] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 47, [1] = 103, [2] = 24 })[R[20]], ({ [0] = 84, [1] = 9, [2] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 47, [1] = 103, [2] = 24 })[R[20]], ({ [0] = 84, [1] = 9, [2] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[35] == 3 then
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
        unseen("R[35]", R[35])
      end
    else
      unseen("R[35]", R[35])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 33, [1] = 94, [2] = 16 }, [1] = { [0] = 50, [1] = 115, [2] = 32 }, [2] = { [0] = 42, [1] = 98, [2] = 19 }, [3] = { [0] = 28, [1] = 95, [2] = 9 }, [4] = { [0] = 25, [1] = 93, [2] = 3 }, [5] = { [0] = 24, [1] = 90, [2] = 9 }, [6] = { [0] = 37, [1] = 102, [2] = 15 } })[R[35]][R[20]], ({ [0] = { [0] = 97, [1] = 18, [2] = 31 }, [1] = { [0] = 85, [1] = 9, [2] = 22 }, [2] = { [0] = 78, [1] = 3, [2] = 12 }, [3] = { [0] = 86, [1] = 7, [2] = 17 }, [4] = { [0] = 85, [1] = 12, [2] = 21 }, [5] = { [0] = 85, [1] = 15, [2] = 16 }, [6] = { [0] = 101, [1] = 20, [2] = 32 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 38, [1] = 99, [2] = 21 }, [1] = { [0] = 46, [1] = 111, [2] = 28 }, [2] = { [0] = 31, [1] = 87, [2] = 8 }, [3] = { [0] = 46, [1] = 113, [2] = 27 }, [4] = { [0] = 43, [1] = 111, [2] = 21 }, [5] = { [0] = 31, [1] = 97, [2] = 16 }, [6] = { [0] = 47, [1] = 112, [2] = 25 } })[R[35]][R[20]], ({ [0] = { [0] = 86, [1] = 7, [2] = 20 }, [1] = { [0] = 89, [1] = 13, [2] = 26 }, [2] = { [0] = 85, [1] = 10, [2] = 19 }, [3] = { [0] = 90, [1] = 11, [2] = 21 }, [4] = { [0] = 76, [1] = 3, [2] = 12 }, [5] = { [0] = 90, [1] = 20, [2] = 21 }, [6] = { [0] = 92, [1] = 11, [2] = 23 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 97, [2] = 19 }, [1] = { [0] = 46, [1] = 111, [2] = 28 }, [2] = { [0] = 34, [1] = 90, [2] = 11 }, [3] = { [0] = 48, [1] = 115, [2] = 29 }, [4] = { [0] = 43, [1] = 111, [2] = 21 }, [5] = { [0] = 29, [1] = 95, [2] = 14 }, [6] = { [0] = 47, [1] = 112, [2] = 25 } })[R[35]][R[20]], ({ [0] = { [0] = 86, [1] = 7, [2] = 20 }, [1] = { [0] = 87, [1] = 11, [2] = 24 }, [2] = { [0] = 81, [1] = 6, [2] = 15 }, [3] = { [0] = 90, [1] = 11, [2] = 21 }, [4] = { [0] = 78, [1] = 5, [2] = 14 }, [5] = { [0] = 90, [1] = 20, [2] = 21 }, [6] = { [0] = 94, [1] = 13, [2] = 25 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "RoboMiner", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec" })[R[35]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 108, [2] = 30 }, [1] = { [0] = 28, [1] = 93, [2] = 10 }, [2] = { [0] = 51, [1] = 107, [2] = 28 }, [3] = { [0] = 40, [1] = 107, [2] = 21 }, [4] = { [0] = 31, [1] = 99, [2] = 9 }, [5] = { [0] = 44, [1] = 110, [2] = 29 }, [6] = { [0] = 46, [1] = 111, [2] = 24 } })[R[35]][R[20]], ({ [0] = { [0] = 92, [1] = 13, [2] = 26 }, [1] = { [0] = 90, [1] = 14, [2] = 27 }, [2] = { [0] = 85, [1] = 10, [2] = 19 }, [3] = { [0] = 98, [1] = 19, [2] = 29 }, [4] = { [0] = 86, [1] = 13, [2] = 22 }, [5] = { [0] = 77, [1] = 7, [2] = 8 }, [6] = { [0] = 86, [1] = 5, [2] = 17 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec" })[R[35]], player = players[3], at = { ({ [0] = { [0] = 47, [1] = 108, [2] = 30 }, [1] = { [0] = 28, [1] = 93, [2] = 10 }, [2] = { [0] = 49, [1] = 105, [2] = 26 }, [3] = { [0] = 40, [1] = 107, [2] = 21 }, [4] = { [0] = 31, [1] = 99, [2] = 9 }, [5] = { [0] = 44, [1] = 110, [2] = 29 }, [6] = { [0] = 46, [1] = 111, [2] = 24 } })[R[35]][R[20]], ({ [0] = { [0] = 92, [1] = 13, [2] = 26 }, [1] = { [0] = 90, [1] = 14, [2] = 27 }, [2] = { [0] = 81, [1] = 6, [2] = 15 }, [3] = { [0] = 98, [1] = 19, [2] = 29 }, [4] = { [0] = 86, [1] = 13, [2] = 22 }, [5] = { [0] = 77, [1] = 7, [2] = 8 }, [6] = { [0] = 86, [1] = 5, [2] = 17 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 47, [1] = 108, [2] = 30 }, [1] = { [0] = 28, [1] = 93, [2] = 10 }, [2] = { [0] = 37, [1] = 93, [2] = 14 }, [3] = { [0] = 40, [1] = 107, [2] = 21 }, [4] = { [0] = 31, [1] = 99, [2] = 9 }, [5] = { [0] = 44, [1] = 110, [2] = 29 }, [6] = { [0] = 46, [1] = 111, [2] = 24 } })[R[35]][R[20]], ({ [0] = { [0] = 92, [1] = 13, [2] = 26 }, [1] = { [0] = 90, [1] = 14, [2] = 27 }, [2] = { [0] = 96, [1] = 21, [2] = 30 }, [3] = { [0] = 98, [1] = 19, [2] = 29 }, [4] = { [0] = 86, [1] = 13, [2] = 22 }, [5] = { [0] = 77, [1] = 7, [2] = 8 }, [6] = { [0] = 86, [1] = 5, [2] = 17 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor" })[R[35]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 94, [2] = 16 }, [1] = { [0] = 46, [1] = 111, [2] = 28 }, [2] = { [0] = 37, [1] = 93, [2] = 14 }, [3] = { [0] = 41, [1] = 108, [2] = 22 }, [4] = { [0] = 30, [1] = 98, [2] = 8 }, [5] = { [0] = 36, [1] = 102, [2] = 21 }, [6] = { [0] = 31, [1] = 96, [2] = 9 } })[R[35]][R[20]], ({ [0] = { [0] = 86, [1] = 7, [2] = 20 }, [1] = { [0] = 93, [1] = 17, [2] = 30 }, [2] = { [0] = 96, [1] = 21, [2] = 30 }, [3] = { [0] = 94, [1] = 15, [2] = 25 }, [4] = { [0] = 75, [1] = 2, [2] = 11 }, [5] = { [0] = 87, [1] = 17, [2] = 18 }, [6] = { [0] = 92, [1] = 11, [2] = 23 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner" })[R[35]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 94, [2] = 16 }, [1] = { [0] = 42, [1] = 107, [2] = 24 }, [2] = { [0] = 37, [1] = 93, [2] = 14 }, [3] = { [0] = 43, [1] = 110, [2] = 24 }, [4] = { [0] = 39, [1] = 107, [2] = 17 }, [5] = { [0] = 45, [1] = 111, [2] = 30 }, [6] = { [0] = 26, [1] = 91, [2] = 4 } })[R[35]][R[20]], ({ [0] = { [0] = 83, [1] = 4, [2] = 17 }, [1] = { [0] = 94, [1] = 18, [2] = 31 }, [2] = { [0] = 96, [1] = 21, [2] = 30 }, [3] = { [0] = 85, [1] = 6, [2] = 16 }, [4] = { [0] = 83, [1] = 10, [2] = 19 }, [5] = { [0] = 84, [1] = 14, [2] = 15 }, [6] = { [0] = 89, [1] = 8, [2] = 20 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor" })[R[35]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 94, [2] = 16 }, [1] = { [0] = 46, [1] = 111, [2] = 28 }, [2] = { [0] = 37, [1] = 93, [2] = 14 }, [3] = { [0] = 41, [1] = 108, [2] = 22 }, [4] = { [0] = 30, [1] = 98, [2] = 8 }, [5] = { [0] = 36, [1] = 102, [2] = 21 }, [6] = { [0] = 31, [1] = 96, [2] = 9 } })[R[35]][R[20]], ({ [0] = { [0] = 86, [1] = 7, [2] = 20 }, [1] = { [0] = 93, [1] = 17, [2] = 30 }, [2] = { [0] = 96, [1] = 21, [2] = 30 }, [3] = { [0] = 94, [1] = 15, [2] = 25 }, [4] = { [0] = 75, [1] = 2, [2] = 11 }, [5] = { [0] = 87, [1] = 17, [2] = 18 }, [6] = { [0] = 92, [1] = 11, [2] = 23 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "ConVec", [3] = "RoboMiner", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner" })[R[35]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 94, [2] = 16 }, [1] = { [0] = 42, [1] = 107, [2] = 24 }, [2] = { [0] = 37, [1] = 93, [2] = 14 }, [3] = { [0] = 43, [1] = 110, [2] = 24 }, [4] = { [0] = 39, [1] = 107, [2] = 17 }, [5] = { [0] = 45, [1] = 111, [2] = 30 }, [6] = { [0] = 26, [1] = 91, [2] = 4 } })[R[35]][R[20]], ({ [0] = { [0] = 83, [1] = 4, [2] = 17 }, [1] = { [0] = 94, [1] = 18, [2] = 31 }, [2] = { [0] = 96, [1] = 21, [2] = 30 }, [3] = { [0] = 85, [1] = 6, [2] = 16 }, [4] = { [0] = 83, [1] = 10, [2] = 19 }, [5] = { [0] = 84, [1] = 14, [2] = 15 }, [6] = { [0] = 89, [1] = 8, [2] = 20 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 54, [1] = 115, [2] = 37 }, [1] = { [0] = 38, [1] = 103, [2] = 20 }, [2] = { [0] = 41, [1] = 97, [2] = 18 }, [3] = { [0] = 49, [1] = 116, [2] = 30 }, [4] = { [0] = 31, [1] = 99, [2] = 9 }, [5] = { [0] = 45, [1] = 111, [2] = 30 }, [6] = { [0] = 40, [1] = 105, [2] = 18 } })[R[35]][R[20]], ({ [0] = { [0] = 94, [1] = 15, [2] = 28 }, [1] = { [0] = 87, [1] = 11, [2] = 24 }, [2] = { [0] = 82, [1] = 7, [2] = 16 }, [3] = { [0] = 81, [1] = 2, [2] = 12 }, [4] = { [0] = 92, [1] = 19, [2] = 28 }, [5] = { [0] = 87, [1] = 17, [2] = 18 }, [6] = { [0] = 91, [1] = 10, [2] = 22 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 95, [2] = 17 }, [1] = { [0] = 33, [1] = 98, [2] = 15 }, [2] = { [0] = 33, [1] = 89, [2] = 10 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 35, [1] = 103, [2] = 13 }, [5] = { [0] = 31, [1] = 97, [2] = 16 }, [6] = { [0] = 29, [1] = 94, [2] = 7 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 85, [1] = 9, [2] = 22 }, [2] = { [0] = 91, [1] = 16, [2] = 25 }, [3] = { [0] = 84, [1] = 5, [2] = 15 }, [4] = { [0] = 81, [1] = 8, [2] = 17 }, [5] = { [0] = 79, [1] = 9, [2] = 10 }, [6] = { [0] = 88, [1] = 7, [2] = 19 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 96, [2] = 18 }, [1] = { [0] = 34, [1] = 99, [2] = 16 }, [2] = { [0] = 33, [1] = 89, [2] = 10 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 35, [1] = 103, [2] = 13 }, [5] = { [0] = 31, [1] = 97, [2] = 16 }, [6] = { [0] = 29, [1] = 94, [2] = 7 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 85, [1] = 9, [2] = 22 }, [2] = { [0] = 92, [1] = 17, [2] = 26 }, [3] = { [0] = 85, [1] = 6, [2] = 16 }, [4] = { [0] = 82, [1] = 9, [2] = 18 }, [5] = { [0] = 80, [1] = 10, [2] = 11 }, [6] = { [0] = 89, [1] = 8, [2] = 20 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 97, [2] = 19 }, [1] = { [0] = 35, [1] = 100, [2] = 17 }, [2] = { [0] = 33, [1] = 89, [2] = 10 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 35, [1] = 103, [2] = 13 }, [5] = { [0] = 31, [1] = 97, [2] = 16 }, [6] = { [0] = 29, [1] = 94, [2] = 7 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 85, [1] = 9, [2] = 22 }, [2] = { [0] = 93, [1] = 18, [2] = 27 }, [3] = { [0] = 86, [1] = 7, [2] = 17 }, [4] = { [0] = 83, [1] = 10, [2] = 19 }, [5] = { [0] = 81, [1] = 11, [2] = 12 }, [6] = { [0] = 90, [1] = 9, [2] = 21 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 98, [2] = 20 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 34, [1] = 90, [2] = 11 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 35, [1] = 103, [2] = 13 }, [5] = { [0] = 31, [1] = 97, [2] = 16 }, [6] = { [0] = 29, [1] = 94, [2] = 7 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 82, [1] = 6, [2] = 19 }, [2] = { [0] = 91, [1] = 16, [2] = 25 }, [3] = { [0] = 87, [1] = 8, [2] = 18 }, [4] = { [0] = 87, [1] = 14, [2] = 23 }, [5] = { [0] = 82, [1] = 12, [2] = 13 }, [6] = { [0] = 91, [1] = 10, [2] = 22 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 99, [2] = 21 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 35, [1] = 91, [2] = 12 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 35, [1] = 103, [2] = 13 }, [5] = { [0] = 31, [1] = 97, [2] = 16 }, [6] = { [0] = 29, [1] = 94, [2] = 7 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 83, [1] = 7, [2] = 20 }, [2] = { [0] = 87, [1] = 12, [2] = 21 }, [3] = { [0] = 88, [1] = 9, [2] = 19 }, [4] = { [0] = 88, [1] = 15, [2] = 24 }, [5] = { [0] = 83, [1] = 13, [2] = 14 }, [6] = { [0] = 92, [1] = 11, [2] = 23 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 39, [1] = 100, [2] = 22 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 35, [1] = 91, [2] = 12 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 35, [1] = 103, [2] = 13 }, [5] = { [0] = 34, [1] = 100, [2] = 19 }, [6] = { [0] = 29, [1] = 94, [2] = 7 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 84, [1] = 8, [2] = 21 }, [2] = { [0] = 88, [1] = 13, [2] = 22 }, [3] = { [0] = 92, [1] = 13, [2] = 23 }, [4] = { [0] = 89, [1] = 16, [2] = 25 }, [5] = { [0] = 77, [1] = 7, [2] = 8 }, [6] = { [0] = 93, [1] = 12, [2] = 24 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 40, [1] = 101, [2] = 23 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 35, [1] = 91, [2] = 12 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 38, [1] = 106, [2] = 16 }, [5] = { [0] = 35, [1] = 101, [2] = 20 }, [6] = { [0] = 29, [1] = 94, [2] = 7 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 85, [1] = 9, [2] = 22 }, [2] = { [0] = 89, [1] = 14, [2] = 23 }, [3] = { [0] = 93, [1] = 14, [2] = 24 }, [4] = { [0] = 85, [1] = 12, [2] = 21 }, [5] = { [0] = 77, [1] = 7, [2] = 8 }, [6] = { [0] = 94, [1] = 13, [2] = 25 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103, [2] = 25 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 35, [1] = 91, [2] = 12 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 38, [1] = 106, [2] = 16 }, [5] = { [0] = 35, [1] = 101, [2] = 20 }, [6] = { [0] = 29, [1] = 94, [2] = 7 } })[R[35]][R[20]], ({ [0] = { [0] = 85, [1] = 6, [2] = 19 }, [1] = { [0] = 86, [1] = 10, [2] = 23 }, [2] = { [0] = 90, [1] = 15, [2] = 24 }, [3] = { [0] = 94, [1] = 15, [2] = 25 }, [4] = { [0] = 91, [1] = 18, [2] = 27 }, [5] = { [0] = 85, [1] = 15, [2] = 16 }, [6] = { [0] = 95, [1] = 14, [2] = 26 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103, [2] = 25 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 35, [1] = 91, [2] = 12 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 39, [1] = 107, [2] = 17 }, [5] = { [0] = 36, [1] = 102, [2] = 21 }, [6] = { [0] = 29, [1] = 94, [2] = 7 } })[R[35]][R[20]], ({ [0] = { [0] = 86, [1] = 7, [2] = 20 }, [1] = { [0] = 87, [1] = 11, [2] = 24 }, [2] = { [0] = 91, [1] = 16, [2] = 25 }, [3] = { [0] = 95, [1] = 16, [2] = 26 }, [4] = { [0] = 85, [1] = 12, [2] = 21 }, [5] = { [0] = 77, [1] = 7, [2] = 8 }, [6] = { [0] = 96, [1] = 15, [2] = 27 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103, [2] = 25 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 36, [1] = 92, [2] = 13 }, [3] = { [0] = 36, [1] = 103, [2] = 17 }, [4] = { [0] = 39, [1] = 107, [2] = 17 }, [5] = { [0] = 36, [1] = 102, [2] = 21 }, [6] = { [0] = 32, [1] = 97, [2] = 10 } })[R[35]][R[20]], ({ [0] = { [0] = 87, [1] = 8, [2] = 21 }, [1] = { [0] = 88, [1] = 12, [2] = 25 }, [2] = { [0] = 87, [1] = 12, [2] = 21 }, [3] = { [0] = 96, [1] = 17, [2] = 27 }, [4] = { [0] = 91, [1] = 18, [2] = 27 }, [5] = { [0] = 85, [1] = 15, [2] = 16 }, [6] = { [0] = 85, [1] = 4, [2] = 16 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103, [2] = 25 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 36, [1] = 92, [2] = 13 }, [3] = { [0] = 39, [1] = 106, [2] = 20 }, [4] = { [0] = 40, [1] = 108, [2] = 18 }, [5] = { [0] = 37, [1] = 103, [2] = 22 }, [6] = { [0] = 32, [1] = 97, [2] = 10 } })[R[35]][R[20]], ({ [0] = { [0] = 88, [1] = 9, [2] = 22 }, [1] = { [0] = 89, [1] = 13, [2] = 26 }, [2] = { [0] = 91, [1] = 16, [2] = 25 }, [3] = { [0] = 82, [1] = 3, [2] = 13 }, [4] = { [0] = 85, [1] = 12, [2] = 21 }, [5] = { [0] = 77, [1] = 7, [2] = 8 }, [6] = { [0] = 98, [1] = 17, [2] = 29 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103, [2] = 25 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 37, [1] = 93, [2] = 14 }, [3] = { [0] = 39, [1] = 106, [2] = 20 }, [4] = { [0] = 40, [1] = 108, [2] = 18 }, [5] = { [0] = 37, [1] = 103, [2] = 22 }, [6] = { [0] = 33, [1] = 98, [2] = 11 } })[R[35]][R[20]], ({ [0] = { [0] = 92, [1] = 13, [2] = 26 }, [1] = { [0] = 90, [1] = 14, [2] = 27 }, [2] = { [0] = 91, [1] = 16, [2] = 25 }, [3] = { [0] = 90, [1] = 11, [2] = 21 }, [4] = { [0] = 91, [1] = 18, [2] = 27 }, [5] = { [0] = 85, [1] = 15, [2] = 16 }, [6] = { [0] = 85, [1] = 4, [2] = 16 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103, [2] = 25 }, [1] = { [0] = 36, [1] = 101, [2] = 18 }, [2] = { [0] = 38, [1] = 94, [2] = 15 }, [3] = { [0] = 39, [1] = 106, [2] = 20 }, [4] = { [0] = 41, [1] = 109, [2] = 19 }, [5] = { [0] = 38, [1] = 104, [2] = 23 }, [6] = { [0] = 33, [1] = 98, [2] = 11 } })[R[35]][R[20]], ({ [0] = { [0] = 93, [1] = 14, [2] = 27 }, [1] = { [0] = 91, [1] = 15, [2] = 28 }, [2] = { [0] = 91, [1] = 16, [2] = 25 }, [3] = { [0] = 98, [1] = 19, [2] = 29 }, [4] = { [0] = 85, [1] = 12, [2] = 21 }, [5] = { [0] = 77, [1] = 7, [2] = 8 }, [6] = { [0] = 98, [1] = 17, [2] = 29 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103, [2] = 25 }, [1] = { [0] = 37, [1] = 102, [2] = 19 }, [2] = { [0] = 39, [1] = 95, [2] = 16 }, [3] = { [0] = 40, [1] = 107, [2] = 21 }, [4] = { [0] = 41, [1] = 109, [2] = 19 }, [5] = { [0] = 38, [1] = 104, [2] = 23 }, [6] = { [0] = 34, [1] = 99, [2] = 12 } })[R[35]][R[20]], ({ [0] = { [0] = 94, [1] = 15, [2] = 28 }, [1] = { [0] = 85, [1] = 9, [2] = 22 }, [2] = { [0] = 84, [1] = 9, [2] = 18 }, [3] = { [0] = 82, [1] = 3, [2] = 13 }, [4] = { [0] = 91, [1] = 18, [2] = 27 }, [5] = { [0] = 85, [1] = 15, [2] = 16 }, [6] = { [0] = 85, [1] = 4, [2] = 16 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 42, [1] = 103, [2] = 25 }, [1] = { [0] = 37, [1] = 102, [2] = 19 }, [2] = { [0] = 39, [1] = 95, [2] = 16 }, [3] = { [0] = 40, [1] = 107, [2] = 21 }, [4] = { [0] = 42, [1] = 110, [2] = 20 }, [5] = { [0] = 40, [1] = 106, [2] = 25 }, [6] = { [0] = 34, [1] = 99, [2] = 12 } })[R[35]][R[20]], ({ [0] = { [0] = 95, [1] = 16, [2] = 29 }, [1] = { [0] = 91, [1] = 15, [2] = 28 }, [2] = { [0] = 91, [1] = 16, [2] = 25 }, [3] = { [0] = 90, [1] = 11, [2] = 21 }, [4] = { [0] = 85, [1] = 12, [2] = 21 }, [5] = { [0] = 79, [1] = 9, [2] = 10 }, [6] = { [0] = 98, [1] = 17, [2] = 29 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 45, [1] = 106, [2] = 28 }, [1] = { [0] = 38, [1] = 103, [2] = 20 }, [2] = { [0] = 40, [1] = 96, [2] = 17 }, [3] = { [0] = 40, [1] = 107, [2] = 21 }, [4] = { [0] = 42, [1] = 110, [2] = 20 }, [5] = { [0] = 40, [1] = 106, [2] = 25 }, [6] = { [0] = 35, [1] = 100, [2] = 13 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 85, [1] = 9, [2] = 22 }, [2] = { [0] = 84, [1] = 9, [2] = 18 }, [3] = { [0] = 98, [1] = 19, [2] = 29 }, [4] = { [0] = 91, [1] = 18, [2] = 27 }, [5] = { [0] = 80, [1] = 10, [2] = 11 }, [6] = { [0] = 85, [1] = 4, [2] = 16 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 46, [1] = 107, [2] = 29 }, [1] = { [0] = 38, [1] = 103, [2] = 20 }, [2] = { [0] = 41, [1] = 97, [2] = 18 }, [3] = { [0] = 41, [1] = 108, [2] = 22 }, [4] = { [0] = 43, [1] = 111, [2] = 21 }, [5] = { [0] = 40, [1] = 106, [2] = 25 }, [6] = { [0] = 35, [1] = 100, [2] = 13 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 91, [1] = 15, [2] = 28 }, [2] = { [0] = 84, [1] = 9, [2] = 18 }, [3] = { [0] = 82, [1] = 3, [2] = 13 }, [4] = { [0] = 85, [1] = 12, [2] = 21 }, [5] = { [0] = 81, [1] = 11, [2] = 12 }, [6] = { [0] = 98, [1] = 17, [2] = 29 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 47, [1] = 108, [2] = 30 }, [1] = { [0] = 39, [1] = 104, [2] = 21 }, [2] = { [0] = 42, [1] = 98, [2] = 19 }, [3] = { [0] = 41, [1] = 108, [2] = 22 }, [4] = { [0] = 44, [1] = 112, [2] = 22 }, [5] = { [0] = 40, [1] = 106, [2] = 25 }, [6] = { [0] = 36, [1] = 101, [2] = 14 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 85, [1] = 9, [2] = 22 }, [2] = { [0] = 84, [1] = 9, [2] = 18 }, [3] = { [0] = 83, [1] = 4, [2] = 14 }, [4] = { [0] = 85, [1] = 12, [2] = 21 }, [5] = { [0] = 82, [1] = 12, [2] = 13 }, [6] = { [0] = 85, [1] = 4, [2] = 16 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 48, [1] = 109, [2] = 31 }, [1] = { [0] = 39, [1] = 104, [2] = 21 }, [2] = { [0] = 43, [1] = 99, [2] = 20 }, [3] = { [0] = 41, [1] = 108, [2] = 22 }, [4] = { [0] = 45, [1] = 113, [2] = 23 }, [5] = { [0] = 40, [1] = 106, [2] = 25 }, [6] = { [0] = 36, [1] = 101, [2] = 14 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 91, [1] = 15, [2] = 28 }, [2] = { [0] = 84, [1] = 9, [2] = 18 }, [3] = { [0] = 90, [1] = 11, [2] = 21 }, [4] = { [0] = 85, [1] = 12, [2] = 21 }, [5] = { [0] = 83, [1] = 13, [2] = 14 }, [6] = { [0] = 86, [1] = 5, [2] = 17 } })[R[35]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 49, [1] = 110, [2] = 32 }, [1] = { [0] = 40, [1] = 105, [2] = 22 }, [2] = { [0] = 44, [1] = 100, [2] = 21 }, [3] = { [0] = 41, [1] = 108, [2] = 22 }, [4] = { [0] = 45, [1] = 113, [2] = 23 }, [5] = { [0] = 44, [1] = 110, [2] = 29 }, [6] = { [0] = 36, [1] = 101, [2] = 14 } })[R[35]][R[20]], ({ [0] = { [0] = 90, [1] = 11, [2] = 24 }, [1] = { [0] = 85, [1] = 9, [2] = 22 }, [2] = { [0] = 84, [1] = 9, [2] = 18 }, [3] = { [0] = 98, [1] = 19, [2] = 29 }, [4] = { [0] = 86, [1] = 13, [2] = 22 }, [5] = { [0] = 85, [1] = 15, [2] = 16 }, [6] = { [0] = 87, [1] = 6, [2] = 18 } })[R[35]][R[20]] })
    if R[35] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 50, [1] = 111, [2] = 33 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 112, [2] = 34 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 50, [1] = 111, [2] = 33 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 51, [1] = 112, [2] = 34 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 24 })[R[20]] })
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 48, [1] = 109, [2] = 31 }, [1] = { [0] = 50, [1] = 111, [2] = 33 }, [2] = { [0] = 37, [1] = 98, [2] = 20 } })[R[36]][R[20]], ({ [0] = { [0] = 84, [1] = 5, [2] = 18 }, [1] = { [0] = 84, [1] = 5, [2] = 18 }, [2] = { [0] = 95, [1] = 16, [2] = 29 } })[R[36]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 1 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[37] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 31, [1] = 96, [2] = 13 }, [1] = { [0] = 41, [1] = 106, [2] = 23 }, [2] = { [0] = 36, [1] = 101, [2] = 18 } })[R[37]][R[20]], ({ [0] = { [0] = 79, [1] = 3, [2] = 16 }, [1] = { [0] = 79, [1] = 3, [2] = 16 }, [2] = { [0] = 95, [1] = 19, [2] = 32 } })[R[37]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 44, [1] = 100, [2] = 21 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 101, [2] = 22 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 46, [1] = 102, [2] = 23 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[20]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[20]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[20]], ({ [0] = 88, [1] = 13, [2] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[20]], ({ [0] = 89, [1] = 14, [2] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[20]], ({ [0] = 90, [1] = 15, [2] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[20]], ({ [0] = 92, [1] = 17, [2] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[20]], ({ [0] = 93, [1] = 18, [2] = 27 })[R[20]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 41, [1] = 97, [2] = 18 }, [1] = { [0] = 43, [1] = 99, [2] = 20 }, [2] = { [0] = 30, [1] = 86, [2] = 7 } })[R[38]][R[20]], ({ [0] = { [0] = 87, [1] = 12, [2] = 21 }, [1] = { [0] = 94, [1] = 19, [2] = 28 }, [2] = { [0] = 91, [1] = 16, [2] = 25 } })[R[38]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 44, [1] = 100, [2] = 21 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 101, [2] = 22 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 46, [1] = 102, [2] = 23 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[20]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 103, [2] = 24 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[20]], ({ [0] = 87, [1] = 12, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[20]], ({ [0] = 88, [1] = 13, [2] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[20]], ({ [0] = 89, [1] = 14, [2] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[20]], ({ [0] = 90, [1] = 15, [2] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 48, [1] = 104, [2] = 25 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[20]], ({ [0] = 91, [1] = 16, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[20]], ({ [0] = 92, [1] = 17, [2] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 49, [1] = 105, [2] = 26 })[R[20]], ({ [0] = 93, [1] = 18, [2] = 27 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[20]], ({ [0] = 83, [1] = 4, [2] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[20]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[20]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[20]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[20]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[20]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[20]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 91, [1] = 12, [2] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 92, [1] = 13, [2] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[20]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[20]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[20]], ({ [0] = 87, [1] = 8, [2] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[20]], ({ [0] = 88, [1] = 9, [2] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[20]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[20]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[20]], ({ [0] = 83, [1] = 4, [2] = 14 })[R[20]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[20]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 42, [1] = 109, [2] = 23 })[R[20]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[20]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 43, [1] = 110, [2] = 24 })[R[20]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[20]], ({ [0] = 84, [1] = 5, [2] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 111, [2] = 25 })[R[20]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 90, [1] = 11, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 91, [1] = 12, [2] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 92, [1] = 13, [2] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 112, [2] = 26 })[R[20]], ({ [0] = 98, [1] = 19, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[20]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 46, [1] = 113, [2] = 27 })[R[20]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[20]], ({ [0] = 87, [1] = 8, [2] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[20]], ({ [0] = 88, [1] = 9, [2] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[20]], ({ [0] = 89, [1] = 10, [2] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 114, [2] = 28 })[R[20]], ({ [0] = 97, [1] = 18, [2] = 28 })[R[20]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 40, [1] = 107, [2] = 21 }, [1] = { [0] = 33, [1] = 100, [2] = 14 }, [2] = { [0] = 29, [1] = 96, [2] = 10 } })[R[39]][R[20]], ({ [0] = { [0] = 81, [1] = 2, [2] = 12 }, [1] = { [0] = 81, [1] = 2, [2] = 12 }, [2] = { [0] = 90, [1] = 11, [2] = 21 } })[R[39]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[20]], ({ [0] = 87, [1] = 14, [2] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[20]], ({ [0] = 88, [1] = 15, [2] = 24 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[20]], ({ [0] = 87, [1] = 14, [2] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 45, [1] = 113, [2] = 23 })[R[20]], ({ [0] = 88, [1] = 15, [2] = 24 })[R[20]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 41, [1] = 109, [2] = 19 }, [1] = { [0] = 46, [1] = 114, [2] = 24 }, [2] = { [0] = 24, [1] = 92, [2] = 2 } })[R[40]][R[20]], ({ [0] = { [0] = 94, [1] = 21, [2] = 30 }, [1] = { [0] = 94, [1] = 21, [2] = 30 }, [2] = { [0] = 81, [1] = 8, [2] = 17 } })[R[40]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 45, [1] = 111, [2] = 30 })[R[20]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 46, [1] = 112, [2] = 31 })[R[20]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 113, [2] = 32 })[R[20]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 45, [1] = 111, [2] = 30 })[R[20]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 46, [1] = 112, [2] = 31 })[R[20]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 47, [1] = 113, [2] = 32 })[R[20]], ({ [0] = 85, [1] = 15, [2] = 16 })[R[20]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 26, [1] = 92, [2] = 11 }, [1] = { [0] = 31, [1] = 97, [2] = 16 }, [2] = { [0] = 54, [1] = 120, [2] = 39 } })[R[41]][R[20]], ({ [0] = { [0] = 75, [1] = 5, [2] = 6 }, [1] = { [0] = 73, [1] = 3, [2] = 4 }, [2] = { [0] = 86, [1] = 16, [2] = 17 } })[R[41]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 96, [1] = 15, [2] = 27 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 97, [1] = 16, [2] = 28 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 87, [1] = 6, [2] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 91, [1] = 10, [2] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 92, [1] = 11, [2] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 93, [1] = 12, [2] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 96, [1] = 15, [2] = 27 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 97, [1] = 16, [2] = 28 })[R[20]] })
        game.create_tube({ ({ [0] = 36, [1] = 101, [2] = 14 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 37, [1] = 102, [2] = 15 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 103, [2] = 16 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 39, [1] = 104, [2] = 17 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 40, [1] = 105, [2] = 18 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 41, [1] = 106, [2] = 19 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[20]], ({ [0] = 85, [1] = 4, [2] = 16 })[R[20]] })
        game.create_tube({ ({ [0] = 42, [1] = 107, [2] = 20 })[R[20]], ({ [0] = 98, [1] = 17, [2] = 29 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 87, [1] = 6, [2] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 88, [1] = 7, [2] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 89, [1] = 8, [2] = 20 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 90, [1] = 9, [2] = 21 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 91, [1] = 10, [2] = 22 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 92, [1] = 11, [2] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 93, [1] = 12, [2] = 24 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 94, [1] = 13, [2] = 25 })[R[20]] })
        game.create_tube({ ({ [0] = 44, [1] = 109, [2] = 22 })[R[20]], ({ [0] = 95, [1] = 14, [2] = 26 })[R[20]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 34, [1] = 99, [2] = 12 }, [1] = { [0] = 40, [1] = 105, [2] = 18 }, [2] = { [0] = 30, [1] = 95, [2] = 8 } })[R[42]][R[20]], ({ [0] = { [0] = 81, [1] = 0, [2] = 12 }, [1] = { [0] = 81, [1] = 0, [2] = 12 }, [2] = { [0] = 102, [1] = 21, [2] = 33 } })[R[42]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[35]", R[35])
    end
  else
    unseen("n", n)
  end
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
  if n == 2 then
    if LEVEL_OF[players[2].difficulty] == 0 then
      players[2]:mark_research(3304)
      players[2]:mark_research(3305)
      players[2]:mark_research(3401)
    elseif LEVEL_OF[players[2].difficulty] == 2 then
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      players[2]:mark_research(3304)
      players[2]:mark_research(3305)
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif n == 3 then
    if LEVEL_OF[players[1].difficulty] == 0 then
      players[2]:mark_research(3304)
      players[2]:mark_research(3305)
      players[2]:mark_research(3401)
      players[3]:mark_research(3303)
      players[3].workers = 28
      players[3].scientists = 20
      players[3].kids = 18
      players[3].food = 3000
      players[3].ore = 6000
      players[3]:mark_research(3304)
      players[3]:mark_research(3305)
      players[3]:mark_research(3401)
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      players[2]:mark_research(3304)
      players[2]:mark_research(3305)
      players[3]:mark_research(3303)
      players[3].workers = 25
      players[3].scientists = 17
      players[3].kids = 16
      players[3].food = 2000
      players[3].ore = 4000
      players[3]:mark_research(3304)
      players[3]:mark_research(3305)
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      players[3]:mark_research(3303)
      players[3].workers = 22
      players[3].scientists = 14
      players[3].kids = 14
      players[3].food = 1000
      players[3].ore = 2000
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  else
    unseen("n", n)
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
  local t3 = trigger.count{type = "IonDriveModule", compare = ">=", count = 1}
  mission.victory(t3, "Launch the Ion Drive Module.")
  local t5 = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1}
  mission.victory(t5, "Launch the Fusion Drive Module.")
  local t7 = trigger.count{type = "CommandModule", compare = ">=", count = 1}
  mission.victory(t7, "Launch the Command Module.")
  local t9 = trigger.count{type = "FuelingSystems", compare = ">=", count = 1}
  mission.victory(t9, "Launch the Fueling Systems.")
  local t11 = trigger.count{type = "HabitatRing", compare = ">=", count = 1}
  mission.victory(t11, "Launch the Habitat Ring.")
  local t13 = trigger.count{type = "SensorPackage", compare = ">=", count = 1}
  mission.victory(t13, "Launch the Sensor Package.")
  local t15 = trigger.count{type = "Skydock", compare = ">=", count = 1}
  mission.victory(t15, "Launch the Skydock.")
  local t17 = trigger.count{type = "StasisSystems", compare = ">=", count = 1}
  mission.victory(t17, "Launch the Stasis Systems.")
  local t19 = trigger.count{type = "OrbitalPackage", compare = ">=", count = 1}
  mission.victory(t19, "Launch the Orbital Package.")
  local t21 = trigger.count{type = "PhoenixModule", compare = ">=", count = 1}
  mission.victory(t21, "Launch the Phoenix Module.")
  if game.disasters_enabled() then
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Tornados}  -- after 60 to 120 marks
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Meteors}  -- after 60 to 120 marks
    trigger.research{tech = 5201, one_shot = true, on = Lava1}
    trigger.resource{resource = "Colonists", compare = ">=", amount = 85, one_shot = true, on = Lava2}
  end
  return true
end
