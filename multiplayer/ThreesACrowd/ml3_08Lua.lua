-- ml3_08Lua.lua  -  3 Player, LastOne, 'Three's a Crowd' map. (Lua)
--
-- Converted by op2dll from ml3_08.dll ("3 Player, LastOne, 'Three's a Crowd' map."): its setup replayed. `on_init` makes the original's
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
    game.create_wall("Wall", { ({ [0] = 85, [1] = 39 })[R[1]], ({ [0] = 12, [1] = 114 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 85, [1] = 40 })[R[1]], ({ [0] = 13, [1] = 114 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 85, [1] = 41 })[R[1]], ({ [0] = 14, [1] = 114 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 86, [1] = 43 })[R[1]], ({ [0] = 11, [1] = 98 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 86, [1] = 43 })[R[1]], ({ [0] = 12, [1] = 99 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 86, [1] = 43 })[R[1]], ({ [0] = 14, [1] = 100 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 86, [1] = 44 })[R[1]], ({ [0] = 15, [1] = 98 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 86, [1] = 45 })[R[1]], ({ [0] = 19, [1] = 98 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 86, [1] = 46 })[R[1]], ({ [0] = 20, [1] = 97 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 86, [1] = 46 })[R[1]], ({ [0] = 21, [1] = 98 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 86, [1] = 47 })[R[1]], ({ [0] = 22, [1] = 97 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 86, [1] = 48 })[R[1]], ({ [0] = 23, [1] = 95 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 87, [1] = 48 })[R[1]], ({ [0] = 18, [1] = 97 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 87, [1] = 49 })[R[1]], ({ [0] = 19, [1] = 90 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 87, [1] = 49 })[R[1]], ({ [0] = 23, [1] = 91 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 88, [1] = 49 })[R[1]], ({ [0] = 22, [1] = 95 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 88, [1] = 49 })[R[1]], ({ [0] = 23, [1] = 96 })[R[1]] })
    game.create_wall("Wall", { ({ [0] = 89, [1] = 49 })[R[1]], ({ [0] = 22, [1] = 97 })[R[1]] })
    if R[1] == 1 then
      game.create_wall("Wall", { 50, 92 })
      game.create_wall("Wall", { 51, 92 })
      game.create_wall("Wall", { 52, 87 })
      game.create_wall("Wall", { 52, 88 })
      game.create_wall("Wall", { 52, 89 })
      game.create_wall("Wall", { 52, 90 })
      game.create_wall("Wall", { 52, 91 })
      game.create_wall("Wall", { 52, 92 })
    elseif R[1] == 0 then
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 89, [1] = 48 })[R[1]], ({ [0] = 20, [1] = 91 })[R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 88, [1] = 46 })[R[1]], ({ [0] = 13, [1] = 95 })[R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[2] = game.rand(7)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 108, [1] = 37 }, [1] = { [0] = 112, [1] = 41 }, [2] = { [0] = 104, [1] = 33 }, [3] = { [0] = 108, [1] = 37 }, [4] = { [0] = 107, [1] = 36 }, [5] = { [0] = 104, [1] = 33 }, [6] = { [0] = 110, [1] = 39 } })[R[2]][R[1]], ({ [0] = { [0] = 9, [1] = 86 }, [1] = { [0] = 9, [1] = 86 }, [2] = { [0] = 5, [1] = 82 }, [3] = { [0] = 8, [1] = 85 }, [4] = { [0] = 6, [1] = 83 }, [5] = { [0] = 3, [1] = 80 }, [6] = { [0] = 6, [1] = 83 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 108, [1] = 37 }, [1] = { [0] = 112, [1] = 41 }, [2] = { [0] = 104, [1] = 33 }, [3] = { [0] = 108, [1] = 37 }, [4] = { [0] = 107, [1] = 36 }, [5] = { [0] = 104, [1] = 33 }, [6] = { [0] = 110, [1] = 39 } })[R[2]][R[1]], ({ [0] = { [0] = 9, [1] = 86 }, [1] = { [0] = 9, [1] = 86 }, [2] = { [0] = 5, [1] = 82 }, [3] = { [0] = 8, [1] = 85 }, [4] = { [0] = 6, [1] = 83 }, [5] = { [0] = 3, [1] = 80 }, [6] = { [0] = 6, [1] = 83 } })[R[2]][R[1]] })
    if R[2] == 1 or R[2] == 2 or R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 105, [1] = 34 }, [2] = { [0] = 109, [1] = 38 }, [3] = { [0] = 105, [1] = 34 } })[R[2]][R[1]], ({ [0] = 12, [1] = 89 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 1 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 104, [1] = 33 })[R[1]], ({ [0] = 3, [1] = 80 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 112, [1] = 41 })[R[1]], ({ [0] = 12, [1] = 89 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 108, [1] = 37 })[R[1]], ({ [0] = 9, [1] = 86 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 112, [1] = 41 })[R[1]], ({ [0] = 6, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 2 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 104, [1] = 33 })[R[1]], ({ [0] = 13, [1] = 90 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 9, [1] = 86 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 105, [1] = 34 })[R[1]], ({ [0] = 8, [1] = 85 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 113, [1] = 42 })[R[1]], ({ [0] = 3, [1] = 80 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 110, [1] = 39 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 105, [1] = 34 })[R[1]], ({ [0] = 4, [1] = 81 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 109, [1] = 38 })[R[1]], ({ [0] = 5, [1] = 82 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 104, [1] = 33 })[R[1]], ({ [0] = 8, [1] = 85 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 113, [1] = 42 })[R[1]], ({ [0] = 13, [1] = 90 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 2, [1] = 79 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "RoboMiner" })[R[2]], player = players[1], at = { ({ [1] = { [0] = 113, [1] = 42 }, [2] = { [0] = 111, [1] = 40 }, [3] = { [0] = 108, [1] = 37 } })[R[2]][R[1]], ({ [1] = { [0] = 14, [1] = 91 }, [2] = { [0] = 13, [1] = 90 }, [3] = { [0] = 3, [1] = 80 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "Earthworker" })[R[2]], player = players[1], at = { ({ [1] = { [0] = 109, [1] = 38 }, [2] = { [0] = 112, [1] = 41 }, [3] = { [0] = 102, [1] = 31 } })[R[2]][R[1]], ({ [1] = { [0] = 13, [1] = 90 }, [2] = { [0] = 14, [1] = 91 }, [3] = { [0] = 10, [1] = 87 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 106, [1] = 35 })[R[1]], ({ [1] = { [0] = 14, [1] = 91 }, [2] = { [0] = 10, [1] = 87 }, [3] = { [0] = 6, [1] = 83 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 106, [1] = 35 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 106, [1] = 35 })[R[1]], ({ [0] = 10, [1] = 87 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 106, [1] = 35 })[R[1]], ({ [0] = 6, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[2] == 4 or R[2] == 5 or R[2] == 6 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [4] = { [0] = 104, [1] = 33 }, [5] = { [0] = 113, [1] = 42 }, [6] = { [0] = 104, [1] = 33 } })[R[2]][R[1]], ({ [0] = 13, [1] = 90 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [4] = { [0] = 112, [1] = 41 }, [5] = { [0] = 104, [1] = 33 }, [6] = { [0] = 112, [1] = 41 } })[R[2]][R[1]], ({ [4] = { [0] = 7, [1] = 84 }, [5] = { [0] = 12, [1] = 89 }, [6] = { [0] = 12, [1] = 89 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 4 or R[2] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [4] = { [0] = 112, [1] = 41 }, [6] = { [0] = 105, [1] = 34 } })[R[2]][R[1]], ({ [0] = 3, [1] = 80 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if R[2] == 4 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 11, [1] = 88 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 11, [1] = 88 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 11, [1] = 88 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [4] = { [0] = 107, [1] = 36 }, [6] = { [0] = 109, [1] = 38 } })[R[2]][R[1]], ({ [0] = 3, [1] = 80 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if R[2] == 6 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 110, [1] = 39 })[R[1]], ({ [0] = 9, [1] = 86 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[2] == 4 then
        else
          unseen("R[2]", R[2])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [4] = { [0] = 9, [1] = 86 }, [6] = { [0] = 6, [1] = 83 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 108, [1] = 37 })[R[1]], ({ [4] = { [0] = 8, [1] = 85 }, [6] = { [0] = 7, [1] = 84 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [4] = { [0] = 108, [1] = 37 }, [6] = { [0] = 113, [1] = 42 } })[R[2]][R[1]], ({ [4] = { [0] = 10, [1] = 87 }, [6] = { [0] = 7, [1] = 84 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[2] == 5 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 104, [1] = 33 })[R[1]], ({ [0] = 9, [1] = 86 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 104, [1] = 33 })[R[1]], ({ [0] = 6, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 109, [1] = 38 })[R[1]], ({ [0] = 4, [1] = 81 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [4] = { [0] = 114, [1] = 43 }, [5] = { [0] = 111, [1] = 40 }, [6] = { [0] = 107, [1] = 36 } })[R[2]][R[1]], ({ [4] = { [0] = 5, [1] = 82 }, [5] = { [0] = 6, [1] = 83 }, [6] = { [0] = 4, [1] = 81 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 114, [1] = 43 })[R[1]], ({ [0] = 5, [1] = 82 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 6, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 6, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 106, [1] = 35 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 13, [1] = 90 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 4, [1] = 81 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[2] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 105, [1] = 34 })[R[1]], ({ [0] = 12, [1] = 89 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 110, [1] = 39 })[R[1]], ({ [0] = 12, [1] = 89 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 104, [1] = 33 })[R[1]], ({ [0] = 9, [1] = 86 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 112, [1] = 41 })[R[1]], ({ [0] = 9, [1] = 86 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 113, [1] = 42 })[R[1]], ({ [0] = 3, [1] = 80 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 112, [1] = 41 })[R[1]], ({ [0] = 13, [1] = 90 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 114, [1] = 43 })[R[1]], ({ [0] = 12, [1] = 89 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    if R[2] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 103, [1] = 32 })[R[1]], ({ [0] = 5, [1] = 82 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 103, [1] = 32 })[R[1]], ({ [0] = 5, [1] = 82 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 106, [1] = 35 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 108, [1] = 37 })[R[1]], ({ [0] = 5, [1] = 82 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 108, [1] = 37 })[R[1]], ({ [0] = 5, [1] = 82 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 106, [1] = 35 })[R[1]], ({ [0] = 10, [1] = 87 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 6, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 6, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 106, [1] = 35 })[R[1]], ({ [0] = 6, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 103, [1] = 32 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 114, [1] = 43 })[R[1]], ({ [0] = 5, [1] = 82 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 114, [1] = 43 })[R[1]], ({ [0] = 11, [1] = 88 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 6, [1] = 83 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 106, [1] = 35 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 13, [1] = 90 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 109, [1] = 38 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 7, [1] = 84 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 109, [1] = 38 })[R[1]], ({ [0] = 14, [1] = 91 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 7, [1] = 84 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 6 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 107, [1] = 36 })[R[1]], ({ [0] = 4, [1] = 81 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 114, [1] = 43 })[R[1]], ({ [0] = 11, [1] = 88 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "RoboMiner", [6] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 104, [1] = 33 }, [1] = { [0] = 109, [1] = 38 }, [2] = { [0] = 108, [1] = 37 }, [3] = { [0] = 106, [1] = 35 }, [4] = { [0] = 113, [1] = 42 }, [5] = { [0] = 108, [1] = 37 }, [6] = { [0] = 113, [1] = 42 } })[R[2]][R[1]], ({ [0] = { [0] = 6, [1] = 83 }, [1] = { [0] = 4, [1] = 81 }, [2] = { [0] = 5, [1] = 82 }, [3] = { [0] = 14, [1] = 91 }, [4] = { [0] = 9, [1] = 86 }, [5] = { [0] = 8, [1] = 85 }, [6] = { [0] = 14, [1] = 91 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "Earthworker", [6] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 105, [1] = 34 }, [1] = { [0] = 108, [1] = 37 }, [2] = { [0] = 107, [1] = 36 }, [3] = { [0] = 107, [1] = 36 }, [4] = { [0] = 114, [1] = 43 }, [5] = { [0] = 109, [1] = 38 }, [6] = { [0] = 114, [1] = 43 } })[R[2]][R[1]], ({ [0] = { [0] = 6, [1] = 83 }, [1] = { [0] = 3, [1] = 80 }, [2] = { [0] = 4, [1] = 81 }, [3] = { [0] = 13, [1] = 90 }, [4] = { [0] = 8, [1] = 85 }, [5] = { [0] = 7, [1] = 84 }, [6] = { [0] = 14, [1] = 91 } })[R[2]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[2] == 0 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 12 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 13 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 14 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86 })[R[1]], ({ [0] = 98, [1] = 11 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86 })[R[1]], ({ [0] = 99, [1] = 12 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[3] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 32 }, [1] = { [0] = 108, [1] = 37 }, [2] = { [0] = 113, [1] = 42 } })[R[3]][R[1]], ({ [0] = { [0] = 2, [1] = 79 }, [1] = { [0] = 5, [1] = 82 }, [2] = { [0] = 11, [1] = 88 } })[R[3]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 108, [1] = 37 })[R[1]], ({ [0] = 11, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 108, [1] = 37 })[R[1]], ({ [0] = 12, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 38 })[R[1]], ({ [0] = 12, [1] = 89 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 12 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 13 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 108, [1] = 37 })[R[1]], ({ [0] = 11, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 108, [1] = 37 })[R[1]], ({ [0] = 12, [1] = 89 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 38 })[R[1]], ({ [0] = 12, [1] = 89 })[R[1]] })
        for i = 1, game.initial_units() do
          R[4] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 112, [1] = 41 }, [1] = { [0] = 104, [1] = 33 }, [2] = { [0] = 108, [1] = 37 } })[R[4]][R[1]], ({ [0] = { [0] = 2, [1] = 79 }, [1] = { [0] = 7, [1] = 84 }, [2] = { [0] = 12, [1] = 89 } })[R[4]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 105, [1] = 34 })[R[1]], ({ [0] = 11, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 108, [1] = 37 })[R[1]], ({ [0] = 8, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 38 })[R[1]], ({ [0] = 8, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 11, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 12, [1] = 89 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 105, [1] = 34 })[R[1]], ({ [0] = 11, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 108, [1] = 37 })[R[1]], ({ [0] = 8, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 109, [1] = 38 })[R[1]], ({ [0] = 8, [1] = 85 })[R[1]] })
        game.create_tube({ ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 11, [1] = 88 })[R[1]] })
        game.create_tube({ ({ [0] = 111, [1] = 40 })[R[1]], ({ [0] = 12, [1] = 89 })[R[1]] })
        for i = 1, game.initial_units() do
          R[5] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 113, [1] = 42 }, [1] = { [0] = 109, [1] = 38 }, [2] = { [0] = 105, [1] = 34 } })[R[5]][R[1]], ({ [0] = { [0] = 13, [1] = 90 }, [1] = { [0] = 7, [1] = 84 }, [2] = { [0] = 2, [1] = 79 } })[R[5]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 104, [1] = 33 })[R[1]], ({ [0] = 10, [1] = 87 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 12 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 13 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 14 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86 })[R[1]], ({ [0] = 98, [1] = 11 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 104, [1] = 33 })[R[1]], ({ [0] = 10, [1] = 87 })[R[1]] })
        for i = 1, game.initial_units() do
          R[6] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 112, [1] = 41 }, [1] = { [0] = 113, [1] = 42 }, [2] = { [0] = 109, [1] = 38 } })[R[6]][R[1]], ({ [0] = { [0] = 2, [1] = 79 }, [1] = { [0] = 8, [1] = 85 }, [2] = { [0] = 12, [1] = 89 } })[R[6]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 4 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 12 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 13 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 14 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86 })[R[1]], ({ [0] = 98, [1] = 11 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86 })[R[1]], ({ [0] = 99, [1] = 12 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[7] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 109, [1] = 38 }, [1] = { [0] = 103, [1] = 32 }, [2] = { [0] = 103, [1] = 32 } })[R[7]][R[1]], ({ [0] = { [0] = 13, [1] = 90 }, [1] = { [0] = 8, [1] = 85 }, [2] = { [0] = 3, [1] = 80 } })[R[7]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 5 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 12 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 13 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 14 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86 })[R[1]], ({ [0] = 98, [1] = 11 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86 })[R[1]], ({ [0] = 99, [1] = 12 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[8] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 113, [1] = 42 }, [1] = { [0] = 112, [1] = 41 }, [2] = { [0] = 109, [1] = 38 } })[R[8]][R[1]], ({ [0] = { [0] = 3, [1] = 80 }, [1] = { [0] = 9, [1] = 86 }, [2] = { [0] = 10, [1] = 87 } })[R[8]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 6 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 12 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 13 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85 })[R[1]], ({ [0] = 114, [1] = 14 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86 })[R[1]], ({ [0] = 98, [1] = 11 })[R[1]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86 })[R[1]], ({ [0] = 99, [1] = 12 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[9] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 107, [1] = 36 }, [1] = { [0] = 103, [1] = 32 }, [2] = { [0] = 113, [1] = 42 } })[R[9]][R[1]], ({ [0] = { [0] = 12, [1] = 89 }, [1] = { [0] = 8, [1] = 85 }, [2] = { [0] = 3, [1] = 80 } })[R[9]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[2]", R[2])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 39, 114 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 85, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 85, 12 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 40, 114 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 11 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 85, 13 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 41, 114 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 12 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 85, 14 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 43, 98 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 11 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 43, 99 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 12 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 43, 100 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 14 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 44, 98 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 15 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 45, 98 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 19 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 46, 97 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 20 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 46, 98 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 21 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 47, 97 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 22 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 48, 95 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 23 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 48, 97 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 87, 18 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    if R[1] == 0 then
      game.create_wall("Wall", { ({ [0] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 }, [1] = { [0] = 95, [4] = 90, [8] = 90, [12] = 90 }, [2] = { [0] = 90, [4] = 90, [8] = 90, [12] = 90 }, [3] = { [0] = 97, [4] = 90, [8] = 90, [12] = 90 }, [4] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 }, [5] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 }, [6] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [1] = { [0] = 96, [4] = 91, [8] = 91, [12] = 91 }, [2] = { [0] = 91, [4] = 91, [8] = 91, [12] = 91 }, [3] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [4] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [5] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [6] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 }, [1] = { [0] = 97, [4] = 95, [8] = 95, [12] = 95 }, [2] = { [0] = 95, [4] = 95, [8] = 95, [12] = 95 }, [3] = { [0] = 92, [4] = 95, [8] = 95, [12] = 95 }, [4] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 }, [5] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 }, [6] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 }, [1] = { [0] = 92, [4] = 96, [8] = 96, [12] = 96 }, [2] = { [0] = 96, [4] = 96, [8] = 96, [12] = 96 }, [3] = { [0] = 87, [4] = 96, [8] = 96, [12] = 96 }, [4] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 }, [5] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 }, [6] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 }, [1] = { [0] = 92, [4] = 97, [8] = 97, [12] = 97 }, [2] = { [0] = 97, [4] = 97, [8] = 97, [12] = 97 }, [3] = { [0] = 88, [4] = 97, [8] = 97, [12] = 97 }, [4] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 }, [5] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 }, [6] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [1] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [2] = { [0] = 50, [4] = 50, [8] = 50, [12] = 50 }, [3] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [4] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [5] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [6] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [1] = { [0] = 87, [4] = 92, [8] = 92, [12] = 92 }, [2] = { [0] = 92, [4] = 92, [8] = 92, [12] = 92 }, [3] = { [0] = 89, [4] = 92, [8] = 92, [12] = 92 }, [4] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [5] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [6] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [1] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [2] = { [0] = 51, [4] = 51, [8] = 51, [12] = 51 }, [3] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [4] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [5] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [6] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 }, [1] = { [0] = 88, [4] = 92, [8] = 92, [12] = 92 }, [2] = { [0] = 92, [4] = 92, [8] = 92, [12] = 92 }, [3] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [4] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 }, [5] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 }, [6] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 } })[R[2]][game.initial_units()] })
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 52, 87 })
        game.create_wall("Wall", { 52, 88 })
        game.create_wall("Wall", { 52, 89 })
        game.create_wall("Wall", { 52, 90 })
        game.create_wall("Wall", { 52, 91 })
        game.create_wall("Wall", { 52, 92 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[1] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 87, 19 })
        game.create_wall("Wall", { 87, 23 })
        game.create_wall("Wall", { 88, 22 })
        game.create_wall("Wall", { 88, 23 })
        game.create_wall("Wall", { 89, 22 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 48, [1] = 89 })[R[1]], ({ [0] = 91, [1] = 20 })[R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 46, [1] = 88 })[R[1]], ({ [0] = 95, [1] = 13 })[R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[10] = game.rand(7)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 37, [1] = 108 }, [1] = { [0] = 41, [1] = 112 }, [2] = { [0] = 33, [1] = 104 }, [3] = { [0] = 37, [1] = 108 }, [4] = { [0] = 36, [1] = 107 }, [5] = { [0] = 33, [1] = 104 }, [6] = { [0] = 39, [1] = 110 } })[R[10]][R[1]], ({ [0] = { [0] = 86, [1] = 9 }, [1] = { [0] = 86, [1] = 9 }, [2] = { [0] = 82, [1] = 5 }, [3] = { [0] = 85, [1] = 8 }, [4] = { [0] = 83, [1] = 6 }, [5] = { [0] = 80, [1] = 3 }, [6] = { [0] = 83, [1] = 6 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 37, [1] = 108 }, [1] = { [0] = 41, [1] = 112 }, [2] = { [0] = 33, [1] = 104 }, [3] = { [0] = 37, [1] = 108 }, [4] = { [0] = 36, [1] = 107 }, [5] = { [0] = 33, [1] = 104 }, [6] = { [0] = 39, [1] = 110 } })[R[10]][R[1]], ({ [0] = { [0] = 86, [1] = 9 }, [1] = { [0] = 86, [1] = 9 }, [2] = { [0] = 82, [1] = 5 }, [3] = { [0] = 85, [1] = 8 }, [4] = { [0] = 83, [1] = 6 }, [5] = { [0] = 80, [1] = 3 }, [6] = { [0] = 83, [1] = 6 } })[R[10]][R[1]] })
    if R[10] == 1 or R[10] == 2 or R[10] == 3 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 34, [1] = 105 }, [2] = { [0] = 38, [1] = 109 }, [3] = { [0] = 34, [1] = 105 } })[R[10]][R[1]], ({ [0] = 89, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 34, [1] = 105 })[R[1]], ({ [0] = 81, [1] = 4 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 38, [1] = 109 })[R[1]], ({ [0] = 82, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 33, [1] = 104 })[R[1]], ({ [0] = 85, [1] = 8 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 42, [1] = 113 })[R[1]], ({ [0] = 90, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 79, [1] = 2 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 33, [1] = 104 })[R[1]], ({ [0] = 90, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 40, [1] = 111 })[R[1]], ({ [0] = 86, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 34, [1] = 105 })[R[1]], ({ [0] = 85, [1] = 8 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 42, [1] = 113 })[R[1]], ({ [0] = 80, [1] = 3 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 39, [1] = 110 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 33, [1] = 104 })[R[1]], ({ [0] = 80, [1] = 3 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 41, [1] = 112 })[R[1]], ({ [0] = 89, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 37, [1] = 108 })[R[1]], ({ [0] = 86, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 112 })[R[1]], ({ [0] = 83, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 40, [1] = 111 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [1] = { [0] = 42, [1] = 113 }, [2] = { [0] = 40, [1] = 111 }, [3] = { [0] = 37, [1] = 108 } })[R[10]][R[1]], ({ [1] = { [0] = 91, [1] = 14 }, [2] = { [0] = 90, [1] = 13 }, [3] = { [0] = 80, [1] = 3 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "Earthworker" })[R[10]], player = players[2], at = { ({ [1] = { [0] = 38, [1] = 109 }, [2] = { [0] = 41, [1] = 112 }, [3] = { [0] = 31, [1] = 102 } })[R[10]][R[1]], ({ [1] = { [0] = 90, [1] = 13 }, [2] = { [0] = 91, [1] = 14 }, [3] = { [0] = 87, [1] = 10 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106 })[R[1]], ({ [1] = { [0] = 91, [1] = 14 }, [2] = { [0] = 87, [1] = 10 }, [3] = { [0] = 83, [1] = 6 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106 })[R[1]], ({ [0] = 87, [1] = 10 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106 })[R[1]], ({ [0] = 83, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 4 or R[10] == 5 or R[10] == 6 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [4] = { [0] = 33, [1] = 104 }, [5] = { [0] = 42, [1] = 113 }, [6] = { [0] = 33, [1] = 104 } })[R[10]][R[1]], ({ [0] = 90, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [4] = { [0] = 41, [1] = 112 }, [5] = { [0] = 33, [1] = 104 }, [6] = { [0] = 41, [1] = 112 } })[R[10]][R[1]], ({ [4] = { [0] = 84, [1] = 7 }, [5] = { [0] = 89, [1] = 12 }, [6] = { [0] = 89, [1] = 12 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 4 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [4] = { [0] = 41, [1] = 112 }, [6] = { [0] = 34, [1] = 105 } })[R[10]][R[1]], ({ [0] = 80, [1] = 3 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 4 then
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
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 38, [1] = 109 })[R[1]], ({ [0] = 80, [1] = 3 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 38, [1] = 109 })[R[1]], ({ [0] = 80, [1] = 3 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 38, [1] = 109 })[R[1]], ({ [0] = 80, [1] = 3 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [4] = { [0] = 40, [1] = 111 }, [6] = { [0] = 39, [1] = 110 } })[R[10]][R[1]], ({ [4] = { [0] = 88, [1] = 11 }, [6] = { [0] = 86, [1] = 9 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 6 then
        elseif R[10] == 4 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 80, [1] = 3 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [4] = { [0] = 86, [1] = 9 }, [6] = { [0] = 83, [1] = 6 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 37, [1] = 108 })[R[1]], ({ [4] = { [0] = 85, [1] = 8 }, [6] = { [0] = 84, [1] = 7 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [4] = { [0] = 37, [1] = 108 }, [6] = { [0] = 42, [1] = 113 } })[R[10]][R[1]], ({ [4] = { [0] = 87, [1] = 10 }, [6] = { [0] = 84, [1] = 7 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[10] == 5 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 33, [1] = 104 })[R[1]], ({ [0] = 86, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 33, [1] = 104 })[R[1]], ({ [0] = 83, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 38, [1] = 109 })[R[1]], ({ [0] = 81, [1] = 4 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [4] = { [0] = 43, [1] = 114 }, [5] = { [0] = 40, [1] = 111 }, [6] = { [0] = 36, [1] = 107 } })[R[10]][R[1]], ({ [4] = { [0] = 82, [1] = 5 }, [5] = { [0] = 83, [1] = 6 }, [6] = { [0] = 81, [1] = 4 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 43, [1] = 114 })[R[1]], ({ [0] = 82, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 40, [1] = 111 })[R[1]], ({ [0] = 83, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 40, [1] = 111 })[R[1]], ({ [0] = 83, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 35, [1] = 106 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 90, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 81, [1] = 4 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 34, [1] = 105 })[R[1]], ({ [0] = 89, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 39, [1] = 110 })[R[1]], ({ [0] = 89, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 33, [1] = 104 })[R[1]], ({ [0] = 86, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 112 })[R[1]], ({ [0] = 86, [1] = 9 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 42, [1] = 113 })[R[1]], ({ [0] = 80, [1] = 3 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 40, [1] = 111 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 41, [1] = 112 })[R[1]], ({ [0] = 90, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 43, [1] = 114 })[R[1]], ({ [0] = 89, [1] = 12 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 32, [1] = 103 })[R[1]], ({ [0] = 82, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 32, [1] = 103 })[R[1]], ({ [0] = 82, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 37, [1] = 108 })[R[1]], ({ [0] = 82, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 37, [1] = 108 })[R[1]], ({ [0] = 82, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106 })[R[1]], ({ [0] = 87, [1] = 10 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 83, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 83, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106 })[R[1]], ({ [0] = 83, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 32, [1] = 103 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 43, [1] = 114 })[R[1]], ({ [0] = 82, [1] = 5 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 43, [1] = 114 })[R[1]], ({ [0] = 88, [1] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 40, [1] = 111 })[R[1]], ({ [0] = 83, [1] = 6 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 35, [1] = 106 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 90, [1] = 13 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 38, [1] = 109 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 84, [1] = 7 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 38, [1] = 109 })[R[1]], ({ [0] = 91, [1] = 14 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 84, [1] = 7 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 6 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 107 })[R[1]], ({ [0] = 81, [1] = 4 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 43, [1] = 114 })[R[1]], ({ [0] = 88, [1] = 11 })[R[1]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "RoboMiner", [6] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 104 }, [1] = { [0] = 38, [1] = 109 }, [2] = { [0] = 37, [1] = 108 }, [3] = { [0] = 35, [1] = 106 }, [4] = { [0] = 42, [1] = 113 }, [5] = { [0] = 37, [1] = 108 }, [6] = { [0] = 42, [1] = 113 } })[R[10]][R[1]], ({ [0] = { [0] = 83, [1] = 6 }, [1] = { [0] = 81, [1] = 4 }, [2] = { [0] = 82, [1] = 5 }, [3] = { [0] = 91, [1] = 14 }, [4] = { [0] = 86, [1] = 9 }, [5] = { [0] = 85, [1] = 8 }, [6] = { [0] = 91, [1] = 14 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "Earthworker", [6] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 34, [1] = 105 }, [1] = { [0] = 37, [1] = 108 }, [2] = { [0] = 36, [1] = 107 }, [3] = { [0] = 36, [1] = 107 }, [4] = { [0] = 43, [1] = 114 }, [5] = { [0] = 38, [1] = 109 }, [6] = { [0] = 43, [1] = 114 } })[R[10]][R[1]], ({ [0] = { [0] = 83, [1] = 6 }, [1] = { [0] = 80, [1] = 3 }, [2] = { [0] = 81, [1] = 4 }, [3] = { [0] = 90, [1] = 13 }, [4] = { [0] = 85, [1] = 8 }, [5] = { [0] = 84, [1] = 7 }, [6] = { [0] = 91, [1] = 14 } })[R[10]][R[1]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[11] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 103 }, [1] = { [0] = 37, [1] = 108 }, [2] = { [0] = 42, [1] = 113 } })[R[11]][R[1]], ({ [0] = { [0] = 79, [1] = 2 }, [1] = { [0] = 82, [1] = 5 }, [2] = { [0] = 88, [1] = 11 } })[R[11]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 108 })[R[1]], ({ [0] = 88, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 37, [1] = 108 })[R[1]], ({ [0] = 89, [1] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 109 })[R[1]], ({ [0] = 89, [1] = 12 })[R[1]] })
        for i = 1, game.initial_units() do
          R[12] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 41, [1] = 112 }, [1] = { [0] = 33, [1] = 104 }, [2] = { [0] = 37, [1] = 108 } })[R[12]][R[1]], ({ [0] = { [0] = 79, [1] = 2 }, [1] = { [0] = 84, [1] = 7 }, [2] = { [0] = 89, [1] = 12 } })[R[12]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 108 })[R[1]], ({ [0] = 88, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 37, [1] = 108 })[R[1]], ({ [0] = 89, [1] = 12 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 109 })[R[1]], ({ [0] = 89, [1] = 12 })[R[1]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 34, [1] = 105 })[R[1]], ({ [0] = 88, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 37, [1] = 108 })[R[1]], ({ [0] = 85, [1] = 8 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 109 })[R[1]], ({ [0] = 85, [1] = 8 })[R[1]] })
        game.create_tube({ ({ [0] = 40, [1] = 111 })[R[1]], ({ [0] = 88, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 40, [1] = 111 })[R[1]], ({ [0] = 89, [1] = 12 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 34, [1] = 105 })[R[1]], ({ [0] = 88, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 37, [1] = 108 })[R[1]], ({ [0] = 85, [1] = 8 })[R[1]] })
        game.create_tube({ ({ [0] = 38, [1] = 109 })[R[1]], ({ [0] = 85, [1] = 8 })[R[1]] })
        game.create_tube({ ({ [0] = 40, [1] = 111 })[R[1]], ({ [0] = 88, [1] = 11 })[R[1]] })
        game.create_tube({ ({ [0] = 40, [1] = 111 })[R[1]], ({ [0] = 89, [1] = 12 })[R[1]] })
        for i = 1, game.initial_units() do
          R[13] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 113 }, [1] = { [0] = 38, [1] = 109 }, [2] = { [0] = 34, [1] = 105 } })[R[13]][R[1]], ({ [0] = { [0] = 90, [1] = 13 }, [1] = { [0] = 84, [1] = 7 }, [2] = { [0] = 79, [1] = 2 } })[R[13]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 33, [1] = 104 })[R[1]], ({ [0] = 87, [1] = 10 })[R[1]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 33, [1] = 104 })[R[1]], ({ [0] = 87, [1] = 10 })[R[1]] })
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 41, [1] = 112 }, [1] = { [0] = 42, [1] = 113 }, [2] = { [0] = 38, [1] = 109 } })[R[14]][R[1]], ({ [0] = { [0] = 79, [1] = 2 }, [1] = { [0] = 85, [1] = 8 }, [2] = { [0] = 89, [1] = 12 } })[R[14]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 38, [1] = 109 }, [1] = { [0] = 32, [1] = 103 }, [2] = { [0] = 32, [1] = 103 } })[R[15]][R[1]], ({ [0] = { [0] = 90, [1] = 13 }, [1] = { [0] = 85, [1] = 8 }, [2] = { [0] = 80, [1] = 3 } })[R[15]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 113 }, [1] = { [0] = 41, [1] = 112 }, [2] = { [0] = 38, [1] = 109 } })[R[16]][R[1]], ({ [0] = { [0] = 80, [1] = 3 }, [1] = { [0] = 86, [1] = 9 }, [2] = { [0] = 87, [1] = 10 } })[R[16]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 107 }, [1] = { [0] = 32, [1] = 103 }, [2] = { [0] = 42, [1] = 113 } })[R[17]][R[1]], ({ [0] = { [0] = 89, [1] = 12 }, [1] = { [0] = 85, [1] = 8 }, [2] = { [0] = 80, [1] = 3 } })[R[17]][R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[18]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[18]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 41, [1] = 85, [2] = 9 })[R[18]], ({ [0] = 114, [1] = 14, [2] = 27 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 9 })[R[18]], ({ [0] = 98, [1] = 11, [2] = 28 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 10 })[R[18]], ({ [0] = 99, [1] = 12, [2] = 28 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 11 })[R[18]], ({ [0] = 100, [1] = 14, [2] = 28 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 44, [1] = 86, [2] = 12 })[R[18]], ({ [0] = 98, [1] = 15, [2] = 28 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 45, [1] = 86, [2] = 13 })[R[18]], ({ [0] = 98, [1] = 19, [2] = 28 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 46, [1] = 86, [2] = 14 })[R[18]], ({ [0] = 97, [1] = 20, [2] = 28 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 46, [1] = 86, [2] = 15 })[R[18]], ({ [0] = 98, [1] = 21, [2] = 28 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 47, [1] = 86, [2] = 16 })[R[18]], ({ [0] = 97, [1] = 22, [2] = 28 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 48, [1] = 86, [2] = 17 })[R[18]], ({ [0] = 95, [1] = 23, [2] = 28 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 48, [1] = 87, [2] = 18 })[R[18]], ({ [0] = 97, [1] = 18, [2] = 24 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 49, [1] = 87, [2] = 18 })[R[18]], ({ [0] = 90, [1] = 19, [2] = 25 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 49, [1] = 87, [2] = 18 })[R[18]], ({ [0] = 91, [1] = 23, [2] = 26 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 49, [1] = 88, [2] = 18 })[R[18]], ({ [0] = 95, [1] = 22, [2] = 27 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 49, [1] = 88, [2] = 18 })[R[18]], ({ [0] = 96, [1] = 23, [2] = 28 })[R[18]] })
    game.create_wall("Wall", { ({ [0] = 49, [1] = 89, [2] = 19 })[R[18]], ({ [0] = 97, [1] = 22, [2] = 24 })[R[18]] })
    if R[18] == 0 or R[18] == 2 then
      game.create_wall("Wall", { ({ [0] = 50, [2] = 24 })[R[18]], ({ [0] = 92, [2] = 5 })[R[18]] })
      game.create_wall("Wall", { ({ [0] = 51, [2] = 24 })[R[18]], ({ [0] = 92, [2] = 27 })[R[18]] })
      game.create_wall("Wall", { ({ [0] = 52, [2] = 24 })[R[18]], ({ [0] = 87, [2] = 28 })[R[18]] })
      game.create_wall("Wall", { ({ [0] = 52, [2] = 25 })[R[18]], ({ [0] = 88, [2] = 5 })[R[18]] })
      game.create_wall("Wall", { ({ [0] = 52, [2] = 25 })[R[18]], ({ [0] = 89, [2] = 18 })[R[18]] })
      game.create_wall("Wall", { ({ [0] = 52, [2] = 25 })[R[18]], ({ [0] = 90, [2] = 19 })[R[18]] })
      game.create_wall("Wall", { ({ [0] = 52, [2] = 25 })[R[18]], ({ [0] = 91, [2] = 28 })[R[18]] })
      game.create_wall("Wall", { ({ [0] = 52, [2] = 26 })[R[18]], ({ [0] = 92, [2] = 5 })[R[18]] })
      if R[18] == 0 then
      elseif R[18] == 2 then
        game.create_wall("Wall", { 26, 18 })
        game.create_wall("Wall", { 26, 28 })
        game.create_wall("Wall", { 27, 5 })
        game.create_wall("Wall", { 27, 18 })
        game.create_wall("Wall", { 27, 24 })
        game.create_wall("Wall", { 27, 28 })
        game.create_wall("Wall", { 28, 5 })
        game.create_wall("Wall", { 28, 18 })
        game.create_wall("Wall", { 28, 24 })
        game.create_wall("Wall", { 28, 28 })
        game.create_wall("Wall", { 29, 5 })
        game.create_wall("Wall", { 29, 6 })
        game.create_wall("Wall", { 29, 7 })
        game.create_wall("Wall", { 29, 8 })
        game.create_wall("Wall", { 29, 9 })
        game.create_wall("Wall", { 29, 10 })
        game.create_wall("Wall", { 29, 11 })
        game.create_wall("Wall", { 29, 12 })
        game.create_wall("Wall", { 29, 13 })
        game.create_wall("Wall", { 29, 14 })
        game.create_wall("Wall", { 29, 15 })
        game.create_wall("Wall", { 29, 16 })
        game.create_wall("Wall", { 29, 17 })
        game.create_wall("Wall", { 29, 18 })
        game.create_wall("Wall", { 29, 24 })
        game.create_wall("Wall", { 29, 25 })
        game.create_wall("Wall", { 29, 26 })
        game.create_wall("Wall", { 29, 27 })
        game.create_wall("Wall", { 29, 28 })
      else
        unseen("R[18]", R[18])
      end
    elseif R[18] == 1 then
    else
      unseen("R[18]", R[18])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 48, [1] = 89, [2] = 24 })[R[18]], ({ [0] = 91, [1] = 20, [2] = 24 })[R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[18] == 0 or R[18] == 1 then
    elseif R[18] == 2 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { 5, 24 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[18]", R[18])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 46, [1] = 88, [2] = 22 })[R[18]], ({ [0] = 95, [1] = 13, [2] = 4 })[R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[2] = game.rand(7)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 37, [1] = 41, [2] = 33, [3] = 37, [4] = 36, [5] = 33, [6] = 39 }, [1] = { [0] = 108, [1] = 112, [2] = 104, [3] = 108, [4] = 107, [5] = 104, [6] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 10, [3] = 14, [4] = 13, [5] = 10, [6] = 16 } })[R[18]][R[2]], ({ [0] = { [0] = 86, [1] = 86, [2] = 82, [3] = 85, [4] = 83, [5] = 80, [6] = 83 }, [1] = { [0] = 9, [1] = 9, [2] = 5, [3] = 8, [4] = 6, [5] = 3, [6] = 6 }, [2] = { [0] = 16, [1] = 16, [2] = 12, [3] = 15, [4] = 13, [5] = 10, [6] = 13 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 37, [1] = 41, [2] = 33, [3] = 37, [4] = 36, [5] = 33, [6] = 39 }, [1] = { [0] = 108, [1] = 112, [2] = 104, [3] = 108, [4] = 107, [5] = 104, [6] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 10, [3] = 14, [4] = 13, [5] = 10, [6] = 16 } })[R[18]][R[2]], ({ [0] = { [0] = 86, [1] = 86, [2] = 82, [3] = 85, [4] = 83, [5] = 80, [6] = 83 }, [1] = { [0] = 9, [1] = 9, [2] = 5, [3] = 8, [4] = 6, [5] = 3, [6] = 6 }, [2] = { [0] = 16, [1] = 16, [2] = 12, [3] = 15, [4] = 13, [5] = 10, [6] = 13 } })[R[18]][R[2]] })
    if R[2] == 4 or R[2] == 5 or R[2] == 6 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [4] = 33, [5] = 42, [6] = 33 }, [1] = { [4] = 104, [5] = 113, [6] = 104 }, [2] = { [4] = 10, [5] = 19, [6] = 10 } })[R[18]][R[2]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [4] = 41, [5] = 33, [6] = 41 }, [1] = { [4] = 112, [5] = 104, [6] = 112 }, [2] = { [4] = 18, [5] = 10, [6] = 18 } })[R[18]][R[2]], ({ [0] = { [4] = 84, [5] = 89, [6] = 89 }, [1] = { [4] = 7, [5] = 12, [6] = 12 }, [2] = { [4] = 14, [5] = 19, [6] = 19 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 5 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[18]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[18]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[18]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[2] == 4 or R[2] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [4] = 41, [6] = 34 }, [1] = { [4] = 112, [6] = 105 }, [2] = { [4] = 18, [6] = 11 } })[R[18]][R[2]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        if R[2] == 4 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[2] == 6 then
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
          unseen("R[2]", R[2])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [4] = 36, [6] = 38 }, [1] = { [4] = 107, [6] = 109 }, [2] = { [4] = 13, [6] = 15 } })[R[18]][R[2]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        if R[2] == 4 then
        elseif R[2] == 6 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 39, [1] = 110, [2] = 16 })[R[18]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[2]", R[2])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = { [4] = 86, [6] = 83 }, [1] = { [4] = 9, [6] = 6 }, [2] = { [4] = 16, [6] = 13 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = { [4] = 85, [6] = 84 }, [1] = { [4] = 8, [6] = 7 }, [2] = { [4] = 15, [6] = 14 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [4] = 37, [6] = 42 }, [1] = { [4] = 108, [6] = 113 }, [2] = { [4] = 14, [6] = 19 } })[R[18]][R[2]], ({ [0] = { [4] = 87, [6] = 84 }, [1] = { [4] = 10, [6] = 7 }, [2] = { [4] = 17, [6] = 14 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[2]", R[2])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [4] = 43, [5] = 40, [6] = 36 }, [1] = { [4] = 114, [5] = 111, [6] = 107 }, [2] = { [4] = 20, [5] = 17, [6] = 13 } })[R[18]][R[2]], ({ [0] = { [4] = 82, [5] = 83, [6] = 81 }, [1] = { [4] = 5, [5] = 6, [6] = 4 }, [2] = { [4] = 12, [5] = 13, [6] = 11 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[18]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[2] == 1 or R[2] == 2 or R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [1] = 34, [2] = 38, [3] = 34 }, [1] = { [1] = 105, [2] = 109, [3] = 105 }, [2] = { [1] = 11, [2] = 15, [3] = 11 } })[R[18]][R[2]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      if R[2] == 1 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[18]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[18]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[18]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 42, [1] = 113, [2] = 19 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 34, [1] = 105, [2] = 11 })[R[18]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[18]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[18]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 42, [1] = 113, [2] = 19 })[R[18]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 79, [1] = 2, [2] = 9 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[2] == 2 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[18]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 34, [1] = 105, [2] = 11 })[R[18]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 42, [1] = 113, [2] = 19 })[R[18]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 39, [1] = 110, [2] = 16 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
      if R[2] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[18]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 31, [1] = 102, [2] = 8 })[R[18]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
      if R[2] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[18]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[2] == 3 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[18]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 31, [1] = 102, [2] = 8 })[R[18]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[2]", R[2])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[18]], ({ [0] = { [1] = 91, [2] = 87, [3] = 83 }, [1] = { [1] = 14, [2] = 10, [3] = 6 }, [2] = { [1] = 21, [2] = 17, [3] = 13 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 34, [1] = 105, [2] = 11 })[R[18]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 39, [1] = 110, [2] = 16 })[R[18]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[18]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[18]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 42, [1] = 113, [2] = 19 })[R[18]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[18]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[18]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    if R[2] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 32, [1] = 103, [2] = 9 })[R[18]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 32, [1] = 103, [2] = 9 })[R[18]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[18]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[18]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 32, [1] = 103, [2] = 9 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[18]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[18]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[2] == 5 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 84, [1] = 7, [2] = 14 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[18]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 84, [1] = 7, [2] = 14 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[2] == 6 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[18]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[18]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[18]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[2]", R[2])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "RoboMiner", [6] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 33, [1] = 38, [2] = 37, [3] = 35, [4] = 42, [5] = 37, [6] = 42 }, [1] = { [0] = 104, [1] = 109, [2] = 108, [3] = 106, [4] = 113, [5] = 108, [6] = 113 }, [2] = { [0] = 10, [1] = 15, [2] = 14, [3] = 12, [4] = 19, [5] = 14, [6] = 19 } })[R[18]][R[2]], ({ [0] = { [0] = 83, [1] = 81, [2] = 82, [3] = 91, [4] = 86, [5] = 85, [6] = 91 }, [1] = { [0] = 6, [1] = 4, [2] = 5, [3] = 14, [4] = 9, [5] = 8, [6] = 14 }, [2] = { [0] = 13, [1] = 11, [2] = 12, [3] = 21, [4] = 16, [5] = 15, [6] = 21 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "Earthworker", [6] = "CargoTruck" })[R[2]], player = players[1], at = { ({ [0] = { [0] = 34, [1] = 37, [2] = 36, [3] = 36, [4] = 43, [5] = 38, [6] = 43 }, [1] = { [0] = 105, [1] = 108, [2] = 107, [3] = 107, [4] = 114, [5] = 109, [6] = 114 }, [2] = { [0] = 11, [1] = 14, [2] = 13, [3] = 13, [4] = 20, [5] = 15, [6] = 20 } })[R[18]][R[2]], ({ [0] = { [0] = 83, [1] = 80, [2] = 81, [3] = 90, [4] = 85, [5] = 84, [6] = 91 }, [1] = { [0] = 6, [1] = 3, [2] = 4, [3] = 13, [4] = 8, [5] = 7, [6] = 14 }, [2] = { [0] = 13, [1] = 10, [2] = 11, [3] = 20, [4] = 15, [5] = 14, [6] = 21 } })[R[18]][R[2]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[2] == 0 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 14, [2] = 27 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 9 })[R[19]], ({ [0] = 98, [1] = 11, [2] = 28 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 10 })[R[19]], ({ [0] = 99, [1] = 12, [2] = 28 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 32, [1] = 103, [2] = 9 }, [1] = { [0] = 37, [1] = 108, [2] = 14 }, [2] = { [0] = 42, [1] = 113, [2] = 19 } })[R[21]][R[18]], ({ [0] = { [0] = 79, [1] = 2, [2] = 9 }, [1] = { [0] = 82, [1] = 5, [2] = 12 }, [2] = { [0] = 88, [1] = 11, [2] = 18 } })[R[21]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[18]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[18]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[18]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[18]] })
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[18]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[18]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[18]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[18]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 41, [1] = 112, [2] = 18 }, [1] = { [0] = 33, [1] = 104, [2] = 10 }, [2] = { [0] = 37, [1] = 108, [2] = 14 } })[R[22]][R[18]], ({ [0] = { [0] = 79, [1] = 2, [2] = 9 }, [1] = { [0] = 84, [1] = 7, [2] = 14 }, [2] = { [0] = 89, [1] = 12, [2] = 19 } })[R[22]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 34, [1] = 105, [2] = 11 })[R[18]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[18]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[18]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[18]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[18]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[18]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[18]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 34, [1] = 105, [2] = 11 })[R[18]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[18]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[18]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[18]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[18]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[18]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[18]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[18]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[18]] })
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 113, [2] = 19 }, [1] = { [0] = 38, [1] = 109, [2] = 15 }, [2] = { [0] = 34, [1] = 105, [2] = 11 } })[R[23]][R[18]], ({ [0] = { [0] = 90, [1] = 13, [2] = 20 }, [1] = { [0] = 84, [1] = 7, [2] = 14 }, [2] = { [0] = 79, [1] = 2, [2] = 9 } })[R[23]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 33, [1] = 104, [2] = 10 })[R[18]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[18]] })
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 14, [2] = 27 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 9 })[R[19]], ({ [0] = 98, [1] = 11, [2] = 28 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 33, [1] = 104, [2] = 10 })[R[18]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[18]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 41, [1] = 112, [2] = 18 }, [1] = { [0] = 42, [1] = 113, [2] = 19 }, [2] = { [0] = 38, [1] = 109, [2] = 15 } })[R[24]][R[18]], ({ [0] = { [0] = 79, [1] = 2, [2] = 9 }, [1] = { [0] = 85, [1] = 8, [2] = 15 }, [2] = { [0] = 89, [1] = 12, [2] = 19 } })[R[24]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 4 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 14, [2] = 27 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 9 })[R[19]], ({ [0] = 98, [1] = 11, [2] = 28 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 10 })[R[19]], ({ [0] = 99, [1] = 12, [2] = 28 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 38, [1] = 109, [2] = 15 }, [1] = { [0] = 32, [1] = 103, [2] = 9 }, [2] = { [0] = 32, [1] = 103, [2] = 9 } })[R[25]][R[18]], ({ [0] = { [0] = 90, [1] = 13, [2] = 20 }, [1] = { [0] = 85, [1] = 8, [2] = 15 }, [2] = { [0] = 80, [1] = 3, [2] = 10 } })[R[25]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 5 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 14, [2] = 27 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 9 })[R[19]], ({ [0] = 98, [1] = 11, [2] = 28 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 10 })[R[19]], ({ [0] = 99, [1] = 12, [2] = 28 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 42, [1] = 113, [2] = 19 }, [1] = { [0] = 41, [1] = 112, [2] = 18 }, [2] = { [0] = 38, [1] = 109, [2] = 15 } })[R[26]][R[18]], ({ [0] = { [0] = 80, [1] = 3, [2] = 10 }, [1] = { [0] = 86, [1] = 9, [2] = 16 }, [2] = { [0] = 87, [1] = 10, [2] = 17 } })[R[26]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[2] == 6 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85, [2] = 9 })[R[19]], ({ [0] = 114, [1] = 14, [2] = 27 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 9 })[R[19]], ({ [0] = 98, [1] = 11, [2] = 28 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 10 })[R[19]], ({ [0] = 99, [1] = 12, [2] = 28 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 36, [1] = 107, [2] = 13 }, [1] = { [0] = 32, [1] = 103, [2] = 9 }, [2] = { [0] = 42, [1] = 113, [2] = 19 } })[R[27]][R[18]], ({ [0] = { [0] = 89, [1] = 12, [2] = 19 }, [1] = { [0] = 85, [1] = 8, [2] = 15 }, [2] = { [0] = 80, [1] = 3, [2] = 10 } })[R[27]][R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[2]", R[2])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 39, 114 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 99 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 85, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 85, 12 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 9, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 9, 25 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 40, 114 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 11 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 85, 13 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 9, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 9, 26 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 41, 114 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 12 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 85, 14 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 9, 27 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 43, 98 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 11 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 9, 28 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 43, 99 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 12 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 10, 28 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 43, 100 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 14 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 11, 28 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 44, 98 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 15 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 12, 28 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 45, 98 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 19 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 13, 28 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 46, 97 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 20 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 14, 28 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 46, 98 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 21 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 15, 28 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 47, 97 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 22 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 27 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 16, 28 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 27 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 27 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 27 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 48, 95 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 86, 23 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 17, 28 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 48, 97 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 87, 18 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 19, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 18, 24 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 19, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 19, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 19, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    if R[19] == 0 then
      game.create_wall("Wall", { ({ [0] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 }, [1] = { [0] = 95, [4] = 90, [8] = 90, [12] = 90 }, [2] = { [0] = 90, [4] = 90, [8] = 90, [12] = 90 }, [3] = { [0] = 97, [4] = 90, [8] = 90, [12] = 90 }, [4] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 }, [5] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 }, [6] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [1] = { [0] = 96, [4] = 91, [8] = 91, [12] = 91 }, [2] = { [0] = 91, [4] = 91, [8] = 91, [12] = 91 }, [3] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [4] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [5] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [6] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 }, [1] = { [0] = 97, [4] = 95, [8] = 95, [12] = 95 }, [2] = { [0] = 95, [4] = 95, [8] = 95, [12] = 95 }, [3] = { [0] = 92, [4] = 95, [8] = 95, [12] = 95 }, [4] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 }, [5] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 }, [6] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 }, [1] = { [0] = 92, [4] = 96, [8] = 96, [12] = 96 }, [2] = { [0] = 96, [4] = 96, [8] = 96, [12] = 96 }, [3] = { [0] = 87, [4] = 96, [8] = 96, [12] = 96 }, [4] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 }, [5] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 }, [6] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 }, [1] = { [0] = 92, [4] = 97, [8] = 97, [12] = 97 }, [2] = { [0] = 97, [4] = 97, [8] = 97, [12] = 97 }, [3] = { [0] = 88, [4] = 97, [8] = 97, [12] = 97 }, [4] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 }, [5] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 }, [6] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [1] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [2] = { [0] = 50, [4] = 50, [8] = 50, [12] = 50 }, [3] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [4] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [5] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [6] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [1] = { [0] = 87, [4] = 92, [8] = 92, [12] = 92 }, [2] = { [0] = 92, [4] = 92, [8] = 92, [12] = 92 }, [3] = { [0] = 89, [4] = 92, [8] = 92, [12] = 92 }, [4] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [5] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [6] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [1] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [2] = { [0] = 51, [4] = 51, [8] = 51, [12] = 51 }, [3] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [4] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [5] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [6] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 }, [1] = { [0] = 88, [4] = 92, [8] = 92, [12] = 92 }, [2] = { [0] = 92, [4] = 92, [8] = 92, [12] = 92 }, [3] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [4] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 }, [5] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 }, [6] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 } })[R[2]][game.initial_units()] })
      if R[2] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 52, 87 })
        game.create_wall("Wall", { 52, 88 })
        game.create_wall("Wall", { 52, 89 })
        game.create_wall("Wall", { 52, 90 })
        game.create_wall("Wall", { 52, 91 })
        game.create_wall("Wall", { 52, 92 })
      elseif R[2] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 1 then
      if R[2] == 0 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 87, 19 })
        game.create_wall("Wall", { 87, 23 })
        game.create_wall("Wall", { 88, 22 })
        game.create_wall("Wall", { 88, 23 })
        game.create_wall("Wall", { 89, 22 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    elseif R[19] == 2 then
      game.create_wall("Wall", { ({ [0] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 19, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 25, [8] = 25, [12] = 25 }, [1] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [2] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [3] = { [0] = 24, [4] = 25, [8] = 25, [12] = 25 }, [4] = { [0] = 5, [4] = 25, [8] = 25, [12] = 25 }, [5] = { [0] = 5, [4] = 25, [8] = 25, [12] = 25 }, [6] = { [0] = 5, [4] = 25, [8] = 25, [12] = 25 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [1] = { [0] = 28, [4] = 26, [8] = 26, [12] = 26 }, [2] = { [0] = 26, [4] = 26, [8] = 26, [12] = 26 }, [3] = { [0] = 5, [4] = 26, [8] = 26, [12] = 26 }, [4] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [5] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [6] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 19, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 24, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 25, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 25, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 25, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 25, [4] = 18, [8] = 18, [12] = 18 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 25, [4] = 19, [8] = 19, [12] = 19 }, [1] = { [0] = 24, [4] = 19, [8] = 19, [12] = 19 }, [2] = { [0] = 19, [4] = 19, [8] = 19, [12] = 19 }, [3] = { [0] = 25, [4] = 19, [8] = 19, [12] = 19 }, [4] = { [0] = 25, [4] = 19, [8] = 19, [12] = 19 }, [5] = { [0] = 25, [4] = 19, [8] = 19, [12] = 19 }, [6] = { [0] = 25, [4] = 19, [8] = 19, [12] = 19 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 18, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 27, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 5, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 18, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 18, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 18, [4] = 24, [8] = 24, [12] = 24 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 19, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 28, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 19, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 19, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 19, [4] = 5, [8] = 5, [12] = 5 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 5, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 19, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 26, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 26, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 26, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 26, [4] = 24, [8] = 24, [12] = 24 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [1] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [2] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [3] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [4] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [5] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [6] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 19, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [1] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [2] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [3] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [4] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [5] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [6] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [1] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [2] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [3] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [4] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [5] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [6] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 19, [8] = 19, [12] = 19 }, [1] = { [0] = 5, [4] = 19, [8] = 19, [12] = 19 }, [2] = { [0] = 19, [4] = 19, [8] = 19, [12] = 19 }, [3] = { [0] = 28, [4] = 19, [8] = 19, [12] = 19 }, [4] = { [0] = 5, [4] = 19, [8] = 19, [12] = 19 }, [5] = { [0] = 5, [4] = 19, [8] = 19, [12] = 19 }, [6] = { [0] = 5, [4] = 19, [8] = 19, [12] = 19 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [1] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [2] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [3] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [4] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [5] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [6] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [1] = { [0] = 26, [4] = 26, [8] = 26, [12] = 26 }, [2] = { [0] = 26, [4] = 26, [8] = 26, [12] = 26 }, [3] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [4] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [5] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [6] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 28, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [1] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [2] = { [0] = 26, [4] = 26, [8] = 26, [12] = 26 }, [3] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [4] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [5] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [6] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 5, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 28, [4] = 26, [8] = 26, [12] = 26 }, [1] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [2] = { [0] = 26, [4] = 26, [8] = 26, [12] = 26 }, [3] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [4] = { [0] = 28, [4] = 26, [8] = 26, [12] = 26 }, [5] = { [0] = 28, [4] = 26, [8] = 26, [12] = 26 }, [6] = { [0] = 28, [4] = 26, [8] = 26, [12] = 26 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 28, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 5, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 28, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 28, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 28, [4] = 24, [8] = 24, [12] = 24 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 29, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 29, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 29, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 29, [4] = 27, [8] = 27, [12] = 27 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 6, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 6, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 6, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 6, [4] = 5, [8] = 5, [12] = 5 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 7, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 6, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 7, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 7, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 7, [4] = 18, [8] = 18, [12] = 18 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 8, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 5, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 7, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 8, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 8, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 8, [4] = 24, [8] = 24, [12] = 24 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 } })[R[2]][game.initial_units()], ({ [0] = { [0] = 9, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 6, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 8, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 9, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 9, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 9, [4] = 28, [8] = 28, [12] = 28 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 10, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 7, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 9, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 10, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 10, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 10, [4] = 5, [8] = 5, [12] = 5 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 11, [4] = 6, [8] = 6, [12] = 6 }, [1] = { [0] = 8, [4] = 6, [8] = 6, [12] = 6 }, [2] = { [0] = 6, [4] = 6, [8] = 6, [12] = 6 }, [3] = { [0] = 10, [4] = 6, [8] = 6, [12] = 6 }, [4] = { [0] = 11, [4] = 6, [8] = 6, [12] = 6 }, [5] = { [0] = 11, [4] = 6, [8] = 6, [12] = 6 }, [6] = { [0] = 11, [4] = 6, [8] = 6, [12] = 6 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 12, [4] = 7, [8] = 7, [12] = 7 }, [1] = { [0] = 9, [4] = 7, [8] = 7, [12] = 7 }, [2] = { [0] = 7, [4] = 7, [8] = 7, [12] = 7 }, [3] = { [0] = 11, [4] = 7, [8] = 7, [12] = 7 }, [4] = { [0] = 12, [4] = 7, [8] = 7, [12] = 7 }, [5] = { [0] = 12, [4] = 7, [8] = 7, [12] = 7 }, [6] = { [0] = 12, [4] = 7, [8] = 7, [12] = 7 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 13, [4] = 8, [8] = 8, [12] = 8 }, [1] = { [0] = 10, [4] = 8, [8] = 8, [12] = 8 }, [2] = { [0] = 8, [4] = 8, [8] = 8, [12] = 8 }, [3] = { [0] = 12, [4] = 8, [8] = 8, [12] = 8 }, [4] = { [0] = 13, [4] = 8, [8] = 8, [12] = 8 }, [5] = { [0] = 13, [4] = 8, [8] = 8, [12] = 8 }, [6] = { [0] = 13, [4] = 8, [8] = 8, [12] = 8 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 14, [4] = 9, [8] = 9, [12] = 9 }, [1] = { [0] = 11, [4] = 9, [8] = 9, [12] = 9 }, [2] = { [0] = 9, [4] = 9, [8] = 9, [12] = 9 }, [3] = { [0] = 13, [4] = 9, [8] = 9, [12] = 9 }, [4] = { [0] = 14, [4] = 9, [8] = 9, [12] = 9 }, [5] = { [0] = 14, [4] = 9, [8] = 9, [12] = 9 }, [6] = { [0] = 14, [4] = 9, [8] = 9, [12] = 9 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 15, [4] = 10, [8] = 10, [12] = 10 }, [1] = { [0] = 12, [4] = 10, [8] = 10, [12] = 10 }, [2] = { [0] = 10, [4] = 10, [8] = 10, [12] = 10 }, [3] = { [0] = 14, [4] = 10, [8] = 10, [12] = 10 }, [4] = { [0] = 15, [4] = 10, [8] = 10, [12] = 10 }, [5] = { [0] = 15, [4] = 10, [8] = 10, [12] = 10 }, [6] = { [0] = 15, [4] = 10, [8] = 10, [12] = 10 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 16, [4] = 11, [8] = 11, [12] = 11 }, [1] = { [0] = 13, [4] = 11, [8] = 11, [12] = 11 }, [2] = { [0] = 11, [4] = 11, [8] = 11, [12] = 11 }, [3] = { [0] = 15, [4] = 11, [8] = 11, [12] = 11 }, [4] = { [0] = 16, [4] = 11, [8] = 11, [12] = 11 }, [5] = { [0] = 16, [4] = 11, [8] = 11, [12] = 11 }, [6] = { [0] = 16, [4] = 11, [8] = 11, [12] = 11 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 17, [4] = 12, [8] = 12, [12] = 12 }, [1] = { [0] = 14, [4] = 12, [8] = 12, [12] = 12 }, [2] = { [0] = 12, [4] = 12, [8] = 12, [12] = 12 }, [3] = { [0] = 16, [4] = 12, [8] = 12, [12] = 12 }, [4] = { [0] = 17, [4] = 12, [8] = 12, [12] = 12 }, [5] = { [0] = 17, [4] = 12, [8] = 12, [12] = 12 }, [6] = { [0] = 17, [4] = 12, [8] = 12, [12] = 12 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 18, [4] = 13, [8] = 13, [12] = 13 }, [1] = { [0] = 15, [4] = 13, [8] = 13, [12] = 13 }, [2] = { [0] = 13, [4] = 13, [8] = 13, [12] = 13 }, [3] = { [0] = 17, [4] = 13, [8] = 13, [12] = 13 }, [4] = { [0] = 18, [4] = 13, [8] = 13, [12] = 13 }, [5] = { [0] = 18, [4] = 13, [8] = 13, [12] = 13 }, [6] = { [0] = 18, [4] = 13, [8] = 13, [12] = 13 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 24, [4] = 14, [8] = 14, [12] = 14 }, [1] = { [0] = 16, [4] = 14, [8] = 14, [12] = 14 }, [2] = { [0] = 14, [4] = 14, [8] = 14, [12] = 14 }, [3] = { [0] = 18, [4] = 14, [8] = 14, [12] = 14 }, [4] = { [0] = 24, [4] = 14, [8] = 14, [12] = 14 }, [5] = { [0] = 24, [4] = 14, [8] = 14, [12] = 14 }, [6] = { [0] = 24, [4] = 14, [8] = 14, [12] = 14 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 25, [4] = 15, [8] = 15, [12] = 15 }, [1] = { [0] = 17, [4] = 15, [8] = 15, [12] = 15 }, [2] = { [0] = 15, [4] = 15, [8] = 15, [12] = 15 }, [3] = { [0] = 24, [4] = 15, [8] = 15, [12] = 15 }, [4] = { [0] = 25, [4] = 15, [8] = 15, [12] = 15 }, [5] = { [0] = 25, [4] = 15, [8] = 15, [12] = 15 }, [6] = { [0] = 25, [4] = 15, [8] = 15, [12] = 15 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 26, [4] = 16, [8] = 16, [12] = 16 }, [1] = { [0] = 18, [4] = 16, [8] = 16, [12] = 16 }, [2] = { [0] = 16, [4] = 16, [8] = 16, [12] = 16 }, [3] = { [0] = 25, [4] = 16, [8] = 16, [12] = 16 }, [4] = { [0] = 26, [4] = 16, [8] = 16, [12] = 16 }, [5] = { [0] = 26, [4] = 16, [8] = 16, [12] = 16 }, [6] = { [0] = 26, [4] = 16, [8] = 16, [12] = 16 } })[R[2]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 27, [4] = 17, [8] = 17, [12] = 17 }, [1] = { [0] = 24, [4] = 17, [8] = 17, [12] = 17 }, [2] = { [0] = 17, [4] = 17, [8] = 17, [12] = 17 }, [3] = { [0] = 26, [4] = 17, [8] = 17, [12] = 17 }, [4] = { [0] = 27, [4] = 17, [8] = 17, [12] = 17 }, [5] = { [0] = 27, [4] = 17, [8] = 17, [12] = 17 }, [6] = { [0] = 27, [4] = 17, [8] = 17, [12] = 17 } })[R[2]][game.initial_units()] })
      if R[2] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 2 then
        game.create_wall("Wall", { 29, 18 })
        game.create_wall("Wall", { 29, 24 })
        game.create_wall("Wall", { 29, 25 })
        game.create_wall("Wall", { 29, 26 })
        game.create_wall("Wall", { 29, 27 })
        game.create_wall("Wall", { 29, 28 })
      elseif R[2] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[2] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[2]", R[2])
      end
    else
      unseen("R[19]", R[19])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 48, [1] = 89, [2] = 24 })[R[19]], ({ [0] = 91, [1] = 20, [2] = 24 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[19] == 2 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { 5, 24 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    elseif R[19] == 0 or R[19] == 1 then
    else
      unseen("R[19]", R[19])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 46, [1] = 88, [2] = 22 })[R[19]], ({ [0] = 95, [1] = 13, [2] = 4 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[10] = game.rand(7)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 37, [1] = 41, [2] = 33, [3] = 37, [4] = 36, [5] = 33, [6] = 39 }, [1] = { [0] = 108, [1] = 112, [2] = 104, [3] = 108, [4] = 107, [5] = 104, [6] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 10, [3] = 14, [4] = 13, [5] = 10, [6] = 16 } })[R[19]][R[10]], ({ [0] = { [0] = 86, [1] = 86, [2] = 82, [3] = 85, [4] = 83, [5] = 80, [6] = 83 }, [1] = { [0] = 9, [1] = 9, [2] = 5, [3] = 8, [4] = 6, [5] = 3, [6] = 6 }, [2] = { [0] = 16, [1] = 16, [2] = 12, [3] = 15, [4] = 13, [5] = 10, [6] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 37, [1] = 41, [2] = 33, [3] = 37, [4] = 36, [5] = 33, [6] = 39 }, [1] = { [0] = 108, [1] = 112, [2] = 104, [3] = 108, [4] = 107, [5] = 104, [6] = 110 }, [2] = { [0] = 14, [1] = 18, [2] = 10, [3] = 14, [4] = 13, [5] = 10, [6] = 16 } })[R[19]][R[10]], ({ [0] = { [0] = 86, [1] = 86, [2] = 82, [3] = 85, [4] = 83, [5] = 80, [6] = 83 }, [1] = { [0] = 9, [1] = 9, [2] = 5, [3] = 8, [4] = 6, [5] = 3, [6] = 6 }, [2] = { [0] = 16, [1] = 16, [2] = 12, [3] = 15, [4] = 13, [5] = 10, [6] = 13 } })[R[19]][R[10]] })
    if R[10] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 34, [1] = 105, [2] = 11 })[R[19]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 39, [1] = 110, [2] = 16 })[R[19]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[19]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[19]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 42, [1] = 113, [2] = 19 })[R[19]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[19]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[19]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 4 or R[10] == 5 or R[10] == 6 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [4] = 33, [5] = 42, [6] = 33 }, [1] = { [4] = 104, [5] = 113, [6] = 104 }, [2] = { [4] = 10, [5] = 19, [6] = 10 } })[R[19]][R[10]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [4] = 41, [5] = 33, [6] = 41 }, [1] = { [4] = 112, [5] = 104, [6] = 112 }, [2] = { [4] = 18, [5] = 10, [6] = 18 } })[R[19]][R[10]], ({ [0] = { [4] = 84, [5] = 89, [6] = 89 }, [1] = { [4] = 7, [5] = 12, [6] = 12 }, [2] = { [4] = 14, [5] = 19, [6] = 19 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[19]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[19]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[19]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[10] == 4 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [4] = 41, [6] = 34 }, [1] = { [4] = 112, [6] = 105 }, [2] = { [4] = 18, [6] = 11 } })[R[19]][R[10]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 4 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[10] == 6 then
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [4] = 36, [6] = 38 }, [1] = { [4] = 107, [6] = 109 }, [2] = { [4] = 13, [6] = 15 } })[R[19]][R[10]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 4 then
        elseif R[10] == 6 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 39, [1] = 110, [2] = 16 })[R[19]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = { [4] = 86, [6] = 83 }, [1] = { [4] = 9, [6] = 6 }, [2] = { [4] = 16, [6] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[19]], ({ [0] = { [4] = 85, [6] = 84 }, [1] = { [4] = 8, [6] = 7 }, [2] = { [4] = 15, [6] = 14 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [4] = 37, [6] = 42 }, [1] = { [4] = 108, [6] = 113 }, [2] = { [4] = 14, [6] = 19 } })[R[19]][R[10]], ({ [0] = { [4] = 87, [6] = 84 }, [1] = { [4] = 10, [6] = 7 }, [2] = { [4] = 17, [6] = 14 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [4] = 43, [5] = 40, [6] = 36 }, [1] = { [4] = 114, [5] = 111, [6] = 107 }, [2] = { [4] = 20, [5] = 17, [6] = 13 } })[R[19]][R[10]], ({ [0] = { [4] = 82, [5] = 83, [6] = 81 }, [1] = { [4] = 5, [5] = 6, [6] = 4 }, [2] = { [4] = 12, [5] = 13, [6] = 11 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[19]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 1 or R[10] == 2 or R[10] == 3 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 34, [2] = 38, [3] = 34 }, [1] = { [1] = 105, [2] = 109, [3] = 105 }, [2] = { [1] = 11, [2] = 15, [3] = 11 } })[R[19]][R[10]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 34, [1] = 105, [2] = 11 })[R[19]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[19]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[19]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 42, [1] = 113, [2] = 19 })[R[19]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 79, [1] = 2, [2] = 9 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[19]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[19]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[19]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[19]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[19]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 34, [1] = 105, [2] = 11 })[R[19]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 42, [1] = 113, [2] = 19 })[R[19]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 39, [1] = 110, [2] = 16 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [1] = 42, [2] = 40, [3] = 37 }, [1] = { [1] = 113, [2] = 111, [3] = 108 }, [2] = { [1] = 19, [2] = 17, [3] = 14 } })[R[19]][R[10]], ({ [0] = { [1] = 91, [2] = 90, [3] = 80 }, [1] = { [1] = 14, [2] = 13, [3] = 3 }, [2] = { [1] = 21, [2] = 20, [3] = 10 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "Earthworker" })[R[10]], player = players[2], at = { ({ [0] = { [1] = 38, [2] = 41, [3] = 31 }, [1] = { [1] = 109, [2] = 112, [3] = 102 }, [2] = { [1] = 15, [2] = 18, [3] = 8 } })[R[19]][R[10]], ({ [0] = { [1] = 90, [2] = 91, [3] = 87 }, [1] = { [1] = 13, [2] = 14, [3] = 10 }, [2] = { [1] = 20, [2] = 21, [3] = 17 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[19]], ({ [0] = { [1] = 91, [2] = 87, [3] = 83 }, [1] = { [1] = 14, [2] = 10, [3] = 6 }, [2] = { [1] = 21, [2] = 17, [3] = 13 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[19]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[19]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 32, [1] = 103, [2] = 9 })[R[19]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 32, [1] = 103, [2] = 9 })[R[19]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[19]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[19]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[19]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[19]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 32, [1] = 103, [2] = 9 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[19]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[19]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 84, [1] = 7, [2] = 14 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[19]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 84, [1] = 7, [2] = 14 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 6 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[19]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[19]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "RoboMiner", [6] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 33, [1] = 38, [2] = 37, [3] = 35, [4] = 42, [5] = 37, [6] = 42 }, [1] = { [0] = 104, [1] = 109, [2] = 108, [3] = 106, [4] = 113, [5] = 108, [6] = 113 }, [2] = { [0] = 10, [1] = 15, [2] = 14, [3] = 12, [4] = 19, [5] = 14, [6] = 19 } })[R[19]][R[10]], ({ [0] = { [0] = 83, [1] = 81, [2] = 82, [3] = 91, [4] = 86, [5] = 85, [6] = 91 }, [1] = { [0] = 6, [1] = 4, [2] = 5, [3] = 14, [4] = 9, [5] = 8, [6] = 14 }, [2] = { [0] = 13, [1] = 11, [2] = 12, [3] = 21, [4] = 16, [5] = 15, [6] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "Earthworker", [6] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 34, [1] = 37, [2] = 36, [3] = 36, [4] = 43, [5] = 38, [6] = 43 }, [1] = { [0] = 105, [1] = 108, [2] = 107, [3] = 107, [4] = 114, [5] = 109, [6] = 114 }, [2] = { [0] = 11, [1] = 14, [2] = 13, [3] = 13, [4] = 20, [5] = 15, [6] = 20 } })[R[19]][R[10]], ({ [0] = { [0] = 83, [1] = 80, [2] = 81, [3] = 90, [4] = 85, [5] = 84, [6] = 91 }, [1] = { [0] = 6, [1] = 3, [2] = 4, [3] = 13, [4] = 8, [5] = 7, [6] = 14 }, [2] = { [0] = 13, [1] = 10, [2] = 11, [3] = 20, [4] = 15, [5] = 14, [6] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 14, [2] = 27 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 9 })[R[20]], ({ [0] = 98, [1] = 11, [2] = 28 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 10 })[R[20]], ({ [0] = 99, [1] = 12, [2] = 28 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 103, [2] = 9 }, [1] = { [0] = 37, [1] = 108, [2] = 14 }, [2] = { [0] = 42, [1] = 113, [2] = 19 } })[R[28]][R[19]], ({ [0] = { [0] = 79, [1] = 2, [2] = 9 }, [1] = { [0] = 82, [1] = 5, [2] = 12 }, [2] = { [0] = 88, [1] = 11, [2] = 18 } })[R[28]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[19]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[19]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[19]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[19]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[19]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[19]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[19]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[19]] })
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 41, [1] = 112, [2] = 18 }, [1] = { [0] = 33, [1] = 104, [2] = 10 }, [2] = { [0] = 37, [1] = 108, [2] = 14 } })[R[29]][R[19]], ({ [0] = { [0] = 79, [1] = 2, [2] = 9 }, [1] = { [0] = 84, [1] = 7, [2] = 14 }, [2] = { [0] = 89, [1] = 12, [2] = 19 } })[R[29]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 34, [1] = 105, [2] = 11 })[R[19]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[19]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[19]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 34, [1] = 105, [2] = 11 })[R[19]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[19]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[19]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[19]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[19]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[19]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[19]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 113, [2] = 19 }, [1] = { [0] = 38, [1] = 109, [2] = 15 }, [2] = { [0] = 34, [1] = 105, [2] = 11 } })[R[30]][R[19]], ({ [0] = { [0] = 90, [1] = 13, [2] = 20 }, [1] = { [0] = 84, [1] = 7, [2] = 14 }, [2] = { [0] = 79, [1] = 2, [2] = 9 } })[R[30]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 33, [1] = 104, [2] = 10 })[R[19]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[19]] })
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 14, [2] = 27 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 9 })[R[20]], ({ [0] = 98, [1] = 11, [2] = 28 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 33, [1] = 104, [2] = 10 })[R[19]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[19]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 41, [1] = 112, [2] = 18 }, [1] = { [0] = 42, [1] = 113, [2] = 19 }, [2] = { [0] = 38, [1] = 109, [2] = 15 } })[R[31]][R[19]], ({ [0] = { [0] = 79, [1] = 2, [2] = 9 }, [1] = { [0] = 85, [1] = 8, [2] = 15 }, [2] = { [0] = 89, [1] = 12, [2] = 19 } })[R[31]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 14, [2] = 27 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 9 })[R[20]], ({ [0] = 98, [1] = 11, [2] = 28 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 10 })[R[20]], ({ [0] = 99, [1] = 12, [2] = 28 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 38, [1] = 109, [2] = 15 }, [1] = { [0] = 32, [1] = 103, [2] = 9 }, [2] = { [0] = 32, [1] = 103, [2] = 9 } })[R[32]][R[19]], ({ [0] = { [0] = 90, [1] = 13, [2] = 20 }, [1] = { [0] = 85, [1] = 8, [2] = 15 }, [2] = { [0] = 80, [1] = 3, [2] = 10 } })[R[32]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 14, [2] = 27 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 9 })[R[20]], ({ [0] = 98, [1] = 11, [2] = 28 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 10 })[R[20]], ({ [0] = 99, [1] = 12, [2] = 28 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 42, [1] = 113, [2] = 19 }, [1] = { [0] = 41, [1] = 112, [2] = 18 }, [2] = { [0] = 38, [1] = 109, [2] = 15 } })[R[33]][R[19]], ({ [0] = { [0] = 80, [1] = 3, [2] = 10 }, [1] = { [0] = 86, [1] = 9, [2] = 16 }, [2] = { [0] = 87, [1] = 10, [2] = 17 } })[R[33]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        game.create_wall("Wall", { ({ [0] = 39, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 12, [2] = 25 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 40, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 13, [2] = 26 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 41, [1] = 85, [2] = 9 })[R[20]], ({ [0] = 114, [1] = 14, [2] = 27 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 9 })[R[20]], ({ [0] = 98, [1] = 11, [2] = 28 })[R[20]] })
        game.create_wall("Wall", { ({ [0] = 43, [1] = 86, [2] = 10 })[R[20]], ({ [0] = 99, [1] = 12, [2] = 28 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 107, [2] = 13 }, [1] = { [0] = 32, [1] = 103, [2] = 9 }, [2] = { [0] = 42, [1] = 113, [2] = 19 } })[R[34]][R[19]], ({ [0] = { [0] = 89, [1] = 12, [2] = 19 }, [1] = { [0] = 85, [1] = 8, [2] = 15 }, [2] = { [0] = 80, [1] = 3, [2] = 10 } })[R[34]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 41, 114 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 39, 114 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 39, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 85, 12 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 9, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 9, 25 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 10, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 40, 114 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 40, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 85, 13 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 13 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 9, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 9, 26 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 99 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 41, 114 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 41, 114 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 85, 14 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 85, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 9, 27 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 27 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 43, 98 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 86, 11 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 11 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 9, 28 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 9, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 43, 99 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 99 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 86, 12 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 12 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 10, 28 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 10, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 43, 100 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 43, 100 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 86, 14 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 14 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 11, 28 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 11, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 44, 98 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 44, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 86, 15 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 15 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 12, 28 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 12, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 45, 98 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 45, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 86, 19 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 13, 28 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 13, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 46, 97 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 86, 20 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 20 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 14, 28 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 14, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 46, 98 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 46, 98 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 86, 21 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 21 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 15, 28 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 15, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 47, 97 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 47, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 86, 22 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 27 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 16, 28 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 27 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 27 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 27 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 16, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 90 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 48, 95 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 95 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 19 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 86, 23 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 86, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 25 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 17, 28 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 27 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 17, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 91 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 48, 97 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 96 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 49, 97 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 48, 97 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 87, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 87, 18 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 23 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 18 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 19, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 26 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 18, 24 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 18, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 19, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 19, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 19, 24 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 18, 24 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    if R[20] == 0 then
      game.create_wall("Wall", { ({ [0] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 }, [1] = { [0] = 95, [4] = 90, [8] = 90, [12] = 90 }, [2] = { [0] = 90, [4] = 90, [8] = 90, [12] = 90 }, [3] = { [0] = 97, [4] = 90, [8] = 90, [12] = 90 }, [4] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 }, [5] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 }, [6] = { [0] = 92, [4] = 90, [8] = 90, [12] = 90 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [1] = { [0] = 96, [4] = 91, [8] = 91, [12] = 91 }, [2] = { [0] = 91, [4] = 91, [8] = 91, [12] = 91 }, [3] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [4] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [5] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 }, [6] = { [0] = 92, [4] = 91, [8] = 91, [12] = 91 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 }, [1] = { [0] = 97, [4] = 95, [8] = 95, [12] = 95 }, [2] = { [0] = 95, [4] = 95, [8] = 95, [12] = 95 }, [3] = { [0] = 92, [4] = 95, [8] = 95, [12] = 95 }, [4] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 }, [5] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 }, [6] = { [0] = 87, [4] = 95, [8] = 95, [12] = 95 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 50, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 }, [1] = { [0] = 92, [4] = 96, [8] = 96, [12] = 96 }, [2] = { [0] = 96, [4] = 96, [8] = 96, [12] = 96 }, [3] = { [0] = 87, [4] = 96, [8] = 96, [12] = 96 }, [4] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 }, [5] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 }, [6] = { [0] = 88, [4] = 96, [8] = 96, [12] = 96 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [1] = { [0] = 51, [4] = 49, [8] = 49, [12] = 49 }, [2] = { [0] = 49, [4] = 49, [8] = 49, [12] = 49 }, [3] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [4] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [5] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 }, [6] = { [0] = 52, [4] = 49, [8] = 49, [12] = 49 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 }, [1] = { [0] = 92, [4] = 97, [8] = 97, [12] = 97 }, [2] = { [0] = 97, [4] = 97, [8] = 97, [12] = 97 }, [3] = { [0] = 88, [4] = 97, [8] = 97, [12] = 97 }, [4] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 }, [5] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 }, [6] = { [0] = 89, [4] = 97, [8] = 97, [12] = 97 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [1] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [2] = { [0] = 50, [4] = 50, [8] = 50, [12] = 50 }, [3] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [4] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [5] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 }, [6] = { [0] = 52, [4] = 50, [8] = 50, [12] = 50 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [1] = { [0] = 87, [4] = 92, [8] = 92, [12] = 92 }, [2] = { [0] = 92, [4] = 92, [8] = 92, [12] = 92 }, [3] = { [0] = 89, [4] = 92, [8] = 92, [12] = 92 }, [4] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [5] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [6] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [1] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [2] = { [0] = 51, [4] = 51, [8] = 51, [12] = 51 }, [3] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [4] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [5] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 }, [6] = { [0] = 52, [4] = 51, [8] = 51, [12] = 51 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 }, [1] = { [0] = 88, [4] = 92, [8] = 92, [12] = 92 }, [2] = { [0] = 92, [4] = 92, [8] = 92, [12] = 92 }, [3] = { [0] = 90, [4] = 92, [8] = 92, [12] = 92 }, [4] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 }, [5] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 }, [6] = { [0] = 91, [4] = 92, [8] = 92, [12] = 92 } })[R[10]][game.initial_units()] })
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 52, 87 })
        game.create_wall("Wall", { 52, 88 })
        game.create_wall("Wall", { 52, 89 })
        game.create_wall("Wall", { 52, 90 })
        game.create_wall("Wall", { 52, 91 })
        game.create_wall("Wall", { 52, 92 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 52, 92 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 52, 87 })
          game.create_wall("Wall", { 52, 88 })
          game.create_wall("Wall", { 52, 89 })
          game.create_wall("Wall", { 52, 90 })
          game.create_wall("Wall", { 52, 91 })
          game.create_wall("Wall", { 52, 92 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 1 then
      if R[10] == 0 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 87, 19 })
        game.create_wall("Wall", { 87, 23 })
        game.create_wall("Wall", { 88, 22 })
        game.create_wall("Wall", { 88, 23 })
        game.create_wall("Wall", { 89, 22 })
      elseif R[10] == 3 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 87, 19 })
          game.create_wall("Wall", { 87, 23 })
          game.create_wall("Wall", { 88, 22 })
          game.create_wall("Wall", { 88, 23 })
          game.create_wall("Wall", { 89, 22 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[20] == 2 then
      game.create_wall("Wall", { ({ [0] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 19, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 25, [8] = 25, [12] = 25 }, [1] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [2] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [3] = { [0] = 24, [4] = 25, [8] = 25, [12] = 25 }, [4] = { [0] = 5, [4] = 25, [8] = 25, [12] = 25 }, [5] = { [0] = 5, [4] = 25, [8] = 25, [12] = 25 }, [6] = { [0] = 5, [4] = 25, [8] = 25, [12] = 25 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [1] = { [0] = 28, [4] = 26, [8] = 26, [12] = 26 }, [2] = { [0] = 26, [4] = 26, [8] = 26, [12] = 26 }, [3] = { [0] = 5, [4] = 26, [8] = 26, [12] = 26 }, [4] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [5] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [6] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 19, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 24, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 25, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 25, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 25, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 25, [4] = 18, [8] = 18, [12] = 18 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 25, [4] = 19, [8] = 19, [12] = 19 }, [1] = { [0] = 24, [4] = 19, [8] = 19, [12] = 19 }, [2] = { [0] = 19, [4] = 19, [8] = 19, [12] = 19 }, [3] = { [0] = 25, [4] = 19, [8] = 19, [12] = 19 }, [4] = { [0] = 25, [4] = 19, [8] = 19, [12] = 19 }, [5] = { [0] = 25, [4] = 19, [8] = 19, [12] = 19 }, [6] = { [0] = 25, [4] = 19, [8] = 19, [12] = 19 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 18, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 27, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 5, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 18, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 18, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 18, [4] = 24, [8] = 24, [12] = 24 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 19, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 28, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 19, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 19, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 19, [4] = 5, [8] = 5, [12] = 5 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 5, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 19, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 26, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 25, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 26, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 26, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 26, [4] = 24, [8] = 24, [12] = 24 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [1] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [2] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [3] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [4] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [5] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [6] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 19, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [1] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [2] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [3] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [4] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [5] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [6] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [1] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [2] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [3] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [4] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [5] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [6] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 19, [8] = 19, [12] = 19 }, [1] = { [0] = 5, [4] = 19, [8] = 19, [12] = 19 }, [2] = { [0] = 19, [4] = 19, [8] = 19, [12] = 19 }, [3] = { [0] = 28, [4] = 19, [8] = 19, [12] = 19 }, [4] = { [0] = 5, [4] = 19, [8] = 19, [12] = 19 }, [5] = { [0] = 5, [4] = 19, [8] = 19, [12] = 19 }, [6] = { [0] = 5, [4] = 19, [8] = 19, [12] = 19 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [1] = { [0] = 26, [4] = 25, [8] = 25, [12] = 25 }, [2] = { [0] = 25, [4] = 25, [8] = 25, [12] = 25 }, [3] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [4] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [5] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 }, [6] = { [0] = 27, [4] = 25, [8] = 25, [12] = 25 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [1] = { [0] = 26, [4] = 26, [8] = 26, [12] = 26 }, [2] = { [0] = 26, [4] = 26, [8] = 26, [12] = 26 }, [3] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [4] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [5] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [6] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 28, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [1] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [2] = { [0] = 26, [4] = 26, [8] = 26, [12] = 26 }, [3] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [4] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [5] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [6] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 5, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 28, [4] = 26, [8] = 26, [12] = 26 }, [1] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [2] = { [0] = 26, [4] = 26, [8] = 26, [12] = 26 }, [3] = { [0] = 27, [4] = 26, [8] = 26, [12] = 26 }, [4] = { [0] = 28, [4] = 26, [8] = 26, [12] = 26 }, [5] = { [0] = 28, [4] = 26, [8] = 26, [12] = 26 }, [6] = { [0] = 28, [4] = 26, [8] = 26, [12] = 26 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 18, [4] = 5, [8] = 5, [12] = 5 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 24, [4] = 18, [8] = 18, [12] = 18 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 28, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 5, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 28, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 28, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 28, [4] = 24, [8] = 24, [12] = 24 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 29, [4] = 27, [8] = 27, [12] = 27 }, [1] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [2] = { [0] = 27, [4] = 27, [8] = 27, [12] = 27 }, [3] = { [0] = 28, [4] = 27, [8] = 27, [12] = 27 }, [4] = { [0] = 29, [4] = 27, [8] = 27, [12] = 27 }, [5] = { [0] = 29, [4] = 27, [8] = 27, [12] = 27 }, [6] = { [0] = 29, [4] = 27, [8] = 27, [12] = 27 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 18, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 5, [4] = 28, [8] = 28, [12] = 28 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 6, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 24, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 6, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 6, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 6, [4] = 5, [8] = 5, [12] = 5 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 7, [4] = 18, [8] = 18, [12] = 18 }, [1] = { [0] = 28, [4] = 18, [8] = 18, [12] = 18 }, [2] = { [0] = 18, [4] = 18, [8] = 18, [12] = 18 }, [3] = { [0] = 6, [4] = 18, [8] = 18, [12] = 18 }, [4] = { [0] = 7, [4] = 18, [8] = 18, [12] = 18 }, [5] = { [0] = 7, [4] = 18, [8] = 18, [12] = 18 }, [6] = { [0] = 7, [4] = 18, [8] = 18, [12] = 18 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 8, [4] = 24, [8] = 24, [12] = 24 }, [1] = { [0] = 5, [4] = 24, [8] = 24, [12] = 24 }, [2] = { [0] = 24, [4] = 24, [8] = 24, [12] = 24 }, [3] = { [0] = 7, [4] = 24, [8] = 24, [12] = 24 }, [4] = { [0] = 8, [4] = 24, [8] = 24, [12] = 24 }, [5] = { [0] = 8, [4] = 24, [8] = 24, [12] = 24 }, [6] = { [0] = 8, [4] = 24, [8] = 24, [12] = 24 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { ({ [0] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 29, [4] = 28, [8] = 28, [12] = 28 } })[R[10]][game.initial_units()], ({ [0] = { [0] = 9, [4] = 28, [8] = 28, [12] = 28 }, [1] = { [0] = 6, [4] = 28, [8] = 28, [12] = 28 }, [2] = { [0] = 28, [4] = 28, [8] = 28, [12] = 28 }, [3] = { [0] = 8, [4] = 28, [8] = 28, [12] = 28 }, [4] = { [0] = 9, [4] = 28, [8] = 28, [12] = 28 }, [5] = { [0] = 9, [4] = 28, [8] = 28, [12] = 28 }, [6] = { [0] = 9, [4] = 28, [8] = 28, [12] = 28 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 10, [4] = 5, [8] = 5, [12] = 5 }, [1] = { [0] = 7, [4] = 5, [8] = 5, [12] = 5 }, [2] = { [0] = 5, [4] = 5, [8] = 5, [12] = 5 }, [3] = { [0] = 9, [4] = 5, [8] = 5, [12] = 5 }, [4] = { [0] = 10, [4] = 5, [8] = 5, [12] = 5 }, [5] = { [0] = 10, [4] = 5, [8] = 5, [12] = 5 }, [6] = { [0] = 10, [4] = 5, [8] = 5, [12] = 5 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 11, [4] = 6, [8] = 6, [12] = 6 }, [1] = { [0] = 8, [4] = 6, [8] = 6, [12] = 6 }, [2] = { [0] = 6, [4] = 6, [8] = 6, [12] = 6 }, [3] = { [0] = 10, [4] = 6, [8] = 6, [12] = 6 }, [4] = { [0] = 11, [4] = 6, [8] = 6, [12] = 6 }, [5] = { [0] = 11, [4] = 6, [8] = 6, [12] = 6 }, [6] = { [0] = 11, [4] = 6, [8] = 6, [12] = 6 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 12, [4] = 7, [8] = 7, [12] = 7 }, [1] = { [0] = 9, [4] = 7, [8] = 7, [12] = 7 }, [2] = { [0] = 7, [4] = 7, [8] = 7, [12] = 7 }, [3] = { [0] = 11, [4] = 7, [8] = 7, [12] = 7 }, [4] = { [0] = 12, [4] = 7, [8] = 7, [12] = 7 }, [5] = { [0] = 12, [4] = 7, [8] = 7, [12] = 7 }, [6] = { [0] = 12, [4] = 7, [8] = 7, [12] = 7 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 13, [4] = 8, [8] = 8, [12] = 8 }, [1] = { [0] = 10, [4] = 8, [8] = 8, [12] = 8 }, [2] = { [0] = 8, [4] = 8, [8] = 8, [12] = 8 }, [3] = { [0] = 12, [4] = 8, [8] = 8, [12] = 8 }, [4] = { [0] = 13, [4] = 8, [8] = 8, [12] = 8 }, [5] = { [0] = 13, [4] = 8, [8] = 8, [12] = 8 }, [6] = { [0] = 13, [4] = 8, [8] = 8, [12] = 8 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 14, [4] = 9, [8] = 9, [12] = 9 }, [1] = { [0] = 11, [4] = 9, [8] = 9, [12] = 9 }, [2] = { [0] = 9, [4] = 9, [8] = 9, [12] = 9 }, [3] = { [0] = 13, [4] = 9, [8] = 9, [12] = 9 }, [4] = { [0] = 14, [4] = 9, [8] = 9, [12] = 9 }, [5] = { [0] = 14, [4] = 9, [8] = 9, [12] = 9 }, [6] = { [0] = 14, [4] = 9, [8] = 9, [12] = 9 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 15, [4] = 10, [8] = 10, [12] = 10 }, [1] = { [0] = 12, [4] = 10, [8] = 10, [12] = 10 }, [2] = { [0] = 10, [4] = 10, [8] = 10, [12] = 10 }, [3] = { [0] = 14, [4] = 10, [8] = 10, [12] = 10 }, [4] = { [0] = 15, [4] = 10, [8] = 10, [12] = 10 }, [5] = { [0] = 15, [4] = 10, [8] = 10, [12] = 10 }, [6] = { [0] = 15, [4] = 10, [8] = 10, [12] = 10 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 16, [4] = 11, [8] = 11, [12] = 11 }, [1] = { [0] = 13, [4] = 11, [8] = 11, [12] = 11 }, [2] = { [0] = 11, [4] = 11, [8] = 11, [12] = 11 }, [3] = { [0] = 15, [4] = 11, [8] = 11, [12] = 11 }, [4] = { [0] = 16, [4] = 11, [8] = 11, [12] = 11 }, [5] = { [0] = 16, [4] = 11, [8] = 11, [12] = 11 }, [6] = { [0] = 16, [4] = 11, [8] = 11, [12] = 11 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 17, [4] = 12, [8] = 12, [12] = 12 }, [1] = { [0] = 14, [4] = 12, [8] = 12, [12] = 12 }, [2] = { [0] = 12, [4] = 12, [8] = 12, [12] = 12 }, [3] = { [0] = 16, [4] = 12, [8] = 12, [12] = 12 }, [4] = { [0] = 17, [4] = 12, [8] = 12, [12] = 12 }, [5] = { [0] = 17, [4] = 12, [8] = 12, [12] = 12 }, [6] = { [0] = 17, [4] = 12, [8] = 12, [12] = 12 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 18, [4] = 13, [8] = 13, [12] = 13 }, [1] = { [0] = 15, [4] = 13, [8] = 13, [12] = 13 }, [2] = { [0] = 13, [4] = 13, [8] = 13, [12] = 13 }, [3] = { [0] = 17, [4] = 13, [8] = 13, [12] = 13 }, [4] = { [0] = 18, [4] = 13, [8] = 13, [12] = 13 }, [5] = { [0] = 18, [4] = 13, [8] = 13, [12] = 13 }, [6] = { [0] = 18, [4] = 13, [8] = 13, [12] = 13 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 24, [4] = 14, [8] = 14, [12] = 14 }, [1] = { [0] = 16, [4] = 14, [8] = 14, [12] = 14 }, [2] = { [0] = 14, [4] = 14, [8] = 14, [12] = 14 }, [3] = { [0] = 18, [4] = 14, [8] = 14, [12] = 14 }, [4] = { [0] = 24, [4] = 14, [8] = 14, [12] = 14 }, [5] = { [0] = 24, [4] = 14, [8] = 14, [12] = 14 }, [6] = { [0] = 24, [4] = 14, [8] = 14, [12] = 14 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 25, [4] = 15, [8] = 15, [12] = 15 }, [1] = { [0] = 17, [4] = 15, [8] = 15, [12] = 15 }, [2] = { [0] = 15, [4] = 15, [8] = 15, [12] = 15 }, [3] = { [0] = 24, [4] = 15, [8] = 15, [12] = 15 }, [4] = { [0] = 25, [4] = 15, [8] = 15, [12] = 15 }, [5] = { [0] = 25, [4] = 15, [8] = 15, [12] = 15 }, [6] = { [0] = 25, [4] = 15, [8] = 15, [12] = 15 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 26, [4] = 16, [8] = 16, [12] = 16 }, [1] = { [0] = 18, [4] = 16, [8] = 16, [12] = 16 }, [2] = { [0] = 16, [4] = 16, [8] = 16, [12] = 16 }, [3] = { [0] = 25, [4] = 16, [8] = 16, [12] = 16 }, [4] = { [0] = 26, [4] = 16, [8] = 16, [12] = 16 }, [5] = { [0] = 26, [4] = 16, [8] = 16, [12] = 16 }, [6] = { [0] = 26, [4] = 16, [8] = 16, [12] = 16 } })[R[10]][game.initial_units()] })
      game.create_wall("Wall", { 29, ({ [0] = { [0] = 27, [4] = 17, [8] = 17, [12] = 17 }, [1] = { [0] = 24, [4] = 17, [8] = 17, [12] = 17 }, [2] = { [0] = 17, [4] = 17, [8] = 17, [12] = 17 }, [3] = { [0] = 26, [4] = 17, [8] = 17, [12] = 17 }, [4] = { [0] = 27, [4] = 17, [8] = 17, [12] = 17 }, [5] = { [0] = 27, [4] = 17, [8] = 17, [12] = 17 }, [6] = { [0] = 27, [4] = 17, [8] = 17, [12] = 17 } })[R[10]][game.initial_units()] })
      if R[10] == 0 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 2 then
        game.create_wall("Wall", { 29, 18 })
        game.create_wall("Wall", { 29, 24 })
        game.create_wall("Wall", { 29, 25 })
        game.create_wall("Wall", { 29, 26 })
        game.create_wall("Wall", { 29, 27 })
        game.create_wall("Wall", { 29, 28 })
      elseif R[10] == 3 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 4 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 5 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif R[10] == 6 then
        if game.initial_units() == 0 then
          game.create_wall("Wall", { 29, 28 })
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          game.create_wall("Wall", { 29, 18 })
          game.create_wall("Wall", { 29, 24 })
          game.create_wall("Wall", { 29, 25 })
          game.create_wall("Wall", { 29, 26 })
          game.create_wall("Wall", { 29, 27 })
          game.create_wall("Wall", { 29, 28 })
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[20]", R[20])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 48, [1] = 89, [2] = 24 })[R[20]], ({ [0] = 91, [1] = 20, [2] = 24 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[20] == 0 or R[20] == 1 then
    elseif R[20] == 2 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { 5, 24 }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[20]", R[20])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 46, [1] = 88, [2] = 22 })[R[20]], ({ [0] = 95, [1] = 13, [2] = 4 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[35] = game.rand(7)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 37, [1] = 108, [2] = 14 }, [1] = { [0] = 41, [1] = 112, [2] = 18 }, [2] = { [0] = 33, [1] = 104, [2] = 10 }, [3] = { [0] = 37, [1] = 108, [2] = 14 }, [4] = { [0] = 36, [1] = 107, [2] = 13 }, [5] = { [0] = 33, [1] = 104, [2] = 10 }, [6] = { [0] = 39, [1] = 110, [2] = 16 } })[R[35]][R[20]], ({ [0] = { [0] = 86, [1] = 9, [2] = 16 }, [1] = { [0] = 86, [1] = 9, [2] = 16 }, [2] = { [0] = 82, [1] = 5, [2] = 12 }, [3] = { [0] = 85, [1] = 8, [2] = 15 }, [4] = { [0] = 83, [1] = 6, [2] = 13 }, [5] = { [0] = 80, [1] = 3, [2] = 10 }, [6] = { [0] = 83, [1] = 6, [2] = 13 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 37, [1] = 108, [2] = 14 }, [1] = { [0] = 41, [1] = 112, [2] = 18 }, [2] = { [0] = 33, [1] = 104, [2] = 10 }, [3] = { [0] = 37, [1] = 108, [2] = 14 }, [4] = { [0] = 36, [1] = 107, [2] = 13 }, [5] = { [0] = 33, [1] = 104, [2] = 10 }, [6] = { [0] = 39, [1] = 110, [2] = 16 } })[R[35]][R[20]], ({ [0] = { [0] = 86, [1] = 9, [2] = 16 }, [1] = { [0] = 86, [1] = 9, [2] = 16 }, [2] = { [0] = 82, [1] = 5, [2] = 12 }, [3] = { [0] = 85, [1] = 8, [2] = 15 }, [4] = { [0] = 83, [1] = 6, [2] = 13 }, [5] = { [0] = 80, [1] = 3, [2] = 10 }, [6] = { [0] = 83, [1] = 6, [2] = 13 } })[R[35]][R[20]] })
    if R[35] == 4 or R[35] == 5 or R[35] == 6 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [4] = { [0] = 33, [1] = 104, [2] = 10 }, [5] = { [0] = 42, [1] = 113, [2] = 19 }, [6] = { [0] = 33, [1] = 104, [2] = 10 } })[R[35]][R[20]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [4] = { [0] = 41, [1] = 112, [2] = 18 }, [5] = { [0] = 33, [1] = 104, [2] = 10 }, [6] = { [0] = 41, [1] = 112, [2] = 18 } })[R[35]][R[20]], ({ [4] = { [0] = 84, [1] = 7, [2] = 14 }, [5] = { [0] = 89, [1] = 12, [2] = 19 }, [6] = { [0] = 89, [1] = 12, [2] = 19 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[35] == 5 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[20]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[20]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[20]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[35] == 4 or R[35] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [4] = { [0] = 41, [1] = 112, [2] = 18 }, [6] = { [0] = 34, [1] = 105, [2] = 11 } })[R[35]][R[20]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[35] == 4 then
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
        elseif R[35] == 6 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[20]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[20]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[20]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[35]", R[35])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [4] = { [0] = 40, [1] = 111, [2] = 17 }, [6] = { [0] = 39, [1] = 110, [2] = 16 } })[R[35]][R[20]], ({ [4] = { [0] = 88, [1] = 11, [2] = 18 }, [6] = { [0] = 86, [1] = 9, [2] = 16 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[35] == 6 then
        elseif R[35] == 4 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[35]", R[35])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [4] = { [0] = 86, [1] = 9, [2] = 16 }, [6] = { [0] = 83, [1] = 6, [2] = 13 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[20]], ({ [4] = { [0] = 85, [1] = 8, [2] = 15 }, [6] = { [0] = 84, [1] = 7, [2] = 14 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [4] = { [0] = 37, [1] = 108, [2] = 14 }, [6] = { [0] = 42, [1] = 113, [2] = 19 } })[R[35]][R[20]], ({ [4] = { [0] = 87, [1] = 10, [2] = 17 }, [6] = { [0] = 84, [1] = 7, [2] = 14 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[35]", R[35])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [4] = { [0] = 43, [1] = 114, [2] = 20 }, [5] = { [0] = 40, [1] = 111, [2] = 17 }, [6] = { [0] = 36, [1] = 107, [2] = 13 } })[R[35]][R[20]], ({ [4] = { [0] = 82, [1] = 5, [2] = 12 }, [5] = { [0] = 83, [1] = 6, [2] = 13 }, [6] = { [0] = 81, [1] = 4, [2] = 11 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[35] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[20]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[35] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[20]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[20]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[35] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[35]", R[35])
      end
    elseif R[35] == 1 or R[35] == 2 or R[35] == 3 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 34, [1] = 105, [2] = 11 }, [2] = { [0] = 38, [1] = 109, [2] = 15 }, [3] = { [0] = 34, [1] = 105, [2] = 11 } })[R[35]][R[20]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[35] == 1 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[20]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[20]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[20]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[20]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[35] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 34, [1] = 105, [2] = 11 })[R[20]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[20]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[20]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 42, [1] = 113, [2] = 19 })[R[20]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 79, [1] = 2, [2] = 9 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[35] == 2 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[20]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[20]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 34, [1] = 105, [2] = 11 })[R[20]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 42, [1] = 113, [2] = 19 })[R[20]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 39, [1] = 110, [2] = 16 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[35]", R[35])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "RoboMiner" })[R[35]], player = players[3], at = { ({ [1] = { [0] = 42, [1] = 113, [2] = 19 }, [2] = { [0] = 40, [1] = 111, [2] = 17 }, [3] = { [0] = 37, [1] = 108, [2] = 14 } })[R[35]][R[20]], ({ [1] = { [0] = 91, [1] = 14, [2] = 21 }, [2] = { [0] = 90, [1] = 13, [2] = 20 }, [3] = { [0] = 80, [1] = 3, [2] = 10 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "Earthworker" })[R[35]], player = players[3], at = { ({ [1] = { [0] = 38, [1] = 109, [2] = 15 }, [2] = { [0] = 41, [1] = 112, [2] = 18 }, [3] = { [0] = 31, [1] = 102, [2] = 8 } })[R[35]][R[20]], ({ [1] = { [0] = 90, [1] = 13, [2] = 20 }, [2] = { [0] = 91, [1] = 14, [2] = 21 }, [3] = { [0] = 87, [1] = 10, [2] = 17 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[20]], ({ [1] = { [0] = 91, [1] = 14, [2] = 21 }, [2] = { [0] = 87, [1] = 10, [2] = 17 }, [3] = { [0] = 83, [1] = 6, [2] = 13 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[35] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[35] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[20]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[35] == 3 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[20]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[35]", R[35])
      end
    elseif R[35] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 34, [1] = 105, [2] = 11 })[R[20]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 39, [1] = 110, [2] = 16 })[R[20]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 33, [1] = 104, [2] = 10 })[R[20]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[20]], ({ [0] = 86, [1] = 9, [2] = 16 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 42, [1] = 113, [2] = 19 })[R[20]], ({ [0] = 80, [1] = 3, [2] = 10 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 41, [1] = 112, [2] = 18 })[R[20]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[20]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[35]", R[35])
    end
    U[#U]:set_lights(true)
    if R[35] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 32, [1] = 103, [2] = 9 })[R[20]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 32, [1] = 103, [2] = 9 })[R[20]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[35] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[20]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 37, [1] = 108, [2] = 14 })[R[20]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[35] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[20]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[35] == 3 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[20]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 32, [1] = 103, [2] = 9 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[35] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[20]], ({ [0] = 82, [1] = 5, [2] = 12 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[20]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[35] == 5 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 40, [1] = 111, [2] = 17 })[R[20]], ({ [0] = 83, [1] = 6, [2] = 13 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 35, [1] = 106, [2] = 12 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 90, [1] = 13, [2] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 84, [1] = 7, [2] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 38, [1] = 109, [2] = 15 })[R[20]], ({ [0] = 91, [1] = 14, [2] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 84, [1] = 7, [2] = 14 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[35] == 6 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 36, [1] = 107, [2] = 13 })[R[20]], ({ [0] = 81, [1] = 4, [2] = 11 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 43, [1] = 114, [2] = 20 })[R[20]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[35]", R[35])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "RoboMiner", [6] = "CargoTruck" })[R[35]], player = players[3], at = { ({ [0] = { [0] = 33, [1] = 104, [2] = 10 }, [1] = { [0] = 38, [1] = 109, [2] = 15 }, [2] = { [0] = 37, [1] = 108, [2] = 14 }, [3] = { [0] = 35, [1] = 106, [2] = 12 }, [4] = { [0] = 42, [1] = 113, [2] = 19 }, [5] = { [0] = 37, [1] = 108, [2] = 14 }, [6] = { [0] = 42, [1] = 113, [2] = 19 } })[R[35]][R[20]], ({ [0] = { [0] = 83, [1] = 6, [2] = 13 }, [1] = { [0] = 81, [1] = 4, [2] = 11 }, [2] = { [0] = 82, [1] = 5, [2] = 12 }, [3] = { [0] = 91, [1] = 14, [2] = 21 }, [4] = { [0] = 86, [1] = 9, [2] = 16 }, [5] = { [0] = 85, [1] = 8, [2] = 15 }, [6] = { [0] = 91, [1] = 14, [2] = 21 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "CargoTruck", [4] = "CargoTruck", [5] = "Earthworker", [6] = "CargoTruck" })[R[35]], player = players[3], at = { ({ [0] = { [0] = 34, [1] = 105, [2] = 11 }, [1] = { [0] = 37, [1] = 108, [2] = 14 }, [2] = { [0] = 36, [1] = 107, [2] = 13 }, [3] = { [0] = 36, [1] = 107, [2] = 13 }, [4] = { [0] = 43, [1] = 114, [2] = 20 }, [5] = { [0] = 38, [1] = 109, [2] = 15 }, [6] = { [0] = 43, [1] = 114, [2] = 20 } })[R[35]][R[20]], ({ [0] = { [0] = 83, [1] = 6, [2] = 13 }, [1] = { [0] = 80, [1] = 3, [2] = 10 }, [2] = { [0] = 81, [1] = 4, [2] = 11 }, [3] = { [0] = 90, [1] = 13, [2] = 20 }, [4] = { [0] = 85, [1] = 8, [2] = 15 }, [5] = { [0] = 84, [1] = 7, [2] = 14 }, [6] = { [0] = 91, [1] = 14, [2] = 21 } })[R[35]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[35] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 32, [1] = 103, [2] = 9 }, [1] = { [0] = 37, [1] = 108, [2] = 14 }, [2] = { [0] = 42, [1] = 113, [2] = 19 } })[R[36]][R[20]], ({ [0] = { [0] = 79, [1] = 2, [2] = 9 }, [1] = { [0] = 82, [1] = 5, [2] = 12 }, [2] = { [0] = 88, [1] = 11, [2] = 18 } })[R[36]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[20]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[20]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[20]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[20]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[20]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[20]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[20]] })
        for i = 1, game.initial_units() do
          R[37] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 41, [1] = 112, [2] = 18 }, [1] = { [0] = 33, [1] = 104, [2] = 10 }, [2] = { [0] = 37, [1] = 108, [2] = 14 } })[R[37]][R[20]], ({ [0] = { [0] = 79, [1] = 2, [2] = 9 }, [1] = { [0] = 84, [1] = 7, [2] = 14 }, [2] = { [0] = 89, [1] = 12, [2] = 19 } })[R[37]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 34, [1] = 105, [2] = 11 })[R[20]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[20]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[20]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[20]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[20]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[20]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 42, [1] = 113, [2] = 19 }, [1] = { [0] = 38, [1] = 109, [2] = 15 }, [2] = { [0] = 34, [1] = 105, [2] = 11 } })[R[38]][R[20]], ({ [0] = { [0] = 90, [1] = 13, [2] = 20 }, [1] = { [0] = 84, [1] = 7, [2] = 14 }, [2] = { [0] = 79, [1] = 2, [2] = 9 } })[R[38]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 34, [1] = 105, [2] = 11 })[R[20]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 37, [1] = 108, [2] = 14 })[R[20]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 38, [1] = 109, [2] = 15 })[R[20]], ({ [0] = 85, [1] = 8, [2] = 15 })[R[20]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[20]], ({ [0] = 88, [1] = 11, [2] = 18 })[R[20]] })
        game.create_tube({ ({ [0] = 40, [1] = 111, [2] = 17 })[R[20]], ({ [0] = 89, [1] = 12, [2] = 19 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 33, [1] = 104, [2] = 10 })[R[20]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 33, [1] = 104, [2] = 10 })[R[20]], ({ [0] = 87, [1] = 10, [2] = 17 })[R[20]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 41, [1] = 112, [2] = 18 }, [1] = { [0] = 42, [1] = 113, [2] = 19 }, [2] = { [0] = 38, [1] = 109, [2] = 15 } })[R[39]][R[20]], ({ [0] = { [0] = 79, [1] = 2, [2] = 9 }, [1] = { [0] = 85, [1] = 8, [2] = 15 }, [2] = { [0] = 89, [1] = 12, [2] = 19 } })[R[39]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 4 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 38, [1] = 109, [2] = 15 }, [1] = { [0] = 32, [1] = 103, [2] = 9 }, [2] = { [0] = 32, [1] = 103, [2] = 9 } })[R[40]][R[20]], ({ [0] = { [0] = 90, [1] = 13, [2] = 20 }, [1] = { [0] = 85, [1] = 8, [2] = 15 }, [2] = { [0] = 80, [1] = 3, [2] = 10 } })[R[40]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 42, [1] = 113, [2] = 19 }, [1] = { [0] = 41, [1] = 112, [2] = 18 }, [2] = { [0] = 38, [1] = 109, [2] = 15 } })[R[41]][R[20]], ({ [0] = { [0] = 80, [1] = 3, [2] = 10 }, [1] = { [0] = 86, [1] = 9, [2] = 16 }, [2] = { [0] = 87, [1] = 10, [2] = 17 } })[R[41]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[35] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 36, [1] = 107, [2] = 13 }, [1] = { [0] = 32, [1] = 103, [2] = 9 }, [2] = { [0] = 42, [1] = 113, [2] = 19 } })[R[42]][R[20]], ({ [0] = { [0] = 89, [1] = 12, [2] = 19 }, [1] = { [0] = 85, [1] = 8, [2] = 15 }, [2] = { [0] = 80, [1] = 3, [2] = 10 } })[R[42]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
      players[3].workers = 27
      players[3].scientists = 18
      players[3].kids = 22
      players[3].food = 3000
      players[3].ore = 6000
      players[3]:mark_research(3304)
      players[3]:mark_research(3305)
      players[3]:mark_research(3401)
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      players[2]:mark_research(3304)
      players[2]:mark_research(3305)
      players[3]:mark_research(3303)
      players[3].workers = 24
      players[3].scientists = 15
      players[3].kids = 20
      players[3].food = 2000
      players[3].ore = 4000
      players[3]:mark_research(3304)
      players[3]:mark_research(3305)
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      players[3]:mark_research(3303)
      players[3].workers = 20
      players[3].scientists = 12
      players[3].kids = 18
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
  mission.last_one_standing("Eliminate your opponents.")
  if game.disasters_enabled() then
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Tornados}  -- after 60 to 120 marks
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Meteors}  -- after 60 to 120 marks
    trigger.research{tech = 5201, one_shot = true, on = Lava1}
    trigger.resource{resource = "Colonists", compare = ">=", amount = 85, one_shot = true, on = Lava2}
  end
  return true
end
