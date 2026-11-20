-- mr4_12Lua.lua  -  4 Player, ResourceRace, 'Olympus Mons' map. (Lua)
--
-- Converted by op2dll from mr4_12.dll ("4 Player, ResourceRace, 'Olympus Mons' map."): its setup replayed. `on_init` makes the original's
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
  { 1, 53, 60, 53 }, { 1, 54, 58, 54 }, { 1, 55, 57, 55 }, { 1, 56, 55, 56 }, { 1, 57, 54, 58 }, { 1, 59, 52, 59 },
  { 1, 60, 50, 60 }, { 1, 61, 49, 61 }, { 1, 62, 48, 63 }, { 1, 64, 49, 66 }, { 1, 67, 45, 67 }, { 1, 68, 44, 69 },
  { 1, 70, 43, 70 }, { 1, 71, 42, 72 }, { 1, 73, 39, 73 }, { 41, 73, 42, 73 }, { 1, 74, 38, 74 }, { 42, 74, 42, 74 },
  { 1, 75, 37, 75 }, { 1, 76, 34, 76 }, { 36, 76, 38, 76 }, { 1, 77, 28, 77 }, { 37, 77, 38, 77 }, { 1, 78, 26, 78 },
  { 37, 78, 39, 78 }, { 1, 79, 20, 79 }, { 38, 79, 39, 81 }, { 1, 80, 19, 80 }, { 1, 81, 18, 81 }, { 1, 82, 16, 82 },
  { 4, 83, 6, 83 }, { 10, 83, 15, 83 }, { 12, 84, 13, 84 },
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 160 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 111, 228 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 219, 127 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 116, 2 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 4, 206 } }
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
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 22, [1] = 154, [2] = 237, [3] = 139 })[R[0]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[0]], ({ [0] = 190, [1] = 253, [2] = 107, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 8, [1] = 140, [2] = 223, [3] = 125 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 3, [1] = 135, [2] = 218, [3] = 120 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[0]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[0]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[0]] })
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[2] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 11, [1] = 143, [2] = 226, [3] = 128 }, [1] = { [0] = 17, [1] = 149, [2] = 232, [3] = 134 }, [2] = { [0] = 5, [1] = 137, [2] = 220, [3] = 122 } })[R[2]][R[0]], ({ [0] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [1] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [2] = { [0] = 191, [1] = 254, [2] = 108, [3] = 30 } })[R[2]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[3] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 244, [1] = 98, [2] = 20, [3] = 181 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 244, [1] = 98, [2] = 20, [3] = 181 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 138, [1] = 221, [2] = 123, [3] = 6 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 138, [1] = 221, [2] = 123, [3] = 6 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 153, [1] = 236, [2] = 138, [3] = 21 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 154, [1] = 237, [2] = 139, [3] = 22 })[R[0]], ({ [0] = 249, [1] = 103, [2] = 25, [3] = 186 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 146, [1] = 229, [2] = 131, [3] = 14 })[R[0]], ({ [0] = 253, [1] = 107, [2] = 29, [3] = 190 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 156, [1] = 239, [2] = 141, [3] = 24 })[R[0]], ({ [0] = 244, [1] = 98, [2] = 20, [3] = 181 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 156, [1] = 239, [2] = 141, [3] = 24 })[R[0]], ({ [0] = 246, [1] = 100, [2] = 22, [3] = 183 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 155, [1] = 238, [2] = 140, [3] = 23 })[R[0]], ({ [0] = 238, [1] = 92, [2] = 14, [3] = 175 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 155, [1] = 238, [2] = 140, [3] = 23 })[R[0]], ({ [0] = 238, [1] = 92, [2] = 14, [3] = 175 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 156, [1] = 239, [2] = 141, [3] = 24 })[R[0]], ({ [0] = 246, [1] = 100, [2] = 22, [3] = 183 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 156, [1] = 239, [2] = 141, [3] = 24 })[R[0]], ({ [0] = 246, [1] = 100, [2] = 22, [3] = 183 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 155, [1] = 238, [2] = 140, [3] = 23 })[R[0]], ({ [0] = 238, [1] = 92, [2] = 14, [3] = 175 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif LEVEL_OF[players[2].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 140, [1] = 223, [2] = 125, [3] = 8 })[R[0]], ({ [0] = 244, [1] = 98, [2] = 20, [3] = 181 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 135, [1] = 218, [2] = 120, [3] = 3 })[R[0]], ({ [0] = 241, [1] = 95, [2] = 17, [3] = 178 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 149, [1] = 232, [2] = 134, [3] = 17 })[R[0]], ({ [0] = 243, [1] = 97, [2] = 19, [3] = 180 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = 138, [1] = 221, [2] = 123, [3] = 6 })[R[0]], ({ [0] = 240, [1] = 94, [2] = 16, [3] = 177 })[R[0]] })
    game.create_tube({ ({ [0] = 138, [1] = 221, [2] = 123, [3] = 6 })[R[0]], ({ [0] = 241, [1] = 95, [2] = 17, [3] = 178 })[R[0]] })
    game.create_tube({ ({ [0] = 138, [1] = 221, [2] = 123, [3] = 6 })[R[0]], ({ [0] = 242, [1] = 96, [2] = 18, [3] = 179 })[R[0]] })
    game.create_tube({ ({ [0] = 138, [1] = 221, [2] = 123, [3] = 6 })[R[0]], ({ [0] = 243, [1] = 97, [2] = 19, [3] = 180 })[R[0]] })
    game.create_tube({ ({ [0] = 138, [1] = 221, [2] = 123, [3] = 6 })[R[0]], ({ [0] = 244, [1] = 98, [2] = 20, [3] = 181 })[R[0]] })
    game.create_tube({ ({ [0] = 138, [1] = 221, [2] = 123, [3] = 6 })[R[0]], ({ [0] = 245, [1] = 99, [2] = 21, [3] = 182 })[R[0]] })
    game.create_tube({ ({ [0] = 138, [1] = 221, [2] = 123, [3] = 6 })[R[0]], ({ [0] = 246, [1] = 100, [2] = 22, [3] = 183 })[R[0]] })
    game.create_tube({ ({ [0] = 138, [1] = 221, [2] = 123, [3] = 6 })[R[0]], ({ [0] = 247, [1] = 101, [2] = 23, [3] = 184 })[R[0]] })
    game.create_tube({ ({ [0] = 138, [1] = 221, [2] = 123, [3] = 6 })[R[0]], ({ [0] = 248, [1] = 102, [2] = 24, [3] = 185 })[R[0]] })
    game.create_tube({ ({ [0] = 141, [1] = 224, [2] = 126, [3] = 9 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] })
    game.create_tube({ ({ [0] = 141, [1] = 224, [2] = 126, [3] = 9 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] })
    game.create_tube({ ({ [0] = 142, [1] = 225, [2] = 127, [3] = 10 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] })
    game.create_tube({ ({ [0] = 142, [1] = 225, [2] = 127, [3] = 10 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] })
    game.create_tube({ ({ [0] = 143, [1] = 226, [2] = 128, [3] = 11 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] })
    game.create_tube({ ({ [0] = 143, [1] = 226, [2] = 128, [3] = 11 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] })
    game.create_tube({ ({ [0] = 144, [1] = 227, [2] = 129, [3] = 12 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] })
    game.create_tube({ ({ [0] = 144, [1] = 227, [2] = 129, [3] = 12 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] })
    game.create_tube({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] })
    game.create_tube({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 238, [1] = 92, [2] = 14, [3] = 175 })[R[0]] })
    game.create_tube({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 239, [1] = 93, [2] = 15, [3] = 176 })[R[0]] })
    game.create_tube({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 240, [1] = 94, [2] = 16, [3] = 177 })[R[0]] })
    game.create_tube({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 241, [1] = 95, [2] = 17, [3] = 178 })[R[0]] })
    game.create_tube({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 242, [1] = 96, [2] = 18, [3] = 179 })[R[0]] })
    game.create_tube({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 246, [1] = 100, [2] = 22, [3] = 183 })[R[0]] })
    game.create_tube({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 247, [1] = 101, [2] = 23, [3] = 184 })[R[0]] })
    game.create_tube({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 248, [1] = 102, [2] = 24, [3] = 185 })[R[0]] })
    game.create_tube({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 249, [1] = 103, [2] = 25, [3] = 186 })[R[0]] })
    game.create_tube({ ({ [0] = 145, [1] = 228, [2] = 130, [3] = 13 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] })
    game.create_tube({ ({ [0] = 146, [1] = 229, [2] = 131, [3] = 14 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] })
    game.create_tube({ ({ [0] = 146, [1] = 229, [2] = 131, [3] = 14 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] })
    game.create_tube({ ({ [0] = 147, [1] = 230, [2] = 132, [3] = 15 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] })
    game.create_tube({ ({ [0] = 147, [1] = 230, [2] = 132, [3] = 15 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] })
    game.create_tube({ ({ [0] = 148, [1] = 231, [2] = 133, [3] = 16 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] })
    game.create_tube({ ({ [0] = 148, [1] = 231, [2] = 133, [3] = 16 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] })
    game.create_tube({ ({ [0] = 149, [1] = 232, [2] = 134, [3] = 17 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] })
    game.create_tube({ ({ [0] = 149, [1] = 232, [2] = 134, [3] = 17 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] })
    game.create_tube({ ({ [0] = 150, [1] = 233, [2] = 135, [3] = 18 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] })
    game.create_tube({ ({ [0] = 150, [1] = 233, [2] = 135, [3] = 18 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] })
    game.create_tube({ ({ [0] = 151, [1] = 234, [2] = 136, [3] = 19 })[R[0]], ({ [0] = 237, [1] = 91, [2] = 13, [3] = 174 })[R[0]] })
    game.create_tube({ ({ [0] = 151, [1] = 234, [2] = 136, [3] = 19 })[R[0]], ({ [0] = 250, [1] = 104, [2] = 26, [3] = 187 })[R[0]] })
    game.create_tube({ ({ [0] = 153, [1] = 236, [2] = 138, [3] = 21 })[R[0]], ({ [0] = 239, [1] = 93, [2] = 15, [3] = 176 })[R[0]] })
    game.create_tube({ ({ [0] = 153, [1] = 236, [2] = 138, [3] = 21 })[R[0]], ({ [0] = 240, [1] = 94, [2] = 16, [3] = 177 })[R[0]] })
    game.create_tube({ ({ [0] = 153, [1] = 236, [2] = 138, [3] = 21 })[R[0]], ({ [0] = 241, [1] = 95, [2] = 17, [3] = 178 })[R[0]] })
    game.create_tube({ ({ [0] = 153, [1] = 236, [2] = 138, [3] = 21 })[R[0]], ({ [0] = 242, [1] = 96, [2] = 18, [3] = 179 })[R[0]] })
    game.create_tube({ ({ [0] = 153, [1] = 236, [2] = 138, [3] = 21 })[R[0]], ({ [0] = 243, [1] = 97, [2] = 19, [3] = 180 })[R[0]] })
    game.create_tube({ ({ [0] = 153, [1] = 236, [2] = 138, [3] = 21 })[R[0]], ({ [0] = 244, [1] = 98, [2] = 20, [3] = 181 })[R[0]] })
    game.create_tube({ ({ [0] = 153, [1] = 236, [2] = 138, [3] = 21 })[R[0]], ({ [0] = 245, [1] = 99, [2] = 21, [3] = 182 })[R[0]] })
    game.create_tube({ ({ [0] = 153, [1] = 236, [2] = 138, [3] = 21 })[R[0]], ({ [0] = 246, [1] = 100, [2] = 22, [3] = 183 })[R[0]] })
    game.create_tube({ ({ [0] = 153, [1] = 236, [2] = 138, [3] = 21 })[R[0]], ({ [0] = 247, [1] = 101, [2] = 23, [3] = 184 })[R[0]] })
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[4] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 143, [1] = 226, [2] = 128, [3] = 11 }, [1] = { [0] = 149, [1] = 232, [2] = 134, [3] = 17 }, [2] = { [0] = 137, [1] = 220, [2] = 122, [3] = 5 } })[R[4]][R[0]], ({ [0] = { [0] = 233, [1] = 87, [2] = 9, [3] = 170 }, [1] = { [0] = 233, [1] = 87, [2] = 9, [3] = 170 }, [2] = { [0] = 254, [1] = 108, [2] = 30, [3] = 191 } })[R[4]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 160 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 111, 228 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 219, 127 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 116, 2 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 4, 206 } }
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
    pick(4, 3, { 0, 5, 6 })
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 22, [1] = 154, [2] = 237, [3] = 139 })[R[0]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[0]], ({ [0] = 190, [1] = 253, [2] = 107, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 8, [1] = 140, [2] = 223, [3] = 125 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 3, [1] = 135, [2] = 218, [3] = 120 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[0]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[0]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[0]] })
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[7] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 11, [1] = 143, [2] = 226, [3] = 128 }, [1] = { [0] = 17, [1] = 149, [2] = 232, [3] = 134 }, [2] = { [0] = 5, [1] = 137, [2] = 220, [3] = 122 } })[R[7]][R[0]], ({ [0] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [1] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [2] = { [0] = 191, [1] = 254, [2] = 108, [3] = 30 } })[R[7]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[3] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 22, [1] = 154, [2] = 237, [3] = 139 })[R[5]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[5]], ({ [0] = 190, [1] = 253, [2] = 107, [3] = 29 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[5]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[5]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[5]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif LEVEL_OF[players[2].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 140, [2] = 223, [3] = 125 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 3, [1] = 135, [2] = 218, [3] = 120 })[R[5]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[5]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[5]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[5]] })
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[8] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 11, [1] = 143, [2] = 226, [3] = 128 }, [1] = { [0] = 17, [1] = 149, [2] = 232, [3] = 134 }, [2] = { [0] = 5, [1] = 137, [2] = 220, [3] = 122 } })[R[8]][R[5]], ({ [0] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [1] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [2] = { [0] = 191, [1] = 254, [2] = 108, [3] = 30 } })[R[8]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[9] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 22, [1] = 154, [2] = 237, [3] = 139 })[R[6]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[6]], ({ [0] = 190, [1] = 253, [2] = 107, [3] = 29 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[6]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[6]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[3].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[6]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif LEVEL_OF[players[3].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 8, [1] = 140, [2] = 223, [3] = 125 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 3, [1] = 135, [2] = 218, [3] = 120 })[R[6]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[6]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[6]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[6]] })
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[10] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 11, [1] = 143, [2] = 226, [3] = 128 }, [1] = { [0] = 17, [1] = 149, [2] = 232, [3] = 134 }, [2] = { [0] = 5, [1] = 137, [2] = 220, [3] = 122 } })[R[10]][R[6]], ({ [0] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [1] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [2] = { [0] = 191, [1] = 254, [2] = 108, [3] = 30 } })[R[10]][R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 4, 160 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 111, 228 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 219, 127 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 116, 2 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 4, 206 } }
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
    pick(4, 4, { 0, 5, 6, 11 })
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 22, [1] = 154, [2] = 237, [3] = 139 })[R[0]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[0]], ({ [0] = 190, [1] = 253, [2] = 107, [3] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[1].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[1].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 8, [1] = 140, [2] = 223, [3] = 125 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 3, [1] = 135, [2] = 218, [3] = 120 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[0]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[0]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[0]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[0]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[0]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[0]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[0]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[0]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[0]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[0]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[0]] })
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[12] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 11, [1] = 143, [2] = 226, [3] = 128 }, [1] = { [0] = 17, [1] = 149, [2] = 232, [3] = 134 }, [2] = { [0] = 5, [1] = 137, [2] = 220, [3] = 122 } })[R[12]][R[0]], ({ [0] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [1] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [2] = { [0] = 191, [1] = 254, [2] = 108, [3] = 30 } })[R[12]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[3] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 22, [1] = 154, [2] = 237, [3] = 139 })[R[5]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[5]], ({ [0] = 190, [1] = 253, [2] = 107, [3] = 29 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[5]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[5]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[5]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif LEVEL_OF[players[2].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 8, [1] = 140, [2] = 223, [3] = 125 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 3, [1] = 135, [2] = 218, [3] = 120 })[R[5]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[5]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[5]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[5]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[5]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[5]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[5]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[5]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[5]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[5]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[5]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[5]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[5]] })
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[13] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 11, [1] = 143, [2] = 226, [3] = 128 }, [1] = { [0] = 17, [1] = 149, [2] = 232, [3] = 134 }, [2] = { [0] = 5, [1] = 137, [2] = 220, [3] = 122 } })[R[13]][R[5]], ({ [0] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [1] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [2] = { [0] = 191, [1] = 254, [2] = 108, [3] = 30 } })[R[13]][R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[9] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 22, [1] = 154, [2] = 237, [3] = 139 })[R[6]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[6]], ({ [0] = 190, [1] = 253, [2] = 107, [3] = 29 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[6]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[6]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[3].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[3].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[6]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif LEVEL_OF[players[3].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 8, [1] = 140, [2] = 223, [3] = 125 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 3, [1] = 135, [2] = 218, [3] = 120 })[R[6]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[6]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[6]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[6]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[6]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[6]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[6]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[6]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[6]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[6]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[6]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[6]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[6]] })
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[14] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 11, [1] = 143, [2] = 226, [3] = 128 }, [1] = { [0] = 17, [1] = 149, [2] = 232, [3] = 134 }, [2] = { [0] = 5, [1] = 137, [2] = 220, [3] = 122 } })[R[14]][R[6]], ({ [0] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [1] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [2] = { [0] = 191, [1] = 254, [2] = 108, [3] = 30 } })[R[14]][R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[15] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[11]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
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
    U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 22, [1] = 154, [2] = 237, [3] = 139 })[R[11]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[11]], ({ [0] = 190, [1] = 253, [2] = 107, [3] = 29 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[11]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[11]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[11]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[11]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[11]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[4].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 24, [1] = 156, [2] = 239, [3] = 141 })[R[11]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[4].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 23, [1] = 155, [2] = 238, [3] = 140 })[R[11]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif LEVEL_OF[players[4].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
    end
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 8, [1] = 140, [2] = 223, [3] = 125 })[R[11]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 3, [1] = 135, [2] = 218, [3] = 120 })[R[11]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[11]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[11]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[11]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[11]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[11]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[11]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[11]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[11]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[11]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[11]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[11]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[11]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[11]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[11]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[11]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[11]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[11]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[11]] })
    game.create_tube({ ({ [0] = 6, [1] = 138, [2] = 221, [3] = 123 })[R[11]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[11]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] })
    game.create_tube({ ({ [0] = 9, [1] = 141, [2] = 224, [3] = 126 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] })
    game.create_tube({ ({ [0] = 10, [1] = 142, [2] = 225, [3] = 127 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] })
    game.create_tube({ ({ [0] = 11, [1] = 143, [2] = 226, [3] = 128 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] })
    game.create_tube({ ({ [0] = 12, [1] = 144, [2] = 227, [3] = 129 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 175, [1] = 238, [2] = 92, [3] = 14 })[R[11]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[11]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[11]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[11]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[11]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[11]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[11]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 185, [1] = 248, [2] = 102, [3] = 24 })[R[11]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 186, [1] = 249, [2] = 103, [3] = 25 })[R[11]] })
    game.create_tube({ ({ [0] = 13, [1] = 145, [2] = 228, [3] = 130 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] })
    game.create_tube({ ({ [0] = 14, [1] = 146, [2] = 229, [3] = 131 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] })
    game.create_tube({ ({ [0] = 15, [1] = 147, [2] = 230, [3] = 132 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] })
    game.create_tube({ ({ [0] = 16, [1] = 148, [2] = 231, [3] = 133 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] })
    game.create_tube({ ({ [0] = 17, [1] = 149, [2] = 232, [3] = 134 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] })
    game.create_tube({ ({ [0] = 18, [1] = 150, [2] = 233, [3] = 135 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[11]], ({ [0] = 174, [1] = 237, [2] = 91, [3] = 13 })[R[11]] })
    game.create_tube({ ({ [0] = 19, [1] = 151, [2] = 234, [3] = 136 })[R[11]], ({ [0] = 187, [1] = 250, [2] = 104, [3] = 26 })[R[11]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[11]], ({ [0] = 176, [1] = 239, [2] = 93, [3] = 15 })[R[11]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[11]], ({ [0] = 177, [1] = 240, [2] = 94, [3] = 16 })[R[11]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[11]], ({ [0] = 178, [1] = 241, [2] = 95, [3] = 17 })[R[11]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[11]], ({ [0] = 179, [1] = 242, [2] = 96, [3] = 18 })[R[11]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[11]], ({ [0] = 180, [1] = 243, [2] = 97, [3] = 19 })[R[11]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[11]], ({ [0] = 181, [1] = 244, [2] = 98, [3] = 20 })[R[11]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[11]], ({ [0] = 182, [1] = 245, [2] = 99, [3] = 21 })[R[11]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[11]], ({ [0] = 183, [1] = 246, [2] = 100, [3] = 22 })[R[11]] })
    game.create_tube({ ({ [0] = 21, [1] = 153, [2] = 236, [3] = 138 })[R[11]], ({ [0] = 184, [1] = 247, [2] = 101, [3] = 23 })[R[11]] })
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[16] = game.rand(3)
        U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 11, [1] = 143, [2] = 226, [3] = 128 }, [1] = { [0] = 17, [1] = 149, [2] = 232, [3] = 134 }, [2] = { [0] = 5, [1] = 137, [2] = 220, [3] = 122 } })[R[16]][R[11]], ({ [0] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [1] = { [0] = 170, [1] = 233, [2] = 87, [3] = 9 }, [2] = { [0] = 191, [1] = 254, [2] = 108, [3] = 30 } })[R[16]][R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
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
  local t3 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 20000}
  local t2 = trigger.resource{resource = "RareOre", compare = ">=", amount = 5000}
  local t4 = trigger.set{t3, t2}
  mission.victory(t4, "Be the first to have 20,000 Common Metal and 5,000 Rare Metal in storage.", {one_shot = true})
  if game.disasters_enabled() then
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Quakes}  -- after 60 to 120 marks
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Tornados}  -- after 60 to 120 marks
    trigger.research{tech = 8201, one_shot = true, on = Lava}
  end
  return true
end
