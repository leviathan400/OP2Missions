-- ml4_07Lua.lua  -  4 Player, LastOne, 'Four Mesas' map. (Lua)
--
-- Converted by op2dll from ml4_07.dll ("4 Player, LastOne, 'Four Mesas' map."): its setup replayed. `on_init` makes the original's
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
local Meteors, Tornados

function Meteors(t)
  local r1 = game.rand(255)
  local r2 = game.rand(256)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 36, 55 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 206, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 220, 200 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 72, 212 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 111, 249 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 214 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 228 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 98, 173 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 148, 165 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 132, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 126, 211 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 39, 136 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 140 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 91, 105 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 110 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 11, 114 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 42, 123 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 115 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 142, 8 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 159, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 112, 47 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 137, 68 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 152, 47 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 123, 30 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 161, 117 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 205, 100 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 244, 110 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 232, 131 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 199, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 224, 119 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 179, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 199, 241 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 251, 212 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 148, 248 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 17, 210 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 40, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 244 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 54, 30 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 104, 7 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 51 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 236, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 180, 28 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 231, 24 } }
    R[0] = game.rand(4)
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 106, [1] = 97, [2] = 160, [3] = 161 })[R[0]], ({ [0] = 102, [1] = 155, [2] = 163, [3] = 85 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[0] == 2 or R[0] == 3 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [2] = 165, [3] = 166 })[R[0]], ({ [2] = 159, [3] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 0 or R[0] == 1 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 100, [1] = 97, [2] = 170, [3] = 171 })[R[0]], ({ [0] = 103, [1] = 161, [2] = 161, [3] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[1]][R[0]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[1]][R[0]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] })
    if R[1] == 1 or R[1] == 2 or R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [3] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [4] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[1]][R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 69, [1] = 164, [2] = 169, [3] = 64 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 1 or R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[1]][R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[0]], ({ [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[1]][R[0]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[1]][R[0]], ({ [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 } })[R[1]][R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[1]][R[0]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [3] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 } })[R[1]][R[0]], ({ [1] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [3] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [4] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [6] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [7] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[1]][R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[1]][R[0]], ({ [5] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [6] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [7] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 or R[1] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [7] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[1]][R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [7] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[1]][R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[1] == 5 then
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[1]][R[0]], ({ [5] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[1] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 }, [7] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 } })[R[1]][R[0]], ({ [5] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [6] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [7] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 6 then
      if LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [3] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [5] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [6] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[1]][R[0]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [6] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [1] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [3] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [4] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [7] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 } })[R[1]][R[0]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [3] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [4] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [6] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[2] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[2]][R[0]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 78, [1] = 173, [2] = 178, [3] = 73 } })[R[2]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        for i = 1, game.initial_units() do
          R[3] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[3]][R[0]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[3]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        for i = 1, game.initial_units() do
          R[4] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[4]][R[0]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[4]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        for i = 1, game.initial_units() do
          R[5] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[5]][R[0]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[5]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] })
        for i = 1, game.initial_units() do
          R[6] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[6]][R[0]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[6]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 } })[R[7]][R[0]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[7]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[8]][R[0]], ({ [0] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 } })[R[8]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[9]][R[0]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[9]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 161, [1] = 160, [2] = 97, [3] = 106 })[R[0]], ({ [0] = 85, [1] = 163, [2] = 155, [3] = 102 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[0] == 2 or R[0] == 3 then
    elseif R[0] == 0 or R[0] == 1 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 166, [1] = 165 })[R[0]], ({ [0] = 92, [1] = 159 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 171, [1] = 170, [2] = 97, [3] = 100 })[R[0]], ({ [0] = 92, [1] = 161, [2] = 161, [3] = 103 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 173, [1] = 209, [2] = 72, [3] = 83 }, [1] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 }, [2] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 }, [3] = { [0] = 169, [1] = 205, [2] = 68, [3] = 79 }, [4] = { [0] = 173, [1] = 209, [2] = 72, [3] = 83 }, [5] = { [0] = 172, [1] = 208, [2] = 71, [3] = 82 }, [6] = { [0] = 169, [1] = 205, [2] = 68, [3] = 79 }, [7] = { [0] = 175, [1] = 211, [2] = 74, [3] = 85 } })[R[10]][R[0]], ({ [0] = { [0] = 71, [1] = 176, [2] = 171, [3] = 76 }, [1] = { [0] = 67, [1] = 172, [2] = 167, [3] = 72 }, [2] = { [0] = 71, [1] = 176, [2] = 171, [3] = 76 }, [3] = { [0] = 67, [1] = 172, [2] = 167, [3] = 72 }, [4] = { [0] = 70, [1] = 175, [2] = 170, [3] = 75 }, [5] = { [0] = 68, [1] = 173, [2] = 168, [3] = 73 }, [6] = { [0] = 65, [1] = 170, [2] = 165, [3] = 70 }, [7] = { [0] = 68, [1] = 173, [2] = 168, [3] = 73 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 173, [1] = 209, [2] = 72, [3] = 83 }, [1] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 }, [2] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 }, [3] = { [0] = 169, [1] = 205, [2] = 68, [3] = 79 }, [4] = { [0] = 173, [1] = 209, [2] = 72, [3] = 83 }, [5] = { [0] = 172, [1] = 208, [2] = 71, [3] = 82 }, [6] = { [0] = 169, [1] = 205, [2] = 68, [3] = 79 }, [7] = { [0] = 175, [1] = 211, [2] = 74, [3] = 85 } })[R[10]][R[0]], ({ [0] = { [0] = 71, [1] = 176, [2] = 171, [3] = 76 }, [1] = { [0] = 67, [1] = 172, [2] = 167, [3] = 72 }, [2] = { [0] = 71, [1] = 176, [2] = 171, [3] = 76 }, [3] = { [0] = 67, [1] = 172, [2] = 167, [3] = 72 }, [4] = { [0] = 70, [1] = 175, [2] = 170, [3] = 75 }, [5] = { [0] = 68, [1] = 173, [2] = 168, [3] = 73 }, [6] = { [0] = 65, [1] = 170, [2] = 165, [3] = 70 }, [7] = { [0] = 68, [1] = 173, [2] = 168, [3] = 73 } })[R[10]][R[0]] })
    if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 }, [2] = { [0] = 170, [1] = 206, [2] = 69, [3] = 80 }, [3] = { [0] = 174, [1] = 210, [2] = 73, [3] = 84 }, [4] = { [0] = 170, [1] = 206, [2] = 69, [3] = 80 } })[R[10]][R[0]], ({ [0] = 74, [1] = 179, [2] = 174, [3] = 79 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 170, [1] = 206, [2] = 69, [3] = 80 })[R[0]], ({ [0] = 66, [1] = 171, [2] = 166, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 174, [1] = 210, [2] = 73, [3] = 84 })[R[0]], ({ [0] = 67, [1] = 172, [2] = 167, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 169, [1] = 205, [2] = 68, [3] = 79 })[R[0]], ({ [0] = 70, [1] = 175, [2] = 170, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 178, [1] = 214, [2] = 77, [3] = 88 })[R[0]], ({ [0] = 75, [1] = 180, [2] = 175, [3] = 80 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 64, [1] = 169, [2] = 164, [3] = 69 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 173, [1] = 209, [2] = 72, [3] = 83 })[R[0]], ({ [0] = 65, [1] = 170, [2] = 165, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 169, [1] = 205, [2] = 68, [3] = 79 })[R[0]], ({ [0] = 75, [1] = 180, [2] = 175, [3] = 80 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 71, [1] = 176, [2] = 171, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 170, [1] = 206, [2] = 69, [3] = 80 })[R[0]], ({ [0] = 70, [1] = 175, [2] = 170, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 178, [1] = 214, [2] = 77, [3] = 88 })[R[0]], ({ [0] = 65, [1] = 170, [2] = 165, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 175, [1] = 211, [2] = 74, [3] = 85 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 75, [1] = 180, [2] = 175, [3] = 80 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 1 or R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 168, [1] = 204, [2] = 67, [3] = 78 }, [2] = { [0] = 169, [1] = 205, [2] = 68, [3] = 79 } })[R[10]][R[0]], ({ [0] = 65, [1] = 170, [2] = 165, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 177, [1] = 213, [2] = 76, [3] = 87 })[R[0]], ({ [1] = { [0] = 70, [1] = 175, [2] = 170, [3] = 75 }, [2] = { [0] = 74, [1] = 179, [2] = 174, [3] = 79 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 172, [1] = 208, [2] = 71, [3] = 82 }, [2] = { [0] = 173, [1] = 209, [2] = 72, [3] = 83 } })[R[10]][R[0]], ({ [1] = { [0] = 75, [1] = 180, [2] = 175, [3] = 80 }, [2] = { [0] = 71, [1] = 176, [2] = 171, [3] = 76 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 172, [1] = 208, [2] = 71, [3] = 82 }, [2] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 } })[R[10]][R[0]], ({ [1] = { [0] = 71, [1] = 176, [2] = 171, [3] = 76 }, [2] = { [0] = 68, [1] = 173, [2] = 168, [3] = 73 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 178, [1] = 214, [2] = 77, [3] = 88 }, [2] = { [0] = 176, [1] = 212, [2] = 75, [3] = 86 } })[R[10]][R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 179, [1] = 215, [2] = 78, [3] = 89 }, [2] = { [0] = 178, [1] = 214, [2] = 77, [3] = 88 } })[R[10]][R[0]], ({ [1] = { [0] = 75, [1] = 180, [2] = 175, [3] = 80 }, [2] = { [0] = 76, [1] = 181, [2] = 176, [3] = 81 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 174, [1] = 210, [2] = 73, [3] = 84 })[R[0]], ({ [0] = 75, [1] = 180, [2] = 175, [3] = 80 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 177, [1] = 213, [2] = 76, [3] = 87 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 167, [1] = 203, [2] = 66, [3] = 77 })[R[0]], ({ [0] = 72, [1] = 177, [2] = 172, [3] = 77 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 173, [1] = 209, [2] = 72, [3] = 83 })[R[0]], ({ [0] = 65, [1] = 170, [2] = 165, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 179, [1] = 215, [2] = 78, [3] = 89 })[R[0]], ({ [0] = 72, [1] = 177, [2] = 172, [3] = 77 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 171, [1] = 207, [2] = 70, [3] = 81 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 171, [1] = 207, [2] = 70, [3] = 81 })[R[0]], ({ [0] = 72, [1] = 177, [2] = 172, [3] = 77 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 171, [1] = 207, [2] = 70, [3] = 81 })[R[0]], ({ [0] = 68, [1] = 173, [2] = 168, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 167, [1] = 203, [2] = 66, [3] = 77 })[R[0]], ({ [0] = 72, [1] = 177, [2] = 172, [3] = 77 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 179, [1] = 215, [2] = 78, [3] = 89 }, [2] = { [0] = 171, [1] = 207, [2] = 70, [3] = 81 }, [3] = { [0] = 171, [1] = 207, [2] = 70, [3] = 81 }, [4] = { [0] = 171, [1] = 207, [2] = 70, [3] = 81 } })[R[10]][R[0]], ({ [1] = { [0] = 72, [1] = 177, [2] = 172, [3] = 77 }, [2] = { [0] = 76, [1] = 181, [2] = 176, [3] = 81 }, [3] = { [0] = 72, [1] = 177, [2] = 172, [3] = 77 }, [4] = { [0] = 68, [1] = 173, [2] = 168, [3] = 73 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 169, [1] = 205, [2] = 68, [3] = 79 }, [6] = { [0] = 178, [1] = 214, [2] = 77, [3] = 88 }, [7] = { [0] = 169, [1] = 205, [2] = 68, [3] = 79 } })[R[10]][R[0]], ({ [0] = 75, [1] = 180, [2] = 175, [3] = 80 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 }, [6] = { [0] = 169, [1] = 205, [2] = 68, [3] = 79 }, [7] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 } })[R[10]][R[0]], ({ [5] = { [0] = 69, [1] = 174, [2] = 169, [3] = 74 }, [6] = { [0] = 74, [1] = 179, [2] = 174, [3] = 79 }, [7] = { [0] = 74, [1] = 179, [2] = 174, [3] = 79 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 or R[10] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [5] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 }, [7] = { [0] = 170, [1] = 206, [2] = 69, [3] = 80 } })[R[10]][R[0]], ({ [0] = 65, [1] = 170, [2] = 165, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [5] = { [0] = 172, [1] = 208, [2] = 71, [3] = 82 }, [7] = { [0] = 174, [1] = 210, [2] = 73, [3] = 84 } })[R[10]][R[0]], ({ [0] = 65, [1] = 170, [2] = 165, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
        elseif R[10] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 175, [1] = 211, [2] = 74, [3] = 85 })[R[0]], ({ [0] = 71, [1] = 176, [2] = 171, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [5] = { [0] = 71, [1] = 176, [2] = 171, [3] = 76 }, [7] = { [0] = 68, [1] = 173, [2] = 168, [3] = 73 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 173, [1] = 209, [2] = 72, [3] = 83 })[R[0]], ({ [5] = { [0] = 70, [1] = 175, [2] = 170, [3] = 75 }, [7] = { [0] = 69, [1] = 174, [2] = 169, [3] = 74 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [5] = { [0] = 173, [1] = 209, [2] = 72, [3] = 83 }, [7] = { [0] = 178, [1] = 214, [2] = 77, [3] = 88 } })[R[10]][R[0]], ({ [5] = { [0] = 72, [1] = 177, [2] = 172, [3] = 77 }, [7] = { [0] = 69, [1] = 174, [2] = 169, [3] = 74 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 169, [1] = 205, [2] = 68, [3] = 79 })[R[0]], ({ [0] = 71, [1] = 176, [2] = 171, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 169, [1] = 205, [2] = 68, [3] = 79 })[R[0]], ({ [0] = 68, [1] = 173, [2] = 168, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 174, [1] = 210, [2] = 73, [3] = 84 })[R[0]], ({ [0] = 66, [1] = 171, [2] = 166, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 179, [1] = 215, [2] = 78, [3] = 89 }, [6] = { [0] = 176, [1] = 212, [2] = 75, [3] = 86 }, [7] = { [0] = 172, [1] = 208, [2] = 71, [3] = 82 } })[R[10]][R[0]], ({ [5] = { [0] = 67, [1] = 172, [2] = 167, [3] = 72 }, [6] = { [0] = 68, [1] = 173, [2] = 168, [3] = 73 }, [7] = { [0] = 66, [1] = 171, [2] = 166, [3] = 71 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 179, [1] = 215, [2] = 78, [3] = 89 })[R[0]], ({ [0] = 67, [1] = 172, [2] = 167, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 68, [1] = 173, [2] = 168, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 68, [1] = 173, [2] = 168, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 171, [1] = 207, [2] = 70, [3] = 81 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 75, [1] = 180, [2] = 175, [3] = 80 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 66, [1] = 171, [2] = 166, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 170, [1] = 206, [2] = 69, [3] = 80 })[R[0]], ({ [0] = 74, [1] = 179, [2] = 174, [3] = 79 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 175, [1] = 211, [2] = 74, [3] = 85 })[R[0]], ({ [0] = 74, [1] = 179, [2] = 174, [3] = 79 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 169, [1] = 205, [2] = 68, [3] = 79 })[R[0]], ({ [0] = 71, [1] = 176, [2] = 171, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 177, [1] = 213, [2] = 76, [3] = 87 })[R[0]], ({ [0] = 71, [1] = 176, [2] = 171, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 178, [1] = 214, [2] = 77, [3] = 88 })[R[0]], ({ [0] = 65, [1] = 170, [2] = 165, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 177, [1] = 213, [2] = 76, [3] = 87 })[R[0]], ({ [0] = 75, [1] = 180, [2] = 175, [3] = 80 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 179, [1] = 215, [2] = 78, [3] = 89 })[R[0]], ({ [0] = 74, [1] = 179, [2] = 174, [3] = 79 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 168, [1] = 204, [2] = 67, [3] = 78 })[R[0]], ({ [0] = 67, [1] = 172, [2] = 167, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 168, [1] = 204, [2] = 67, [3] = 78 })[R[0]], ({ [0] = 67, [1] = 172, [2] = 167, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 179, [1] = 215, [2] = 78, [3] = 89 })[R[0]], ({ [0] = 72, [1] = 177, [2] = 172, [3] = 77 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 169, [1] = 205, [2] = 68, [3] = 79 })[R[0]], ({ [0] = 71, [1] = 176, [2] = 171, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 169, [1] = 205, [2] = 68, [3] = 79 })[R[0]], ({ [0] = 71, [1] = 176, [2] = 171, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 171, [1] = 207, [2] = 70, [3] = 81 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 173, [1] = 209, [2] = 72, [3] = 83 })[R[0]], ({ [0] = 67, [1] = 172, [2] = 167, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 173, [1] = 209, [2] = 72, [3] = 83 })[R[0]], ({ [0] = 67, [1] = 172, [2] = 167, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 171, [1] = 207, [2] = 70, [3] = 81 })[R[0]], ({ [0] = 72, [1] = 177, [2] = 172, [3] = 77 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 68, [1] = 173, [2] = 168, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 68, [1] = 173, [2] = 168, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 171, [1] = 207, [2] = 70, [3] = 81 })[R[0]], ({ [0] = 68, [1] = 173, [2] = 168, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 168, [1] = 204, [2] = 67, [3] = 78 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 179, [1] = 215, [2] = 78, [3] = 89 })[R[0]], ({ [0] = 67, [1] = 172, [2] = 167, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 179, [1] = 215, [2] = 78, [3] = 89 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 68, [1] = 173, [2] = 168, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 171, [1] = 207, [2] = 70, [3] = 81 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 75, [1] = 180, [2] = 175, [3] = 80 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 174, [1] = 210, [2] = 73, [3] = 84 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 69, [1] = 174, [2] = 169, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 174, [1] = 210, [2] = 73, [3] = 84 })[R[0]], ({ [0] = 76, [1] = 181, [2] = 176, [3] = 81 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 69, [1] = 174, [2] = 169, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 66, [1] = 171, [2] = 166, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 179, [1] = 215, [2] = 78, [3] = 89 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 169, [1] = 205, [2] = 68, [3] = 79 }, [1] = { [0] = 168, [1] = 204, [2] = 67, [3] = 78 }, [2] = { [0] = 174, [1] = 210, [2] = 73, [3] = 84 }, [3] = { [0] = 173, [1] = 209, [2] = 72, [3] = 83 }, [4] = { [0] = 171, [1] = 207, [2] = 70, [3] = 81 }, [5] = { [0] = 178, [1] = 214, [2] = 77, [3] = 88 }, [6] = { [0] = 173, [1] = 209, [2] = 72, [3] = 83 }, [7] = { [0] = 178, [1] = 214, [2] = 77, [3] = 88 } })[R[10]][R[0]], ({ [0] = { [0] = 68, [1] = 173, [2] = 168, [3] = 73 }, [1] = { [0] = 70, [1] = 175, [2] = 170, [3] = 75 }, [2] = { [0] = 66, [1] = 171, [2] = 166, [3] = 71 }, [3] = { [0] = 67, [1] = 172, [2] = 167, [3] = 72 }, [4] = { [0] = 76, [1] = 181, [2] = 176, [3] = 81 }, [5] = { [0] = 71, [1] = 176, [2] = 171, [3] = 76 }, [6] = { [0] = 70, [1] = 175, [2] = 170, [3] = 75 }, [7] = { [0] = 76, [1] = 181, [2] = 176, [3] = 81 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 170, [1] = 206, [2] = 69, [3] = 80 }, [1] = { [0] = 170, [1] = 206, [2] = 69, [3] = 80 }, [2] = { [0] = 173, [1] = 209, [2] = 72, [3] = 83 }, [3] = { [0] = 172, [1] = 208, [2] = 71, [3] = 82 }, [4] = { [0] = 172, [1] = 208, [2] = 71, [3] = 82 }, [5] = { [0] = 179, [1] = 215, [2] = 78, [3] = 89 }, [6] = { [0] = 174, [1] = 210, [2] = 73, [3] = 84 }, [7] = { [0] = 179, [1] = 215, [2] = 78, [3] = 89 } })[R[10]][R[0]], ({ [0] = { [0] = 68, [1] = 173, [2] = 168, [3] = 73 }, [1] = { [0] = 69, [1] = 174, [2] = 169, [3] = 74 }, [2] = { [0] = 65, [1] = 170, [2] = 165, [3] = 70 }, [3] = { [0] = 66, [1] = 171, [2] = 166, [3] = 71 }, [4] = { [0] = 75, [1] = 180, [2] = 175, [3] = 80 }, [5] = { [0] = 70, [1] = 175, [2] = 170, [3] = 75 }, [6] = { [0] = 69, [1] = 174, [2] = 169, [3] = 74 }, [7] = { [0] = 76, [1] = 181, [2] = 176, [3] = 81 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[11] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 168, [1] = 204, [2] = 67, [3] = 78 }, [1] = { [0] = 173, [1] = 209, [2] = 72, [3] = 83 }, [2] = { [0] = 178, [1] = 214, [2] = 77, [3] = 88 } })[R[11]][R[0]], ({ [0] = { [0] = 64, [1] = 169, [2] = 164, [3] = 69 }, [1] = { [0] = 67, [1] = 172, [2] = 167, [3] = 72 }, [2] = { [0] = 73, [1] = 178, [2] = 173, [3] = 78 } })[R[11]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 172, [1] = 208, [2] = 71, [3] = 82 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] })
        for i = 1, game.initial_units() do
          R[12] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 168, [1] = 204, [2] = 67, [3] = 78 }, [1] = { [0] = 172, [1] = 208, [2] = 71, [3] = 82 }, [2] = { [0] = 175, [1] = 211, [2] = 74, [3] = 85 } })[R[12]][R[0]], ({ [0] = { [0] = 74, [1] = 179, [2] = 174, [3] = 79 }, [1] = { [0] = 68, [1] = 173, [2] = 168, [3] = 73 }, [2] = { [0] = 64, [1] = 169, [2] = 164, [3] = 69 } })[R[12]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 173, [1] = 209, [2] = 72, [3] = 83 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] })
        game.create_tube({ ({ [0] = 173, [1] = 209, [2] = 72, [3] = 83 })[R[0]], ({ [0] = 74, [1] = 179, [2] = 174, [3] = 79 })[R[0]] })
        game.create_tube({ ({ [0] = 174, [1] = 210, [2] = 73, [3] = 84 })[R[0]], ({ [0] = 74, [1] = 179, [2] = 174, [3] = 79 })[R[0]] })
        for i = 1, game.initial_units() do
          R[13] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 }, [1] = { [0] = 169, [1] = 205, [2] = 68, [3] = 79 }, [2] = { [0] = 173, [1] = 209, [2] = 72, [3] = 83 } })[R[13]][R[0]], ({ [0] = { [0] = 64, [1] = 169, [2] = 164, [3] = 69 }, [1] = { [0] = 69, [1] = 174, [2] = 169, [3] = 74 }, [2] = { [0] = 74, [1] = 179, [2] = 174, [3] = 79 } })[R[13]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 173, [1] = 209, [2] = 72, [3] = 83 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] })
        game.create_tube({ ({ [0] = 173, [1] = 209, [2] = 72, [3] = 83 })[R[0]], ({ [0] = 74, [1] = 179, [2] = 174, [3] = 79 })[R[0]] })
        game.create_tube({ ({ [0] = 174, [1] = 210, [2] = 73, [3] = 84 })[R[0]], ({ [0] = 74, [1] = 179, [2] = 174, [3] = 79 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 170, [1] = 206, [2] = 69, [3] = 80 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] })
        game.create_tube({ ({ [0] = 173, [1] = 209, [2] = 72, [3] = 83 })[R[0]], ({ [0] = 70, [1] = 175, [2] = 170, [3] = 75 })[R[0]] })
        game.create_tube({ ({ [0] = 174, [1] = 210, [2] = 73, [3] = 84 })[R[0]], ({ [0] = 70, [1] = 175, [2] = 170, [3] = 75 })[R[0]] })
        game.create_tube({ ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] })
        game.create_tube({ ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 74, [1] = 179, [2] = 174, [3] = 79 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 170, [1] = 206, [2] = 69, [3] = 80 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] })
        game.create_tube({ ({ [0] = 173, [1] = 209, [2] = 72, [3] = 83 })[R[0]], ({ [0] = 70, [1] = 175, [2] = 170, [3] = 75 })[R[0]] })
        game.create_tube({ ({ [0] = 174, [1] = 210, [2] = 73, [3] = 84 })[R[0]], ({ [0] = 70, [1] = 175, [2] = 170, [3] = 75 })[R[0]] })
        game.create_tube({ ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 73, [1] = 178, [2] = 173, [3] = 78 })[R[0]] })
        game.create_tube({ ({ [0] = 176, [1] = 212, [2] = 75, [3] = 86 })[R[0]], ({ [0] = 74, [1] = 179, [2] = 174, [3] = 79 })[R[0]] })
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 178, [1] = 214, [2] = 77, [3] = 88 }, [1] = { [0] = 174, [1] = 210, [2] = 73, [3] = 84 }, [2] = { [0] = 170, [1] = 206, [2] = 69, [3] = 80 } })[R[14]][R[0]], ({ [0] = { [0] = 75, [1] = 180, [2] = 175, [3] = 80 }, [1] = { [0] = 69, [1] = 174, [2] = 169, [3] = 74 }, [2] = { [0] = 64, [1] = 169, [2] = 164, [3] = 69 } })[R[14]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 169, [1] = 205, [2] = 68, [3] = 79 })[R[0]], ({ [0] = 72, [1] = 177, [2] = 172, [3] = 77 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 169, [1] = 205, [2] = 68, [3] = 79 })[R[0]], ({ [0] = 72, [1] = 177, [2] = 172, [3] = 77 })[R[0]] })
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 }, [1] = { [0] = 178, [1] = 214, [2] = 77, [3] = 88 }, [2] = { [0] = 174, [1] = 210, [2] = 73, [3] = 84 } })[R[15]][R[0]], ({ [0] = { [0] = 64, [1] = 169, [2] = 164, [3] = 69 }, [1] = { [0] = 70, [1] = 175, [2] = 170, [3] = 75 }, [2] = { [0] = 74, [1] = 179, [2] = 174, [3] = 79 } })[R[15]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 174, [1] = 210, [2] = 73, [3] = 84 }, [1] = { [0] = 168, [1] = 204, [2] = 67, [3] = 78 }, [2] = { [0] = 168, [1] = 204, [2] = 67, [3] = 78 } })[R[16]][R[0]], ({ [0] = { [0] = 75, [1] = 180, [2] = 175, [3] = 80 }, [1] = { [0] = 70, [1] = 175, [2] = 170, [3] = 75 }, [2] = { [0] = 65, [1] = 170, [2] = 165, [3] = 70 } })[R[16]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 178, [1] = 214, [2] = 77, [3] = 88 }, [1] = { [0] = 177, [1] = 213, [2] = 76, [3] = 87 }, [2] = { [0] = 174, [1] = 210, [2] = 73, [3] = 84 } })[R[17]][R[0]], ({ [0] = { [0] = 65, [1] = 170, [2] = 165, [3] = 70 }, [1] = { [0] = 71, [1] = 176, [2] = 171, [3] = 76 }, [2] = { [0] = 72, [1] = 177, [2] = 172, [3] = 77 } })[R[17]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 172, [1] = 208, [2] = 71, [3] = 82 }, [1] = { [0] = 168, [1] = 204, [2] = 67, [3] = 78 }, [2] = { [0] = 178, [1] = 214, [2] = 77, [3] = 88 } })[R[18]][R[0]], ({ [0] = { [0] = 74, [1] = 179, [2] = 174, [3] = 79 }, [1] = { [0] = 70, [1] = 175, [2] = 170, [3] = 75 }, [2] = { [0] = 65, [1] = 170, [2] = 165, [3] = 70 } })[R[18]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 36, 55 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 206, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 220, 200 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 72, 212 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 111, 249 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 214 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 228 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 98, 173 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 148, 165 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 132, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 126, 211 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 39, 136 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 140 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 91, 105 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 110 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 11, 114 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 42, 123 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 115 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 142, 8 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 159, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 112, 47 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 137, 68 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 152, 47 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 123, 30 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 161, 117 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 205, 100 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 244, 110 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 232, 131 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 199, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 224, 119 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 179, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 199, 241 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 251, 212 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 148, 248 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 17, 210 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 40, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 244 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 54, 30 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 104, 7 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 51 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 236, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 180, 28 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 231, 24 } }
    pick(4, 3, { 0, 19, 20 })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 106, [1] = 97, [2] = 160, [3] = 161 })[R[0]], ({ [0] = 102, [1] = 155, [2] = 163, [3] = 85 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 1 then
    elseif R[0] == 2 or R[0] == 3 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [2] = 165, [3] = 166 })[R[0]], ({ [2] = 159, [3] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 100, [1] = 97, [2] = 170, [3] = 171 })[R[0]], ({ [0] = 103, [1] = 161, [2] = 161, [3] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[1]][R[0]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[1]][R[0]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] })
    if R[1] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 1 or R[1] == 2 or R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [3] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [4] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[1]][R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 1 or R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[1]][R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[0]], ({ [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[1]][R[0]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[1]][R[0]], ({ [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 } })[R[1]][R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 69, [1] = 164, [2] = 169, [3] = 64 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [3] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[1]][R[0]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [3] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [4] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[1]], player = players[1], at = { ({ [1] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [3] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [4] = { [0] = 77, [1] = 66, [2] = 203, [3] = 167 } })[R[1]][R[0]], ({ [1] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [2] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [3] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [4] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [3] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 } })[R[1]][R[0]], ({ [1] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [3] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [4] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [6] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [7] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[1]][R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[1]][R[0]], ({ [5] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [6] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [7] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 or R[1] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [7] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[1]][R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [7] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[1]][R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[1] == 5 then
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[1]][R[0]], ({ [5] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[1] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 }, [7] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 } })[R[1]][R[0]], ({ [5] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [6] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [7] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [3] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [5] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [6] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[1]][R[0]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [6] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [1] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [3] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [4] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [7] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 } })[R[1]][R[0]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [3] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [4] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [6] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[21]][R[0]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 78, [1] = 173, [2] = 178, [3] = 73 } })[R[21]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[22]][R[0]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[22]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[23]][R[0]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[23]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[24]][R[0]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[24]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[25]][R[0]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[25]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 } })[R[26]][R[0]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[26]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[27]][R[0]], ({ [0] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 } })[R[27]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[28]][R[0]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[28]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 106, [1] = 97, [2] = 160, [3] = 161 })[R[19]], ({ [0] = 102, [1] = 155, [2] = 163, [3] = 85 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[19] == 2 or R[19] == 3 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [2] = 165, [3] = 166 })[R[19]], ({ [2] = 159, [3] = 92 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    elseif R[19] == 0 or R[19] == 1 then
    else
      unseen("R[19]", R[19])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 100, [1] = 97, [2] = 170, [3] = 171 })[R[19]], ({ [0] = 103, [1] = 161, [2] = 161, [3] = 92 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 83, [1] = 87, [2] = 87, [3] = 79, [4] = 83, [5] = 82, [6] = 79, [7] = 85 }, [1] = { [0] = 72, [1] = 76, [2] = 76, [3] = 68, [4] = 72, [5] = 71, [6] = 68, [7] = 74 }, [2] = { [0] = 209, [1] = 213, [2] = 213, [3] = 205, [4] = 209, [5] = 208, [6] = 205, [7] = 211 }, [3] = { [0] = 173, [1] = 177, [2] = 177, [3] = 169, [4] = 173, [5] = 172, [6] = 169, [7] = 175 } })[R[19]][R[10]], ({ [0] = { [0] = 76, [1] = 72, [2] = 76, [3] = 72, [4] = 75, [5] = 73, [6] = 70, [7] = 73 }, [1] = { [0] = 171, [1] = 167, [2] = 171, [3] = 167, [4] = 170, [5] = 168, [6] = 165, [7] = 168 }, [2] = { [0] = 176, [1] = 172, [2] = 176, [3] = 172, [4] = 175, [5] = 173, [6] = 170, [7] = 173 }, [3] = { [0] = 71, [1] = 67, [2] = 71, [3] = 67, [4] = 70, [5] = 68, [6] = 65, [7] = 68 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 83, [1] = 87, [2] = 87, [3] = 79, [4] = 83, [5] = 82, [6] = 79, [7] = 85 }, [1] = { [0] = 72, [1] = 76, [2] = 76, [3] = 68, [4] = 72, [5] = 71, [6] = 68, [7] = 74 }, [2] = { [0] = 209, [1] = 213, [2] = 213, [3] = 205, [4] = 209, [5] = 208, [6] = 205, [7] = 211 }, [3] = { [0] = 173, [1] = 177, [2] = 177, [3] = 169, [4] = 173, [5] = 172, [6] = 169, [7] = 175 } })[R[19]][R[10]], ({ [0] = { [0] = 76, [1] = 72, [2] = 76, [3] = 72, [4] = 75, [5] = 73, [6] = 70, [7] = 73 }, [1] = { [0] = 171, [1] = 167, [2] = 171, [3] = 167, [4] = 170, [5] = 168, [6] = 165, [7] = 168 }, [2] = { [0] = 176, [1] = 172, [2] = 176, [3] = 172, [4] = 175, [5] = 173, [6] = 170, [7] = 173 }, [3] = { [0] = 71, [1] = 67, [2] = 71, [3] = 67, [4] = 70, [5] = 68, [6] = 65, [7] = 68 } })[R[19]][R[10]] })
    if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 87, [2] = 80, [3] = 84, [4] = 80 }, [1] = { [1] = 76, [2] = 69, [3] = 73, [4] = 69 }, [2] = { [1] = 213, [2] = 206, [3] = 210, [4] = 206 }, [3] = { [1] = 177, [2] = 170, [3] = 174, [4] = 170 } })[R[19]][R[10]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[19]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 69, [1] = 164, [2] = 169, [3] = 64 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 1 or R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 78, [2] = 79 }, [1] = { [1] = 67, [2] = 68 }, [2] = { [1] = 204, [2] = 205 }, [3] = { [1] = 168, [2] = 169 } })[R[19]][R[10]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[19]], ({ [0] = { [1] = 75, [2] = 79 }, [1] = { [1] = 170, [2] = 174 }, [2] = { [1] = 175, [2] = 179 }, [3] = { [1] = 70, [2] = 74 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 82, [2] = 83 }, [1] = { [1] = 71, [2] = 72 }, [2] = { [1] = 208, [2] = 209 }, [3] = { [1] = 172, [2] = 173 } })[R[19]][R[10]], ({ [0] = { [1] = 80, [2] = 76 }, [1] = { [1] = 175, [2] = 171 }, [2] = { [1] = 180, [2] = 176 }, [3] = { [1] = 75, [2] = 71 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 82, [2] = 87 }, [1] = { [1] = 71, [2] = 76 }, [2] = { [1] = 208, [2] = 213 }, [3] = { [1] = 172, [2] = 177 } })[R[19]][R[10]], ({ [0] = { [1] = 76, [2] = 73 }, [1] = { [1] = 171, [2] = 168 }, [2] = { [1] = 176, [2] = 173 }, [3] = { [1] = 71, [2] = 68 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 88, [2] = 86 }, [1] = { [1] = 77, [2] = 75 }, [2] = { [1] = 214, [2] = 212 }, [3] = { [1] = 178, [2] = 176 } })[R[19]][R[10]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 89, [2] = 88 }, [1] = { [1] = 78, [2] = 77 }, [2] = { [1] = 215, [2] = 214 }, [3] = { [1] = 179, [2] = 178 } })[R[19]][R[10]], ({ [0] = { [1] = 80, [2] = 81 }, [1] = { [1] = 175, [2] = 176 }, [2] = { [1] = 180, [2] = 181 }, [3] = { [1] = 75, [2] = 76 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 89, [2] = 81, [3] = 81, [4] = 81 }, [1] = { [1] = 78, [2] = 70, [3] = 70, [4] = 70 }, [2] = { [1] = 215, [2] = 207, [3] = 207, [4] = 207 }, [3] = { [1] = 179, [2] = 171, [3] = 171, [4] = 171 } })[R[19]][R[10]], ({ [0] = { [1] = 77, [2] = 81, [3] = 77, [4] = 73 }, [1] = { [1] = 172, [2] = 176, [3] = 172, [4] = 168 }, [2] = { [1] = 177, [2] = 181, [3] = 177, [4] = 173 }, [3] = { [1] = 72, [2] = 76, [3] = 72, [4] = 68 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 79, [6] = 88, [7] = 79 }, [1] = { [5] = 68, [6] = 77, [7] = 68 }, [2] = { [5] = 205, [6] = 214, [7] = 205 }, [3] = { [5] = 169, [6] = 178, [7] = 169 } })[R[19]][R[10]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 87, [6] = 79, [7] = 87 }, [1] = { [5] = 76, [6] = 68, [7] = 76 }, [2] = { [5] = 213, [6] = 205, [7] = 213 }, [3] = { [5] = 177, [6] = 169, [7] = 177 } })[R[19]][R[10]], ({ [0] = { [5] = 74, [6] = 79, [7] = 79 }, [1] = { [5] = 169, [6] = 174, [7] = 174 }, [2] = { [5] = 174, [6] = 179, [7] = 179 }, [3] = { [5] = 69, [6] = 74, [7] = 74 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 or R[10] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 87, [7] = 80 }, [1] = { [5] = 76, [7] = 69 }, [2] = { [5] = 213, [7] = 206 }, [3] = { [5] = 177, [7] = 170 } })[R[19]][R[10]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [5] = 82, [7] = 84 }, [1] = { [5] = 71, [7] = 73 }, [2] = { [5] = 208, [7] = 210 }, [3] = { [5] = 172, [7] = 174 } })[R[19]][R[10]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[10] == 5 then
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = { [5] = 76, [7] = 73 }, [1] = { [5] = 171, [7] = 168 }, [2] = { [5] = 176, [7] = 173 }, [3] = { [5] = 71, [7] = 68 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = { [5] = 75, [7] = 74 }, [1] = { [5] = 170, [7] = 169 }, [2] = { [5] = 175, [7] = 174 }, [3] = { [5] = 70, [7] = 69 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 83, [7] = 88 }, [1] = { [5] = 72, [7] = 77 }, [2] = { [5] = 209, [7] = 214 }, [3] = { [5] = 173, [7] = 178 } })[R[19]][R[10]], ({ [0] = { [5] = 77, [7] = 74 }, [1] = { [5] = 172, [7] = 169 }, [2] = { [5] = 177, [7] = 174 }, [3] = { [5] = 72, [7] = 69 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 89, [6] = 86, [7] = 82 }, [1] = { [5] = 78, [6] = 75, [7] = 71 }, [2] = { [5] = 215, [6] = 212, [7] = 208 }, [3] = { [5] = 179, [6] = 176, [7] = 172 } })[R[19]][R[10]], ({ [0] = { [5] = 72, [6] = 73, [7] = 71 }, [1] = { [5] = 167, [6] = 168, [7] = 166 }, [2] = { [5] = 172, [6] = 173, [7] = 171 }, [3] = { [5] = 67, [6] = 68, [7] = 66 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 6 then
      if LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 79, [1] = 78, [2] = 84, [3] = 83, [4] = 81, [5] = 88, [6] = 83, [7] = 88 }, [1] = { [0] = 68, [1] = 67, [2] = 73, [3] = 72, [4] = 70, [5] = 77, [6] = 72, [7] = 77 }, [2] = { [0] = 205, [1] = 204, [2] = 210, [3] = 209, [4] = 207, [5] = 214, [6] = 209, [7] = 214 }, [3] = { [0] = 169, [1] = 168, [2] = 174, [3] = 173, [4] = 171, [5] = 178, [6] = 173, [7] = 178 } })[R[19]][R[10]], ({ [0] = { [0] = 73, [1] = 75, [2] = 71, [3] = 72, [4] = 81, [5] = 76, [6] = 75, [7] = 81 }, [1] = { [0] = 168, [1] = 170, [2] = 166, [3] = 167, [4] = 176, [5] = 171, [6] = 170, [7] = 176 }, [2] = { [0] = 173, [1] = 175, [2] = 171, [3] = 172, [4] = 181, [5] = 176, [6] = 175, [7] = 181 }, [3] = { [0] = 68, [1] = 70, [2] = 66, [3] = 67, [4] = 76, [5] = 71, [6] = 70, [7] = 76 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 80, [1] = 80, [2] = 83, [3] = 82, [4] = 82, [5] = 89, [6] = 84, [7] = 89 }, [1] = { [0] = 69, [1] = 69, [2] = 72, [3] = 71, [4] = 71, [5] = 78, [6] = 73, [7] = 78 }, [2] = { [0] = 206, [1] = 206, [2] = 209, [3] = 208, [4] = 208, [5] = 215, [6] = 210, [7] = 215 }, [3] = { [0] = 170, [1] = 170, [2] = 173, [3] = 172, [4] = 172, [5] = 179, [6] = 174, [7] = 179 } })[R[19]][R[10]], ({ [0] = { [0] = 73, [1] = 74, [2] = 70, [3] = 71, [4] = 80, [5] = 75, [6] = 74, [7] = 81 }, [1] = { [0] = 168, [1] = 169, [2] = 165, [3] = 166, [4] = 175, [5] = 170, [6] = 169, [7] = 176 }, [2] = { [0] = 173, [1] = 174, [2] = 170, [3] = 171, [4] = 180, [5] = 175, [6] = 174, [7] = 181 }, [3] = { [0] = 68, [1] = 69, [2] = 65, [3] = 66, [4] = 75, [5] = 70, [6] = 69, [7] = 76 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[29]][R[19]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 78, [1] = 173, [2] = 178, [3] = 73 } })[R[29]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[30]][R[19]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[30]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[31]][R[19]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[31]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[32]][R[19]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[32]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[33]][R[19]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[33]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 } })[R[34]][R[19]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[34]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[35]][R[19]], ({ [0] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 } })[R[35]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[36]][R[19]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[36]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 106, [1] = 97, [2] = 160, [3] = 161 })[R[20]], ({ [0] = 102, [1] = 155, [2] = 163, [3] = 85 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[20] == 0 or R[20] == 1 then
    elseif R[20] == 2 or R[20] == 3 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [2] = 165, [3] = 166 })[R[20]], ({ [2] = 159, [3] = 92 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[20]", R[20])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 100, [1] = 97, [2] = 170, [3] = 171 })[R[20]], ({ [0] = 103, [1] = 161, [2] = 161, [3] = 92 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[37]][R[20]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[37]][R[20]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[37]][R[20]] })
    if R[37] == 1 or R[37] == 2 or R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [3] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [4] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[37]][R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 1 or R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[37]][R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[20]], ({ [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[37]][R[20]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[37]][R[20]], ({ [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 } })[R[37]][R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[37]][R[20]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[20]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 69, [1] = 164, [2] = 169, [3] = 64 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 2 then
        elseif LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [3] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 } })[R[37]][R[20]], ({ [1] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [3] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [4] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [6] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [7] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[37]][R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[37]][R[20]], ({ [5] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [6] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [7] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 or R[37] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [7] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[37]][R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [5] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[37]][R[20]], ({ [5] = { [0] = 78, [1] = 173, [2] = 178, [3] = 73 }, [7] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 7 then
        elseif R[37] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[37]][R[20]], ({ [5] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[37] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 }, [7] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 } })[R[37]][R[20]], ({ [5] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [6] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [7] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 6 then
      if LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [3] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [5] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [6] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[37]][R[20]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [6] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [1] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [3] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [4] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [7] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 } })[R[37]][R[20]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [3] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [4] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [6] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[38]][R[20]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 78, [1] = 173, [2] = 178, [3] = 73 } })[R[38]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[39]][R[20]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[39]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[40]][R[20]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[40]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[41]][R[20]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[41]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[42]][R[20]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[42]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 } })[R[43]][R[20]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[43]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[44]][R[20]], ({ [0] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 } })[R[44]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[45]][R[20]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[45]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 36, 55 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 206, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 220, 200 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 72, 212 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 111, 249 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 214 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 228 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 98, 173 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 148, 165 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 132, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 126, 211 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 39, 136 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 140 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 91, 105 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 110 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 11, 114 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 42, 123 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 115 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 142, 8 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 159, 23 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 112, 47 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 91 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 137, 68 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 152, 47 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 123, 30 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 161, 117 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 205, 100 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 244, 110 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 232, 131 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 199, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 224, 119 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 179, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 199, 241 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 251, 212 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 148, 248 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 17, 210 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 40, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 244 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 54, 30 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 104, 7 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 51 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 236, 58 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 180, 28 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 231, 24 } }
    pick(4, 4, { 0, 19, 20, 46 })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 106, [1] = 97, [2] = 160, [3] = 161 })[R[0]], ({ [0] = 102, [1] = 155, [2] = 163, [3] = 85 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[0] == 2 or R[0] == 3 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [2] = 165, [3] = 166 })[R[0]], ({ [2] = 159, [3] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    elseif R[0] == 0 or R[0] == 1 then
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 100, [1] = 97, [2] = 170, [3] = 171 })[R[0]], ({ [0] = 103, [1] = 161, [2] = 161, [3] = 92 })[R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[1]][R[0]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[1]][R[0]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] })
    if R[1] == 1 or R[1] == 2 or R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [3] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [4] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[1]][R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 1 or R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[1]][R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[0]], ({ [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[1]][R[0]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[1]][R[0]], ({ [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 } })[R[1]][R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[1]][R[0]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 69, [1] = 164, [2] = 169, [3] = 64 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      if R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [3] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 } })[R[1]][R[0]], ({ [1] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [3] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [4] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [6] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [7] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[1]][R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[1]][R[0]], ({ [5] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [6] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [7] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 or R[1] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [7] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[1]][R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 5 then
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
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [5] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[1]][R[0]], ({ [5] = { [0] = 78, [1] = 173, [2] = 178, [3] = 73 }, [7] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[1] == 7 then
        elseif R[1] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[1]", R[1])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [5] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[1]][R[0]], ({ [5] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[1] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 }, [7] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 } })[R[1]][R[0]], ({ [5] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [6] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [7] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 7 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[0]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[1] == 6 then
      if LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[1]", R[1])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [3] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [5] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [6] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[1]][R[0]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [6] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [1] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [3] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [4] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [7] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 } })[R[1]][R[0]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [3] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [4] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [6] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[1] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[47]][R[0]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 78, [1] = 173, [2] = 178, [3] = 73 } })[R[47]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[48]][R[0]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[48]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[49]][R[0]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[49]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[50]][R[0]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[50]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[0]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[0]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[0]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[0]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[0]] })
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[51]][R[0]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[51]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 } })[R[52]][R[0]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[52]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[53]][R[0]], ({ [0] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 } })[R[53]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[54]][R[0]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[54]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 106, [1] = 97, [2] = 160, [3] = 161 })[R[19]], ({ [0] = 102, [1] = 155, [2] = 163, [3] = 85 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[19] == 2 or R[19] == 3 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [2] = 165, [3] = 166 })[R[19]], ({ [2] = 159, [3] = 92 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    elseif R[19] == 0 or R[19] == 1 then
    else
      unseen("R[19]", R[19])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 100, [1] = 97, [2] = 170, [3] = 171 })[R[19]], ({ [0] = 103, [1] = 161, [2] = 161, [3] = 92 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 83, [1] = 87, [2] = 87, [3] = 79, [4] = 83, [5] = 82, [6] = 79, [7] = 85 }, [1] = { [0] = 72, [1] = 76, [2] = 76, [3] = 68, [4] = 72, [5] = 71, [6] = 68, [7] = 74 }, [2] = { [0] = 209, [1] = 213, [2] = 213, [3] = 205, [4] = 209, [5] = 208, [6] = 205, [7] = 211 }, [3] = { [0] = 173, [1] = 177, [2] = 177, [3] = 169, [4] = 173, [5] = 172, [6] = 169, [7] = 175 } })[R[19]][R[10]], ({ [0] = { [0] = 76, [1] = 72, [2] = 76, [3] = 72, [4] = 75, [5] = 73, [6] = 70, [7] = 73 }, [1] = { [0] = 171, [1] = 167, [2] = 171, [3] = 167, [4] = 170, [5] = 168, [6] = 165, [7] = 168 }, [2] = { [0] = 176, [1] = 172, [2] = 176, [3] = 172, [4] = 175, [5] = 173, [6] = 170, [7] = 173 }, [3] = { [0] = 71, [1] = 67, [2] = 71, [3] = 67, [4] = 70, [5] = 68, [6] = 65, [7] = 68 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 83, [1] = 87, [2] = 87, [3] = 79, [4] = 83, [5] = 82, [6] = 79, [7] = 85 }, [1] = { [0] = 72, [1] = 76, [2] = 76, [3] = 68, [4] = 72, [5] = 71, [6] = 68, [7] = 74 }, [2] = { [0] = 209, [1] = 213, [2] = 213, [3] = 205, [4] = 209, [5] = 208, [6] = 205, [7] = 211 }, [3] = { [0] = 173, [1] = 177, [2] = 177, [3] = 169, [4] = 173, [5] = 172, [6] = 169, [7] = 175 } })[R[19]][R[10]], ({ [0] = { [0] = 76, [1] = 72, [2] = 76, [3] = 72, [4] = 75, [5] = 73, [6] = 70, [7] = 73 }, [1] = { [0] = 171, [1] = 167, [2] = 171, [3] = 167, [4] = 170, [5] = 168, [6] = 165, [7] = 168 }, [2] = { [0] = 176, [1] = 172, [2] = 176, [3] = 172, [4] = 175, [5] = 173, [6] = 170, [7] = 173 }, [3] = { [0] = 71, [1] = 67, [2] = 71, [3] = 67, [4] = 70, [5] = 68, [6] = 65, [7] = 68 } })[R[19]][R[10]] })
    if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 87, [2] = 80, [3] = 84, [4] = 80 }, [1] = { [1] = 76, [2] = 69, [3] = 73, [4] = 69 }, [2] = { [1] = 213, [2] = 206, [3] = 210, [4] = 206 }, [3] = { [1] = 177, [2] = 170, [3] = 174, [4] = 170 } })[R[19]][R[10]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 1 or R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 78, [2] = 79 }, [1] = { [1] = 67, [2] = 68 }, [2] = { [1] = 204, [2] = 205 }, [3] = { [1] = 168, [2] = 169 } })[R[19]][R[10]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[19]], ({ [0] = { [1] = 75, [2] = 79 }, [1] = { [1] = 170, [2] = 174 }, [2] = { [1] = 175, [2] = 179 }, [3] = { [1] = 70, [2] = 74 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 82, [2] = 83 }, [1] = { [1] = 71, [2] = 72 }, [2] = { [1] = 208, [2] = 209 }, [3] = { [1] = 172, [2] = 173 } })[R[19]][R[10]], ({ [0] = { [1] = 80, [2] = 76 }, [1] = { [1] = 175, [2] = 171 }, [2] = { [1] = 180, [2] = 176 }, [3] = { [1] = 75, [2] = 71 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 82, [2] = 87 }, [1] = { [1] = 71, [2] = 76 }, [2] = { [1] = 208, [2] = 213 }, [3] = { [1] = 172, [2] = 177 } })[R[19]][R[10]], ({ [0] = { [1] = 76, [2] = 73 }, [1] = { [1] = 171, [2] = 168 }, [2] = { [1] = 176, [2] = 173 }, [3] = { [1] = 71, [2] = 68 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 88, [2] = 86 }, [1] = { [1] = 77, [2] = 75 }, [2] = { [1] = 214, [2] = 212 }, [3] = { [1] = 178, [2] = 176 } })[R[19]][R[10]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 89, [2] = 88 }, [1] = { [1] = 78, [2] = 77 }, [2] = { [1] = 215, [2] = 214 }, [3] = { [1] = 179, [2] = 178 } })[R[19]][R[10]], ({ [0] = { [1] = 80, [2] = 81 }, [1] = { [1] = 175, [2] = 176 }, [2] = { [1] = 180, [2] = 181 }, [3] = { [1] = 75, [2] = 76 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[19]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 69, [1] = 164, [2] = 169, [3] = 64 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      if R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 89, [2] = 81, [3] = 81, [4] = 81 }, [1] = { [1] = 78, [2] = 70, [3] = 70, [4] = 70 }, [2] = { [1] = 215, [2] = 207, [3] = 207, [4] = 207 }, [3] = { [1] = 179, [2] = 171, [3] = 171, [4] = 171 } })[R[19]][R[10]], ({ [0] = { [1] = 77, [2] = 81, [3] = 77, [4] = 73 }, [1] = { [1] = 172, [2] = 176, [3] = 172, [4] = 168 }, [2] = { [1] = 177, [2] = 181, [3] = 177, [4] = 173 }, [3] = { [1] = 72, [2] = 76, [3] = 72, [4] = 68 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 79, [6] = 88, [7] = 79 }, [1] = { [5] = 68, [6] = 77, [7] = 68 }, [2] = { [5] = 205, [6] = 214, [7] = 205 }, [3] = { [5] = 169, [6] = 178, [7] = 169 } })[R[19]][R[10]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 87, [6] = 79, [7] = 87 }, [1] = { [5] = 76, [6] = 68, [7] = 76 }, [2] = { [5] = 213, [6] = 205, [7] = 213 }, [3] = { [5] = 177, [6] = 169, [7] = 177 } })[R[19]][R[10]], ({ [0] = { [5] = 74, [6] = 79, [7] = 79 }, [1] = { [5] = 169, [6] = 174, [7] = 174 }, [2] = { [5] = 174, [6] = 179, [7] = 179 }, [3] = { [5] = 69, [6] = 74, [7] = 74 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 or R[10] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [5] = 87, [7] = 80 }, [1] = { [5] = 76, [7] = 69 }, [2] = { [5] = 213, [7] = 206 }, [3] = { [5] = 177, [7] = 170 } })[R[19]][R[10]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [5] = 86, [7] = 85 }, [1] = { [5] = 75, [7] = 74 }, [2] = { [5] = 212, [7] = 211 }, [3] = { [5] = 176, [7] = 175 } })[R[19]][R[10]], ({ [0] = { [5] = 78, [7] = 76 }, [1] = { [5] = 173, [7] = 171 }, [2] = { [5] = 178, [7] = 176 }, [3] = { [5] = 73, [7] = 71 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        if R[10] == 5 then
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[10] == 7 then
        else
          unseen("R[10]", R[10])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = { [5] = 76, [7] = 73 }, [1] = { [5] = 171, [7] = 168 }, [2] = { [5] = 176, [7] = 173 }, [3] = { [5] = 71, [7] = 68 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = { [5] = 75, [7] = 74 }, [1] = { [5] = 170, [7] = 169 }, [2] = { [5] = 175, [7] = 174 }, [3] = { [5] = 70, [7] = 69 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [5] = 83, [7] = 88 }, [1] = { [5] = 72, [7] = 77 }, [2] = { [5] = 209, [7] = 214 }, [3] = { [5] = 173, [7] = 178 } })[R[19]][R[10]], ({ [0] = { [5] = 77, [7] = 74 }, [1] = { [5] = 172, [7] = 169 }, [2] = { [5] = 177, [7] = 174 }, [3] = { [5] = 72, [7] = 69 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 89, [6] = 86, [7] = 82 }, [1] = { [5] = 78, [6] = 75, [7] = 71 }, [2] = { [5] = 215, [6] = 212, [7] = 208 }, [3] = { [5] = 179, [6] = 176, [7] = 172 } })[R[19]][R[10]], ({ [0] = { [5] = 72, [6] = 73, [7] = 71 }, [1] = { [5] = 167, [6] = 168, [7] = 166 }, [2] = { [5] = 172, [6] = 173, [7] = 171 }, [3] = { [5] = 67, [6] = 68, [7] = 66 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[19]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[10] == 6 then
      if LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 79, [1] = 78, [2] = 84, [3] = 83, [4] = 81, [5] = 88, [6] = 83, [7] = 88 }, [1] = { [0] = 68, [1] = 67, [2] = 73, [3] = 72, [4] = 70, [5] = 77, [6] = 72, [7] = 77 }, [2] = { [0] = 205, [1] = 204, [2] = 210, [3] = 209, [4] = 207, [5] = 214, [6] = 209, [7] = 214 }, [3] = { [0] = 169, [1] = 168, [2] = 174, [3] = 173, [4] = 171, [5] = 178, [6] = 173, [7] = 178 } })[R[19]][R[10]], ({ [0] = { [0] = 73, [1] = 75, [2] = 71, [3] = 72, [4] = 81, [5] = 76, [6] = 75, [7] = 81 }, [1] = { [0] = 168, [1] = 170, [2] = 166, [3] = 167, [4] = 176, [5] = 171, [6] = 170, [7] = 176 }, [2] = { [0] = 173, [1] = 175, [2] = 171, [3] = 172, [4] = 181, [5] = 176, [6] = 175, [7] = 181 }, [3] = { [0] = 68, [1] = 70, [2] = 66, [3] = 67, [4] = 76, [5] = 71, [6] = 70, [7] = 76 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 80, [1] = 80, [2] = 83, [3] = 82, [4] = 82, [5] = 89, [6] = 84, [7] = 89 }, [1] = { [0] = 69, [1] = 69, [2] = 72, [3] = 71, [4] = 71, [5] = 78, [6] = 73, [7] = 78 }, [2] = { [0] = 206, [1] = 206, [2] = 209, [3] = 208, [4] = 208, [5] = 215, [6] = 210, [7] = 215 }, [3] = { [0] = 170, [1] = 170, [2] = 173, [3] = 172, [4] = 172, [5] = 179, [6] = 174, [7] = 179 } })[R[19]][R[10]], ({ [0] = { [0] = 73, [1] = 74, [2] = 70, [3] = 71, [4] = 80, [5] = 75, [6] = 74, [7] = 81 }, [1] = { [0] = 168, [1] = 169, [2] = 165, [3] = 166, [4] = 175, [5] = 170, [6] = 169, [7] = 176 }, [2] = { [0] = 173, [1] = 174, [2] = 170, [3] = 171, [4] = 180, [5] = 175, [6] = 174, [7] = 181 }, [3] = { [0] = 68, [1] = 69, [2] = 65, [3] = 66, [4] = 75, [5] = 70, [6] = 69, [7] = 76 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[55]][R[19]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 78, [1] = 173, [2] = 178, [3] = 73 } })[R[55]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[56]][R[19]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[56]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[57]][R[19]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[57]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[19]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[19]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[19]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[19]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[19]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[58]][R[19]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[58]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[19]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[19]] })
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[59]][R[19]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[59]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 } })[R[60]][R[19]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[60]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[61]][R[19]], ({ [0] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 } })[R[61]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[62]][R[19]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[62]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 106, [1] = 97, [2] = 160, [3] = 161 })[R[20]], ({ [0] = 102, [1] = 155, [2] = 163, [3] = 85 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[20] == 0 or R[20] == 1 then
    elseif R[20] == 2 or R[20] == 3 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [2] = 165, [3] = 166 })[R[20]], ({ [2] = 159, [3] = 92 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[20]", R[20])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 100, [1] = 97, [2] = 170, [3] = 171 })[R[20]], ({ [0] = 103, [1] = 161, [2] = 161, [3] = 92 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[37]][R[20]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[37]][R[20]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[37]][R[20]] })
    if R[37] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 1 or R[37] == 2 or R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [3] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [4] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[37]][R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 1 or R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[37]][R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[20]], ({ [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[37]][R[20]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[37]][R[20]], ({ [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 } })[R[37]][R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[37]][R[20]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[20]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 69, [1] = 164, [2] = 169, [3] = 64 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      if R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [3] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 } })[R[37]][R[20]], ({ [1] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [3] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [4] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [6] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [7] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[37]][R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[37]][R[20]], ({ [5] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [6] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [7] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [7] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[37]][R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 5 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [7] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[37]][R[20]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        if R[37] == 5 then
        elseif R[37] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("R[37]", R[37])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [5] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[37]][R[20]], ({ [5] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 }, [7] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 } })[R[37]][R[20]], ({ [5] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [6] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [7] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[37] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[37]", R[37])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [3] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [5] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [6] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[37]][R[20]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [6] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [1] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [3] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [4] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [7] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 } })[R[37]][R[20]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [3] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [4] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [6] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[37] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[63]][R[20]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 78, [1] = 173, [2] = 178, [3] = 73 } })[R[63]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[64]][R[20]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[64]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[65]][R[20]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[65]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[20]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[20]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[20]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[20]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[20]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[66]][R[20]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[66]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[67]][R[20]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[67]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[20]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 } })[R[68]][R[20]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[68]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[69]][R[20]], ({ [0] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 } })[R[69]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[70]][R[20]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[70]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 106, [1] = 97, [2] = 160, [3] = 161 })[R[46]], ({ [0] = 102, [1] = 155, [2] = 163, [3] = 85 })[R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    if R[46] == 0 or R[46] == 1 then
    elseif R[46] == 2 or R[46] == 3 then
      U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [2] = 165, [3] = 166 })[R[46]], ({ [2] = 159, [3] = 92 })[R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[46]", R[46])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 100, [1] = 97, [2] = 170, [3] = 171 })[R[46]], ({ [0] = 103, [1] = 161, [2] = 161, [3] = 92 })[R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[71] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[71]][R[46]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [3] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [4] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[71]][R[46]], ({ [0] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [5] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [6] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[71]][R[46]] })
    if R[71] == 1 or R[71] == 2 or R[71] == 3 or R[71] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [3] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [4] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[71]][R[46]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 1 or R[71] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[71]][R[46]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[46]], ({ [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[71]][R[46]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[71]][R[46]], ({ [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 } })[R[71]][R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[71]][R[46]], ({ [1] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[46]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[46]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[46]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[46]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[46]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[46]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[46]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 69, [1] = 164, [2] = 169, [3] = 64 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[4].difficulty] == 2 then
        elseif LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[46]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
      U[#U]:set_lights(true)
      if R[71] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[46]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 4 then
        if LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[46]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[46]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
      U[#U]:set_lights(true)
      if R[71] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[46]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[46]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[46]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 77, [1] = 66, [2] = 203, [3] = 167 })[R[46]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [1] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [2] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [3] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 } })[R[71]][R[46]], ({ [1] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [2] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [3] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [4] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[71] == 5 or R[71] == 6 or R[71] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [5] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [6] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [7] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 } })[R[71]][R[46]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [6] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [7] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 } })[R[71]][R[46]], ({ [5] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [6] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [7] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 6 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[46]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[46]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[46]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[71] == 5 or R[71] == 7 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [5] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [7] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[71]][R[46]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        if R[71] == 5 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[71] == 7 then
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [5] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [7] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[71]][R[46]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        if R[71] == 7 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[46]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif R[71] == 5 then
        else
          unseen("R[71]", R[71])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [7] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[46]], ({ [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [5] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[71]][R[46]], ({ [5] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 }, [7] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("R[71]", R[71])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 86, [1] = 75, [2] = 212, [3] = 176 }, [7] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 } })[R[71]][R[46]], ({ [5] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [6] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [7] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[46]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
    elseif R[71] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[46]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 85, [1] = 74, [2] = 211, [3] = 175 })[R[46]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[46]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[46]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 88, [1] = 77, [2] = 214, [3] = 178 })[R[46]], ({ [0] = 70, [1] = 165, [2] = 170, [3] = 65 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 87, [1] = 76, [2] = 213, [3] = 177 })[R[46]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[46]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[71]", R[71])
    end
    U[#U]:set_lights(true)
    if R[71] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[46]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[46]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 1 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[46]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[46]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[46]], ({ [0] = 76, [1] = 171, [2] = 176, [3] = 71 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 2 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[46]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[46]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 3 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[46]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[46]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 78, [1] = 67, [2] = 204, [3] = 168 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[71] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[46]], ({ [0] = 72, [1] = 167, [2] = 172, [3] = 67 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[71] == 6 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 73, [1] = 168, [2] = 173, [3] = 68 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 81, [1] = 70, [2] = 207, [3] = 171 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 80, [1] = 175, [2] = 180, [3] = 75 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[46]], ({ [0] = 81, [1] = 176, [2] = 181, [3] = 76 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 74, [1] = 169, [2] = 174, [3] = 69 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[71] == 7 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 71, [1] = 166, [2] = 171, [3] = 66 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 89, [1] = 78, [2] = 215, [3] = 179 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[71]", R[71])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [3] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [4] = { [0] = 81, [1] = 70, [2] = 207, [3] = 171 }, [5] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [6] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [7] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[71]][R[46]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [3] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [4] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 }, [5] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [6] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [1] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [3] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [4] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [5] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 }, [6] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [7] = { [0] = 89, [1] = 78, [2] = 215, [3] = 179 } })[R[71]][R[46]], ({ [0] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [3] = { [0] = 71, [1] = 166, [2] = 171, [3] = 66 }, [4] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [5] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [6] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [7] = { [0] = 81, [1] = 176, [2] = 181, [3] = 76 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[71] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[72]][R[46]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 72, [1] = 167, [2] = 172, [3] = 67 }, [2] = { [0] = 78, [1] = 173, [2] = 178, [3] = 73 } })[R[72]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 82, [1] = 71, [2] = 208, [3] = 172 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] })
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [1] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [2] = { [0] = 85, [1] = 74, [2] = 211, [3] = 175 } })[R[73]][R[46]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 73, [1] = 168, [2] = 173, [3] = 68 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[73]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[46]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[46]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[46]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[46]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[46]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[46]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[46]] })
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 79, [1] = 68, [2] = 205, [3] = 169 }, [2] = { [0] = 83, [1] = 72, [2] = 209, [3] = 173 } })[R[74]][R[46]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[74]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[46]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[46]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[46]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[46]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 80, [1] = 69, [2] = 206, [3] = 170 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] })
        game.create_tube({ ({ [0] = 83, [1] = 72, [2] = 209, [3] = 173 })[R[46]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[46]] })
        game.create_tube({ ({ [0] = 84, [1] = 73, [2] = 210, [3] = 174 })[R[46]], ({ [0] = 75, [1] = 170, [2] = 175, [3] = 70 })[R[46]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 78, [1] = 173, [2] = 178, [3] = 73 })[R[46]] })
        game.create_tube({ ({ [0] = 86, [1] = 75, [2] = 212, [3] = 176 })[R[46]], ({ [0] = 79, [1] = 174, [2] = 179, [3] = 74 })[R[46]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [2] = { [0] = 80, [1] = 69, [2] = 206, [3] = 170 } })[R[75]][R[46]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 74, [1] = 169, [2] = 174, [3] = 69 }, [2] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 } })[R[75]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[46]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 79, [1] = 68, [2] = 205, [3] = 169 })[R[46]], ({ [0] = 77, [1] = 172, [2] = 177, [3] = 72 })[R[46]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [1] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[76]][R[46]], ({ [0] = { [0] = 69, [1] = 164, [2] = 169, [3] = 64 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 } })[R[76]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 } })[R[77]][R[46]], ({ [0] = { [0] = 80, [1] = 175, [2] = 180, [3] = 75 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[77]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 }, [1] = { [0] = 87, [1] = 76, [2] = 213, [3] = 177 }, [2] = { [0] = 84, [1] = 73, [2] = 210, [3] = 174 } })[R[78]][R[46]], ({ [0] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 }, [1] = { [0] = 76, [1] = 171, [2] = 176, [3] = 71 }, [2] = { [0] = 77, [1] = 172, [2] = 177, [3] = 72 } })[R[78]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 82, [1] = 71, [2] = 208, [3] = 172 }, [1] = { [0] = 78, [1] = 67, [2] = 204, [3] = 168 }, [2] = { [0] = 88, [1] = 77, [2] = 214, [3] = 178 } })[R[79]][R[46]], ({ [0] = { [0] = 79, [1] = 174, [2] = 179, [3] = 74 }, [1] = { [0] = 75, [1] = 170, [2] = 175, [3] = 70 }, [2] = { [0] = 70, [1] = 165, [2] = 170, [3] = 65 } })[R[79]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Tornados}  -- after 60 to 120 marks
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Meteors}  -- after 60 to 120 marks
  end
  return true
end
