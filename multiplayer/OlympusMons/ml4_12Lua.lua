-- ml4_12Lua.lua  -  4 Player, LastOne, 'Olympus Mons' map. (Lua)
--
-- Converted by op2dll from ml4_12.dll ("4 Player, LastOne, 'Olympus Mons' map."): its setup replayed. `on_init` makes the original's
-- draws of the game's random numbers in its order and, from them and the lobby, the same units,
-- beacons, walls and settings in the same order, as the original's setup did in every game
-- sampled (every player count, the lobby's colonies, resource levels, vehicles, day and night,
-- morale and disasters). Anything not converted is listed at the end. Coordinates are the in-game
-- status-bar ones (map file tile + 1).

-- Where lava may flow from an eruption, as areas { x1, y1, x2, y2 }.
local LAVA_POSSIBLE = {
  { 1, 1, 76, 1 }, { 78, 1, 99, 1 }, { 1, 2, 100, 2 }, { 1, 3, 101, 4 }, { 1, 5, 102, 5 }, { 1, 6, 103, 6 },
  { 1, 7, 104, 8 }, { 1, 9, 105, 10 }, { 1, 11, 106, 13 }, { 1, 14, 105, 14 }, { 1, 15, 103, 15 }, { 1, 16, 86, 16 },
  { 90, 16, 104, 16 }, { 1, 17, 80, 17 }, { 91, 17, 104, 17 }, { 1, 18, 79, 18 }, { 92, 18, 104, 18 }, { 1, 19, 78, 21 },
  { 93, 19, 105, 20 }, { 93, 21, 106, 22 }, { 1, 22, 79, 22 }, { 1, 23, 82, 23 }, { 94, 23, 107, 25 }, { 1, 24, 81, 24 },
  { 1, 25, 80, 28 }, { 95, 26, 106, 27 }, { 94, 28, 106, 28 }, { 1, 29, 82, 29 }, { 93, 29, 106, 29 }, { 1, 30, 86, 30 },
  { 89, 30, 107, 30 }, { 1, 31, 108, 31 }, { 1, 32, 109, 32 }, { 1, 33, 110, 33 }, { 1, 34, 111, 34 }, { 1, 35, 99, 35 },
  { 103, 35, 112, 35 }, { 1, 36, 95, 36 }, { 104, 36, 113, 36 }, { 1, 37, 94, 38 }, { 106, 37, 114, 37 }, { 109, 38, 115, 38 },
  { 1, 39, 93, 39 }, { 112, 39, 116, 39 }, { 1, 40, 90, 40 }, { 113, 40, 117, 40 }, { 1, 41, 87, 42 }, { 114, 41, 116, 41 },
  { 115, 42, 115, 42 }, { 1, 43, 83, 44 }, { 1, 45, 84, 45 }, { 1, 46, 73, 46 }, { 82, 46, 85, 46 }, { 1, 47, 71, 47 },
  { 83, 47, 84, 47 }, { 1, 48, 70, 48 }, { 1, 49, 67, 49 }, { 1, 50, 62, 51 }, { 64, 50, 64, 50 }, { 1, 52, 61, 52 },
  { 1, 53, 60, 53 }, { 1, 54, 58, 54 }, { 1, 55, 57, 55 }, { 1, 56, 55, 56 }, { 1, 57, 52, 57 }, { 54, 57, 54, 57 },
  { 1, 58, 54, 58 }, { 1, 59, 52, 59 }, { 1, 60, 50, 60 }, { 1, 61, 49, 61 }, { 1, 62, 48, 63 }, { 1, 64, 49, 66 },
  { 1, 67, 45, 67 }, { 1, 68, 44, 69 }, { 1, 70, 43, 70 }, { 1, 71, 42, 72 }, { 1, 73, 39, 73 }, { 41, 73, 42, 73 },
  { 1, 74, 38, 74 }, { 42, 74, 42, 74 }, { 1, 75, 37, 75 }, { 1, 76, 34, 76 }, { 36, 76, 38, 76 }, { 1, 77, 28, 77 },
  { 37, 77, 38, 77 }, { 1, 78, 26, 78 }, { 37, 78, 39, 78 }, { 1, 79, 20, 79 }, { 38, 79, 39, 81 }, { 1, 80, 19, 80 },
  { 1, 81, 18, 81 }, { 1, 82, 16, 82 }, { 4, 83, 6, 83 }, { 10, 83, 15, 83 }, { 12, 84, 13, 84 },
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
local Lava, Quakes, Tornados

function Lava(t)
  game.create_eruption({ 82, 23 }, 200)
end

function Quakes(t)
  local r1 = game.rand(4)
  local r2 = game.rand(255)
  local r3 = game.rand(256)
  game.create_earthquake({ r3 + 1, r2 + 2 }, r1 + 1)
end

function Tornados(t)
  local r1 = game.rand(255)
  local r2 = game.rand(256)
  local r3 = game.rand(10)
  local r4 = game.rand(255)
  local r5 = game.rand(256)
  game.create_tornado({ r5 + 1, r4 + 2 }, { r2 + 1, r1 + 2 }, r3 + 10)
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
    game.initial_set_tile({ 82, 22 }, 1095)
    game.initial_set_tile({ 82, 23 }, 1118)
    game.initial_set_tile({ 83, 22 }, 1107)
    game.initial_set_tile({ 83, 23 }, 1129)
    game.initial_set_tile({ 85, 23 }, 1140)
    game.initial_set_tile({ 85, 24 }, 1150)
    game.initial_set_tile({ 87, 22 }, 1161)
    game.initial_set_tile({ 87, 23 }, 1184)
    game.initial_set_tile({ 88, 22 }, 1172)
    game.initial_set_tile({ 88, 23 }, 1195)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 154, 22 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 230, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 119, 245 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 21, 172 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 4, 251 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 17, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 59, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 66, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 63, 109 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 58, 151 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 49, 192 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 53, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 77, 246 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 75, 183 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 115, 209 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 156, 209 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 191, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 198, 198 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 219, 249 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 190, 187 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 196, 136 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 177, 71 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 82 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 245, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 229, 4 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 188, 9 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 158, 13 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 190, 40 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 123, 111 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 137 } }
    R[0] = game.rand(4)
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[1]][R[0]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[1]][R[0]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] })
    if R[1] == 1 or R[1] == 2 or R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [3] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [4] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[1]][R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 185, [1] = 223, [2] = 83, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 1 or R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[1]][R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[0]], ({ [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[1]][R[0]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[1]][R[0]], ({ [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 } })[R[1]][R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[1]][R[0]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 13, [1] = 128, [2] = 233, [3] = 128 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 13, [1] = 128, [2] = 233, [3] = 128 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [3] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 } })[R[1]][R[0]], ({ [1] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [3] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [4] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [6] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [7] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[1]][R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[1]][R[0]], ({ [5] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [6] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [7] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 or R[1] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [7] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[1]][R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
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
        elseif R[1] == 7 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[1]][R[0]], ({ [5] = { [0] = 194, [1] = 232, [2] = 92, [3] = 26 }, [7] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[1] == 7 then
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[1]][R[0]], ({ [5] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[1] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 }, [7] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 } })[R[1]][R[0]], ({ [5] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [6] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [7] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [3] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [5] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [6] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[1]][R[0]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [6] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [1] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [3] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [4] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [7] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 } })[R[1]][R[0]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [3] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [4] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [6] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[2] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[2]][R[0]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 194, [1] = 232, [2] = 92, [3] = 26 } })[R[2]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        for i = 1, game.initial_units() do
          R[3] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[3]][R[0]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[3]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        for i = 1, game.initial_units() do
          R[4] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[4]][R[0]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[4]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        for i = 1, game.initial_units() do
          R[5] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[5]][R[0]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[5]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] })
        for i = 1, game.initial_units() do
          R[6] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[6]][R[0]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[6]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 } })[R[7]][R[0]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[7]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[8]][R[0]], ({ [0] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 } })[R[8]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[9]][R[0]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[9]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 134, [1] = 239, [2] = 134, [3] = 19 }, [1] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 }, [2] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 }, [3] = { [0] = 130, [1] = 235, [2] = 130, [3] = 15 }, [4] = { [0] = 134, [1] = 239, [2] = 134, [3] = 19 }, [5] = { [0] = 133, [1] = 238, [2] = 133, [3] = 18 }, [6] = { [0] = 130, [1] = 235, [2] = 130, [3] = 15 }, [7] = { [0] = 136, [1] = 241, [2] = 136, [3] = 21 } })[R[10]][R[0]], ({ [0] = { [0] = 230, [1] = 90, [2] = 24, [3] = 192 }, [1] = { [0] = 226, [1] = 86, [2] = 20, [3] = 188 }, [2] = { [0] = 230, [1] = 90, [2] = 24, [3] = 192 }, [3] = { [0] = 226, [1] = 86, [2] = 20, [3] = 188 }, [4] = { [0] = 229, [1] = 89, [2] = 23, [3] = 191 }, [5] = { [0] = 227, [1] = 87, [2] = 21, [3] = 189 }, [6] = { [0] = 224, [1] = 84, [2] = 18, [3] = 186 }, [7] = { [0] = 227, [1] = 87, [2] = 21, [3] = 189 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 134, [1] = 239, [2] = 134, [3] = 19 }, [1] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 }, [2] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 }, [3] = { [0] = 130, [1] = 235, [2] = 130, [3] = 15 }, [4] = { [0] = 134, [1] = 239, [2] = 134, [3] = 19 }, [5] = { [0] = 133, [1] = 238, [2] = 133, [3] = 18 }, [6] = { [0] = 130, [1] = 235, [2] = 130, [3] = 15 }, [7] = { [0] = 136, [1] = 241, [2] = 136, [3] = 21 } })[R[10]][R[0]], ({ [0] = { [0] = 230, [1] = 90, [2] = 24, [3] = 192 }, [1] = { [0] = 226, [1] = 86, [2] = 20, [3] = 188 }, [2] = { [0] = 230, [1] = 90, [2] = 24, [3] = 192 }, [3] = { [0] = 226, [1] = 86, [2] = 20, [3] = 188 }, [4] = { [0] = 229, [1] = 89, [2] = 23, [3] = 191 }, [5] = { [0] = 227, [1] = 87, [2] = 21, [3] = 189 }, [6] = { [0] = 224, [1] = 84, [2] = 18, [3] = 186 }, [7] = { [0] = 227, [1] = 87, [2] = 21, [3] = 189 } })[R[10]][R[0]] })
    if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 }, [2] = { [0] = 131, [1] = 236, [2] = 131, [3] = 16 }, [3] = { [0] = 135, [1] = 240, [2] = 135, [3] = 20 }, [4] = { [0] = 131, [1] = 236, [2] = 131, [3] = 16 } })[R[10]][R[0]], ({ [0] = 233, [1] = 93, [2] = 27, [3] = 195 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 130, [1] = 235, [2] = 130, [3] = 15 })[R[0]], ({ [0] = 234, [1] = 94, [2] = 28, [3] = 196 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 230, [1] = 90, [2] = 24, [3] = 192 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 131, [1] = 236, [2] = 131, [3] = 16 })[R[0]], ({ [0] = 229, [1] = 89, [2] = 23, [3] = 191 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 139, [1] = 244, [2] = 139, [3] = 24 })[R[0]], ({ [0] = 224, [1] = 84, [2] = 18, [3] = 186 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 136, [1] = 241, [2] = 136, [3] = 21 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 234, [1] = 94, [2] = 28, [3] = 196 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 1 or R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 129, [1] = 234, [2] = 129, [3] = 14 }, [2] = { [0] = 130, [1] = 235, [2] = 130, [3] = 15 } })[R[10]][R[0]], ({ [0] = 224, [1] = 84, [2] = 18, [3] = 186 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 138, [1] = 243, [2] = 138, [3] = 23 })[R[0]], ({ [1] = { [0] = 229, [1] = 89, [2] = 23, [3] = 191 }, [2] = { [0] = 233, [1] = 93, [2] = 27, [3] = 195 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 133, [1] = 238, [2] = 133, [3] = 18 }, [2] = { [0] = 134, [1] = 239, [2] = 134, [3] = 19 } })[R[10]][R[0]], ({ [1] = { [0] = 234, [1] = 94, [2] = 28, [3] = 196 }, [2] = { [0] = 230, [1] = 90, [2] = 24, [3] = 192 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 133, [1] = 238, [2] = 133, [3] = 18 }, [2] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 } })[R[10]][R[0]], ({ [1] = { [0] = 230, [1] = 90, [2] = 24, [3] = 192 }, [2] = { [0] = 227, [1] = 87, [2] = 21, [3] = 189 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 139, [1] = 244, [2] = 139, [3] = 24 }, [2] = { [0] = 137, [1] = 242, [2] = 137, [3] = 22 } })[R[10]][R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 140, [1] = 245, [2] = 140, [3] = 25 }, [2] = { [0] = 139, [1] = 244, [2] = 139, [3] = 24 } })[R[10]][R[0]], ({ [1] = { [0] = 234, [1] = 94, [2] = 28, [3] = 196 }, [2] = { [0] = 235, [1] = 95, [2] = 29, [3] = 197 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 131, [1] = 236, [2] = 131, [3] = 16 })[R[0]], ({ [0] = 225, [1] = 85, [2] = 19, [3] = 187 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 135, [1] = 240, [2] = 135, [3] = 20 })[R[0]], ({ [0] = 226, [1] = 86, [2] = 20, [3] = 188 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 130, [1] = 235, [2] = 130, [3] = 15 })[R[0]], ({ [0] = 229, [1] = 89, [2] = 23, [3] = 191 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 139, [1] = 244, [2] = 139, [3] = 24 })[R[0]], ({ [0] = 234, [1] = 94, [2] = 28, [3] = 196 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 223, [1] = 83, [2] = 17, [3] = 185 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 134, [1] = 239, [2] = 134, [3] = 19 })[R[0]], ({ [0] = 224, [1] = 84, [2] = 18, [3] = 186 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 135, [1] = 240, [2] = 135, [3] = 20 })[R[0]], ({ [0] = 234, [1] = 94, [2] = 28, [3] = 196 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 138, [1] = 243, [2] = 138, [3] = 23 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 128, [1] = 233, [2] = 128, [3] = 13 })[R[0]], ({ [0] = 231, [1] = 91, [2] = 25, [3] = 193 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 134, [1] = 239, [2] = 134, [3] = 19 })[R[0]], ({ [0] = 224, [1] = 84, [2] = 18, [3] = 186 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 140, [1] = 245, [2] = 140, [3] = 25 })[R[0]], ({ [0] = 231, [1] = 91, [2] = 25, [3] = 193 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 132, [1] = 237, [2] = 132, [3] = 17 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 132, [1] = 237, [2] = 132, [3] = 17 })[R[0]], ({ [0] = 231, [1] = 91, [2] = 25, [3] = 193 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 132, [1] = 237, [2] = 132, [3] = 17 })[R[0]], ({ [0] = 227, [1] = 87, [2] = 21, [3] = 189 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 128, [1] = 233, [2] = 128, [3] = 13 })[R[0]], ({ [0] = 231, [1] = 91, [2] = 25, [3] = 193 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 140, [1] = 245, [2] = 140, [3] = 25 }, [2] = { [0] = 132, [1] = 237, [2] = 132, [3] = 17 }, [3] = { [0] = 132, [1] = 237, [2] = 132, [3] = 17 }, [4] = { [0] = 132, [1] = 237, [2] = 132, [3] = 17 } })[R[10]][R[0]], ({ [1] = { [0] = 231, [1] = 91, [2] = 25, [3] = 193 }, [2] = { [0] = 235, [1] = 95, [2] = 29, [3] = 197 }, [3] = { [0] = 231, [1] = 91, [2] = 25, [3] = 193 }, [4] = { [0] = 227, [1] = 87, [2] = 21, [3] = 189 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 130, [1] = 235, [2] = 130, [3] = 15 }, [6] = { [0] = 139, [1] = 244, [2] = 139, [3] = 24 }, [7] = { [0] = 130, [1] = 235, [2] = 130, [3] = 15 } })[R[10]][R[0]], ({ [0] = 234, [1] = 94, [2] = 28, [3] = 196 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 }, [6] = { [0] = 130, [1] = 235, [2] = 130, [3] = 15 }, [7] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 } })[R[10]][R[0]], ({ [5] = { [0] = 228, [1] = 88, [2] = 22, [3] = 190 }, [6] = { [0] = 233, [1] = 93, [2] = 27, [3] = 195 }, [7] = { [0] = 233, [1] = 93, [2] = 27, [3] = 195 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 or R[10] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 }, [7] = { [0] = 131, [1] = 236, [2] = 131, [3] = 16 } })[R[10]][R[0]], ({ [0] = 224, [1] = 84, [2] = 18, [3] = 186 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
          if LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 133, [1] = 238, [2] = 133, [3] = 18 }, [7] = { [0] = 135, [1] = 240, [2] = 135, [3] = 20 } })[R[10]][R[0]], ({ [0] = 224, [1] = 84, [2] = 18, [3] = 186 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 136, [1] = 241, [2] = 136, [3] = 21 })[R[0]], ({ [0] = 230, [1] = 90, [2] = 24, [3] = 192 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[10] == 5 then
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [5] = { [0] = 230, [1] = 90, [2] = 24, [3] = 192 }, [7] = { [0] = 227, [1] = 87, [2] = 21, [3] = 189 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 134, [1] = 239, [2] = 134, [3] = 19 })[R[0]], ({ [5] = { [0] = 229, [1] = 89, [2] = 23, [3] = 191 }, [7] = { [0] = 228, [1] = 88, [2] = 22, [3] = 190 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 134, [1] = 239, [2] = 134, [3] = 19 }, [7] = { [0] = 139, [1] = 244, [2] = 139, [3] = 24 } })[R[10]][R[0]], ({ [5] = { [0] = 231, [1] = 91, [2] = 25, [3] = 193 }, [7] = { [0] = 228, [1] = 88, [2] = 22, [3] = 190 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 130, [1] = 235, [2] = 130, [3] = 15 })[R[0]], ({ [0] = 230, [1] = 90, [2] = 24, [3] = 192 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 130, [1] = 235, [2] = 130, [3] = 15 })[R[0]], ({ [0] = 227, [1] = 87, [2] = 21, [3] = 189 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 135, [1] = 240, [2] = 135, [3] = 20 })[R[0]], ({ [0] = 225, [1] = 85, [2] = 19, [3] = 187 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 140, [1] = 245, [2] = 140, [3] = 25 }, [6] = { [0] = 137, [1] = 242, [2] = 137, [3] = 22 }, [7] = { [0] = 133, [1] = 238, [2] = 133, [3] = 18 } })[R[10]][R[0]], ({ [5] = { [0] = 226, [1] = 86, [2] = 20, [3] = 188 }, [6] = { [0] = 227, [1] = 87, [2] = 21, [3] = 189 }, [7] = { [0] = 225, [1] = 85, [2] = 19, [3] = 187 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 140, [1] = 245, [2] = 140, [3] = 25 })[R[0]], ({ [0] = 226, [1] = 86, [2] = 20, [3] = 188 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 227, [1] = 87, [2] = 21, [3] = 189 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 227, [1] = 87, [2] = 21, [3] = 189 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 132, [1] = 237, [2] = 132, [3] = 17 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 234, [1] = 94, [2] = 28, [3] = 196 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 225, [1] = 85, [2] = 19, [3] = 187 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 131, [1] = 236, [2] = 131, [3] = 16 })[R[0]], ({ [0] = 233, [1] = 93, [2] = 27, [3] = 195 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 136, [1] = 241, [2] = 136, [3] = 21 })[R[0]], ({ [0] = 233, [1] = 93, [2] = 27, [3] = 195 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 130, [1] = 235, [2] = 130, [3] = 15 })[R[0]], ({ [0] = 230, [1] = 90, [2] = 24, [3] = 192 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 138, [1] = 243, [2] = 138, [3] = 23 })[R[0]], ({ [0] = 230, [1] = 90, [2] = 24, [3] = 192 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 139, [1] = 244, [2] = 139, [3] = 24 })[R[0]], ({ [0] = 224, [1] = 84, [2] = 18, [3] = 186 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 138, [1] = 243, [2] = 138, [3] = 23 })[R[0]], ({ [0] = 234, [1] = 94, [2] = 28, [3] = 196 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 140, [1] = 245, [2] = 140, [3] = 25 })[R[0]], ({ [0] = 233, [1] = 93, [2] = 27, [3] = 195 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 129, [1] = 234, [2] = 129, [3] = 14 })[R[0]], ({ [0] = 226, [1] = 86, [2] = 20, [3] = 188 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 129, [1] = 234, [2] = 129, [3] = 14 })[R[0]], ({ [0] = 226, [1] = 86, [2] = 20, [3] = 188 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 140, [1] = 245, [2] = 140, [3] = 25 })[R[0]], ({ [0] = 231, [1] = 91, [2] = 25, [3] = 193 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 130, [1] = 235, [2] = 130, [3] = 15 })[R[0]], ({ [0] = 230, [1] = 90, [2] = 24, [3] = 192 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 130, [1] = 235, [2] = 130, [3] = 15 })[R[0]], ({ [0] = 230, [1] = 90, [2] = 24, [3] = 192 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 132, [1] = 237, [2] = 132, [3] = 17 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 134, [1] = 239, [2] = 134, [3] = 19 })[R[0]], ({ [0] = 226, [1] = 86, [2] = 20, [3] = 188 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 134, [1] = 239, [2] = 134, [3] = 19 })[R[0]], ({ [0] = 226, [1] = 86, [2] = 20, [3] = 188 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 132, [1] = 237, [2] = 132, [3] = 17 })[R[0]], ({ [0] = 231, [1] = 91, [2] = 25, [3] = 193 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 227, [1] = 87, [2] = 21, [3] = 189 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 227, [1] = 87, [2] = 21, [3] = 189 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 132, [1] = 237, [2] = 132, [3] = 17 })[R[0]], ({ [0] = 227, [1] = 87, [2] = 21, [3] = 189 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 129, [1] = 234, [2] = 129, [3] = 14 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 140, [1] = 245, [2] = 140, [3] = 25 })[R[0]], ({ [0] = 226, [1] = 86, [2] = 20, [3] = 188 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 140, [1] = 245, [2] = 140, [3] = 25 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 6 then
      if LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 135, [1] = 240, [2] = 135, [3] = 20 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 228, [1] = 88, [2] = 22, [3] = 190 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 227, [1] = 87, [2] = 21, [3] = 189 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 132, [1] = 237, [2] = 132, [3] = 17 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 234, [1] = 94, [2] = 28, [3] = 196 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 135, [1] = 240, [2] = 135, [3] = 20 })[R[0]], ({ [0] = 235, [1] = 95, [2] = 29, [3] = 197 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 228, [1] = 88, [2] = 22, [3] = 190 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 225, [1] = 85, [2] = 19, [3] = 187 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 140, [1] = 245, [2] = 140, [3] = 25 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 130, [1] = 235, [2] = 130, [3] = 15 }, [1] = { [0] = 129, [1] = 234, [2] = 129, [3] = 14 }, [2] = { [0] = 135, [1] = 240, [2] = 135, [3] = 20 }, [3] = { [0] = 134, [1] = 239, [2] = 134, [3] = 19 }, [4] = { [0] = 132, [1] = 237, [2] = 132, [3] = 17 }, [5] = { [0] = 139, [1] = 244, [2] = 139, [3] = 24 }, [6] = { [0] = 134, [1] = 239, [2] = 134, [3] = 19 }, [7] = { [0] = 139, [1] = 244, [2] = 139, [3] = 24 } })[R[10]][R[0]], ({ [0] = { [0] = 227, [1] = 87, [2] = 21, [3] = 189 }, [1] = { [0] = 229, [1] = 89, [2] = 23, [3] = 191 }, [2] = { [0] = 225, [1] = 85, [2] = 19, [3] = 187 }, [3] = { [0] = 226, [1] = 86, [2] = 20, [3] = 188 }, [4] = { [0] = 235, [1] = 95, [2] = 29, [3] = 197 }, [5] = { [0] = 230, [1] = 90, [2] = 24, [3] = 192 }, [6] = { [0] = 229, [1] = 89, [2] = 23, [3] = 191 }, [7] = { [0] = 235, [1] = 95, [2] = 29, [3] = 197 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 131, [1] = 236, [2] = 131, [3] = 16 }, [1] = { [0] = 131, [1] = 236, [2] = 131, [3] = 16 }, [2] = { [0] = 134, [1] = 239, [2] = 134, [3] = 19 }, [3] = { [0] = 133, [1] = 238, [2] = 133, [3] = 18 }, [4] = { [0] = 133, [1] = 238, [2] = 133, [3] = 18 }, [5] = { [0] = 140, [1] = 245, [2] = 140, [3] = 25 }, [6] = { [0] = 135, [1] = 240, [2] = 135, [3] = 20 }, [7] = { [0] = 140, [1] = 245, [2] = 140, [3] = 25 } })[R[10]][R[0]], ({ [0] = { [0] = 227, [1] = 87, [2] = 21, [3] = 189 }, [1] = { [0] = 228, [1] = 88, [2] = 22, [3] = 190 }, [2] = { [0] = 224, [1] = 84, [2] = 18, [3] = 186 }, [3] = { [0] = 225, [1] = 85, [2] = 19, [3] = 187 }, [4] = { [0] = 234, [1] = 94, [2] = 28, [3] = 196 }, [5] = { [0] = 229, [1] = 89, [2] = 23, [3] = 191 }, [6] = { [0] = 228, [1] = 88, [2] = 22, [3] = 190 }, [7] = { [0] = 235, [1] = 95, [2] = 29, [3] = 197 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[11] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 129, [1] = 234, [2] = 129, [3] = 14 }, [1] = { [0] = 134, [1] = 239, [2] = 134, [3] = 19 }, [2] = { [0] = 139, [1] = 244, [2] = 139, [3] = 24 } })[R[11]][R[0]], ({ [0] = { [0] = 223, [1] = 83, [2] = 17, [3] = 185 }, [1] = { [0] = 226, [1] = 86, [2] = 20, [3] = 188 }, [2] = { [0] = 232, [1] = 92, [2] = 26, [3] = 194 } })[R[11]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 133, [1] = 238, [2] = 133, [3] = 18 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] })
        for i = 1, game.initial_units() do
          R[12] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 129, [1] = 234, [2] = 129, [3] = 14 }, [1] = { [0] = 133, [1] = 238, [2] = 133, [3] = 18 }, [2] = { [0] = 136, [1] = 241, [2] = 136, [3] = 21 } })[R[12]][R[0]], ({ [0] = { [0] = 233, [1] = 93, [2] = 27, [3] = 195 }, [1] = { [0] = 227, [1] = 87, [2] = 21, [3] = 189 }, [2] = { [0] = 223, [1] = 83, [2] = 17, [3] = 185 } })[R[12]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 134, [1] = 239, [2] = 134, [3] = 19 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] })
        game.create_tube({ ({ [0] = 134, [1] = 239, [2] = 134, [3] = 19 })[R[0]], ({ [0] = 233, [1] = 93, [2] = 27, [3] = 195 })[R[0]] })
        game.create_tube({ ({ [0] = 135, [1] = 240, [2] = 135, [3] = 20 })[R[0]], ({ [0] = 233, [1] = 93, [2] = 27, [3] = 195 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 134, [1] = 239, [2] = 134, [3] = 19 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] })
        game.create_tube({ ({ [0] = 134, [1] = 239, [2] = 134, [3] = 19 })[R[0]], ({ [0] = 233, [1] = 93, [2] = 27, [3] = 195 })[R[0]] })
        game.create_tube({ ({ [0] = 135, [1] = 240, [2] = 135, [3] = 20 })[R[0]], ({ [0] = 233, [1] = 93, [2] = 27, [3] = 195 })[R[0]] })
        for i = 1, game.initial_units() do
          R[13] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 }, [1] = { [0] = 130, [1] = 235, [2] = 130, [3] = 15 }, [2] = { [0] = 134, [1] = 239, [2] = 134, [3] = 19 } })[R[13]][R[0]], ({ [0] = { [0] = 223, [1] = 83, [2] = 17, [3] = 185 }, [1] = { [0] = 228, [1] = 88, [2] = 22, [3] = 190 }, [2] = { [0] = 233, [1] = 93, [2] = 27, [3] = 195 } })[R[13]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 131, [1] = 236, [2] = 131, [3] = 16 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] })
        game.create_tube({ ({ [0] = 134, [1] = 239, [2] = 134, [3] = 19 })[R[0]], ({ [0] = 229, [1] = 89, [2] = 23, [3] = 191 })[R[0]] })
        game.create_tube({ ({ [0] = 135, [1] = 240, [2] = 135, [3] = 20 })[R[0]], ({ [0] = 229, [1] = 89, [2] = 23, [3] = 191 })[R[0]] })
        game.create_tube({ ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] })
        game.create_tube({ ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 233, [1] = 93, [2] = 27, [3] = 195 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 131, [1] = 236, [2] = 131, [3] = 16 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] })
        game.create_tube({ ({ [0] = 134, [1] = 239, [2] = 134, [3] = 19 })[R[0]], ({ [0] = 229, [1] = 89, [2] = 23, [3] = 191 })[R[0]] })
        game.create_tube({ ({ [0] = 135, [1] = 240, [2] = 135, [3] = 20 })[R[0]], ({ [0] = 229, [1] = 89, [2] = 23, [3] = 191 })[R[0]] })
        game.create_tube({ ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 232, [1] = 92, [2] = 26, [3] = 194 })[R[0]] })
        game.create_tube({ ({ [0] = 137, [1] = 242, [2] = 137, [3] = 22 })[R[0]], ({ [0] = 233, [1] = 93, [2] = 27, [3] = 195 })[R[0]] })
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 139, [1] = 244, [2] = 139, [3] = 24 }, [1] = { [0] = 135, [1] = 240, [2] = 135, [3] = 20 }, [2] = { [0] = 131, [1] = 236, [2] = 131, [3] = 16 } })[R[14]][R[0]], ({ [0] = { [0] = 234, [1] = 94, [2] = 28, [3] = 196 }, [1] = { [0] = 228, [1] = 88, [2] = 22, [3] = 190 }, [2] = { [0] = 223, [1] = 83, [2] = 17, [3] = 185 } })[R[14]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 130, [1] = 235, [2] = 130, [3] = 15 })[R[0]], ({ [0] = 231, [1] = 91, [2] = 25, [3] = 193 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 130, [1] = 235, [2] = 130, [3] = 15 })[R[0]], ({ [0] = 231, [1] = 91, [2] = 25, [3] = 193 })[R[0]] })
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 }, [1] = { [0] = 139, [1] = 244, [2] = 139, [3] = 24 }, [2] = { [0] = 135, [1] = 240, [2] = 135, [3] = 20 } })[R[15]][R[0]], ({ [0] = { [0] = 223, [1] = 83, [2] = 17, [3] = 185 }, [1] = { [0] = 229, [1] = 89, [2] = 23, [3] = 191 }, [2] = { [0] = 233, [1] = 93, [2] = 27, [3] = 195 } })[R[15]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 135, [1] = 240, [2] = 135, [3] = 20 }, [1] = { [0] = 129, [1] = 234, [2] = 129, [3] = 14 }, [2] = { [0] = 129, [1] = 234, [2] = 129, [3] = 14 } })[R[16]][R[0]], ({ [0] = { [0] = 234, [1] = 94, [2] = 28, [3] = 196 }, [1] = { [0] = 229, [1] = 89, [2] = 23, [3] = 191 }, [2] = { [0] = 224, [1] = 84, [2] = 18, [3] = 186 } })[R[16]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 139, [1] = 244, [2] = 139, [3] = 24 }, [1] = { [0] = 138, [1] = 243, [2] = 138, [3] = 23 }, [2] = { [0] = 135, [1] = 240, [2] = 135, [3] = 20 } })[R[17]][R[0]], ({ [0] = { [0] = 224, [1] = 84, [2] = 18, [3] = 186 }, [1] = { [0] = 230, [1] = 90, [2] = 24, [3] = 192 }, [2] = { [0] = 231, [1] = 91, [2] = 25, [3] = 193 } })[R[17]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 133, [1] = 238, [2] = 133, [3] = 18 }, [1] = { [0] = 129, [1] = 234, [2] = 129, [3] = 14 }, [2] = { [0] = 139, [1] = 244, [2] = 139, [3] = 24 } })[R[18]][R[0]], ({ [0] = { [0] = 233, [1] = 93, [2] = 27, [3] = 195 }, [1] = { [0] = 229, [1] = 89, [2] = 23, [3] = 191 }, [2] = { [0] = 224, [1] = 84, [2] = 18, [3] = 186 } })[R[18]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
    game.initial_set_tile({ 82, 22 }, 1095)
    game.initial_set_tile({ 82, 23 }, 1118)
    game.initial_set_tile({ 83, 22 }, 1107)
    game.initial_set_tile({ 83, 23 }, 1129)
    game.initial_set_tile({ 85, 23 }, 1140)
    game.initial_set_tile({ 85, 24 }, 1150)
    game.initial_set_tile({ 87, 22 }, 1161)
    game.initial_set_tile({ 87, 23 }, 1184)
    game.initial_set_tile({ 88, 22 }, 1172)
    game.initial_set_tile({ 88, 23 }, 1195)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 154, 22 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 230, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 119, 245 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 21, 172 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 4, 251 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 17, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 59, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 66, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 63, 109 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 58, 151 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 49, 192 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 53, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 77, 246 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 75, 183 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 115, 209 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 156, 209 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 191, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 198, 198 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 219, 249 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 190, 187 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 196, 136 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 177, 71 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 82 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 245, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 229, 4 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 188, 9 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 158, 13 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 190, 40 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 123, 111 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 137 } }
    pick(4, 3, { 0, 19, 20 })
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[1]][R[0]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[1]][R[0]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] })
    if R[1] == 1 or R[1] == 2 or R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [3] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [4] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[1]][R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 1 or R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[1]][R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[0]], ({ [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[1]][R[0]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[1]][R[0]], ({ [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 } })[R[1]][R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 185, [1] = 223, [2] = 83, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [3] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[1]][R[0]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [3] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [4] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[1]], player = players[1], at = { ({ [1] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [3] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [4] = { [0] = 13, [1] = 128, [2] = 233, [3] = 128 } })[R[1]][R[0]], ({ [1] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [2] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [3] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [4] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [3] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 } })[R[1]][R[0]], ({ [1] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [3] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [4] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [6] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [7] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[1]][R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[1]][R[0]], ({ [5] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [6] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [7] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 or R[1] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [7] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[1]][R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[1] == 7 then
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
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [7] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[1]][R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
        elseif R[1] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[1]][R[0]], ({ [5] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[1] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 }, [7] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 } })[R[1]][R[0]], ({ [5] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [6] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [7] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 6 then
      if LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [3] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [5] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [6] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[1]][R[0]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [6] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [1] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [3] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [4] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [7] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 } })[R[1]][R[0]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [3] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [4] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [6] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[21]][R[0]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 194, [1] = 232, [2] = 92, [3] = 26 } })[R[21]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[22]][R[0]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[22]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[23]][R[0]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[23]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[24]][R[0]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[24]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[25]][R[0]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[25]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 } })[R[26]][R[0]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[26]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[27]][R[0]], ({ [0] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 } })[R[27]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[28]][R[0]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[28]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 23, [2] = 23, [3] = 15, [4] = 19, [5] = 18, [6] = 15, [7] = 21 }, [1] = { [0] = 134, [1] = 138, [2] = 138, [3] = 130, [4] = 134, [5] = 133, [6] = 130, [7] = 136 }, [2] = { [0] = 239, [1] = 243, [2] = 243, [3] = 235, [4] = 239, [5] = 238, [6] = 235, [7] = 241 }, [3] = { [0] = 134, [1] = 138, [2] = 138, [3] = 130, [4] = 134, [5] = 133, [6] = 130, [7] = 136 } })[R[19]][R[10]], ({ [0] = { [0] = 192, [1] = 188, [2] = 192, [3] = 188, [4] = 191, [5] = 189, [6] = 186, [7] = 189 }, [1] = { [0] = 230, [1] = 226, [2] = 230, [3] = 226, [4] = 229, [5] = 227, [6] = 224, [7] = 227 }, [2] = { [0] = 90, [1] = 86, [2] = 90, [3] = 86, [4] = 89, [5] = 87, [6] = 84, [7] = 87 }, [3] = { [0] = 24, [1] = 20, [2] = 24, [3] = 20, [4] = 23, [5] = 21, [6] = 18, [7] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 19, [1] = 23, [2] = 23, [3] = 15, [4] = 19, [5] = 18, [6] = 15, [7] = 21 }, [1] = { [0] = 134, [1] = 138, [2] = 138, [3] = 130, [4] = 134, [5] = 133, [6] = 130, [7] = 136 }, [2] = { [0] = 239, [1] = 243, [2] = 243, [3] = 235, [4] = 239, [5] = 238, [6] = 235, [7] = 241 }, [3] = { [0] = 134, [1] = 138, [2] = 138, [3] = 130, [4] = 134, [5] = 133, [6] = 130, [7] = 136 } })[R[19]][R[10]], ({ [0] = { [0] = 192, [1] = 188, [2] = 192, [3] = 188, [4] = 191, [5] = 189, [6] = 186, [7] = 189 }, [1] = { [0] = 230, [1] = 226, [2] = 230, [3] = 226, [4] = 229, [5] = 227, [6] = 224, [7] = 227 }, [2] = { [0] = 90, [1] = 86, [2] = 90, [3] = 86, [4] = 89, [5] = 87, [6] = 84, [7] = 87 }, [3] = { [0] = 24, [1] = 20, [2] = 24, [3] = 20, [4] = 23, [5] = 21, [6] = 18, [7] = 21 } })[R[19]][R[10]] })
    if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 23, [2] = 16, [3] = 20, [4] = 16 }, [1] = { [1] = 138, [2] = 131, [3] = 135, [4] = 131 }, [2] = { [1] = 243, [2] = 236, [3] = 240, [4] = 236 }, [3] = { [1] = 138, [2] = 131, [3] = 135, [4] = 131 } })[R[19]][R[10]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 or R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 14, [2] = 15 }, [1] = { [1] = 129, [2] = 130 }, [2] = { [1] = 234, [2] = 235 }, [3] = { [1] = 129, [2] = 130 } })[R[19]][R[10]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[19]], ({ [0] = { [1] = 191, [2] = 195 }, [1] = { [1] = 229, [2] = 233 }, [2] = { [1] = 89, [2] = 93 }, [3] = { [1] = 23, [2] = 27 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 18, [2] = 19 }, [1] = { [1] = 133, [2] = 134 }, [2] = { [1] = 238, [2] = 239 }, [3] = { [1] = 133, [2] = 134 } })[R[19]][R[10]], ({ [0] = { [1] = 196, [2] = 192 }, [1] = { [1] = 234, [2] = 230 }, [2] = { [1] = 94, [2] = 90 }, [3] = { [1] = 28, [2] = 24 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 18, [2] = 23 }, [1] = { [1] = 133, [2] = 138 }, [2] = { [1] = 238, [2] = 243 }, [3] = { [1] = 133, [2] = 138 } })[R[19]][R[10]], ({ [0] = { [1] = 192, [2] = 189 }, [1] = { [1] = 230, [2] = 227 }, [2] = { [1] = 90, [2] = 87 }, [3] = { [1] = 24, [2] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 24, [2] = 22 }, [1] = { [1] = 139, [2] = 137 }, [2] = { [1] = 244, [2] = 242 }, [3] = { [1] = 139, [2] = 137 } })[R[19]][R[10]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[19]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[19]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[19]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 185, [1] = 223, [2] = 83, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [1] = 25, [2] = 24, [3] = 22, [4] = 19 }, [1] = { [1] = 140, [2] = 139, [3] = 137, [4] = 134 }, [2] = { [1] = 245, [2] = 244, [3] = 242, [4] = 239 }, [3] = { [1] = 140, [2] = 139, [3] = 137, [4] = 134 } })[R[19]][R[10]], ({ [0] = { [1] = 196, [2] = 197, [3] = 196, [4] = 186 }, [1] = { [1] = 234, [2] = 235, [3] = 234, [4] = 224 }, [2] = { [1] = 94, [2] = 95, [3] = 94, [4] = 84 }, [3] = { [1] = 28, [2] = 29, [3] = 28, [4] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[10]], player = players[2], at = { ({ [0] = { [1] = 22, [2] = 20, [3] = 23, [4] = 13 }, [1] = { [1] = 137, [2] = 135, [3] = 138, [4] = 128 }, [2] = { [1] = 242, [2] = 240, [3] = 243, [4] = 233 }, [3] = { [1] = 137, [2] = 135, [3] = 138, [4] = 128 } })[R[19]][R[10]], ({ [0] = { [1] = 197, [2] = 196, [3] = 197, [4] = 193 }, [1] = { [1] = 235, [2] = 234, [3] = 235, [4] = 231 }, [2] = { [1] = 95, [2] = 94, [3] = 95, [4] = 91 }, [3] = { [1] = 29, [2] = 28, [3] = 29, [4] = 25 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 25, [2] = 17, [3] = 17, [4] = 17 }, [1] = { [1] = 140, [2] = 132, [3] = 132, [4] = 132 }, [2] = { [1] = 245, [2] = 237, [3] = 237, [4] = 237 }, [3] = { [1] = 140, [2] = 132, [3] = 132, [4] = 132 } })[R[19]][R[10]], ({ [0] = { [1] = 193, [2] = 197, [3] = 193, [4] = 189 }, [1] = { [1] = 231, [2] = 235, [3] = 231, [4] = 227 }, [2] = { [1] = 91, [2] = 95, [3] = 91, [4] = 87 }, [3] = { [1] = 25, [2] = 29, [3] = 25, [4] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[19]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[19]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 15, [6] = 24, [7] = 15 }, [1] = { [5] = 130, [6] = 139, [7] = 130 }, [2] = { [5] = 235, [6] = 244, [7] = 235 }, [3] = { [5] = 130, [6] = 139, [7] = 130 } })[R[19]][R[10]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 23, [6] = 15, [7] = 23 }, [1] = { [5] = 138, [6] = 130, [7] = 138 }, [2] = { [5] = 243, [6] = 235, [7] = 243 }, [3] = { [5] = 138, [6] = 130, [7] = 138 } })[R[19]][R[10]], ({ [0] = { [5] = 190, [6] = 195, [7] = 195 }, [1] = { [5] = 228, [6] = 233, [7] = 233 }, [2] = { [5] = 88, [6] = 93, [7] = 93 }, [3] = { [5] = 22, [6] = 27, [7] = 27 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 or R[10] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 23, [7] = 16 }, [1] = { [5] = 138, [7] = 131 }, [2] = { [5] = 243, [7] = 236 }, [3] = { [5] = 138, [7] = 131 } })[R[19]][R[10]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[10] == 7 then
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
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [5] = 18, [7] = 20 }, [1] = { [5] = 133, [7] = 135 }, [2] = { [5] = 238, [7] = 240 }, [3] = { [5] = 133, [7] = 135 } })[R[19]][R[10]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
        elseif R[10] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = { [5] = 192, [7] = 189 }, [1] = { [5] = 230, [7] = 227 }, [2] = { [5] = 90, [7] = 87 }, [3] = { [5] = 24, [7] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = { [5] = 191, [7] = 190 }, [1] = { [5] = 229, [7] = 228 }, [2] = { [5] = 89, [7] = 88 }, [3] = { [5] = 23, [7] = 22 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 19, [7] = 24 }, [1] = { [5] = 134, [7] = 139 }, [2] = { [5] = 239, [7] = 244 }, [3] = { [5] = 134, [7] = 139 } })[R[19]][R[10]], ({ [0] = { [5] = 193, [7] = 190 }, [1] = { [5] = 231, [7] = 228 }, [2] = { [5] = 91, [7] = 88 }, [3] = { [5] = 25, [7] = 22 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 25, [6] = 22, [7] = 18 }, [1] = { [5] = 140, [6] = 137, [7] = 133 }, [2] = { [5] = 245, [6] = 242, [7] = 238 }, [3] = { [5] = 140, [6] = 137, [7] = 133 } })[R[19]][R[10]], ({ [0] = { [5] = 188, [6] = 189, [7] = 187 }, [1] = { [5] = 226, [6] = 227, [7] = 225 }, [2] = { [5] = 86, [6] = 87, [7] = 85 }, [3] = { [5] = 20, [6] = 21, [7] = 19 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 15, [1] = 14, [2] = 20, [3] = 19, [4] = 17, [5] = 24, [6] = 19, [7] = 24 }, [1] = { [0] = 130, [1] = 129, [2] = 135, [3] = 134, [4] = 132, [5] = 139, [6] = 134, [7] = 139 }, [2] = { [0] = 235, [1] = 234, [2] = 240, [3] = 239, [4] = 237, [5] = 244, [6] = 239, [7] = 244 }, [3] = { [0] = 130, [1] = 129, [2] = 135, [3] = 134, [4] = 132, [5] = 139, [6] = 134, [7] = 139 } })[R[19]][R[10]], ({ [0] = { [0] = 189, [1] = 191, [2] = 187, [3] = 188, [4] = 197, [5] = 192, [6] = 191, [7] = 197 }, [1] = { [0] = 227, [1] = 229, [2] = 225, [3] = 226, [4] = 235, [5] = 230, [6] = 229, [7] = 235 }, [2] = { [0] = 87, [1] = 89, [2] = 85, [3] = 86, [4] = 95, [5] = 90, [6] = 89, [7] = 95 }, [3] = { [0] = 21, [1] = 23, [2] = 19, [3] = 20, [4] = 29, [5] = 24, [6] = 23, [7] = 29 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 16, [1] = 16, [2] = 19, [3] = 18, [4] = 18, [5] = 25, [6] = 20, [7] = 25 }, [1] = { [0] = 131, [1] = 131, [2] = 134, [3] = 133, [4] = 133, [5] = 140, [6] = 135, [7] = 140 }, [2] = { [0] = 236, [1] = 236, [2] = 239, [3] = 238, [4] = 238, [5] = 245, [6] = 240, [7] = 245 }, [3] = { [0] = 131, [1] = 131, [2] = 134, [3] = 133, [4] = 133, [5] = 140, [6] = 135, [7] = 140 } })[R[19]][R[10]], ({ [0] = { [0] = 189, [1] = 190, [2] = 186, [3] = 187, [4] = 196, [5] = 191, [6] = 190, [7] = 197 }, [1] = { [0] = 227, [1] = 228, [2] = 224, [3] = 225, [4] = 234, [5] = 229, [6] = 228, [7] = 235 }, [2] = { [0] = 87, [1] = 88, [2] = 84, [3] = 85, [4] = 94, [5] = 89, [6] = 88, [7] = 95 }, [3] = { [0] = 21, [1] = 22, [2] = 18, [3] = 19, [4] = 28, [5] = 23, [6] = 22, [7] = 29 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[29]][R[19]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 194, [1] = 232, [2] = 92, [3] = 26 } })[R[29]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[30]][R[19]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[30]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[31]][R[19]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[31]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[32]][R[19]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[32]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[33]][R[19]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[33]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 } })[R[34]][R[19]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[34]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[35]][R[19]], ({ [0] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 } })[R[35]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[36]][R[19]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[36]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[37]][R[20]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[37]][R[20]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[37]][R[20]] })
    if R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [6] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [7] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[37]][R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[37]][R[20]], ({ [5] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [6] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [7] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 or R[37] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [7] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[37]][R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [5] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[37]][R[20]], ({ [5] = { [0] = 194, [1] = 232, [2] = 92, [3] = 26 }, [7] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[37] == 7 then
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[37]][R[20]], ({ [5] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[37] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 }, [7] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 } })[R[37]][R[20]], ({ [5] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [6] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [7] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 1 or R[37] == 2 or R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [3] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [4] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[37]][R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[20]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 185, [1] = 223, [2] = 83, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 1 or R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[37]][R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[20]], ({ [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[37]][R[20]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[37]][R[20]], ({ [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 } })[R[37]][R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[37]][R[20]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 13, [1] = 128, [2] = 233, [3] = 128 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 13, [1] = 128, [2] = 233, [3] = 128 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [3] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 } })[R[37]][R[20]], ({ [1] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [3] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [4] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [3] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [5] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [6] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[37]][R[20]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [6] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [1] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [3] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [4] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [7] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 } })[R[37]][R[20]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [3] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [4] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [6] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[38]][R[20]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 194, [1] = 232, [2] = 92, [3] = 26 } })[R[38]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[39]][R[20]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[39]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[40]][R[20]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[40]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[41]][R[20]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[41]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[42]][R[20]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[42]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 } })[R[43]][R[20]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[43]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[44]][R[20]], ({ [0] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 } })[R[44]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[45]][R[20]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[45]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
    game.initial_set_tile({ 82, 22 }, 1095)
    game.initial_set_tile({ 82, 23 }, 1118)
    game.initial_set_tile({ 83, 22 }, 1107)
    game.initial_set_tile({ 83, 23 }, 1129)
    game.initial_set_tile({ 85, 23 }, 1140)
    game.initial_set_tile({ 85, 24 }, 1150)
    game.initial_set_tile({ 87, 22 }, 1161)
    game.initial_set_tile({ 87, 23 }, 1184)
    game.initial_set_tile({ 88, 22 }, 1172)
    game.initial_set_tile({ 88, 23 }, 1195)
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 154, 22 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 230, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 119, 245 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 21, 172 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 4, 251 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 17, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 59, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 66, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 63, 109 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 58, 151 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 49, 192 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 53, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 77, 246 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 75, 183 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 115, 209 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 127, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 156, 209 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 191, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 198, 198 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 219, 249 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 190, 187 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 196, 136 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 177, 71 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 82 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 245, 29 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 229, 4 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 188, 9 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 158, 13 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 190, 40 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 123, 111 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 114, 137 } }
    pick(4, 4, { 0, 19, 20, 46 })
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[1]][R[0]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[1]][R[0]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] })
    if R[1] == 1 or R[1] == 2 or R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [3] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [4] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[1]][R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 1 or R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[1]][R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[0]], ({ [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[1]][R[0]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[1]][R[0]], ({ [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 } })[R[1]][R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[1]][R[0]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 185, [1] = 223, [2] = 83, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 13, [1] = 128, [2] = 233, [3] = 128 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 13, [1] = 128, [2] = 233, [3] = 128 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [3] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 } })[R[1]][R[0]], ({ [1] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [3] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [4] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [6] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [7] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[1]][R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[1]][R[0]], ({ [5] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [6] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [7] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 or R[1] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [7] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[1]][R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [7] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[1]][R[0]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
        elseif R[1] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[1]][R[0]], ({ [5] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[1] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 }, [7] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 } })[R[1]][R[0]], ({ [5] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [6] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [7] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [3] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [5] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [6] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[1]][R[0]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [6] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [1] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [3] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [4] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [7] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 } })[R[1]][R[0]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [3] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [4] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [6] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[47]][R[0]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 194, [1] = 232, [2] = 92, [3] = 26 } })[R[47]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[48]][R[0]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[48]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[49]][R[0]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[49]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[0]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[0]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[0]] })
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[50]][R[0]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[50]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[0]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[0]] })
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[51]][R[0]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[51]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 } })[R[52]][R[0]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[52]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[53]][R[0]], ({ [0] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 } })[R[53]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[54]][R[0]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[54]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 19, [1] = 23, [2] = 23, [3] = 15, [4] = 19, [5] = 18, [6] = 15, [7] = 21 }, [1] = { [0] = 134, [1] = 138, [2] = 138, [3] = 130, [4] = 134, [5] = 133, [6] = 130, [7] = 136 }, [2] = { [0] = 239, [1] = 243, [2] = 243, [3] = 235, [4] = 239, [5] = 238, [6] = 235, [7] = 241 }, [3] = { [0] = 134, [1] = 138, [2] = 138, [3] = 130, [4] = 134, [5] = 133, [6] = 130, [7] = 136 } })[R[19]][R[10]], ({ [0] = { [0] = 192, [1] = 188, [2] = 192, [3] = 188, [4] = 191, [5] = 189, [6] = 186, [7] = 189 }, [1] = { [0] = 230, [1] = 226, [2] = 230, [3] = 226, [4] = 229, [5] = 227, [6] = 224, [7] = 227 }, [2] = { [0] = 90, [1] = 86, [2] = 90, [3] = 86, [4] = 89, [5] = 87, [6] = 84, [7] = 87 }, [3] = { [0] = 24, [1] = 20, [2] = 24, [3] = 20, [4] = 23, [5] = 21, [6] = 18, [7] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 19, [1] = 23, [2] = 23, [3] = 15, [4] = 19, [5] = 18, [6] = 15, [7] = 21 }, [1] = { [0] = 134, [1] = 138, [2] = 138, [3] = 130, [4] = 134, [5] = 133, [6] = 130, [7] = 136 }, [2] = { [0] = 239, [1] = 243, [2] = 243, [3] = 235, [4] = 239, [5] = 238, [6] = 235, [7] = 241 }, [3] = { [0] = 134, [1] = 138, [2] = 138, [3] = 130, [4] = 134, [5] = 133, [6] = 130, [7] = 136 } })[R[19]][R[10]], ({ [0] = { [0] = 192, [1] = 188, [2] = 192, [3] = 188, [4] = 191, [5] = 189, [6] = 186, [7] = 189 }, [1] = { [0] = 230, [1] = 226, [2] = 230, [3] = 226, [4] = 229, [5] = 227, [6] = 224, [7] = 227 }, [2] = { [0] = 90, [1] = 86, [2] = 90, [3] = 86, [4] = 89, [5] = 87, [6] = 84, [7] = 87 }, [3] = { [0] = 24, [1] = 20, [2] = 24, [3] = 20, [4] = 23, [5] = 21, [6] = 18, [7] = 21 } })[R[19]][R[10]] })
    if R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 15, [6] = 24, [7] = 15 }, [1] = { [5] = 130, [6] = 139, [7] = 130 }, [2] = { [5] = 235, [6] = 244, [7] = 235 }, [3] = { [5] = 130, [6] = 139, [7] = 130 } })[R[19]][R[10]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 23, [6] = 15, [7] = 23 }, [1] = { [5] = 138, [6] = 130, [7] = 138 }, [2] = { [5] = 243, [6] = 235, [7] = 243 }, [3] = { [5] = 138, [6] = 130, [7] = 138 } })[R[19]][R[10]], ({ [0] = { [5] = 190, [6] = 195, [7] = 195 }, [1] = { [5] = 228, [6] = 233, [7] = 233 }, [2] = { [5] = 88, [6] = 93, [7] = 93 }, [3] = { [5] = 22, [6] = 27, [7] = 27 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 or R[10] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 23, [7] = 16 }, [1] = { [5] = 138, [7] = 131 }, [2] = { [5] = 243, [7] = 236 }, [3] = { [5] = 138, [7] = 131 } })[R[19]][R[10]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
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
        elseif R[10] == 7 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [5] = 22, [7] = 21 }, [1] = { [5] = 137, [7] = 136 }, [2] = { [5] = 242, [7] = 241 }, [3] = { [5] = 137, [7] = 136 } })[R[19]][R[10]], ({ [0] = { [5] = 194, [7] = 192 }, [1] = { [5] = 232, [7] = 230 }, [2] = { [5] = 92, [7] = 90 }, [3] = { [5] = 26, [7] = 24 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 7 then
        elseif R[10] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = { [5] = 192, [7] = 189 }, [1] = { [5] = 230, [7] = 227 }, [2] = { [5] = 90, [7] = 87 }, [3] = { [5] = 24, [7] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = { [5] = 191, [7] = 190 }, [1] = { [5] = 229, [7] = 228 }, [2] = { [5] = 89, [7] = 88 }, [3] = { [5] = 23, [7] = 22 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 19, [7] = 24 }, [1] = { [5] = 134, [7] = 139 }, [2] = { [5] = 239, [7] = 244 }, [3] = { [5] = 134, [7] = 139 } })[R[19]][R[10]], ({ [0] = { [5] = 193, [7] = 190 }, [1] = { [5] = 231, [7] = 228 }, [2] = { [5] = 91, [7] = 88 }, [3] = { [5] = 25, [7] = 22 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 25, [6] = 22, [7] = 18 }, [1] = { [5] = 140, [6] = 137, [7] = 133 }, [2] = { [5] = 245, [6] = 242, [7] = 238 }, [3] = { [5] = 140, [6] = 137, [7] = 133 } })[R[19]][R[10]], ({ [0] = { [5] = 188, [6] = 189, [7] = 187 }, [1] = { [5] = 226, [6] = 227, [7] = 225 }, [2] = { [5] = 86, [6] = 87, [7] = 85 }, [3] = { [5] = 20, [6] = 21, [7] = 19 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 23, [2] = 16, [3] = 20, [4] = 16 }, [1] = { [1] = 138, [2] = 131, [3] = 135, [4] = 131 }, [2] = { [1] = 243, [2] = 236, [3] = 240, [4] = 236 }, [3] = { [1] = 138, [2] = 131, [3] = 135, [4] = 131 } })[R[19]][R[10]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[19]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[19]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[19]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 185, [1] = 223, [2] = 83, [3] = 17 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 1 or R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 14, [2] = 15 }, [1] = { [1] = 129, [2] = 130 }, [2] = { [1] = 234, [2] = 235 }, [3] = { [1] = 129, [2] = 130 } })[R[19]][R[10]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[19]], ({ [0] = { [1] = 191, [2] = 195 }, [1] = { [1] = 229, [2] = 233 }, [2] = { [1] = 89, [2] = 93 }, [3] = { [1] = 23, [2] = 27 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 18, [2] = 19 }, [1] = { [1] = 133, [2] = 134 }, [2] = { [1] = 238, [2] = 239 }, [3] = { [1] = 133, [2] = 134 } })[R[19]][R[10]], ({ [0] = { [1] = 196, [2] = 192 }, [1] = { [1] = 234, [2] = 230 }, [2] = { [1] = 94, [2] = 90 }, [3] = { [1] = 28, [2] = 24 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 18, [2] = 23 }, [1] = { [1] = 133, [2] = 138 }, [2] = { [1] = 238, [2] = 243 }, [3] = { [1] = 133, [2] = 138 } })[R[19]][R[10]], ({ [0] = { [1] = 192, [2] = 189 }, [1] = { [1] = 230, [2] = 227 }, [2] = { [1] = 90, [2] = 87 }, [3] = { [1] = 24, [2] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 24, [2] = 22 }, [1] = { [1] = 139, [2] = 137 }, [2] = { [1] = 244, [2] = 242 }, [3] = { [1] = 139, [2] = 137 } })[R[19]][R[10]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [1] = 25, [2] = 24, [3] = 22, [4] = 19 }, [1] = { [1] = 140, [2] = 139, [3] = 137, [4] = 134 }, [2] = { [1] = 245, [2] = 244, [3] = 242, [4] = 239 }, [3] = { [1] = 140, [2] = 139, [3] = 137, [4] = 134 } })[R[19]][R[10]], ({ [0] = { [1] = 196, [2] = 197, [3] = 196, [4] = 186 }, [1] = { [1] = 234, [2] = 235, [3] = 234, [4] = 224 }, [2] = { [1] = 94, [2] = 95, [3] = 94, [4] = 84 }, [3] = { [1] = 28, [2] = 29, [3] = 28, [4] = 18 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[10]], player = players[2], at = { ({ [0] = { [1] = 22, [2] = 20, [3] = 23, [4] = 13 }, [1] = { [1] = 137, [2] = 135, [3] = 138, [4] = 128 }, [2] = { [1] = 242, [2] = 240, [3] = 243, [4] = 233 }, [3] = { [1] = 137, [2] = 135, [3] = 138, [4] = 128 } })[R[19]][R[10]], ({ [0] = { [1] = 197, [2] = 196, [3] = 197, [4] = 193 }, [1] = { [1] = 235, [2] = 234, [3] = 235, [4] = 231 }, [2] = { [1] = 95, [2] = 94, [3] = 95, [4] = 91 }, [3] = { [1] = 29, [2] = 28, [3] = 29, [4] = 25 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 25, [2] = 17, [3] = 17, [4] = 17 }, [1] = { [1] = 140, [2] = 132, [3] = 132, [4] = 132 }, [2] = { [1] = 245, [2] = 237, [3] = 237, [4] = 237 }, [3] = { [1] = 140, [2] = 132, [3] = 132, [4] = 132 } })[R[19]][R[10]], ({ [0] = { [1] = 193, [2] = 197, [3] = 193, [4] = 189 }, [1] = { [1] = 231, [2] = 235, [3] = 231, [4] = 227 }, [2] = { [1] = 91, [2] = 95, [3] = 91, [4] = 87 }, [3] = { [1] = 25, [2] = 29, [3] = 25, [4] = 21 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[19]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[19]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 6 then
      if LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 15, [1] = 14, [2] = 20, [3] = 19, [4] = 17, [5] = 24, [6] = 19, [7] = 24 }, [1] = { [0] = 130, [1] = 129, [2] = 135, [3] = 134, [4] = 132, [5] = 139, [6] = 134, [7] = 139 }, [2] = { [0] = 235, [1] = 234, [2] = 240, [3] = 239, [4] = 237, [5] = 244, [6] = 239, [7] = 244 }, [3] = { [0] = 130, [1] = 129, [2] = 135, [3] = 134, [4] = 132, [5] = 139, [6] = 134, [7] = 139 } })[R[19]][R[10]], ({ [0] = { [0] = 189, [1] = 191, [2] = 187, [3] = 188, [4] = 197, [5] = 192, [6] = 191, [7] = 197 }, [1] = { [0] = 227, [1] = 229, [2] = 225, [3] = 226, [4] = 235, [5] = 230, [6] = 229, [7] = 235 }, [2] = { [0] = 87, [1] = 89, [2] = 85, [3] = 86, [4] = 95, [5] = 90, [6] = 89, [7] = 95 }, [3] = { [0] = 21, [1] = 23, [2] = 19, [3] = 20, [4] = 29, [5] = 24, [6] = 23, [7] = 29 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 16, [1] = 16, [2] = 19, [3] = 18, [4] = 18, [5] = 25, [6] = 20, [7] = 25 }, [1] = { [0] = 131, [1] = 131, [2] = 134, [3] = 133, [4] = 133, [5] = 140, [6] = 135, [7] = 140 }, [2] = { [0] = 236, [1] = 236, [2] = 239, [3] = 238, [4] = 238, [5] = 245, [6] = 240, [7] = 245 }, [3] = { [0] = 131, [1] = 131, [2] = 134, [3] = 133, [4] = 133, [5] = 140, [6] = 135, [7] = 140 } })[R[19]][R[10]], ({ [0] = { [0] = 189, [1] = 190, [2] = 186, [3] = 187, [4] = 196, [5] = 191, [6] = 190, [7] = 197 }, [1] = { [0] = 227, [1] = 228, [2] = 224, [3] = 225, [4] = 234, [5] = 229, [6] = 228, [7] = 235 }, [2] = { [0] = 87, [1] = 88, [2] = 84, [3] = 85, [4] = 94, [5] = 89, [6] = 88, [7] = 95 }, [3] = { [0] = 21, [1] = 22, [2] = 18, [3] = 19, [4] = 28, [5] = 23, [6] = 22, [7] = 29 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[55]][R[19]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 194, [1] = 232, [2] = 92, [3] = 26 } })[R[55]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[56]][R[19]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[56]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[57]][R[19]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[57]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[19]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[19]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[19]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[19]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[58]][R[19]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[58]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[19]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[19]] })
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[59]][R[19]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[59]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 } })[R[60]][R[19]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[60]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[61]][R[19]], ({ [0] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 } })[R[61]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[62]][R[19]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[62]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[37]][R[20]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[37]][R[20]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[37]][R[20]] })
    if R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [6] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [7] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[37]][R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[37]][R[20]], ({ [5] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [6] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [7] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [7] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[37]][R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 5 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[37] == 7 then
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
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [7] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[37]][R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 5 then
        elseif R[37] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[37]][R[20]], ({ [5] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 }, [7] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 } })[R[37]][R[20]], ({ [5] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [6] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [7] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 1 or R[37] == 2 or R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [3] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [4] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[37]][R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[20]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 185, [1] = 223, [2] = 83, [3] = 17 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 1 or R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[37]][R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[20]], ({ [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[37]][R[20]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[37]][R[20]], ({ [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 } })[R[37]][R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[37]][R[20]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 13, [1] = 128, [2] = 233, [3] = 128 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 13, [1] = 128, [2] = 233, [3] = 128 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [3] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 } })[R[37]][R[20]], ({ [1] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [3] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [4] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[20]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [3] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [5] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [6] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[37]][R[20]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [6] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [1] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [3] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [4] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [7] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 } })[R[37]][R[20]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [3] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [4] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [6] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[63]][R[20]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 194, [1] = 232, [2] = 92, [3] = 26 } })[R[63]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[64]][R[20]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[64]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[65]][R[20]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[65]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[20]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[20]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[20]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[20]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[66]][R[20]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[66]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[20]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[20]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[67]][R[20]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[67]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 } })[R[68]][R[20]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[68]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[69]][R[20]], ({ [0] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 } })[R[69]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[70]][R[20]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[70]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
    end
    R[71] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[71]][R[46]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [3] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [4] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [5] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[71]][R[46]], ({ [0] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [5] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [6] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[71]][R[46]] })
    if R[71] == 5 or R[71] == 6 or R[71] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [5] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [6] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [7] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[71]][R[46]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [6] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [7] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[71]][R[46]], ({ [5] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [6] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [7] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 5 or R[71] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [5] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [7] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[71]][R[46]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        if R[71] == 5 then
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
        elseif R[71] == 7 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        else
          unseen("R[71]", R[71])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [5] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 }, [7] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[71]][R[46]], ({ [5] = { [0] = 194, [1] = 232, [2] = 92, [3] = 26 }, [7] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        if R[71] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[71] == 7 then
        else
          unseen("R[71]", R[71])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [7] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[46]], ({ [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [5] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[71]][R[46]], ({ [5] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [7] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[71] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[46]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[46]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[71]", R[71])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 }, [7] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 } })[R[71]][R[46]], ({ [5] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [6] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [7] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[46]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[46]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[46]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
    elseif R[71] == 1 or R[71] == 2 or R[71] == 3 or R[71] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [3] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [4] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[71]][R[46]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[46]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[46]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[46]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 185, [1] = 223, [2] = 83, [3] = 17 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[46]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 1 or R[71] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 } })[R[71]][R[46]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[46]], ({ [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[71]][R[46]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 } })[R[71]][R[46]], ({ [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 22, [1] = 137, [2] = 242, [3] = 137 } })[R[71]][R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[71]][R[46]], ({ [1] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[46]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[46]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[46]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[46]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[46]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[71]", R[71])
      end
      U[#U]:set_lights(true)
      if R[71] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 13, [1] = 128, [2] = 233, [3] = 128 })[R[46]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[46]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
      U[#U]:set_lights(true)
      if R[71] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[46]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[46]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[46]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 13, [1] = 128, [2] = 233, [3] = 128 })[R[46]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [1] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [2] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [3] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 } })[R[71]][R[46]], ({ [1] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [2] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [3] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 }, [4] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[71] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[46]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 21, [1] = 136, [2] = 241, [3] = 136 })[R[46]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[46]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[46]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 24, [1] = 139, [2] = 244, [3] = 139 })[R[46]], ({ [0] = 186, [1] = 224, [2] = 84, [3] = 18 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 23, [1] = 138, [2] = 243, [3] = 138 })[R[46]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[46]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[71]", R[71])
    end
    U[#U]:set_lights(true)
    if R[71] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[46]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[46]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 1 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[46]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[46]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[46]], ({ [0] = 192, [1] = 230, [2] = 90, [3] = 24 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 2 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[46]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[46]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 3 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[46]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[46]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 14, [1] = 129, [2] = 234, [3] = 129 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[71] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[46]], ({ [0] = 188, [1] = 226, [2] = 86, [3] = 20 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[46]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[71] == 6 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[46]], ({ [0] = 189, [1] = 227, [2] = 87, [3] = 21 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 17, [1] = 132, [2] = 237, [3] = 132 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 196, [1] = 234, [2] = 94, [3] = 28 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 197, [1] = 235, [2] = 95, [3] = 29 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 190, [1] = 228, [2] = 88, [3] = 22 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 187, [1] = 225, [2] = 85, [3] = 19 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 25, [1] = 140, [2] = 245, [3] = 140 })[R[46]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[71]", R[71])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [3] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [4] = { [0] = 17, [1] = 132, [2] = 237, [3] = 132 }, [5] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [6] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [7] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[71]][R[46]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [3] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [4] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 }, [5] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [6] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [1] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [3] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [4] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [5] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 }, [6] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [7] = { [0] = 25, [1] = 140, [2] = 245, [3] = 140 } })[R[71]][R[46]], ({ [0] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [3] = { [0] = 187, [1] = 225, [2] = 85, [3] = 19 }, [4] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [5] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [6] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [7] = { [0] = 197, [1] = 235, [2] = 95, [3] = 29 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[71] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[72]][R[46]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 188, [1] = 226, [2] = 86, [3] = 20 }, [2] = { [0] = 194, [1] = 232, [2] = 92, [3] = 26 } })[R[72]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 18, [1] = 133, [2] = 238, [3] = 133 })[R[46]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[46]] })
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [1] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [2] = { [0] = 21, [1] = 136, [2] = 241, [3] = 136 } })[R[73]][R[46]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 189, [1] = 227, [2] = 87, [3] = 21 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[73]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[46]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[46]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[46]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[46]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[46]] })
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 15, [1] = 130, [2] = 235, [3] = 130 }, [2] = { [0] = 19, [1] = 134, [2] = 239, [3] = 134 } })[R[74]][R[46]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[74]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[46]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[46]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[46]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[46]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 16, [1] = 131, [2] = 236, [3] = 131 })[R[46]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 19, [1] = 134, [2] = 239, [3] = 134 })[R[46]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[46]] })
        game.create_tube({ ({ [0] = 20, [1] = 135, [2] = 240, [3] = 135 })[R[46]], ({ [0] = 191, [1] = 229, [2] = 89, [3] = 23 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[46]], ({ [0] = 194, [1] = 232, [2] = 92, [3] = 26 })[R[46]] })
        game.create_tube({ ({ [0] = 22, [1] = 137, [2] = 242, [3] = 137 })[R[46]], ({ [0] = 195, [1] = 233, [2] = 93, [3] = 27 })[R[46]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [2] = { [0] = 16, [1] = 131, [2] = 236, [3] = 131 } })[R[75]][R[46]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 190, [1] = 228, [2] = 88, [3] = 22 }, [2] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 } })[R[75]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[46]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 15, [1] = 130, [2] = 235, [3] = 130 })[R[46]], ({ [0] = 193, [1] = 231, [2] = 91, [3] = 25 })[R[46]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [1] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[76]][R[46]], ({ [0] = { [0] = 185, [1] = 223, [2] = 83, [3] = 17 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 } })[R[76]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 } })[R[77]][R[46]], ({ [0] = { [0] = 196, [1] = 234, [2] = 94, [3] = 28 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[77]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 }, [1] = { [0] = 23, [1] = 138, [2] = 243, [3] = 138 }, [2] = { [0] = 20, [1] = 135, [2] = 240, [3] = 135 } })[R[78]][R[46]], ({ [0] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 }, [1] = { [0] = 192, [1] = 230, [2] = 90, [3] = 24 }, [2] = { [0] = 193, [1] = 231, [2] = 91, [3] = 25 } })[R[78]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 18, [1] = 133, [2] = 238, [3] = 133 }, [1] = { [0] = 14, [1] = 129, [2] = 234, [3] = 129 }, [2] = { [0] = 24, [1] = 139, [2] = 244, [3] = 139 } })[R[79]][R[46]], ({ [0] = { [0] = 195, [1] = 233, [2] = 93, [3] = 27 }, [1] = { [0] = 191, [1] = 229, [2] = 89, [3] = 23 }, [2] = { [0] = 186, [1] = 224, [2] = 84, [3] = 18 } })[R[79]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Quakes}  -- after 60 to 120 marks
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Tornados}  -- after 60 to 120 marks
    trigger.research{tech = 8201, one_shot = true, on = Lava}
  end
  return true
end
