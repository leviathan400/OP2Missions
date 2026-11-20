-- mr4_03Lua.lua  -  4 Player, ResourceRace, 'Rock Garden' map. (Lua)
--
-- Converted by op2dll from mr4_03.dll ("4 Player, ResourceRace, 'Rock Garden' map."): its setup replayed. `on_init` makes the original's
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
local Meteor

function Meteor(t)
  local r1 = game.rand(255)
  local r2 = game.rand(256)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 104, 235 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 246, 118 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 20, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 158, 14 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 76, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 26 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 34, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 196, 199 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 213, 221 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 224, 238 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 219, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 164, 86 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 39, 200 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 78, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 111, 150 } }
    R[0] = game.rand(4)
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 10, [1] = 77, [2] = 223, [3] = 145 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[1] == 0 or R[1] == 1 or R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 17, [1] = 84, [2] = 230, [3] = 152 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 27, [1] = 94, [2] = 244, [3] = 162 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 0 then
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
      elseif R[1] == 1 then
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
      elseif R[1] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[0]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[0]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[0]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [7] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 29, [1] = 96, [2] = 246, [3] = 158 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
      elseif R[1] == 0 or R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 } })[R[1]][R[0]], ({ [0] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [1] = { [0] = 35, [1] = 102, [2] = 248, [3] = 170 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[1]][R[0]], ({ [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
      else
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 } })[R[1]][R[0]], ({ [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 3 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 4 then
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
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 111, [1] = 21, [2] = 152, [3] = 227 }, [2] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [5] = { [0] = 102, [1] = 12, [2] = 131, [3] = 218 }, [6] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [7] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 } })[R[1]][R[0]], ({ [0] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [1] = { [0] = 32, [1] = 99, [2] = 245, [3] = 167 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 13, [1] = 80, [2] = 232, [3] = 148 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 33, [1] = 100, [2] = 250, [3] = 162 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 13, [1] = 80, [2] = 230, [3] = 148 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 16, [1] = 83, [2] = 229, [3] = 151 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 135, [1] = 45, [2] = 164, [3] = 251 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 } })[R[1]][R[0]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 17, [1] = 84, [2] = 236, [3] = 152 }, [4] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [5] = { [0] = 29, [1] = 96, [2] = 246, [3] = 164 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 }, [5] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 20, [1] = 87, [2] = 237, [3] = 149 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 27, [1] = 94, [2] = 246, [3] = 162 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 19, [1] = 86, [2] = 236, [3] = 154 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 115, [1] = 25, [2] = 156, [3] = 231 }, [2] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 28, [1] = 95, [2] = 247, [3] = 163 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 22, [1] = 89, [2] = 239, [3] = 151 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 19, [1] = 86, [2] = 240, [3] = 154 }, [5] = { [0] = 24, [1] = 91, [2] = 241, [3] = 159 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 117, [1] = 27, [2] = 158, [3] = 233 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 20, [1] = 87, [2] = 241, [3] = 155 }, [5] = { [0] = 25, [1] = 92, [2] = 242, [3] = 160 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 118, [1] = 28, [2] = 159, [3] = 234 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [3] = { [0] = 23, [1] = 90, [2] = 242, [3] = 158 }, [4] = { [0] = 24, [1] = 91, [2] = 245, [3] = 159 }, [5] = { [0] = 26, [1] = 93, [2] = 243, [3] = 161 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 25, [1] = 92, [2] = 242, [3] = 154 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 24, [1] = 91, [2] = 243, [3] = 159 }, [4] = { [0] = 25, [1] = 92, [2] = 246, [3] = 160 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [3] = { [0] = 25, [1] = 92, [2] = 244, [3] = 160 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 27, [1] = 94, [2] = 244, [3] = 156 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 13, [1] = 80, [2] = 226, [3] = 148 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 27, [1] = 94, [2] = 248, [3] = 162 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 28, [1] = 95, [2] = 245, [3] = 157 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 14, [1] = 81, [2] = 227, [3] = 149 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 28, [1] = 95, [2] = 249, [3] = 163 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[1]][R[0]], ({ [0] = { [0] = 14, [1] = 81, [2] = 239, [3] = 149 }, [1] = { [0] = 15, [1] = 82, [2] = 228, [3] = 150 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 120, [1] = 30, [2] = 151, [3] = 236 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[1]][R[0]], ({ [0] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [1] = { [0] = 20, [1] = 87, [2] = 233, [3] = 155 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[1]][R[0]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[1]][R[0]], ({ [0] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 122, [1] = 32, [2] = 153, [3] = 238 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 24, [1] = 91, [2] = 237, [3] = 159 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 25, [1] = 92, [2] = 238, [3] = 160 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 15, [1] = 82, [2] = 236, [3] = 150 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 30, [1] = 97, [2] = 243, [3] = 165 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [3] = { [0] = 126, [1] = 36, [2] = 157, [3] = 242 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 31, [1] = 98, [2] = 244, [3] = 166 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 19, [1] = 86, [2] = 236, [3] = 148 } })[R[1]][R[0]] })
    if R[1] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
        for i = 1, game.initial_units() do
          R[2] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [2] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 } })[R[2]][R[0]], ({ [0] = { [0] = 10, [1] = 77, [2] = 235, [3] = 145 }, [1] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 } })[R[2]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[0]] })
        for i = 1, game.initial_units() do
          R[3] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 153, [3] = 228 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 } })[R[3]][R[0]], ({ [0] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [1] = { [0] = 29, [1] = 96, [2] = 242, [3] = 164 }, [2] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 } })[R[3]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[4] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [2] = { [0] = 131, [1] = 41, [2] = 160, [3] = 247 } })[R[4]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 } })[R[4]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[0]] })
        for i = 1, game.initial_units() do
          R[5] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [1] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [2] = { [0] = 112, [1] = 22, [2] = 143, [3] = 228 } })[R[5]][R[0]], ({ [0] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [1] = { [0] = 29, [1] = 96, [2] = 248, [3] = 164 }, [2] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 } })[R[5]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        for i = 1, game.initial_units() do
          R[6] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 } })[R[6]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [1] = { [0] = 21, [1] = 88, [2] = 242, [3] = 156 }, [2] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 } })[R[6]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[0]] })
        for i = 1, game.initial_units() do
          R[7] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 101, [1] = 11, [2] = 130, [3] = 217 }, [2] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[7]][R[0]], ({ [0] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 }, [1] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [2] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 } })[R[7]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        for i = 1, game.initial_units() do
          R[8] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [2] = { [0] = 136, [1] = 46, [2] = 165, [3] = 252 } })[R[8]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 } })[R[8]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
        for i = 1, game.initial_units() do
          R[9] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 105, [1] = 15, [2] = 134, [3] = 221 } })[R[9]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [1] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [2] = { [0] = 34, [1] = 101, [2] = 251, [3] = 163 } })[R[9]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 20, [1] = 151, [2] = 226, [3] = 110 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 33, [1] = 154, [2] = 239, [3] = 123 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 }, [6] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [7] = { [0] = 23, [1] = 142, [2] = 229, [3] = 113 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 90, [1] = 236, [2] = 158, [3] = 23 }, [2] = { [0] = 80, [1] = 238, [2] = 148, [3] = 13 }, [3] = { [0] = 93, [1] = 245, [2] = 161, [3] = 26 }, [4] = { [0] = 89, [1] = 243, [2] = 157, [3] = 22 }, [5] = { [0] = 89, [1] = 239, [2] = 157, [3] = 22 }, [6] = { [0] = 82, [1] = 240, [2] = 150, [3] = 15 }, [7] = { [0] = 91, [1] = 241, [2] = 153, [3] = 24 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 20, [1] = 151, [2] = 226, [3] = 110 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 33, [1] = 154, [2] = 239, [3] = 123 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 }, [6] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [7] = { [0] = 23, [1] = 142, [2] = 229, [3] = 113 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 90, [1] = 236, [2] = 158, [3] = 23 }, [2] = { [0] = 80, [1] = 238, [2] = 148, [3] = 13 }, [3] = { [0] = 93, [1] = 245, [2] = 161, [3] = 26 }, [4] = { [0] = 89, [1] = 243, [2] = 157, [3] = 22 }, [5] = { [0] = 89, [1] = 239, [2] = 157, [3] = 22 }, [6] = { [0] = 82, [1] = 240, [2] = 150, [3] = 15 }, [7] = { [0] = 91, [1] = 241, [2] = 153, [3] = 24 } })[R[10]][R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 30, [1] = 161, [2] = 236, [3] = 120 }, [2] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 }, [3] = { [0] = 41, [1] = 162, [2] = 247, [3] = 131 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 }, [6] = { [0] = 34, [1] = 153, [2] = 240, [3] = 124 }, [7] = { [0] = 16, [1] = 135, [2] = 222, [3] = 106 } })[R[10]][R[0]], ({ [0] = { [0] = 76, [1] = 234, [2] = 144, [3] = 9 }, [1] = { [0] = 77, [1] = 223, [2] = 145, [3] = 10 }, [2] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [3] = { [0] = 97, [1] = 249, [2] = 165, [3] = 30 }, [4] = { [0] = 97, [1] = 251, [2] = 165, [3] = 30 }, [5] = { [0] = 95, [1] = 245, [2] = 163, [3] = 28 }, [6] = { [0] = 82, [1] = 240, [2] = 150, [3] = 15 }, [7] = { [0] = 97, [1] = 247, [2] = 159, [3] = 30 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [3] = { [0] = 25, [1] = 146, [2] = 231, [3] = 115 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 } })[R[10]][R[0]], ({ [3] = { [0] = 97, [1] = 249, [2] = 165, [3] = 30 }, [4] = { [0] = 81, [1] = 235, [2] = 149, [3] = 14 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 28, [1] = 149, [2] = 234, [3] = 118 })[R[0]], ({ [0] = 86, [1] = 238, [2] = 154, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 39, [1] = 160, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 86, [1] = 238, [2] = 154, [3] = 19 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 83, [1] = 237, [2] = 151, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 93, [1] = 247, [2] = 161, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
    elseif R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 43, [1] = 162, [2] = 249, [3] = 133 }, [1] = { [0] = 31, [1] = 162, [2] = 237, [3] = 121 }, [2] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [5] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [6] = { [0] = 35, [1] = 154, [2] = 241, [3] = 125 }, [7] = { [0] = 16, [1] = 135, [2] = 222, [3] = 106 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 84, [1] = 230, [2] = 152, [3] = 17 }, [2] = { [0] = 91, [1] = 249, [2] = 159, [3] = 24 }, [5] = { [0] = 94, [1] = 244, [2] = 162, [3] = 27 }, [6] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [7] = { [0] = 84, [1] = 234, [2] = 146, [3] = 17 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 0 then
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
      elseif R[10] == 1 then
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
      elseif R[10] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 34, [1] = 153, [2] = 240, [3] = 124 })[R[0]], ({ [0] = 85, [1] = 243, [2] = 153, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 34, [1] = 153, [2] = 240, [3] = 124 })[R[0]], ({ [0] = 85, [1] = 243, [2] = 153, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 34, [1] = 153, [2] = 240, [3] = 124 })[R[0]], ({ [0] = 85, [1] = 243, [2] = 153, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 32, [1] = 151, [2] = 238, [3] = 122 })[R[0]], ({ [0] = 87, [1] = 237, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 32, [1] = 151, [2] = 238, [3] = 122 })[R[0]], ({ [0] = 87, [1] = 237, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 32, [1] = 151, [2] = 238, [3] = 122 })[R[0]], ({ [0] = 87, [1] = 237, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 90, [1] = 248, [2] = 158, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 90, [1] = 248, [2] = 158, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 90, [1] = 248, [2] = 158, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 139, [2] = 226, [3] = 110 }, [1] = { [0] = 31, [1] = 162, [2] = 237, [3] = 121 }, [2] = { [0] = 34, [1] = 153, [2] = 240, [3] = 124 }, [5] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 }, [6] = { [0] = 26, [1] = 145, [2] = 232, [3] = 116 }, [7] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 94, [1] = 240, [2] = 162, [3] = 27 }, [2] = { [0] = 91, [1] = 249, [2] = 159, [3] = 24 }, [5] = { [0] = 82, [1] = 232, [2] = 150, [3] = 15 }, [6] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [7] = { [0] = 96, [1] = 246, [2] = 158, [3] = 29 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 0 or R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 30, [1] = 161, [2] = 236, [3] = 120 } })[R[10]][R[0]], ({ [0] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [1] = { [0] = 102, [1] = 248, [2] = 170, [3] = 35 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 139, [2] = 226, [3] = 110 }, [1] = { [0] = 21, [1] = 152, [2] = 227, [3] = 111 }, [2] = { [0] = 42, [1] = 161, [2] = 248, [3] = 132 }, [3] = { [0] = 34, [1] = 155, [2] = 240, [3] = 124 }, [4] = { [0] = 24, [1] = 143, [2] = 230, [3] = 114 }, [5] = { [0] = 12, [1] = 131, [2] = 218, [3] = 102 }, [6] = { [0] = 18, [1] = 137, [2] = 224, [3] = 108 }, [7] = { [0] = 24, [1] = 143, [2] = 230, [3] = 114 } })[R[10]][R[0]], ({ [0] = { [0] = 92, [1] = 250, [2] = 160, [3] = 25 }, [1] = { [0] = 99, [1] = 245, [2] = 167, [3] = 32 }, [2] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [3] = { [0] = 80, [1] = 232, [2] = 148, [3] = 13 }, [4] = { [0] = 85, [1] = 239, [2] = 153, [3] = 18 }, [5] = { [0] = 89, [1] = 239, [2] = 157, [3] = 22 }, [6] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [7] = { [0] = 100, [1] = 250, [2] = 162, [3] = 33 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 27, [1] = 146, [2] = 233, [3] = 117 }, [1] = { [0] = 20, [1] = 151, [2] = 226, [3] = 110 }, [2] = { [0] = 38, [1] = 157, [2] = 244, [3] = 128 }, [3] = { [0] = 23, [1] = 144, [2] = 229, [3] = 113 }, [4] = { [0] = 42, [1] = 161, [2] = 248, [3] = 132 }, [5] = { [0] = 30, [1] = 149, [2] = 236, [3] = 120 }, [6] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [7] = { [0] = 34, [1] = 153, [2] = 240, [3] = 124 } })[R[10]][R[0]], ({ [0] = { [0] = 79, [1] = 237, [2] = 147, [3] = 12 }, [1] = { [0] = 85, [1] = 231, [2] = 153, [3] = 18 }, [2] = { [0] = 89, [1] = 247, [2] = 157, [3] = 22 }, [3] = { [0] = 87, [1] = 239, [2] = 155, [3] = 20 }, [4] = { [0] = 89, [1] = 243, [2] = 157, [3] = 22 }, [5] = { [0] = 80, [1] = 230, [2] = 148, [3] = 13 }, [6] = { [0] = 95, [1] = 253, [2] = 163, [3] = 28 }, [7] = { [0] = 91, [1] = 241, [2] = 153, [3] = 24 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [1] = { [0] = 20, [1] = 151, [2] = 226, [3] = 110 }, [2] = { [0] = 38, [1] = 157, [2] = 244, [3] = 128 }, [3] = { [0] = 26, [1] = 147, [2] = 232, [3] = 116 }, [4] = { [0] = 44, [1] = 163, [2] = 250, [3] = 134 }, [5] = { [0] = 30, [1] = 149, [2] = 236, [3] = 120 }, [6] = { [0] = 23, [1] = 142, [2] = 229, [3] = 113 }, [7] = { [0] = 34, [1] = 153, [2] = 240, [3] = 124 } })[R[10]][R[0]], ({ [0] = { [0] = 79, [1] = 237, [2] = 147, [3] = 12 }, [1] = { [0] = 83, [1] = 229, [2] = 151, [3] = 16 }, [2] = { [0] = 87, [1] = 245, [2] = 155, [3] = 20 }, [3] = { [0] = 83, [1] = 235, [2] = 151, [3] = 16 }, [4] = { [0] = 89, [1] = 243, [2] = 157, [3] = 22 }, [5] = { [0] = 82, [1] = 232, [2] = 150, [3] = 15 }, [6] = { [0] = 95, [1] = 253, [2] = 163, [3] = 28 }, [7] = { [0] = 93, [1] = 243, [2] = 155, [3] = 26 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 3 then
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 43, [1] = 164, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 87, [1] = 239, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 41, [1] = 162, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 83, [1] = 235, [2] = 151, [3] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 4 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 155, [2] = 242, [3] = 126 }, [1] = { [0] = 23, [1] = 154, [2] = 229, [3] = 113 }, [2] = { [0] = 20, [1] = 139, [2] = 226, [3] = 110 }, [3] = { [0] = 29, [1] = 150, [2] = 235, [3] = 119 }, [4] = { [0] = 36, [1] = 155, [2] = 242, [3] = 126 }, [5] = { [0] = 18, [1] = 137, [2] = 224, [3] = 108 }, [6] = { [0] = 38, [1] = 157, [2] = 244, [3] = 128 }, [7] = { [0] = 33, [1] = 152, [2] = 239, [3] = 123 } })[R[10]][R[0]], ({ [0] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [1] = { [0] = 85, [1] = 231, [2] = 153, [3] = 18 }, [2] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [3] = { [0] = 98, [1] = 250, [2] = 166, [3] = 31 }, [4] = { [0] = 97, [1] = 251, [2] = 165, [3] = 30 }, [5] = { [0] = 90, [1] = 240, [2] = 158, [3] = 23 }, [6] = { [0] = 82, [1] = 240, [2] = 150, [3] = 15 }, [7] = { [0] = 85, [1] = 235, [2] = 147, [3] = 18 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 155, [2] = 242, [3] = 126 }, [1] = { [0] = 23, [1] = 154, [2] = 229, [3] = 113 }, [2] = { [0] = 20, [1] = 139, [2] = 226, [3] = 110 }, [3] = { [0] = 29, [1] = 150, [2] = 235, [3] = 119 }, [4] = { [0] = 36, [1] = 155, [2] = 242, [3] = 126 }, [5] = { [0] = 18, [1] = 137, [2] = 224, [3] = 108 }, [6] = { [0] = 38, [1] = 157, [2] = 244, [3] = 128 }, [7] = { [0] = 33, [1] = 152, [2] = 239, [3] = 123 } })[R[10]][R[0]], ({ [0] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [1] = { [0] = 85, [1] = 231, [2] = 153, [3] = 18 }, [2] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [3] = { [0] = 98, [1] = 250, [2] = 166, [3] = 31 }, [4] = { [0] = 97, [1] = 251, [2] = 165, [3] = 30 }, [5] = { [0] = 90, [1] = 240, [2] = 158, [3] = 23 }, [6] = { [0] = 82, [1] = 240, [2] = 150, [3] = 15 }, [7] = { [0] = 85, [1] = 235, [2] = 147, [3] = 18 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 144, [2] = 231, [3] = 115 })[R[0]], ({ [0] = 79, [1] = 237, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 144, [2] = 231, [3] = 115 })[R[0]], ({ [0] = 79, [1] = 237, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 155, [2] = 242, [3] = 126 })[R[0]], ({ [0] = 85, [1] = 243, [2] = 153, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 22, [1] = 141, [2] = 228, [3] = 112 })[R[0]], ({ [0] = 79, [1] = 237, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 22, [1] = 141, [2] = 228, [3] = 112 })[R[0]], ({ [0] = 76, [1] = 234, [2] = 144, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 22, [1] = 141, [2] = 228, [3] = 112 })[R[0]], ({ [0] = 79, [1] = 237, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 22, [1] = 141, [2] = 228, [3] = 112 })[R[0]], ({ [0] = 76, [1] = 234, [2] = 144, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 144, [2] = 231, [3] = 115 })[R[0]], ({ [0] = 79, [1] = 237, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 155, [2] = 242, [3] = 126 })[R[0]], ({ [0] = 85, [1] = 243, [2] = 153, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 22, [1] = 141, [2] = 228, [3] = 112 })[R[0]], ({ [0] = 79, [1] = 237, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 22, [1] = 141, [2] = 228, [3] = 112 })[R[0]], ({ [0] = 76, [1] = 234, [2] = 144, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 151, [2] = 226, [3] = 110 })[R[0]], ({ [0] = 85, [1] = 231, [2] = 153, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 154, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 85, [1] = 231, [2] = 153, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 151, [2] = 226, [3] = 110 })[R[0]], ({ [0] = 85, [1] = 231, [2] = 153, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 23, [1] = 154, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 79, [1] = 225, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 26, [1] = 157, [2] = 232, [3] = 116 })[R[0]], ({ [0] = 76, [1] = 222, [2] = 144, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 23, [1] = 154, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 79, [1] = 225, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 26, [1] = 157, [2] = 232, [3] = 116 })[R[0]], ({ [0] = 76, [1] = 222, [2] = 144, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 20, [1] = 151, [2] = 226, [3] = 110 })[R[0]], ({ [0] = 85, [1] = 231, [2] = 153, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 23, [1] = 154, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 85, [1] = 231, [2] = 153, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 23, [1] = 154, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 79, [1] = 225, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 26, [1] = 157, [2] = 232, [3] = 116 })[R[0]], ({ [0] = 76, [1] = 222, [2] = 144, [3] = 9 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 87, [1] = 245, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 87, [1] = 245, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 139, [2] = 226, [3] = 110 })[R[0]], ({ [0] = 90, [1] = 248, [2] = 158, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 93, [1] = 251, [2] = 161, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 34, [1] = 153, [2] = 240, [3] = 124 })[R[0]], ({ [0] = 94, [1] = 252, [2] = 162, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 93, [1] = 251, [2] = 161, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 34, [1] = 153, [2] = 240, [3] = 124 })[R[0]], ({ [0] = 94, [1] = 252, [2] = 162, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 87, [1] = 245, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 20, [1] = 139, [2] = 226, [3] = 110 })[R[0]], ({ [0] = 90, [1] = 248, [2] = 158, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 93, [1] = 251, [2] = 161, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 34, [1] = 153, [2] = 240, [3] = 124 })[R[0]], ({ [0] = 94, [1] = 252, [2] = 162, [3] = 27 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 144, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 87, [1] = 239, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 144, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 87, [1] = 239, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 29, [1] = 150, [2] = 235, [3] = 119 })[R[0]], ({ [0] = 98, [1] = 250, [2] = 166, [3] = 31 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 144, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 87, [1] = 239, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 29, [1] = 150, [2] = 235, [3] = 119 })[R[0]], ({ [0] = 98, [1] = 250, [2] = 166, [3] = 31 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 4 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 44, [1] = 163, [2] = 250, [3] = 134 })[R[0]], ({ [0] = 89, [1] = 243, [2] = 157, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 44, [1] = 163, [2] = 250, [3] = 134 })[R[0]], ({ [0] = 89, [1] = 243, [2] = 157, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 155, [2] = 242, [3] = 126 })[R[0]], ({ [0] = 97, [1] = 251, [2] = 165, [3] = 30 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 37, [1] = 156, [2] = 243, [3] = 127 })[R[0]], ({ [0] = 93, [1] = 247, [2] = 161, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 84, [1] = 238, [2] = 152, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 37, [1] = 156, [2] = 243, [3] = 127 })[R[0]], ({ [0] = 93, [1] = 247, [2] = 161, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 84, [1] = 238, [2] = 152, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 44, [1] = 163, [2] = 250, [3] = 134 })[R[0]], ({ [0] = 89, [1] = 243, [2] = 157, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 36, [1] = 155, [2] = 242, [3] = 126 })[R[0]], ({ [0] = 97, [1] = 251, [2] = 165, [3] = 30 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 37, [1] = 156, [2] = 243, [3] = 127 })[R[0]], ({ [0] = 93, [1] = 247, [2] = 161, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 84, [1] = 238, [2] = 152, [3] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 5 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 30, [1] = 149, [2] = 236, [3] = 120 })[R[0]], ({ [0] = 82, [1] = 232, [2] = 150, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 30, [1] = 149, [2] = 236, [3] = 120 })[R[0]], ({ [0] = 82, [1] = 232, [2] = 150, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 137, [2] = 224, [3] = 108 })[R[0]], ({ [0] = 90, [1] = 240, [2] = 158, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 136, [2] = 223, [3] = 107 })[R[0]], ({ [0] = 79, [1] = 229, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 26, [1] = 145, [2] = 232, [3] = 116 })[R[0]], ({ [0] = 87, [1] = 237, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 136, [2] = 223, [3] = 107 })[R[0]], ({ [0] = 79, [1] = 229, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 26, [1] = 145, [2] = 232, [3] = 116 })[R[0]], ({ [0] = 87, [1] = 237, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 30, [1] = 149, [2] = 236, [3] = 120 })[R[0]], ({ [0] = 82, [1] = 232, [2] = 150, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 18, [1] = 137, [2] = 224, [3] = 108 })[R[0]], ({ [0] = 90, [1] = 240, [2] = 158, [3] = 23 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 17, [1] = 136, [2] = 223, [3] = 107 })[R[0]], ({ [0] = 79, [1] = 229, [2] = 147, [3] = 12 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 26, [1] = 145, [2] = 232, [3] = 116 })[R[0]], ({ [0] = 87, [1] = 237, [2] = 155, [3] = 20 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 95, [1] = 253, [2] = 163, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 95, [1] = 253, [2] = 163, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 82, [1] = 240, [2] = 150, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 30, [1] = 149, [2] = 236, [3] = 120 })[R[0]], ({ [0] = 92, [1] = 250, [2] = 160, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 89, [1] = 247, [2] = 157, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 30, [1] = 149, [2] = 236, [3] = 120 })[R[0]], ({ [0] = 92, [1] = 250, [2] = 160, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 89, [1] = 247, [2] = 157, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 95, [1] = 253, [2] = 163, [3] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 82, [1] = 240, [2] = 150, [3] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 30, [1] = 149, [2] = 236, [3] = 120 })[R[0]], ({ [0] = 92, [1] = 250, [2] = 160, [3] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 89, [1] = 247, [2] = 157, [3] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 7 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 34, [1] = 153, [2] = 240, [3] = 124 })[R[0]], ({ [0] = 93, [1] = 243, [2] = 155, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 34, [1] = 153, [2] = 240, [3] = 124 })[R[0]], ({ [0] = 93, [1] = 243, [2] = 155, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 33, [1] = 152, [2] = 239, [3] = 123 })[R[0]], ({ [0] = 85, [1] = 235, [2] = 147, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 137, [2] = 224, [3] = 108 })[R[0]], ({ [0] = 91, [1] = 241, [2] = 153, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 13, [1] = 132, [2] = 219, [3] = 103 })[R[0]], ({ [0] = 88, [1] = 238, [2] = 150, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 137, [2] = 224, [3] = 108 })[R[0]], ({ [0] = 91, [1] = 241, [2] = 153, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 13, [1] = 132, [2] = 219, [3] = 103 })[R[0]], ({ [0] = 88, [1] = 238, [2] = 150, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 34, [1] = 153, [2] = 240, [3] = 124 })[R[0]], ({ [0] = 93, [1] = 243, [2] = 155, [3] = 26 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 33, [1] = 152, [2] = 239, [3] = 123 })[R[0]], ({ [0] = 85, [1] = 235, [2] = 147, [3] = 18 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 18, [1] = 137, [2] = 224, [3] = 108 })[R[0]], ({ [0] = 91, [1] = 241, [2] = 153, [3] = 24 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 13, [1] = 132, [2] = 219, [3] = 103 })[R[0]], ({ [0] = 88, [1] = 238, [2] = 150, [3] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 43, [1] = 162, [2] = 249, [3] = 133 }, [1] = { [0] = 29, [1] = 160, [2] = 235, [3] = 119 }, [2] = { [0] = 30, [1] = 149, [2] = 236, [3] = 120 }, [3] = { [0] = 33, [1] = 154, [2] = 239, [3] = 123 }, [4] = { [0] = 45, [1] = 164, [2] = 251, [3] = 135 }, [5] = { [0] = 18, [1] = 137, [2] = 224, [3] = 108 }, [6] = { [0] = 39, [1] = 158, [2] = 245, [3] = 129 }, [7] = { [0] = 27, [1] = 146, [2] = 233, [3] = 117 } })[R[10]][R[0]], ({ [0] = { [0] = 87, [1] = 245, [2] = 155, [3] = 20 }, [1] = { [0] = 89, [1] = 235, [2] = 157, [3] = 22 }, [2] = { [0] = 87, [1] = 245, [2] = 155, [3] = 20 }, [3] = { [0] = 84, [1] = 236, [2] = 152, [3] = 17 }, [4] = { [0] = 80, [1] = 234, [2] = 148, [3] = 13 }, [5] = { [0] = 96, [1] = 246, [2] = 164, [3] = 29 }, [6] = { [0] = 92, [1] = 250, [2] = 160, [3] = 25 }, [7] = { [0] = 90, [1] = 240, [2] = 152, [3] = 23 } })[R[10]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 23, [1] = 142, [2] = 229, [3] = 113 }, [1] = { [0] = 23, [1] = 154, [2] = 229, [3] = 113 }, [2] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [3] = { [0] = 25, [1] = 146, [2] = 231, [3] = 115 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 }, [6] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [7] = { [0] = 16, [1] = 135, [2] = 222, [3] = 106 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 90, [1] = 236, [2] = 158, [3] = 23 }, [2] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [3] = { [0] = 93, [1] = 245, [2] = 161, [3] = 26 }, [4] = { [0] = 83, [1] = 237, [2] = 151, [3] = 16 }, [5] = { [0] = 85, [1] = 235, [2] = 153, [3] = 18 }, [6] = { [0] = 84, [1] = 242, [2] = 152, [3] = 17 }, [7] = { [0] = 87, [1] = 237, [2] = 149, [3] = 20 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 24, [1] = 143, [2] = 230, [3] = 114 }, [1] = { [0] = 24, [1] = 155, [2] = 230, [3] = 114 }, [2] = { [0] = 26, [1] = 145, [2] = 232, [3] = 116 }, [3] = { [0] = 25, [1] = 146, [2] = 231, [3] = 115 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 }, [6] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [7] = { [0] = 16, [1] = 135, [2] = 222, [3] = 106 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 90, [1] = 236, [2] = 158, [3] = 23 }, [2] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [3] = { [0] = 94, [1] = 246, [2] = 162, [3] = 27 }, [4] = { [0] = 84, [1] = 238, [2] = 152, [3] = 17 }, [5] = { [0] = 86, [1] = 236, [2] = 154, [3] = 19 }, [6] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [7] = { [0] = 88, [1] = 238, [2] = 150, [3] = 21 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [1] = { [0] = 25, [1] = 156, [2] = 231, [3] = 115 }, [2] = { [0] = 27, [1] = 146, [2] = 233, [3] = 117 }, [3] = { [0] = 25, [1] = 146, [2] = 231, [3] = 115 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 }, [6] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [7] = { [0] = 16, [1] = 135, [2] = 222, [3] = 106 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 90, [1] = 236, [2] = 158, [3] = 23 }, [2] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [3] = { [0] = 95, [1] = 247, [2] = 163, [3] = 28 }, [4] = { [0] = 85, [1] = 239, [2] = 153, [3] = 18 }, [5] = { [0] = 87, [1] = 237, [2] = 155, [3] = 20 }, [6] = { [0] = 86, [1] = 244, [2] = 154, [3] = 19 }, [7] = { [0] = 89, [1] = 239, [2] = 151, [3] = 22 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 26, [1] = 145, [2] = 232, [3] = 116 }, [1] = { [0] = 26, [1] = 157, [2] = 232, [3] = 116 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 26, [1] = 147, [2] = 232, [3] = 116 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 }, [6] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [7] = { [0] = 16, [1] = 135, [2] = 222, [3] = 106 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 90, [1] = 236, [2] = 158, [3] = 23 }, [2] = { [0] = 82, [1] = 240, [2] = 150, [3] = 15 }, [3] = { [0] = 93, [1] = 245, [2] = 161, [3] = 26 }, [4] = { [0] = 86, [1] = 240, [2] = 154, [3] = 19 }, [5] = { [0] = 91, [1] = 241, [2] = 159, [3] = 24 }, [6] = { [0] = 87, [1] = 245, [2] = 155, [3] = 20 }, [7] = { [0] = 90, [1] = 240, [2] = 152, [3] = 23 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 27, [1] = 146, [2] = 233, [3] = 117 }, [1] = { [0] = 27, [1] = 158, [2] = 233, [3] = 117 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 27, [1] = 148, [2] = 233, [3] = 117 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 }, [6] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [7] = { [0] = 16, [1] = 135, [2] = 222, [3] = 106 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 90, [1] = 236, [2] = 158, [3] = 23 }, [2] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [3] = { [0] = 89, [1] = 241, [2] = 157, [3] = 22 }, [4] = { [0] = 87, [1] = 241, [2] = 155, [3] = 20 }, [5] = { [0] = 92, [1] = 242, [2] = 160, [3] = 25 }, [6] = { [0] = 88, [1] = 246, [2] = 156, [3] = 21 }, [7] = { [0] = 91, [1] = 241, [2] = 153, [3] = 24 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [1] = { [0] = 28, [1] = 159, [2] = 234, [3] = 118 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 27, [1] = 148, [2] = 233, [3] = 117 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 }, [6] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [7] = { [0] = 16, [1] = 135, [2] = 222, [3] = 106 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 90, [1] = 236, [2] = 158, [3] = 23 }, [2] = { [0] = 84, [1] = 242, [2] = 152, [3] = 17 }, [3] = { [0] = 90, [1] = 242, [2] = 158, [3] = 23 }, [4] = { [0] = 91, [1] = 245, [2] = 159, [3] = 24 }, [5] = { [0] = 93, [1] = 243, [2] = 161, [3] = 26 }, [6] = { [0] = 82, [1] = 240, [2] = 150, [3] = 15 }, [7] = { [0] = 92, [1] = 242, [2] = 154, [3] = 25 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 29, [1] = 148, [2] = 235, [3] = 119 }, [1] = { [0] = 29, [1] = 160, [2] = 235, [3] = 119 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 27, [1] = 148, [2] = 233, [3] = 117 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [6] = { [0] = 29, [1] = 148, [2] = 235, [3] = 119 }, [7] = { [0] = 16, [1] = 135, [2] = 222, [3] = 106 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 90, [1] = 236, [2] = 158, [3] = 23 }, [2] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [3] = { [0] = 91, [1] = 243, [2] = 159, [3] = 24 }, [4] = { [0] = 92, [1] = 246, [2] = 160, [3] = 25 }, [5] = { [0] = 89, [1] = 239, [2] = 157, [3] = 22 }, [6] = { [0] = 82, [1] = 240, [2] = 150, [3] = 15 }, [7] = { [0] = 93, [1] = 243, [2] = 155, [3] = 26 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 30, [1] = 161, [2] = 236, [3] = 120 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 27, [1] = 148, [2] = 233, [3] = 117 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [6] = { [0] = 29, [1] = 148, [2] = 235, [3] = 119 }, [7] = { [0] = 16, [1] = 135, [2] = 222, [3] = 106 } })[R[10]][R[0]], ({ [0] = { [0] = 78, [1] = 236, [2] = 146, [3] = 11 }, [1] = { [0] = 79, [1] = 225, [2] = 147, [3] = 12 }, [2] = { [0] = 86, [1] = 244, [2] = 154, [3] = 19 }, [3] = { [0] = 92, [1] = 244, [2] = 160, [3] = 25 }, [4] = { [0] = 93, [1] = 247, [2] = 161, [3] = 26 }, [5] = { [0] = 95, [1] = 245, [2] = 163, [3] = 28 }, [6] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [7] = { [0] = 94, [1] = 244, [2] = 156, [3] = 27 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 30, [1] = 161, [2] = 236, [3] = 120 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 27, [1] = 148, [2] = 233, [3] = 117 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 26, [1] = 145, [2] = 232, [3] = 116 }, [6] = { [0] = 30, [1] = 149, [2] = 236, [3] = 120 }, [7] = { [0] = 16, [1] = 135, [2] = 222, [3] = 106 } })[R[10]][R[0]], ({ [0] = { [0] = 79, [1] = 237, [2] = 147, [3] = 12 }, [1] = { [0] = 80, [1] = 226, [2] = 148, [3] = 13 }, [2] = { [0] = 87, [1] = 245, [2] = 155, [3] = 20 }, [3] = { [0] = 93, [1] = 245, [2] = 161, [3] = 26 }, [4] = { [0] = 94, [1] = 248, [2] = 162, [3] = 27 }, [5] = { [0] = 89, [1] = 239, [2] = 157, [3] = 22 }, [6] = { [0] = 82, [1] = 240, [2] = 150, [3] = 15 }, [7] = { [0] = 95, [1] = 245, [2] = 157, [3] = 28 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 30, [1] = 161, [2] = 236, [3] = 120 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 28, [1] = 149, [2] = 234, [3] = 118 }, [4] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [5] = { [0] = 26, [1] = 145, [2] = 232, [3] = 116 }, [6] = { [0] = 30, [1] = 149, [2] = 236, [3] = 120 }, [7] = { [0] = 19, [1] = 138, [2] = 225, [3] = 109 } })[R[10]][R[0]], ({ [0] = { [0] = 80, [1] = 238, [2] = 148, [3] = 13 }, [1] = { [0] = 81, [1] = 227, [2] = 149, [3] = 14 }, [2] = { [0] = 88, [1] = 246, [2] = 156, [3] = 21 }, [3] = { [0] = 89, [1] = 241, [2] = 157, [3] = 22 }, [4] = { [0] = 95, [1] = 249, [2] = 163, [3] = 28 }, [5] = { [0] = 95, [1] = 245, [2] = 163, [3] = 28 }, [6] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [7] = { [0] = 84, [1] = 234, [2] = 146, [3] = 17 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 30, [1] = 161, [2] = 236, [3] = 120 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 28, [1] = 149, [2] = 234, [3] = 118 }, [4] = { [0] = 35, [1] = 154, [2] = 241, [3] = 125 }, [5] = { [0] = 27, [1] = 146, [2] = 233, [3] = 117 }, [6] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [7] = { [0] = 19, [1] = 138, [2] = 225, [3] = 109 } })[R[10]][R[0]], ({ [0] = { [0] = 81, [1] = 239, [2] = 149, [3] = 14 }, [1] = { [0] = 82, [1] = 228, [2] = 150, [3] = 15 }, [2] = { [0] = 89, [1] = 247, [2] = 157, [3] = 22 }, [3] = { [0] = 93, [1] = 245, [2] = 161, [3] = 26 }, [4] = { [0] = 81, [1] = 235, [2] = 149, [3] = 14 }, [5] = { [0] = 89, [1] = 239, [2] = 157, [3] = 22 }, [6] = { [0] = 82, [1] = 240, [2] = 150, [3] = 15 }, [7] = { [0] = 97, [1] = 247, [2] = 159, [3] = 30 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 30, [1] = 161, [2] = 236, [3] = 120 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 29, [1] = 150, [2] = 235, [3] = 119 }, [4] = { [0] = 35, [1] = 154, [2] = 241, [3] = 125 }, [5] = { [0] = 27, [1] = 146, [2] = 233, [3] = 117 }, [6] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [7] = { [0] = 20, [1] = 139, [2] = 226, [3] = 110 } })[R[10]][R[0]], ({ [0] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [1] = { [0] = 90, [1] = 236, [2] = 158, [3] = 23 }, [2] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [3] = { [0] = 93, [1] = 245, [2] = 161, [3] = 26 }, [4] = { [0] = 89, [1] = 243, [2] = 157, [3] = 22 }, [5] = { [0] = 95, [1] = 245, [2] = 163, [3] = 28 }, [6] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [7] = { [0] = 84, [1] = 234, [2] = 146, [3] = 17 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 31, [1] = 162, [2] = 237, [3] = 121 }, [2] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [3] = { [0] = 30, [1] = 151, [2] = 236, [3] = 120 }, [4] = { [0] = 35, [1] = 154, [2] = 241, [3] = 125 }, [5] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [6] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [7] = { [0] = 20, [1] = 139, [2] = 226, [3] = 110 } })[R[10]][R[0]], ({ [0] = { [0] = 86, [1] = 244, [2] = 154, [3] = 19 }, [1] = { [0] = 87, [1] = 233, [2] = 155, [3] = 20 }, [2] = { [0] = 91, [1] = 249, [2] = 159, [3] = 24 }, [3] = { [0] = 93, [1] = 245, [2] = 161, [3] = 26 }, [4] = { [0] = 97, [1] = 251, [2] = 165, [3] = 30 }, [5] = { [0] = 89, [1] = 239, [2] = 157, [3] = 22 }, [6] = { [0] = 82, [1] = 240, [2] = 150, [3] = 15 }, [7] = { [0] = 97, [1] = 247, [2] = 159, [3] = 30 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 31, [1] = 162, [2] = 237, [3] = 121 }, [2] = { [0] = 29, [1] = 148, [2] = 235, [3] = 119 }, [3] = { [0] = 31, [1] = 152, [2] = 237, [3] = 121 }, [4] = { [0] = 36, [1] = 155, [2] = 242, [3] = 126 }, [5] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [6] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [7] = { [0] = 21, [1] = 140, [2] = 227, [3] = 111 } })[R[10]][R[0]], ({ [0] = { [0] = 87, [1] = 245, [2] = 155, [3] = 20 }, [1] = { [0] = 88, [1] = 234, [2] = 156, [3] = 21 }, [2] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [3] = { [0] = 86, [1] = 238, [2] = 154, [3] = 19 }, [4] = { [0] = 81, [1] = 235, [2] = 149, [3] = 14 }, [5] = { [0] = 95, [1] = 245, [2] = 163, [3] = 28 }, [6] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [7] = { [0] = 84, [1] = 234, [2] = 146, [3] = 17 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [1] = { [0] = 31, [1] = 162, [2] = 237, [3] = 121 }, [2] = { [0] = 29, [1] = 148, [2] = 235, [3] = 119 }, [3] = { [0] = 31, [1] = 152, [2] = 237, [3] = 121 }, [4] = { [0] = 36, [1] = 155, [2] = 242, [3] = 126 }, [5] = { [0] = 29, [1] = 148, [2] = 235, [3] = 119 }, [6] = { [0] = 34, [1] = 153, [2] = 240, [3] = 124 }, [7] = { [0] = 21, [1] = 140, [2] = 227, [3] = 111 } })[R[10]][R[0]], ({ [0] = { [0] = 88, [1] = 246, [2] = 156, [3] = 21 }, [1] = { [0] = 89, [1] = 235, [2] = 157, [3] = 22 }, [2] = { [0] = 91, [1] = 249, [2] = 159, [3] = 24 }, [3] = { [0] = 93, [1] = 245, [2] = 161, [3] = 26 }, [4] = { [0] = 89, [1] = 243, [2] = 157, [3] = 22 }, [5] = { [0] = 89, [1] = 239, [2] = 157, [3] = 22 }, [6] = { [0] = 84, [1] = 242, [2] = 152, [3] = 17 }, [7] = { [0] = 97, [1] = 247, [2] = 159, [3] = 30 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 34, [1] = 153, [2] = 240, [3] = 124 }, [1] = { [0] = 31, [1] = 162, [2] = 237, [3] = 121 }, [2] = { [0] = 30, [1] = 149, [2] = 236, [3] = 120 }, [3] = { [0] = 32, [1] = 153, [2] = 238, [3] = 122 }, [4] = { [0] = 36, [1] = 155, [2] = 242, [3] = 126 }, [5] = { [0] = 29, [1] = 148, [2] = 235, [3] = 119 }, [6] = { [0] = 34, [1] = 153, [2] = 240, [3] = 124 }, [7] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 90, [1] = 236, [2] = 158, [3] = 23 }, [2] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [3] = { [0] = 86, [1] = 238, [2] = 154, [3] = 19 }, [4] = { [0] = 97, [1] = 251, [2] = 165, [3] = 30 }, [5] = { [0] = 95, [1] = 245, [2] = 163, [3] = 28 }, [6] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [7] = { [0] = 84, [1] = 234, [2] = 146, [3] = 17 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 35, [1] = 154, [2] = 241, [3] = 125 }, [1] = { [0] = 31, [1] = 162, [2] = 237, [3] = 121 }, [2] = { [0] = 30, [1] = 149, [2] = 236, [3] = 120 }, [3] = { [0] = 33, [1] = 154, [2] = 239, [3] = 123 }, [4] = { [0] = 37, [1] = 156, [2] = 243, [3] = 127 }, [5] = { [0] = 30, [1] = 149, [2] = 236, [3] = 120 }, [6] = { [0] = 34, [1] = 153, [2] = 240, [3] = 124 }, [7] = { [0] = 22, [1] = 141, [2] = 228, [3] = 112 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 91, [1] = 237, [2] = 159, [3] = 24 }, [2] = { [0] = 91, [1] = 249, [2] = 159, [3] = 24 }, [3] = { [0] = 86, [1] = 238, [2] = 154, [3] = 19 }, [4] = { [0] = 81, [1] = 235, [2] = 149, [3] = 14 }, [5] = { [0] = 89, [1] = 239, [2] = 157, [3] = 22 }, [6] = { [0] = 86, [1] = 244, [2] = 154, [3] = 19 }, [7] = { [0] = 97, [1] = 247, [2] = 159, [3] = 30 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 36, [1] = 155, [2] = 242, [3] = 126 }, [1] = { [0] = 31, [1] = 162, [2] = 237, [3] = 121 }, [2] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [3] = { [0] = 34, [1] = 155, [2] = 240, [3] = 124 }, [4] = { [0] = 37, [1] = 156, [2] = 243, [3] = 127 }, [5] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [6] = { [0] = 34, [1] = 153, [2] = 240, [3] = 124 }, [7] = { [0] = 23, [1] = 142, [2] = 229, [3] = 113 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 92, [1] = 238, [2] = 160, [3] = 25 }, [2] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [3] = { [0] = 86, [1] = 238, [2] = 154, [3] = 19 }, [4] = { [0] = 82, [1] = 236, [2] = 150, [3] = 15 }, [5] = { [0] = 89, [1] = 239, [2] = 157, [3] = 22 }, [6] = { [0] = 87, [1] = 245, [2] = 155, [3] = 20 }, [7] = { [0] = 84, [1] = 234, [2] = 146, [3] = 17 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 37, [1] = 156, [2] = 243, [3] = 127 }, [1] = { [0] = 31, [1] = 162, [2] = 237, [3] = 121 }, [2] = { [0] = 31, [1] = 150, [2] = 237, [3] = 121 }, [3] = { [0] = 35, [1] = 156, [2] = 241, [3] = 125 }, [4] = { [0] = 37, [1] = 156, [2] = 243, [3] = 127 }, [5] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [6] = { [0] = 34, [1] = 153, [2] = 240, [3] = 124 }, [7] = { [0] = 23, [1] = 142, [2] = 229, [3] = 113 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 97, [1] = 243, [2] = 165, [3] = 30 }, [2] = { [0] = 91, [1] = 249, [2] = 159, [3] = 24 }, [3] = { [0] = 86, [1] = 238, [2] = 154, [3] = 19 }, [4] = { [0] = 89, [1] = 243, [2] = 157, [3] = 22 }, [5] = { [0] = 89, [1] = 239, [2] = 157, [3] = 22 }, [6] = { [0] = 88, [1] = 246, [2] = 156, [3] = 21 }, [7] = { [0] = 85, [1] = 235, [2] = 147, [3] = 18 } })[R[10]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 38, [1] = 157, [2] = 244, [3] = 128 }, [1] = { [0] = 31, [1] = 162, [2] = 237, [3] = 121 }, [2] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [3] = { [0] = 36, [1] = 157, [2] = 242, [3] = 126 }, [4] = { [0] = 37, [1] = 156, [2] = 243, [3] = 127 }, [5] = { [0] = 32, [1] = 151, [2] = 238, [3] = 122 }, [6] = { [0] = 38, [1] = 157, [2] = 244, [3] = 128 }, [7] = { [0] = 23, [1] = 142, [2] = 229, [3] = 113 } })[R[10]][R[0]], ({ [0] = { [0] = 83, [1] = 241, [2] = 151, [3] = 16 }, [1] = { [0] = 98, [1] = 244, [2] = 166, [3] = 31 }, [2] = { [0] = 85, [1] = 243, [2] = 153, [3] = 18 }, [3] = { [0] = 86, [1] = 238, [2] = 154, [3] = 19 }, [4] = { [0] = 97, [1] = 251, [2] = 165, [3] = 30 }, [5] = { [0] = 90, [1] = 240, [2] = 158, [3] = 23 }, [6] = { [0] = 90, [1] = 248, [2] = 158, [3] = 23 }, [7] = { [0] = 86, [1] = 236, [2] = 148, [3] = 19 } })[R[10]][R[0]] })
    if R[10] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 83, [1] = 241, [2] = 151, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 159, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 83, [1] = 241, [2] = 151, [3] = 16 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 83, [1] = 241, [2] = 151, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 159, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 83, [1] = 241, [2] = 151, [3] = 16 })[R[0]] })
        for i = 1, game.initial_units() do
          R[11] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 37, [1] = 156, [2] = 243, [3] = 127 }, [1] = { [0] = 24, [1] = 143, [2] = 230, [3] = 114 }, [2] = { [0] = 36, [1] = 155, [2] = 242, [3] = 126 } })[R[11]][R[0]], ({ [0] = { [0] = 77, [1] = 235, [2] = 145, [3] = 10 }, [1] = { [0] = 86, [1] = 244, [2] = 154, [3] = 19 }, [2] = { [0] = 89, [1] = 247, [2] = 157, [3] = 22 } })[R[11]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 31, [1] = 162, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 99, [1] = 245, [2] = 167, [3] = 32 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 162, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 99, [1] = 245, [2] = 167, [3] = 32 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 162, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 100, [1] = 246, [2] = 168, [3] = 33 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 31, [1] = 162, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 99, [1] = 245, [2] = 167, [3] = 32 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 162, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 99, [1] = 245, [2] = 167, [3] = 32 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 162, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 100, [1] = 246, [2] = 168, [3] = 33 })[R[0]] })
        for i = 1, game.initial_units() do
          R[12] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 153, [2] = 228, [3] = 112 }, [1] = { [0] = 24, [1] = 155, [2] = 230, [3] = 114 }, [2] = { [0] = 26, [1] = 157, [2] = 232, [3] = 116 } })[R[12]][R[0]], ({ [0] = { [0] = 94, [1] = 240, [2] = 162, [3] = 27 }, [1] = { [0] = 96, [1] = 242, [2] = 164, [3] = 29 }, [2] = { [0] = 88, [1] = 234, [2] = 156, [3] = 21 } })[R[12]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[13] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 23, [1] = 142, [2] = 229, [3] = 113 }, [1] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [2] = { [0] = 41, [1] = 160, [2] = 247, [3] = 131 } })[R[13]][R[0]], ({ [0] = { [0] = 79, [1] = 237, [2] = 147, [3] = 12 }, [1] = { [0] = 95, [1] = 253, [2] = 163, [3] = 28 }, [2] = { [0] = 88, [1] = 246, [2] = 156, [3] = 21 } })[R[13]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 36, [1] = 157, [2] = 242, [3] = 126 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 37, [1] = 158, [2] = 243, [3] = 127 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 159, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 160, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 89, [1] = 241, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 160, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 161, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 89, [1] = 241, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 161, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 90, [1] = 242, [2] = 158, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 161, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 91, [1] = 243, [2] = 159, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 161, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 92, [1] = 244, [2] = 160, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 161, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 162, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 162, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 94, [1] = 246, [2] = 162, [3] = 27 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 162, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 95, [1] = 247, [2] = 163, [3] = 28 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 36, [1] = 157, [2] = 242, [3] = 126 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 37, [1] = 158, [2] = 243, [3] = 127 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 159, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 160, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 89, [1] = 241, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 160, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 161, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 89, [1] = 241, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 161, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 90, [1] = 242, [2] = 158, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 161, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 91, [1] = 243, [2] = 159, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 161, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 92, [1] = 244, [2] = 160, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 161, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 162, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 93, [1] = 245, [2] = 161, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 162, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 94, [1] = 246, [2] = 162, [3] = 27 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 162, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 95, [1] = 247, [2] = 163, [3] = 28 })[R[0]] })
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 34, [1] = 155, [2] = 240, [3] = 124 }, [1] = { [0] = 35, [1] = 156, [2] = 241, [3] = 125 }, [2] = { [0] = 22, [1] = 143, [2] = 228, [3] = 112 } })[R[14]][R[0]], ({ [0] = { [0] = 89, [1] = 241, [2] = 157, [3] = 22 }, [1] = { [0] = 96, [1] = 248, [2] = 164, [3] = 29 }, [2] = { [0] = 93, [1] = 245, [2] = 161, [3] = 26 } })[R[14]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 82, [1] = 236, [2] = 150, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 83, [1] = 237, [2] = 151, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 89, [1] = 243, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 97, [1] = 251, [2] = 165, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 83, [1] = 237, [2] = 151, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 89, [1] = 243, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 97, [1] = 251, [2] = 165, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 159, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 83, [1] = 237, [2] = 151, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 159, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 89, [1] = 243, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 159, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 97, [1] = 251, [2] = 165, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 88, [1] = 242, [2] = 156, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 89, [1] = 243, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 90, [1] = 244, [2] = 158, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 91, [1] = 245, [2] = 159, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 96, [1] = 250, [2] = 164, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 97, [1] = 251, [2] = 165, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 42, [1] = 161, [2] = 248, [3] = 132 })[R[0]], ({ [0] = 88, [1] = 242, [2] = 156, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 42, [1] = 161, [2] = 248, [3] = 132 })[R[0]], ({ [0] = 96, [1] = 250, [2] = 164, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 86, [1] = 240, [2] = 154, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 87, [1] = 241, [2] = 155, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 88, [1] = 242, [2] = 156, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 96, [1] = 250, [2] = 164, [3] = 29 })[R[0]] })
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 36, [1] = 155, [2] = 242, [3] = 126 }, [1] = { [0] = 27, [1] = 146, [2] = 233, [3] = 117 }, [2] = { [0] = 35, [1] = 154, [2] = 241, [3] = 125 } })[R[15]][R[0]], ({ [0] = { [0] = 80, [1] = 234, [2] = 148, [3] = 13 }, [1] = { [0] = 88, [1] = 242, [2] = 156, [3] = 21 }, [2] = { [0] = 83, [1] = 237, [2] = 151, [3] = 16 } })[R[15]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 82, [1] = 236, [2] = 150, [3] = 15 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 83, [1] = 237, [2] = 151, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 89, [1] = 243, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 38, [1] = 157, [2] = 244, [3] = 128 })[R[0]], ({ [0] = 97, [1] = 251, [2] = 165, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 83, [1] = 237, [2] = 151, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 89, [1] = 243, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 97, [1] = 251, [2] = 165, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 159, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 83, [1] = 237, [2] = 151, [3] = 16 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 159, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 89, [1] = 243, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 159, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 97, [1] = 251, [2] = 165, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 88, [1] = 242, [2] = 156, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 89, [1] = 243, [2] = 157, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 90, [1] = 244, [2] = 158, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 91, [1] = 245, [2] = 159, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 96, [1] = 250, [2] = 164, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 97, [1] = 251, [2] = 165, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 42, [1] = 161, [2] = 248, [3] = 132 })[R[0]], ({ [0] = 88, [1] = 242, [2] = 156, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 42, [1] = 161, [2] = 248, [3] = 132 })[R[0]], ({ [0] = 96, [1] = 250, [2] = 164, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 86, [1] = 240, [2] = 154, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 87, [1] = 241, [2] = 155, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 88, [1] = 242, [2] = 156, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 43, [1] = 162, [2] = 249, [3] = 133 })[R[0]], ({ [0] = 96, [1] = 250, [2] = 164, [3] = 29 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 32, [1] = 151, [2] = 238, [3] = 122 })[R[0]], ({ [0] = 91, [1] = 241, [2] = 159, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 151, [2] = 238, [3] = 122 })[R[0]], ({ [0] = 92, [1] = 242, [2] = 160, [3] = 25 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 32, [1] = 151, [2] = 238, [3] = 122 })[R[0]], ({ [0] = 91, [1] = 241, [2] = 159, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 32, [1] = 151, [2] = 238, [3] = 122 })[R[0]], ({ [0] = 92, [1] = 242, [2] = 160, [3] = 25 })[R[0]] })
        for i = 1, game.initial_units() do
          R[16] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 147, [2] = 234, [3] = 118 }, [1] = { [0] = 11, [1] = 130, [2] = 217, [3] = 101 }, [2] = { [0] = 33, [1] = 152, [2] = 239, [3] = 123 } })[R[16]][R[0]], ({ [0] = { [0] = 98, [1] = 248, [2] = 166, [3] = 31 }, [1] = { [0] = 85, [1] = 235, [2] = 153, [3] = 18 }, [2] = { [0] = 98, [1] = 248, [2] = 166, [3] = 31 } })[R[16]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 90, [1] = 248, [2] = 158, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 159, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 90, [1] = 248, [2] = 158, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 90, [1] = 248, [2] = 158, [3] = 23 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 39, [1] = 158, [2] = 245, [3] = 129 })[R[0]], ({ [0] = 90, [1] = 248, [2] = 158, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 40, [1] = 159, [2] = 246, [3] = 130 })[R[0]], ({ [0] = 90, [1] = 248, [2] = 158, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 41, [1] = 160, [2] = 247, [3] = 131 })[R[0]], ({ [0] = 90, [1] = 248, [2] = 158, [3] = 23 })[R[0]] })
        for i = 1, game.initial_units() do
          R[17] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 20, [1] = 139, [2] = 226, [3] = 110 }, [1] = { [0] = 25, [1] = 144, [2] = 231, [3] = 115 }, [2] = { [0] = 46, [1] = 165, [2] = 252, [3] = 136 } })[R[17]][R[0]], ({ [0] = { [0] = 80, [1] = 238, [2] = 148, [3] = 13 }, [1] = { [0] = 78, [1] = 236, [2] = 146, [3] = 11 }, [2] = { [0] = 93, [1] = 251, [2] = 161, [3] = 26 } })[R[17]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 87, [1] = 237, [2] = 149, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 88, [1] = 238, [2] = 150, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 89, [1] = 239, [2] = 151, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 93, [1] = 243, [2] = 155, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 94, [1] = 244, [2] = 156, [3] = 27 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 95, [1] = 245, [2] = 157, [3] = 28 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 96, [1] = 246, [2] = 158, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 143, [2] = 230, [3] = 114 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 143, [2] = 230, [3] = 114 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 144, [2] = 231, [3] = 115 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 144, [2] = 231, [3] = 115 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 145, [2] = 232, [3] = 116 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 145, [2] = 232, [3] = 116 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 146, [2] = 233, [3] = 117 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 146, [2] = 233, [3] = 117 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 147, [2] = 234, [3] = 118 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 147, [2] = 234, [3] = 118 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 148, [2] = 235, [3] = 119 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 148, [2] = 235, [3] = 119 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 86, [1] = 236, [2] = 148, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 87, [1] = 237, [2] = 149, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 88, [1] = 238, [2] = 150, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 89, [1] = 239, [2] = 151, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 90, [1] = 240, [2] = 152, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 91, [1] = 241, [2] = 153, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 92, [1] = 242, [2] = 154, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 93, [1] = 243, [2] = 155, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 94, [1] = 244, [2] = 156, [3] = 27 })[R[0]] })
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 21, [1] = 140, [2] = 227, [3] = 111 }, [1] = { [0] = 27, [1] = 146, [2] = 233, [3] = 117 }, [2] = { [0] = 15, [1] = 134, [2] = 221, [3] = 105 } })[R[18]][R[0]], ({ [0] = { [0] = 80, [1] = 230, [2] = 142, [3] = 13 }, [1] = { [0] = 80, [1] = 230, [2] = 142, [3] = 13 }, [2] = { [0] = 101, [1] = 251, [2] = 163, [3] = 34 } })[R[18]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 87, [1] = 237, [2] = 149, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 88, [1] = 238, [2] = 150, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 89, [1] = 239, [2] = 151, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 93, [1] = 243, [2] = 155, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 94, [1] = 244, [2] = 156, [3] = 27 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 95, [1] = 245, [2] = 157, [3] = 28 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 96, [1] = 246, [2] = 158, [3] = 29 })[R[0]] })
        game.create_tube({ ({ [0] = 23, [1] = 142, [2] = 229, [3] = 113 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 143, [2] = 230, [3] = 114 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 24, [1] = 143, [2] = 230, [3] = 114 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 144, [2] = 231, [3] = 115 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 25, [1] = 144, [2] = 231, [3] = 115 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 145, [2] = 232, [3] = 116 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 26, [1] = 145, [2] = 232, [3] = 116 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 146, [2] = 233, [3] = 117 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 27, [1] = 146, [2] = 233, [3] = 117 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 147, [2] = 234, [3] = 118 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 28, [1] = 147, [2] = 234, [3] = 118 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 148, [2] = 235, [3] = 119 })[R[0]], ({ [0] = 84, [1] = 234, [2] = 146, [3] = 17 })[R[0]] })
        game.create_tube({ ({ [0] = 29, [1] = 148, [2] = 235, [3] = 119 })[R[0]], ({ [0] = 97, [1] = 247, [2] = 159, [3] = 30 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 86, [1] = 236, [2] = 148, [3] = 19 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 87, [1] = 237, [2] = 149, [3] = 20 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 88, [1] = 238, [2] = 150, [3] = 21 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 89, [1] = 239, [2] = 151, [3] = 22 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 90, [1] = 240, [2] = 152, [3] = 23 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 91, [1] = 241, [2] = 153, [3] = 24 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 92, [1] = 242, [2] = 154, [3] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 93, [1] = 243, [2] = 155, [3] = 26 })[R[0]] })
        game.create_tube({ ({ [0] = 31, [1] = 150, [2] = 237, [3] = 121 })[R[0]], ({ [0] = 94, [1] = 244, [2] = 156, [3] = 27 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 104, 235 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 246, 118 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 20, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 158, 14 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 76, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 26 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 34, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 196, 199 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 213, 221 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 224, 238 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 219, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 164, 86 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 39, 200 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 78, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 111, 150 } }
    pick(4, 3, { 0, 19, 20 })
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 10, [1] = 77, [2] = 223, [3] = 145 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[1]][R[0]], ({ [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 247, [3] = 161 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[1] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 118, [1] = 28, [2] = 149, [3] = 234 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 0 or R[1] == 1 or R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 17, [1] = 84, [2] = 230, [3] = 152 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 27, [1] = 94, [2] = 244, [3] = 162 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 0 then
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
      elseif R[1] == 1 then
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
      elseif R[1] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[0]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[0]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[0]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [7] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 29, [1] = 96, [2] = 246, [3] = 158 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 0 or R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 } })[R[1]][R[0]], ({ [0] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [1] = { [0] = 35, [1] = 102, [2] = 248, [3] = 170 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
      else
        unseen("R[1]", R[1])
      end
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 111, [1] = 21, [2] = 152, [3] = 227 }, [2] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [5] = { [0] = 102, [1] = 12, [2] = 131, [3] = 218 }, [6] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [7] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 } })[R[1]][R[0]], ({ [0] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [1] = { [0] = 32, [1] = 99, [2] = 245, [3] = 167 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 13, [1] = 80, [2] = 232, [3] = 148 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 33, [1] = 100, [2] = 250, [3] = 162 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 13, [1] = 80, [2] = 230, [3] = 148 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 16, [1] = 83, [2] = 229, [3] = 151 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 135, [1] = 45, [2] = 164, [3] = 251 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 } })[R[1]][R[0]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 17, [1] = 84, [2] = 236, [3] = 152 }, [4] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [5] = { [0] = 29, [1] = 96, [2] = 246, [3] = 164 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 }, [5] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 20, [1] = 87, [2] = 237, [3] = 149 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 27, [1] = 94, [2] = 246, [3] = 162 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 19, [1] = 86, [2] = 236, [3] = 154 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 115, [1] = 25, [2] = 156, [3] = 231 }, [2] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 28, [1] = 95, [2] = 247, [3] = 163 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 22, [1] = 89, [2] = 239, [3] = 151 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 19, [1] = 86, [2] = 240, [3] = 154 }, [5] = { [0] = 24, [1] = 91, [2] = 241, [3] = 159 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 117, [1] = 27, [2] = 158, [3] = 233 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 20, [1] = 87, [2] = 241, [3] = 155 }, [5] = { [0] = 25, [1] = 92, [2] = 242, [3] = 160 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 118, [1] = 28, [2] = 159, [3] = 234 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [3] = { [0] = 23, [1] = 90, [2] = 242, [3] = 158 }, [4] = { [0] = 24, [1] = 91, [2] = 245, [3] = 159 }, [5] = { [0] = 26, [1] = 93, [2] = 243, [3] = 161 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 25, [1] = 92, [2] = 242, [3] = 154 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 24, [1] = 91, [2] = 243, [3] = 159 }, [4] = { [0] = 25, [1] = 92, [2] = 246, [3] = 160 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [3] = { [0] = 25, [1] = 92, [2] = 244, [3] = 160 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 27, [1] = 94, [2] = 244, [3] = 156 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 13, [1] = 80, [2] = 226, [3] = 148 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 27, [1] = 94, [2] = 248, [3] = 162 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 28, [1] = 95, [2] = 245, [3] = 157 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 14, [1] = 81, [2] = 227, [3] = 149 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 28, [1] = 95, [2] = 249, [3] = 163 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[1]][R[0]], ({ [0] = { [0] = 14, [1] = 81, [2] = 239, [3] = 149 }, [1] = { [0] = 15, [1] = 82, [2] = 228, [3] = 150 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 120, [1] = 30, [2] = 151, [3] = 236 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[1]][R[0]], ({ [0] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [1] = { [0] = 20, [1] = 87, [2] = 233, [3] = 155 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[1]][R[0]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[1]][R[0]], ({ [0] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 122, [1] = 32, [2] = 153, [3] = 238 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 24, [1] = 91, [2] = 237, [3] = 159 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 25, [1] = 92, [2] = 238, [3] = 160 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 15, [1] = 82, [2] = 236, [3] = 150 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 30, [1] = 97, [2] = 243, [3] = 165 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [3] = { [0] = 126, [1] = 36, [2] = 157, [3] = 242 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 31, [1] = 98, [2] = 244, [3] = 166 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 19, [1] = 86, [2] = 236, [3] = 148 } })[R[1]][R[0]] })
    if R[1] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [2] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 } })[R[21]][R[0]], ({ [0] = { [0] = 10, [1] = 77, [2] = 235, [3] = 145 }, [1] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 } })[R[21]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[0]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 153, [3] = 228 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 } })[R[22]][R[0]], ({ [0] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [1] = { [0] = 29, [1] = 96, [2] = 242, [3] = 164 }, [2] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 } })[R[22]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [2] = { [0] = 131, [1] = 41, [2] = 160, [3] = 247 } })[R[23]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 } })[R[23]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[0]] })
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [1] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [2] = { [0] = 112, [1] = 22, [2] = 143, [3] = 228 } })[R[24]][R[0]], ({ [0] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [1] = { [0] = 29, [1] = 96, [2] = 248, [3] = 164 }, [2] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 } })[R[24]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 } })[R[25]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [1] = { [0] = 21, [1] = 88, [2] = 242, [3] = 156 }, [2] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 } })[R[25]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[0]] })
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 101, [1] = 11, [2] = 130, [3] = 217 }, [2] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[26]][R[0]], ({ [0] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 }, [1] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [2] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 } })[R[26]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [2] = { [0] = 136, [1] = 46, [2] = 165, [3] = 252 } })[R[27]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 } })[R[27]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 7 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 105, [1] = 15, [2] = 134, [3] = 221 } })[R[28]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [1] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [2] = { [0] = 34, [1] = 101, [2] = 251, [3] = 163 } })[R[28]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 121, [1] = 110, [2] = 118, [3] = 123, [4] = 122, [5] = 112, [6] = 115, [7] = 113 }, [1] = { [0] = 31, [1] = 20, [2] = 28, [3] = 33, [4] = 32, [5] = 22, [6] = 25, [7] = 23 }, [2] = { [0] = 150, [1] = 151, [2] = 147, [3] = 154, [4] = 151, [5] = 141, [6] = 144, [7] = 142 }, [3] = { [0] = 237, [1] = 226, [2] = 234, [3] = 239, [4] = 238, [5] = 228, [6] = 231, [7] = 229 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 13, [3] = 26, [4] = 22, [5] = 22, [6] = 15, [7] = 24 }, [1] = { [0] = 83, [1] = 90, [2] = 80, [3] = 93, [4] = 89, [5] = 89, [6] = 82, [7] = 91 }, [2] = { [0] = 241, [1] = 236, [2] = 238, [3] = 245, [4] = 243, [5] = 239, [6] = 240, [7] = 241 }, [3] = { [0] = 151, [1] = 158, [2] = 148, [3] = 161, [4] = 157, [5] = 157, [6] = 150, [7] = 153 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 121, [1] = 110, [2] = 118, [3] = 123, [4] = 122, [5] = 112, [6] = 115, [7] = 113 }, [1] = { [0] = 31, [1] = 20, [2] = 28, [3] = 33, [4] = 32, [5] = 22, [6] = 25, [7] = 23 }, [2] = { [0] = 150, [1] = 151, [2] = 147, [3] = 154, [4] = 151, [5] = 141, [6] = 144, [7] = 142 }, [3] = { [0] = 237, [1] = 226, [2] = 234, [3] = 239, [4] = 238, [5] = 228, [6] = 231, [7] = 229 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 13, [3] = 26, [4] = 22, [5] = 22, [6] = 15, [7] = 24 }, [1] = { [0] = 83, [1] = 90, [2] = 80, [3] = 93, [4] = 89, [5] = 89, [6] = 82, [7] = 91 }, [2] = { [0] = 241, [1] = 236, [2] = 238, [3] = 245, [4] = 243, [5] = 239, [6] = 240, [7] = 241 }, [3] = { [0] = 151, [1] = 158, [2] = 148, [3] = 161, [4] = 157, [5] = 157, [6] = 150, [7] = 153 } })[R[19]][R[10]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 121, [1] = 120, [2] = 112, [3] = 131, [4] = 122, [5] = 112, [6] = 124, [7] = 106 }, [1] = { [0] = 31, [1] = 30, [2] = 22, [3] = 41, [4] = 32, [5] = 22, [6] = 34, [7] = 16 }, [2] = { [0] = 150, [1] = 161, [2] = 141, [3] = 162, [4] = 151, [5] = 141, [6] = 153, [7] = 135 }, [3] = { [0] = 237, [1] = 236, [2] = 228, [3] = 247, [4] = 238, [5] = 228, [6] = 240, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 9, [1] = 10, [2] = 18, [3] = 30, [4] = 30, [5] = 28, [6] = 15, [7] = 30 }, [1] = { [0] = 76, [1] = 77, [2] = 85, [3] = 97, [4] = 97, [5] = 95, [6] = 82, [7] = 97 }, [2] = { [0] = 234, [1] = 223, [2] = 243, [3] = 249, [4] = 251, [5] = 245, [6] = 240, [7] = 247 }, [3] = { [0] = 144, [1] = 145, [2] = 153, [3] = 165, [4] = 165, [5] = 163, [6] = 150, [7] = 159 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 133, [1] = 121, [2] = 115, [5] = 122, [6] = 125, [7] = 106 }, [1] = { [0] = 43, [1] = 31, [2] = 25, [5] = 32, [6] = 35, [7] = 16 }, [2] = { [0] = 162, [1] = 162, [2] = 144, [5] = 151, [6] = 154, [7] = 135 }, [3] = { [0] = 249, [1] = 237, [2] = 231, [5] = 238, [6] = 241, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 17, [2] = 24, [5] = 27, [6] = 23, [7] = 17 }, [1] = { [0] = 83, [1] = 84, [2] = 91, [5] = 94, [6] = 90, [7] = 84 }, [2] = { [0] = 241, [1] = 230, [2] = 249, [5] = 244, [6] = 248, [7] = 234 }, [3] = { [0] = 151, [1] = 152, [2] = 159, [5] = 162, [6] = 158, [7] = 146 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 0 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 110, [1] = 20, [2] = 139, [3] = 226 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 110, [1] = 20, [2] = 139, [3] = 226 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 110, [1] = 20, [2] = 139, [3] = 226 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 1 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 240, [3] = 162 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 240, [3] = 162 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 240, [3] = 162 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 2 then
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
      elseif R[10] == 5 then
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 121, [1] = 120, [2] = 124, [5] = 122, [6] = 133, [7] = 121 }, [1] = { [0] = 31, [1] = 30, [2] = 34, [5] = 32, [6] = 43, [7] = 31 }, [2] = { [0] = 150, [1] = 161, [2] = 153, [5] = 151, [6] = 162, [7] = 150 }, [3] = { [0] = 237, [1] = 236, [2] = 240, [5] = 238, [6] = 249, [7] = 237 } })[R[19]][R[10]], ({ [0] = { [0] = 23, [1] = 35, [2] = 18, [5] = 20, [6] = 23, [7] = 17 }, [1] = { [0] = 90, [1] = 102, [2] = 85, [5] = 87, [6] = 90, [7] = 84 }, [2] = { [0] = 248, [1] = 248, [2] = 243, [5] = 237, [6] = 248, [7] = 234 }, [3] = { [0] = 158, [1] = 170, [2] = 153, [5] = 155, [6] = 158, [7] = 146 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [2] = 124, [5] = 112, [6] = 116, [7] = 122 }, [1] = { [2] = 34, [5] = 22, [6] = 26, [7] = 32 }, [2] = { [2] = 153, [5] = 141, [6] = 145, [7] = 151 }, [3] = { [2] = 240, [5] = 228, [6] = 232, [7] = 238 } })[R[19]][R[10]], ({ [0] = { [2] = 24, [5] = 15, [6] = 23, [7] = 29 }, [1] = { [2] = 91, [5] = 82, [6] = 90, [7] = 96 }, [2] = { [2] = 249, [5] = 232, [6] = 248, [7] = 246 }, [3] = { [2] = 159, [5] = 150, [6] = 158, [7] = 158 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 0 or R[10] == 1 then
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [3] = 115, [4] = 122 }, [1] = { [3] = 25, [4] = 32 }, [2] = { [3] = 146, [4] = 151 }, [3] = { [3] = 231, [4] = 238 } })[R[19]][R[10]], ({ [0] = { [3] = 30, [4] = 14 }, [1] = { [3] = 97, [4] = 81 }, [2] = { [3] = 249, [4] = 235 }, [3] = { [3] = 165, [4] = 149 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 247, [3] = 161 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 118, [1] = 28, [2] = 149, [3] = 234 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 110, [1] = 111, [2] = 132, [3] = 124, [4] = 114, [5] = 102, [6] = 108, [7] = 114 }, [1] = { [0] = 20, [1] = 21, [2] = 42, [3] = 34, [4] = 24, [5] = 12, [6] = 18, [7] = 24 }, [2] = { [0] = 139, [1] = 152, [2] = 161, [3] = 155, [4] = 143, [5] = 131, [6] = 137, [7] = 143 }, [3] = { [0] = 226, [1] = 227, [2] = 248, [3] = 240, [4] = 230, [5] = 218, [6] = 224, [7] = 230 } })[R[19]][R[10]], ({ [0] = { [0] = 25, [1] = 32, [2] = 18, [3] = 13, [4] = 18, [5] = 22, [6] = 23, [7] = 33 }, [1] = { [0] = 92, [1] = 99, [2] = 85, [3] = 80, [4] = 85, [5] = 89, [6] = 90, [7] = 100 }, [2] = { [0] = 250, [1] = 245, [2] = 243, [3] = 232, [4] = 239, [5] = 239, [6] = 248, [7] = 250 }, [3] = { [0] = 160, [1] = 167, [2] = 153, [3] = 148, [4] = 153, [5] = 157, [6] = 158, [7] = 162 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 110, [2] = 128, [3] = 113, [4] = 132, [5] = 120, [6] = 115, [7] = 124 }, [1] = { [0] = 27, [1] = 20, [2] = 38, [3] = 23, [4] = 42, [5] = 30, [6] = 25, [7] = 34 }, [2] = { [0] = 146, [1] = 151, [2] = 157, [3] = 144, [4] = 161, [5] = 149, [6] = 144, [7] = 153 }, [3] = { [0] = 233, [1] = 226, [2] = 244, [3] = 229, [4] = 248, [5] = 236, [6] = 231, [7] = 240 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 18, [2] = 22, [3] = 20, [4] = 22, [5] = 13, [6] = 28, [7] = 24 }, [1] = { [0] = 79, [1] = 85, [2] = 89, [3] = 87, [4] = 89, [5] = 80, [6] = 95, [7] = 91 }, [2] = { [0] = 237, [1] = 231, [2] = 247, [3] = 239, [4] = 243, [5] = 230, [6] = 253, [7] = 241 }, [3] = { [0] = 147, [1] = 153, [2] = 157, [3] = 155, [4] = 157, [5] = 148, [6] = 163, [7] = 153 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 115, [1] = 110, [2] = 128, [3] = 116, [4] = 134, [5] = 120, [6] = 113, [7] = 124 }, [1] = { [0] = 25, [1] = 20, [2] = 38, [3] = 26, [4] = 44, [5] = 30, [6] = 23, [7] = 34 }, [2] = { [0] = 144, [1] = 151, [2] = 157, [3] = 147, [4] = 163, [5] = 149, [6] = 142, [7] = 153 }, [3] = { [0] = 231, [1] = 226, [2] = 244, [3] = 232, [4] = 250, [5] = 236, [6] = 229, [7] = 240 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 16, [2] = 20, [3] = 16, [4] = 22, [5] = 15, [6] = 28, [7] = 26 }, [1] = { [0] = 79, [1] = 83, [2] = 87, [3] = 83, [4] = 89, [5] = 82, [6] = 95, [7] = 93 }, [2] = { [0] = 237, [1] = 229, [2] = 245, [3] = 235, [4] = 243, [5] = 232, [6] = 253, [7] = 243 }, [3] = { [0] = 147, [1] = 151, [2] = 155, [3] = 151, [4] = 157, [5] = 150, [6] = 163, [7] = 155 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 133, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 43, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 164, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 249, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 20, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 87, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 239, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 155, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 131, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 41, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 162, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 247, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 16, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 83, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 235, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 151, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 115, [1] = 110, [2] = 128, [3] = 119, [4] = 134, [5] = 120, [6] = 113, [7] = 124 }, [1] = { [0] = 25, [1] = 20, [2] = 38, [3] = 29, [4] = 44, [5] = 30, [6] = 23, [7] = 34 }, [2] = { [0] = 144, [1] = 151, [2] = 157, [3] = 150, [4] = 163, [5] = 149, [6] = 142, [7] = 153 }, [3] = { [0] = 231, [1] = 226, [2] = 244, [3] = 235, [4] = 250, [5] = 236, [6] = 229, [7] = 240 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 18, [2] = 20, [3] = 31, [4] = 22, [5] = 15, [6] = 28, [7] = 26 }, [1] = { [0] = 79, [1] = 85, [2] = 87, [3] = 98, [4] = 89, [5] = 82, [6] = 95, [7] = 93 }, [2] = { [0] = 237, [1] = 231, [2] = 245, [3] = 250, [4] = 243, [5] = 232, [6] = 253, [7] = 243 }, [3] = { [0] = 147, [1] = 153, [2] = 155, [3] = 166, [4] = 157, [5] = 150, [6] = 163, [7] = 155 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 115, [1] = 113, [2] = 128, [3] = 119, [4] = 134, [5] = 120, [6] = 113, [7] = 124 }, [1] = { [0] = 25, [1] = 23, [2] = 38, [3] = 29, [4] = 44, [5] = 30, [6] = 23, [7] = 34 }, [2] = { [0] = 144, [1] = 154, [2] = 157, [3] = 150, [4] = 163, [5] = 149, [6] = 142, [7] = 153 }, [3] = { [0] = 231, [1] = 229, [2] = 244, [3] = 235, [4] = 250, [5] = 236, [6] = 229, [7] = 240 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 18, [2] = 20, [3] = 31, [4] = 22, [5] = 15, [6] = 28, [7] = 26 }, [1] = { [0] = 79, [1] = 85, [2] = 87, [3] = 98, [4] = 89, [5] = 82, [6] = 95, [7] = 93 }, [2] = { [0] = 237, [1] = 231, [2] = 245, [3] = 250, [4] = 243, [5] = 232, [6] = 253, [7] = 243 }, [3] = { [0] = 147, [1] = 153, [2] = 155, [3] = 166, [4] = 157, [5] = 150, [6] = 163, [7] = 155 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 110, [2] = 110, [3] = 113, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 20, [2] = 20, [3] = 23, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 151, [2] = 139, [3] = 144, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 226, [2] = 226, [3] = 229, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 20, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 87, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 239, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 155, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 113, [2] = 128, [3] = 113, [4] = 127, [5] = 107, [6] = 120, [7] = 108 }, [1] = { [0] = 22, [1] = 23, [2] = 38, [3] = 23, [4] = 37, [5] = 17, [6] = 30, [7] = 18 }, [2] = { [0] = 141, [1] = 154, [2] = 157, [3] = 144, [4] = 156, [5] = 136, [6] = 149, [7] = 137 }, [3] = { [0] = 228, [1] = 229, [2] = 244, [3] = 229, [4] = 243, [5] = 223, [6] = 236, [7] = 224 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 12, [2] = 26, [3] = 20, [4] = 26, [5] = 12, [6] = 25, [7] = 24 }, [1] = { [0] = 79, [1] = 79, [2] = 93, [3] = 87, [4] = 93, [5] = 79, [6] = 92, [7] = 91 }, [2] = { [0] = 237, [1] = 225, [2] = 251, [3] = 239, [4] = 247, [5] = 229, [6] = 250, [7] = 241 }, [3] = { [0] = 147, [1] = 147, [2] = 161, [3] = 155, [4] = 161, [5] = 147, [6] = 160, [7] = 153 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 116, [2] = 124, [3] = 119, [4] = 129, [5] = 116, [6] = 129, [7] = 103 }, [1] = { [0] = 22, [1] = 26, [2] = 34, [3] = 29, [4] = 39, [5] = 26, [6] = 39, [7] = 13 }, [2] = { [0] = 141, [1] = 157, [2] = 153, [3] = 150, [4] = 158, [5] = 145, [6] = 158, [7] = 132 }, [3] = { [0] = 228, [1] = 232, [2] = 240, [3] = 235, [4] = 245, [5] = 232, [6] = 245, [7] = 219 } })[R[19]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 27, [3] = 31, [4] = 17, [5] = 20, [6] = 22, [7] = 21 }, [1] = { [0] = 76, [1] = 76, [2] = 94, [3] = 98, [4] = 84, [5] = 87, [6] = 89, [7] = 88 }, [2] = { [0] = 234, [1] = 222, [2] = 252, [3] = 250, [4] = 238, [5] = 237, [6] = 247, [7] = 238 }, [3] = { [0] = 144, [1] = 144, [2] = 162, [3] = 166, [4] = 152, [5] = 155, [6] = 157, [7] = 150 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 133, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 43, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 164, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 249, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 20, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 87, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 239, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 155, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 131, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 41, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 162, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 247, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 16, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 83, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 235, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 151, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 115, [1] = 110, [2] = 128, [3] = 119, [4] = 134, [5] = 120, [6] = 113, [7] = 124 }, [1] = { [0] = 25, [1] = 20, [2] = 38, [3] = 29, [4] = 44, [5] = 30, [6] = 23, [7] = 34 }, [2] = { [0] = 144, [1] = 151, [2] = 157, [3] = 150, [4] = 163, [5] = 149, [6] = 142, [7] = 153 }, [3] = { [0] = 231, [1] = 226, [2] = 244, [3] = 235, [4] = 250, [5] = 236, [6] = 229, [7] = 240 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 18, [2] = 20, [3] = 31, [4] = 22, [5] = 15, [6] = 28, [7] = 26 }, [1] = { [0] = 79, [1] = 85, [2] = 87, [3] = 98, [4] = 89, [5] = 82, [6] = 95, [7] = 93 }, [2] = { [0] = 237, [1] = 231, [2] = 245, [3] = 250, [4] = 243, [5] = 232, [6] = 253, [7] = 243 }, [3] = { [0] = 147, [1] = 153, [2] = 155, [3] = 166, [4] = 157, [5] = 150, [6] = 163, [7] = 155 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 119, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 29, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 150, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 235, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 31, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 98, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 250, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 166, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 113, [2] = 128, [3] = 113, [4] = 127, [5] = 107, [6] = 120, [7] = 108 }, [1] = { [0] = 22, [1] = 23, [2] = 38, [3] = 23, [4] = 37, [5] = 17, [6] = 30, [7] = 18 }, [2] = { [0] = 141, [1] = 154, [2] = 157, [3] = 144, [4] = 156, [5] = 136, [6] = 149, [7] = 137 }, [3] = { [0] = 228, [1] = 229, [2] = 244, [3] = 229, [4] = 243, [5] = 223, [6] = 236, [7] = 224 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 12, [2] = 26, [3] = 20, [4] = 26, [5] = 12, [6] = 25, [7] = 24 }, [1] = { [0] = 79, [1] = 79, [2] = 93, [3] = 87, [4] = 93, [5] = 79, [6] = 92, [7] = 91 }, [2] = { [0] = 237, [1] = 225, [2] = 251, [3] = 239, [4] = 247, [5] = 229, [6] = 250, [7] = 241 }, [3] = { [0] = 147, [1] = 147, [2] = 161, [3] = 155, [4] = 161, [5] = 147, [6] = 160, [7] = 153 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 116, [2] = 124, [3] = 119, [4] = 129, [5] = 116, [6] = 129, [7] = 103 }, [1] = { [0] = 22, [1] = 26, [2] = 34, [3] = 29, [4] = 39, [5] = 26, [6] = 39, [7] = 13 }, [2] = { [0] = 141, [1] = 157, [2] = 153, [3] = 150, [4] = 158, [5] = 145, [6] = 158, [7] = 132 }, [3] = { [0] = 228, [1] = 232, [2] = 240, [3] = 235, [4] = 245, [5] = 232, [6] = 245, [7] = 219 } })[R[19]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 27, [3] = 31, [4] = 17, [5] = 20, [6] = 22, [7] = 21 }, [1] = { [0] = 76, [1] = 76, [2] = 94, [3] = 98, [4] = 84, [5] = 87, [6] = 89, [7] = 88 }, [2] = { [0] = 234, [1] = 222, [2] = 252, [3] = 250, [4] = 238, [5] = 237, [6] = 247, [7] = 238 }, [3] = { [0] = 144, [1] = 144, [2] = 162, [3] = 166, [4] = 152, [5] = 155, [6] = 157, [7] = 150 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 133, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 43, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 164, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 249, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 20, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 87, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 239, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 155, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 131, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 41, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 162, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 247, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 16, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 83, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 235, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 151, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 113, [2] = 128, [3] = 119, [4] = 127, [5] = 107, [6] = 120, [7] = 108 }, [1] = { [0] = 22, [1] = 23, [2] = 38, [3] = 29, [4] = 37, [5] = 17, [6] = 30, [7] = 18 }, [2] = { [0] = 141, [1] = 154, [2] = 157, [3] = 150, [4] = 156, [5] = 136, [6] = 149, [7] = 137 }, [3] = { [0] = 228, [1] = 229, [2] = 244, [3] = 235, [4] = 243, [5] = 223, [6] = 236, [7] = 224 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 12, [2] = 26, [3] = 31, [4] = 26, [5] = 12, [6] = 25, [7] = 24 }, [1] = { [0] = 79, [1] = 79, [2] = 93, [3] = 98, [4] = 93, [5] = 79, [6] = 92, [7] = 91 }, [2] = { [0] = 237, [1] = 225, [2] = 251, [3] = 250, [4] = 247, [5] = 229, [6] = 250, [7] = 241 }, [3] = { [0] = 147, [1] = 147, [2] = 161, [3] = 166, [4] = 161, [5] = 147, [6] = 160, [7] = 153 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 116, [2] = 124, [3] = 119, [4] = 129, [5] = 116, [6] = 129, [7] = 103 }, [1] = { [0] = 22, [1] = 26, [2] = 34, [3] = 29, [4] = 39, [5] = 26, [6] = 39, [7] = 13 }, [2] = { [0] = 141, [1] = 157, [2] = 153, [3] = 150, [4] = 158, [5] = 145, [6] = 158, [7] = 132 }, [3] = { [0] = 228, [1] = 232, [2] = 240, [3] = 235, [4] = 245, [5] = 232, [6] = 245, [7] = 219 } })[R[19]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 27, [3] = 31, [4] = 17, [5] = 20, [6] = 22, [7] = 21 }, [1] = { [0] = 76, [1] = 76, [2] = 94, [3] = 98, [4] = 84, [5] = 87, [6] = 89, [7] = 88 }, [2] = { [0] = 234, [1] = 222, [2] = 252, [3] = 250, [4] = 238, [5] = 237, [6] = 247, [7] = 238 }, [3] = { [0] = 144, [1] = 144, [2] = 162, [3] = 166, [4] = 152, [5] = 155, [6] = 157, [7] = 150 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 133, [1] = 119, [2] = 120, [3] = 123, [4] = 135, [5] = 108, [6] = 129, [7] = 117 }, [1] = { [0] = 43, [1] = 29, [2] = 30, [3] = 33, [4] = 45, [5] = 18, [6] = 39, [7] = 27 }, [2] = { [0] = 162, [1] = 160, [2] = 149, [3] = 154, [4] = 164, [5] = 137, [6] = 158, [7] = 146 }, [3] = { [0] = 249, [1] = 235, [2] = 236, [3] = 239, [4] = 251, [5] = 224, [6] = 245, [7] = 233 } })[R[19]][R[10]], ({ [0] = { [0] = 20, [1] = 22, [2] = 20, [3] = 17, [4] = 13, [5] = 29, [6] = 25, [7] = 23 }, [1] = { [0] = 87, [1] = 89, [2] = 87, [3] = 84, [4] = 80, [5] = 96, [6] = 92, [7] = 90 }, [2] = { [0] = 245, [1] = 235, [2] = 245, [3] = 236, [4] = 234, [5] = 246, [6] = 250, [7] = 240 }, [3] = { [0] = 155, [1] = 157, [2] = 155, [3] = 152, [4] = 148, [5] = 164, [6] = 160, [7] = 152 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 113, [2] = 115, [3] = 115, [4] = 122, [5] = 112, [6] = 115, [7] = 106 }, [1] = { [0] = 23, [1] = 23, [2] = 25, [3] = 25, [4] = 32, [5] = 22, [6] = 25, [7] = 16 }, [2] = { [0] = 142, [1] = 154, [2] = 144, [3] = 146, [4] = 151, [5] = 141, [6] = 144, [7] = 135 }, [3] = { [0] = 229, [1] = 229, [2] = 231, [3] = 231, [4] = 238, [5] = 228, [6] = 231, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 18, [3] = 26, [4] = 16, [5] = 18, [6] = 17, [7] = 20 }, [1] = { [0] = 83, [1] = 90, [2] = 85, [3] = 93, [4] = 83, [5] = 85, [6] = 84, [7] = 87 }, [2] = { [0] = 241, [1] = 236, [2] = 243, [3] = 245, [4] = 237, [5] = 235, [6] = 242, [7] = 237 }, [3] = { [0] = 151, [1] = 158, [2] = 153, [3] = 161, [4] = 151, [5] = 153, [6] = 152, [7] = 149 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 114, [1] = 114, [2] = 116, [3] = 115, [4] = 122, [5] = 112, [6] = 115, [7] = 106 }, [1] = { [0] = 24, [1] = 24, [2] = 26, [3] = 25, [4] = 32, [5] = 22, [6] = 25, [7] = 16 }, [2] = { [0] = 143, [1] = 155, [2] = 145, [3] = 146, [4] = 151, [5] = 141, [6] = 144, [7] = 135 }, [3] = { [0] = 230, [1] = 230, [2] = 232, [3] = 231, [4] = 238, [5] = 228, [6] = 231, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 18, [3] = 27, [4] = 17, [5] = 19, [6] = 18, [7] = 21 }, [1] = { [0] = 83, [1] = 90, [2] = 85, [3] = 94, [4] = 84, [5] = 86, [6] = 85, [7] = 88 }, [2] = { [0] = 241, [1] = 236, [2] = 243, [3] = 246, [4] = 238, [5] = 236, [6] = 243, [7] = 238 }, [3] = { [0] = 151, [1] = 158, [2] = 153, [3] = 162, [4] = 152, [5] = 154, [6] = 153, [7] = 150 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 115, [1] = 115, [2] = 117, [3] = 115, [4] = 122, [5] = 112, [6] = 115, [7] = 106 }, [1] = { [0] = 25, [1] = 25, [2] = 27, [3] = 25, [4] = 32, [5] = 22, [6] = 25, [7] = 16 }, [2] = { [0] = 144, [1] = 156, [2] = 146, [3] = 146, [4] = 151, [5] = 141, [6] = 144, [7] = 135 }, [3] = { [0] = 231, [1] = 231, [2] = 233, [3] = 231, [4] = 238, [5] = 228, [6] = 231, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 18, [3] = 28, [4] = 18, [5] = 20, [6] = 19, [7] = 22 }, [1] = { [0] = 83, [1] = 90, [2] = 85, [3] = 95, [4] = 85, [5] = 87, [6] = 86, [7] = 89 }, [2] = { [0] = 241, [1] = 236, [2] = 243, [3] = 247, [4] = 239, [5] = 237, [6] = 244, [7] = 239 }, [3] = { [0] = 151, [1] = 158, [2] = 153, [3] = 163, [4] = 153, [5] = 155, [6] = 154, [7] = 151 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 116, [1] = 116, [2] = 118, [3] = 116, [4] = 122, [5] = 112, [6] = 115, [7] = 106 }, [1] = { [0] = 26, [1] = 26, [2] = 28, [3] = 26, [4] = 32, [5] = 22, [6] = 25, [7] = 16 }, [2] = { [0] = 145, [1] = 157, [2] = 147, [3] = 147, [4] = 151, [5] = 141, [6] = 144, [7] = 135 }, [3] = { [0] = 232, [1] = 232, [2] = 234, [3] = 232, [4] = 238, [5] = 228, [6] = 231, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 15, [3] = 26, [4] = 19, [5] = 24, [6] = 20, [7] = 23 }, [1] = { [0] = 83, [1] = 90, [2] = 82, [3] = 93, [4] = 86, [5] = 91, [6] = 87, [7] = 90 }, [2] = { [0] = 241, [1] = 236, [2] = 240, [3] = 245, [4] = 240, [5] = 241, [6] = 245, [7] = 240 }, [3] = { [0] = 151, [1] = 158, [2] = 150, [3] = 161, [4] = 154, [5] = 159, [6] = 155, [7] = 152 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 117, [1] = 117, [2] = 118, [3] = 117, [4] = 122, [5] = 112, [6] = 115, [7] = 106 }, [1] = { [0] = 27, [1] = 27, [2] = 28, [3] = 27, [4] = 32, [5] = 22, [6] = 25, [7] = 16 }, [2] = { [0] = 146, [1] = 158, [2] = 147, [3] = 148, [4] = 151, [5] = 141, [6] = 144, [7] = 135 }, [3] = { [0] = 233, [1] = 233, [2] = 234, [3] = 233, [4] = 238, [5] = 228, [6] = 231, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 16, [3] = 22, [4] = 20, [5] = 25, [6] = 21, [7] = 24 }, [1] = { [0] = 83, [1] = 90, [2] = 83, [3] = 89, [4] = 87, [5] = 92, [6] = 88, [7] = 91 }, [2] = { [0] = 241, [1] = 236, [2] = 241, [3] = 241, [4] = 241, [5] = 242, [6] = 246, [7] = 241 }, [3] = { [0] = 151, [1] = 158, [2] = 151, [3] = 157, [4] = 155, [5] = 160, [6] = 156, [7] = 153 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 118, [1] = 118, [2] = 118, [3] = 117, [4] = 122, [5] = 112, [6] = 118, [7] = 106 }, [1] = { [0] = 28, [1] = 28, [2] = 28, [3] = 27, [4] = 32, [5] = 22, [6] = 28, [7] = 16 }, [2] = { [0] = 147, [1] = 159, [2] = 147, [3] = 148, [4] = 151, [5] = 141, [6] = 147, [7] = 135 }, [3] = { [0] = 234, [1] = 234, [2] = 234, [3] = 233, [4] = 238, [5] = 228, [6] = 234, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 17, [3] = 23, [4] = 24, [5] = 26, [6] = 15, [7] = 25 }, [1] = { [0] = 83, [1] = 90, [2] = 84, [3] = 90, [4] = 91, [5] = 93, [6] = 82, [7] = 92 }, [2] = { [0] = 241, [1] = 236, [2] = 242, [3] = 242, [4] = 245, [5] = 243, [6] = 240, [7] = 242 }, [3] = { [0] = 151, [1] = 158, [2] = 152, [3] = 158, [4] = 159, [5] = 161, [6] = 150, [7] = 154 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 119, [1] = 119, [2] = 118, [3] = 117, [4] = 122, [5] = 115, [6] = 119, [7] = 106 }, [1] = { [0] = 29, [1] = 29, [2] = 28, [3] = 27, [4] = 32, [5] = 25, [6] = 29, [7] = 16 }, [2] = { [0] = 148, [1] = 160, [2] = 147, [3] = 148, [4] = 151, [5] = 144, [6] = 148, [7] = 135 }, [3] = { [0] = 235, [1] = 235, [2] = 234, [3] = 233, [4] = 238, [5] = 231, [6] = 235, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 18, [3] = 24, [4] = 25, [5] = 22, [6] = 15, [7] = 26 }, [1] = { [0] = 83, [1] = 90, [2] = 85, [3] = 91, [4] = 92, [5] = 89, [6] = 82, [7] = 93 }, [2] = { [0] = 241, [1] = 236, [2] = 243, [3] = 243, [4] = 246, [5] = 239, [6] = 240, [7] = 243 }, [3] = { [0] = 151, [1] = 158, [2] = 153, [3] = 159, [4] = 160, [5] = 157, [6] = 150, [7] = 155 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 120, [2] = 118, [3] = 117, [4] = 122, [5] = 115, [6] = 119, [7] = 106 }, [1] = { [0] = 31, [1] = 30, [2] = 28, [3] = 27, [4] = 32, [5] = 25, [6] = 29, [7] = 16 }, [2] = { [0] = 150, [1] = 161, [2] = 147, [3] = 148, [4] = 151, [5] = 144, [6] = 148, [7] = 135 }, [3] = { [0] = 237, [1] = 236, [2] = 234, [3] = 233, [4] = 238, [5] = 231, [6] = 235, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 12, [2] = 19, [3] = 25, [4] = 26, [5] = 28, [6] = 23, [7] = 27 }, [1] = { [0] = 78, [1] = 79, [2] = 86, [3] = 92, [4] = 93, [5] = 95, [6] = 90, [7] = 94 }, [2] = { [0] = 236, [1] = 225, [2] = 244, [3] = 244, [4] = 247, [5] = 245, [6] = 248, [7] = 244 }, [3] = { [0] = 146, [1] = 147, [2] = 154, [3] = 160, [4] = 161, [5] = 163, [6] = 158, [7] = 156 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 120, [2] = 118, [3] = 117, [4] = 122, [5] = 116, [6] = 120, [7] = 106 }, [1] = { [0] = 31, [1] = 30, [2] = 28, [3] = 27, [4] = 32, [5] = 26, [6] = 30, [7] = 16 }, [2] = { [0] = 150, [1] = 161, [2] = 147, [3] = 148, [4] = 151, [5] = 145, [6] = 149, [7] = 135 }, [3] = { [0] = 237, [1] = 236, [2] = 234, [3] = 233, [4] = 238, [5] = 232, [6] = 236, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 13, [2] = 20, [3] = 26, [4] = 27, [5] = 22, [6] = 15, [7] = 28 }, [1] = { [0] = 79, [1] = 80, [2] = 87, [3] = 93, [4] = 94, [5] = 89, [6] = 82, [7] = 95 }, [2] = { [0] = 237, [1] = 226, [2] = 245, [3] = 245, [4] = 248, [5] = 239, [6] = 240, [7] = 245 }, [3] = { [0] = 147, [1] = 148, [2] = 155, [3] = 161, [4] = 162, [5] = 157, [6] = 150, [7] = 157 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 120, [2] = 118, [3] = 118, [4] = 122, [5] = 116, [6] = 120, [7] = 109 }, [1] = { [0] = 31, [1] = 30, [2] = 28, [3] = 28, [4] = 32, [5] = 26, [6] = 30, [7] = 19 }, [2] = { [0] = 150, [1] = 161, [2] = 147, [3] = 149, [4] = 151, [5] = 145, [6] = 149, [7] = 138 }, [3] = { [0] = 237, [1] = 236, [2] = 234, [3] = 234, [4] = 238, [5] = 232, [6] = 236, [7] = 225 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 14, [2] = 21, [3] = 22, [4] = 28, [5] = 28, [6] = 23, [7] = 17 }, [1] = { [0] = 80, [1] = 81, [2] = 88, [3] = 89, [4] = 95, [5] = 95, [6] = 90, [7] = 84 }, [2] = { [0] = 238, [1] = 227, [2] = 246, [3] = 241, [4] = 249, [5] = 245, [6] = 248, [7] = 234 }, [3] = { [0] = 148, [1] = 149, [2] = 156, [3] = 157, [4] = 163, [5] = 163, [6] = 158, [7] = 146 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 120, [2] = 118, [3] = 118, [4] = 125, [5] = 117, [6] = 121, [7] = 109 }, [1] = { [0] = 31, [1] = 30, [2] = 28, [3] = 28, [4] = 35, [5] = 27, [6] = 31, [7] = 19 }, [2] = { [0] = 150, [1] = 161, [2] = 147, [3] = 149, [4] = 154, [5] = 146, [6] = 150, [7] = 138 }, [3] = { [0] = 237, [1] = 236, [2] = 234, [3] = 234, [4] = 241, [5] = 233, [6] = 237, [7] = 225 } })[R[19]][R[10]], ({ [0] = { [0] = 14, [1] = 15, [2] = 22, [3] = 26, [4] = 14, [5] = 22, [6] = 15, [7] = 30 }, [1] = { [0] = 81, [1] = 82, [2] = 89, [3] = 93, [4] = 81, [5] = 89, [6] = 82, [7] = 97 }, [2] = { [0] = 239, [1] = 228, [2] = 247, [3] = 245, [4] = 235, [5] = 239, [6] = 240, [7] = 247 }, [3] = { [0] = 149, [1] = 150, [2] = 157, [3] = 161, [4] = 149, [5] = 157, [6] = 150, [7] = 159 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 120, [2] = 118, [3] = 119, [4] = 125, [5] = 117, [6] = 121, [7] = 110 }, [1] = { [0] = 31, [1] = 30, [2] = 28, [3] = 29, [4] = 35, [5] = 27, [6] = 31, [7] = 20 }, [2] = { [0] = 150, [1] = 161, [2] = 147, [3] = 150, [4] = 154, [5] = 146, [6] = 150, [7] = 139 }, [3] = { [0] = 237, [1] = 236, [2] = 234, [3] = 235, [4] = 241, [5] = 233, [6] = 237, [7] = 226 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 23, [2] = 23, [3] = 26, [4] = 22, [5] = 28, [6] = 23, [7] = 17 }, [1] = { [0] = 85, [1] = 90, [2] = 90, [3] = 93, [4] = 89, [5] = 95, [6] = 90, [7] = 84 }, [2] = { [0] = 243, [1] = 236, [2] = 248, [3] = 245, [4] = 243, [5] = 245, [6] = 248, [7] = 234 }, [3] = { [0] = 153, [1] = 158, [2] = 158, [3] = 161, [4] = 157, [5] = 163, [6] = 158, [7] = 146 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 121, [2] = 118, [3] = 120, [4] = 125, [5] = 118, [6] = 122, [7] = 110 }, [1] = { [0] = 31, [1] = 31, [2] = 28, [3] = 30, [4] = 35, [5] = 28, [6] = 32, [7] = 20 }, [2] = { [0] = 150, [1] = 162, [2] = 147, [3] = 151, [4] = 154, [5] = 147, [6] = 151, [7] = 139 }, [3] = { [0] = 237, [1] = 237, [2] = 234, [3] = 236, [4] = 241, [5] = 234, [6] = 238, [7] = 226 } })[R[19]][R[10]], ({ [0] = { [0] = 19, [1] = 20, [2] = 24, [3] = 26, [4] = 30, [5] = 22, [6] = 15, [7] = 30 }, [1] = { [0] = 86, [1] = 87, [2] = 91, [3] = 93, [4] = 97, [5] = 89, [6] = 82, [7] = 97 }, [2] = { [0] = 244, [1] = 233, [2] = 249, [3] = 245, [4] = 251, [5] = 239, [6] = 240, [7] = 247 }, [3] = { [0] = 154, [1] = 155, [2] = 159, [3] = 161, [4] = 165, [5] = 157, [6] = 150, [7] = 159 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 121, [2] = 119, [3] = 121, [4] = 126, [5] = 118, [6] = 122, [7] = 111 }, [1] = { [0] = 31, [1] = 31, [2] = 29, [3] = 31, [4] = 36, [5] = 28, [6] = 32, [7] = 21 }, [2] = { [0] = 150, [1] = 162, [2] = 148, [3] = 152, [4] = 155, [5] = 147, [6] = 151, [7] = 140 }, [3] = { [0] = 237, [1] = 237, [2] = 235, [3] = 237, [4] = 242, [5] = 234, [6] = 238, [7] = 227 } })[R[19]][R[10]], ({ [0] = { [0] = 20, [1] = 21, [2] = 18, [3] = 19, [4] = 14, [5] = 28, [6] = 23, [7] = 17 }, [1] = { [0] = 87, [1] = 88, [2] = 85, [3] = 86, [4] = 81, [5] = 95, [6] = 90, [7] = 84 }, [2] = { [0] = 245, [1] = 234, [2] = 243, [3] = 238, [4] = 235, [5] = 245, [6] = 248, [7] = 234 }, [3] = { [0] = 155, [1] = 156, [2] = 153, [3] = 154, [4] = 149, [5] = 163, [6] = 158, [7] = 146 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 121, [2] = 119, [3] = 121, [4] = 126, [5] = 119, [6] = 124, [7] = 111 }, [1] = { [0] = 31, [1] = 31, [2] = 29, [3] = 31, [4] = 36, [5] = 29, [6] = 34, [7] = 21 }, [2] = { [0] = 150, [1] = 162, [2] = 148, [3] = 152, [4] = 155, [5] = 148, [6] = 153, [7] = 140 }, [3] = { [0] = 237, [1] = 237, [2] = 235, [3] = 237, [4] = 242, [5] = 235, [6] = 240, [7] = 227 } })[R[19]][R[10]], ({ [0] = { [0] = 21, [1] = 22, [2] = 24, [3] = 26, [4] = 22, [5] = 22, [6] = 17, [7] = 30 }, [1] = { [0] = 88, [1] = 89, [2] = 91, [3] = 93, [4] = 89, [5] = 89, [6] = 84, [7] = 97 }, [2] = { [0] = 246, [1] = 235, [2] = 249, [3] = 245, [4] = 243, [5] = 239, [6] = 242, [7] = 247 }, [3] = { [0] = 156, [1] = 157, [2] = 159, [3] = 161, [4] = 157, [5] = 157, [6] = 152, [7] = 159 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 124, [1] = 121, [2] = 120, [3] = 122, [4] = 126, [5] = 119, [6] = 124, [7] = 112 }, [1] = { [0] = 34, [1] = 31, [2] = 30, [3] = 32, [4] = 36, [5] = 29, [6] = 34, [7] = 22 }, [2] = { [0] = 153, [1] = 162, [2] = 149, [3] = 153, [4] = 155, [5] = 148, [6] = 153, [7] = 141 }, [3] = { [0] = 240, [1] = 237, [2] = 236, [3] = 238, [4] = 242, [5] = 235, [6] = 240, [7] = 228 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 18, [3] = 19, [4] = 30, [5] = 28, [6] = 18, [7] = 17 }, [1] = { [0] = 83, [1] = 90, [2] = 85, [3] = 86, [4] = 97, [5] = 95, [6] = 85, [7] = 84 }, [2] = { [0] = 241, [1] = 236, [2] = 243, [3] = 238, [4] = 251, [5] = 245, [6] = 243, [7] = 234 }, [3] = { [0] = 151, [1] = 158, [2] = 153, [3] = 154, [4] = 165, [5] = 163, [6] = 153, [7] = 146 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 125, [1] = 121, [2] = 120, [3] = 123, [4] = 127, [5] = 120, [6] = 124, [7] = 112 }, [1] = { [0] = 35, [1] = 31, [2] = 30, [3] = 33, [4] = 37, [5] = 30, [6] = 34, [7] = 22 }, [2] = { [0] = 154, [1] = 162, [2] = 149, [3] = 154, [4] = 156, [5] = 149, [6] = 153, [7] = 141 }, [3] = { [0] = 241, [1] = 237, [2] = 236, [3] = 239, [4] = 243, [5] = 236, [6] = 240, [7] = 228 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 24, [2] = 24, [3] = 19, [4] = 14, [5] = 22, [6] = 19, [7] = 30 }, [1] = { [0] = 83, [1] = 91, [2] = 91, [3] = 86, [4] = 81, [5] = 89, [6] = 86, [7] = 97 }, [2] = { [0] = 241, [1] = 237, [2] = 249, [3] = 238, [4] = 235, [5] = 239, [6] = 244, [7] = 247 }, [3] = { [0] = 151, [1] = 159, [2] = 159, [3] = 154, [4] = 149, [5] = 157, [6] = 154, [7] = 159 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 126, [1] = 121, [2] = 121, [3] = 124, [4] = 127, [5] = 121, [6] = 124, [7] = 113 }, [1] = { [0] = 36, [1] = 31, [2] = 31, [3] = 34, [4] = 37, [5] = 31, [6] = 34, [7] = 23 }, [2] = { [0] = 155, [1] = 162, [2] = 150, [3] = 155, [4] = 156, [5] = 150, [6] = 153, [7] = 142 }, [3] = { [0] = 242, [1] = 237, [2] = 237, [3] = 240, [4] = 243, [5] = 237, [6] = 240, [7] = 229 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 25, [2] = 18, [3] = 19, [4] = 15, [5] = 22, [6] = 20, [7] = 17 }, [1] = { [0] = 83, [1] = 92, [2] = 85, [3] = 86, [4] = 82, [5] = 89, [6] = 87, [7] = 84 }, [2] = { [0] = 241, [1] = 238, [2] = 243, [3] = 238, [4] = 236, [5] = 239, [6] = 245, [7] = 234 }, [3] = { [0] = 151, [1] = 160, [2] = 153, [3] = 154, [4] = 150, [5] = 157, [6] = 155, [7] = 146 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 127, [1] = 121, [2] = 121, [3] = 125, [4] = 127, [5] = 122, [6] = 124, [7] = 113 }, [1] = { [0] = 37, [1] = 31, [2] = 31, [3] = 35, [4] = 37, [5] = 32, [6] = 34, [7] = 23 }, [2] = { [0] = 156, [1] = 162, [2] = 150, [3] = 156, [4] = 156, [5] = 151, [6] = 153, [7] = 142 }, [3] = { [0] = 243, [1] = 237, [2] = 237, [3] = 241, [4] = 243, [5] = 238, [6] = 240, [7] = 229 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 30, [2] = 24, [3] = 19, [4] = 22, [5] = 22, [6] = 21, [7] = 18 }, [1] = { [0] = 83, [1] = 97, [2] = 91, [3] = 86, [4] = 89, [5] = 89, [6] = 88, [7] = 85 }, [2] = { [0] = 241, [1] = 243, [2] = 249, [3] = 238, [4] = 243, [5] = 239, [6] = 246, [7] = 235 }, [3] = { [0] = 151, [1] = 165, [2] = 159, [3] = 154, [4] = 157, [5] = 157, [6] = 156, [7] = 147 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 128, [1] = 121, [2] = 122, [3] = 126, [4] = 127, [5] = 122, [6] = 128, [7] = 113 }, [1] = { [0] = 38, [1] = 31, [2] = 32, [3] = 36, [4] = 37, [5] = 32, [6] = 38, [7] = 23 }, [2] = { [0] = 157, [1] = 162, [2] = 151, [3] = 157, [4] = 156, [5] = 151, [6] = 157, [7] = 142 }, [3] = { [0] = 244, [1] = 237, [2] = 238, [3] = 242, [4] = 243, [5] = 238, [6] = 244, [7] = 229 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 31, [2] = 18, [3] = 19, [4] = 30, [5] = 23, [6] = 23, [7] = 19 }, [1] = { [0] = 83, [1] = 98, [2] = 85, [3] = 86, [4] = 97, [5] = 90, [6] = 90, [7] = 86 }, [2] = { [0] = 241, [1] = 244, [2] = 243, [3] = 238, [4] = 251, [5] = 240, [6] = 248, [7] = 236 }, [3] = { [0] = 151, [1] = 166, [2] = 153, [3] = 154, [4] = 165, [5] = 158, [6] = 158, [7] = 148 } })[R[19]][R[10]] })
    if R[10] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[19]] })
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [2] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 } })[R[29]][R[19]], ({ [0] = { [0] = 10, [1] = 77, [2] = 235, [3] = 145 }, [1] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 } })[R[29]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[19]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 153, [3] = 228 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 } })[R[30]][R[19]], ({ [0] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [1] = { [0] = 29, [1] = 96, [2] = 242, [3] = 164 }, [2] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 } })[R[30]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [2] = { [0] = 131, [1] = 41, [2] = 160, [3] = 247 } })[R[31]][R[19]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 } })[R[31]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[19]] })
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [1] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [2] = { [0] = 112, [1] = 22, [2] = 143, [3] = 228 } })[R[32]][R[19]], ({ [0] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [1] = { [0] = 29, [1] = 96, [2] = 248, [3] = 164 }, [2] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 } })[R[32]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[19]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 } })[R[33]][R[19]], ({ [0] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [1] = { [0] = 21, [1] = 88, [2] = 242, [3] = 156 }, [2] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 } })[R[33]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[19]] })
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 101, [1] = 11, [2] = 130, [3] = 217 }, [2] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[34]][R[19]], ({ [0] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 }, [1] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [2] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 } })[R[34]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
        for i = 1, game.initial_units() do
          R[35] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [2] = { [0] = 136, [1] = 46, [2] = 165, [3] = 252 } })[R[35]][R[19]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 } })[R[35]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[19]] })
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 105, [1] = 15, [2] = 134, [3] = 221 } })[R[36]][R[19]], ({ [0] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [1] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [2] = { [0] = 34, [1] = 101, [2] = 251, [3] = 163 } })[R[36]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 10, [1] = 77, [2] = 223, [3] = 145 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    if R[37] == 0 or R[37] == 1 or R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 17, [1] = 84, [2] = 230, [3] = 152 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 27, [1] = 94, [2] = 244, [3] = 162 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 0 then
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
      elseif R[37] == 1 then
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
      elseif R[37] == 2 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[20]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[20]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[20]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [7] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 29, [1] = 96, [2] = 246, [3] = 158 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 0 or R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [1] = { [0] = 35, [1] = 102, [2] = 248, [3] = 170 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[37]][R[20]], ({ [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 247, [3] = 161 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 118, [1] = 28, [2] = 149, [3] = 234 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 111, [1] = 21, [2] = 152, [3] = 227 }, [2] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [5] = { [0] = 102, [1] = 12, [2] = 131, [3] = 218 }, [6] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [7] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 } })[R[37]][R[20]], ({ [0] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [1] = { [0] = 32, [1] = 99, [2] = 245, [3] = 167 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 13, [1] = 80, [2] = 232, [3] = 148 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 33, [1] = 100, [2] = 250, [3] = 162 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 13, [1] = 80, [2] = 230, [3] = 148 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 16, [1] = 83, [2] = 229, [3] = 151 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[37]][R[20]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[37]][R[20]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[37]][R[20]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 135, [1] = 45, [2] = 164, [3] = 251 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 17, [1] = 84, [2] = 236, [3] = 152 }, [4] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [5] = { [0] = 29, [1] = 96, [2] = 246, [3] = 164 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 }, [5] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 20, [1] = 87, [2] = 237, [3] = 149 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 27, [1] = 94, [2] = 246, [3] = 162 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 19, [1] = 86, [2] = 236, [3] = 154 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 115, [1] = 25, [2] = 156, [3] = 231 }, [2] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 28, [1] = 95, [2] = 247, [3] = 163 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 22, [1] = 89, [2] = 239, [3] = 151 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 19, [1] = 86, [2] = 240, [3] = 154 }, [5] = { [0] = 24, [1] = 91, [2] = 241, [3] = 159 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 117, [1] = 27, [2] = 158, [3] = 233 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 20, [1] = 87, [2] = 241, [3] = 155 }, [5] = { [0] = 25, [1] = 92, [2] = 242, [3] = 160 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 118, [1] = 28, [2] = 159, [3] = 234 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [3] = { [0] = 23, [1] = 90, [2] = 242, [3] = 158 }, [4] = { [0] = 24, [1] = 91, [2] = 245, [3] = 159 }, [5] = { [0] = 26, [1] = 93, [2] = 243, [3] = 161 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 25, [1] = 92, [2] = 242, [3] = 154 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 24, [1] = 91, [2] = 243, [3] = 159 }, [4] = { [0] = 25, [1] = 92, [2] = 246, [3] = 160 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [3] = { [0] = 25, [1] = 92, [2] = 244, [3] = 160 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 27, [1] = 94, [2] = 244, [3] = 156 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 13, [1] = 80, [2] = 226, [3] = 148 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 27, [1] = 94, [2] = 248, [3] = 162 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 28, [1] = 95, [2] = 245, [3] = 157 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 14, [1] = 81, [2] = 227, [3] = 149 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 28, [1] = 95, [2] = 249, [3] = 163 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 14, [1] = 81, [2] = 239, [3] = 149 }, [1] = { [0] = 15, [1] = 82, [2] = 228, [3] = 150 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 120, [1] = 30, [2] = 151, [3] = 236 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [1] = { [0] = 20, [1] = 87, [2] = 233, [3] = 155 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[37]][R[20]], ({ [0] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 122, [1] = 32, [2] = 153, [3] = 238 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 24, [1] = 91, [2] = 237, [3] = 159 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 25, [1] = 92, [2] = 238, [3] = 160 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 15, [1] = 82, [2] = 236, [3] = 150 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 30, [1] = 97, [2] = 243, [3] = 165 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [3] = { [0] = 126, [1] = 36, [2] = 157, [3] = 242 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 31, [1] = 98, [2] = 244, [3] = 166 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 19, [1] = 86, [2] = 236, [3] = 148 } })[R[37]][R[20]] })
    if R[37] == 0 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[20]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [2] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 } })[R[38]][R[20]], ({ [0] = { [0] = 10, [1] = 77, [2] = 235, [3] = 145 }, [1] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 } })[R[38]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[20]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 153, [3] = 228 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 } })[R[39]][R[20]], ({ [0] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [1] = { [0] = 29, [1] = 96, [2] = 242, [3] = 164 }, [2] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 } })[R[39]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [2] = { [0] = 131, [1] = 41, [2] = 160, [3] = 247 } })[R[40]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 } })[R[40]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[20]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [1] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [2] = { [0] = 112, [1] = 22, [2] = 143, [3] = 228 } })[R[41]][R[20]], ({ [0] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [1] = { [0] = 29, [1] = 96, [2] = 248, [3] = 164 }, [2] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 } })[R[41]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 } })[R[42]][R[20]], ({ [0] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [1] = { [0] = 21, [1] = 88, [2] = 242, [3] = 156 }, [2] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 } })[R[42]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 5 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[20]] })
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 101, [1] = 11, [2] = 130, [3] = 217 }, [2] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[43]][R[20]], ({ [0] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 }, [1] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [2] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 } })[R[43]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[20]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [2] = { [0] = 136, [1] = 46, [2] = 165, [3] = 252 } })[R[44]][R[20]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 } })[R[44]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[20]] })
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 105, [1] = 15, [2] = 134, [3] = 221 } })[R[45]][R[20]], ({ [0] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [1] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [2] = { [0] = 34, [1] = 101, [2] = 251, [3] = 163 } })[R[45]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 104, 235 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 246, 118 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 20, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 158, 14 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 76, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 26 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 34, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 196, 199 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 213, 221 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 224, 238 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 219, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 164, 86 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 39, 200 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 78, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 111, 150 } }
    pick(4, 4, { 0, 19, 20, 46 })
    R[1] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 10, [1] = 77, [2] = 223, [3] = 145 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[1] == 0 or R[1] == 1 or R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 17, [1] = 84, [2] = 230, [3] = 152 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 27, [1] = 94, [2] = 244, [3] = 162 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 0 then
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
      elseif R[1] == 1 then
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
      elseif R[1] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[0]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[0]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[0]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [7] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 29, [1] = 96, [2] = 246, [3] = 158 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 2 or R[1] == 5 or R[1] == 6 or R[1] == 7 then
      elseif R[1] == 0 or R[1] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 } })[R[1]][R[0]], ({ [0] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [1] = { [0] = 35, [1] = 102, [2] = 248, [3] = 170 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[1]", R[1])
      end
    elseif R[1] == 3 or R[1] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[1]][R[0]], ({ [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[1] == 3 then
      else
        unseen("R[1]", R[1])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 } })[R[1]][R[0]], ({ [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[1] == 3 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[1] == 4 then
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
    else
      unseen("R[1]", R[1])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 111, [1] = 21, [2] = 152, [3] = 227 }, [2] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [5] = { [0] = 102, [1] = 12, [2] = 131, [3] = 218 }, [6] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [7] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 } })[R[1]][R[0]], ({ [0] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [1] = { [0] = 32, [1] = 99, [2] = 245, [3] = 167 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 13, [1] = 80, [2] = 232, [3] = 148 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 33, [1] = 100, [2] = 250, [3] = 162 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 13, [1] = 80, [2] = 230, [3] = 148 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 16, [1] = 83, [2] = 229, [3] = 151 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[1].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[1]], player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[1]][R[0]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 135, [1] = 45, [2] = 164, [3] = 251 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 } })[R[1]][R[0]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 17, [1] = 84, [2] = 236, [3] = 152 }, [4] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [5] = { [0] = 29, [1] = 96, [2] = 246, [3] = 164 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[1]][R[0]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 }, [5] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 20, [1] = 87, [2] = 237, [3] = 149 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 27, [1] = 94, [2] = 246, [3] = 162 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 19, [1] = 86, [2] = 236, [3] = 154 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 115, [1] = 25, [2] = 156, [3] = 231 }, [2] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 28, [1] = 95, [2] = 247, [3] = 163 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 22, [1] = 89, [2] = 239, [3] = 151 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 19, [1] = 86, [2] = 240, [3] = 154 }, [5] = { [0] = 24, [1] = 91, [2] = 241, [3] = 159 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 117, [1] = 27, [2] = 158, [3] = 233 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 20, [1] = 87, [2] = 241, [3] = 155 }, [5] = { [0] = 25, [1] = 92, [2] = 242, [3] = 160 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 118, [1] = 28, [2] = 159, [3] = 234 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [3] = { [0] = 23, [1] = 90, [2] = 242, [3] = 158 }, [4] = { [0] = 24, [1] = 91, [2] = 245, [3] = 159 }, [5] = { [0] = 26, [1] = 93, [2] = 243, [3] = 161 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 25, [1] = 92, [2] = 242, [3] = 154 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 24, [1] = 91, [2] = 243, [3] = 159 }, [4] = { [0] = 25, [1] = 92, [2] = 246, [3] = 160 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [3] = { [0] = 25, [1] = 92, [2] = 244, [3] = 160 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 27, [1] = 94, [2] = 244, [3] = 156 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[1]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 13, [1] = 80, [2] = 226, [3] = 148 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 27, [1] = 94, [2] = 248, [3] = 162 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 28, [1] = 95, [2] = 245, [3] = 157 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[1]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 14, [1] = 81, [2] = 227, [3] = 149 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 28, [1] = 95, [2] = 249, [3] = 163 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[1]][R[0]], ({ [0] = { [0] = 14, [1] = 81, [2] = 239, [3] = 149 }, [1] = { [0] = 15, [1] = 82, [2] = 228, [3] = 150 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[1]][R[0]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 120, [1] = 30, [2] = 151, [3] = 236 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[1]][R[0]], ({ [0] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [1] = { [0] = 20, [1] = 87, [2] = 233, [3] = 155 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[1]][R[0]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[1]][R[0]], ({ [0] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 122, [1] = 32, [2] = 153, [3] = 238 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 24, [1] = 91, [2] = 237, [3] = 159 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 25, [1] = 92, [2] = 238, [3] = 160 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 15, [1] = 82, [2] = 236, [3] = 150 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 30, [1] = 97, [2] = 243, [3] = 165 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[1]][R[0]] })
    game.create_tube({ ({ [0] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [3] = { [0] = 126, [1] = 36, [2] = 157, [3] = 242 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[1]][R[0]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 31, [1] = 98, [2] = 244, [3] = 166 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 19, [1] = 86, [2] = 236, [3] = 148 } })[R[1]][R[0]] })
    if R[1] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[0]] })
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [2] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 } })[R[47]][R[0]], ({ [0] = { [0] = 10, [1] = 77, [2] = 235, [3] = 145 }, [1] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 } })[R[47]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[0]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 153, [3] = 228 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 } })[R[48]][R[0]], ({ [0] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [1] = { [0] = 29, [1] = 96, [2] = 242, [3] = 164 }, [2] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 } })[R[48]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[0]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [2] = { [0] = 131, [1] = 41, [2] = 160, [3] = 247 } })[R[49]][R[0]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 } })[R[49]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[0]] })
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [1] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [2] = { [0] = 112, [1] = 22, [2] = 143, [3] = 228 } })[R[50]][R[0]], ({ [0] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [1] = { [0] = 29, [1] = 96, [2] = 248, [3] = 164 }, [2] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 } })[R[50]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[0]] })
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 } })[R[51]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [1] = { [0] = 21, [1] = 88, [2] = 242, [3] = 156 }, [2] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 } })[R[51]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[0]] })
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 101, [1] = 11, [2] = 130, [3] = 217 }, [2] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[52]][R[0]], ({ [0] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 }, [1] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [2] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 } })[R[52]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 6 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [2] = { [0] = 136, [1] = 46, [2] = 165, [3] = 252 } })[R[53]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 } })[R[53]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[0]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[1] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[0]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[0]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[0]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[0]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[0]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[0]] })
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 105, [1] = 15, [2] = 134, [3] = 221 } })[R[54]][R[0]], ({ [0] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [1] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [2] = { [0] = 34, [1] = 101, [2] = 251, [3] = 163 } })[R[54]][R[0]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[1]", R[1])
    end
    R[10] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 121, [1] = 110, [2] = 118, [3] = 123, [4] = 122, [5] = 112, [6] = 115, [7] = 113 }, [1] = { [0] = 31, [1] = 20, [2] = 28, [3] = 33, [4] = 32, [5] = 22, [6] = 25, [7] = 23 }, [2] = { [0] = 150, [1] = 151, [2] = 147, [3] = 154, [4] = 151, [5] = 141, [6] = 144, [7] = 142 }, [3] = { [0] = 237, [1] = 226, [2] = 234, [3] = 239, [4] = 238, [5] = 228, [6] = 231, [7] = 229 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 13, [3] = 26, [4] = 22, [5] = 22, [6] = 15, [7] = 24 }, [1] = { [0] = 83, [1] = 90, [2] = 80, [3] = 93, [4] = 89, [5] = 89, [6] = 82, [7] = 91 }, [2] = { [0] = 241, [1] = 236, [2] = 238, [3] = 245, [4] = 243, [5] = 239, [6] = 240, [7] = 241 }, [3] = { [0] = 151, [1] = 158, [2] = 148, [3] = 161, [4] = 157, [5] = 157, [6] = 150, [7] = 153 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 121, [1] = 110, [2] = 118, [3] = 123, [4] = 122, [5] = 112, [6] = 115, [7] = 113 }, [1] = { [0] = 31, [1] = 20, [2] = 28, [3] = 33, [4] = 32, [5] = 22, [6] = 25, [7] = 23 }, [2] = { [0] = 150, [1] = 151, [2] = 147, [3] = 154, [4] = 151, [5] = 141, [6] = 144, [7] = 142 }, [3] = { [0] = 237, [1] = 226, [2] = 234, [3] = 239, [4] = 238, [5] = 228, [6] = 231, [7] = 229 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 13, [3] = 26, [4] = 22, [5] = 22, [6] = 15, [7] = 24 }, [1] = { [0] = 83, [1] = 90, [2] = 80, [3] = 93, [4] = 89, [5] = 89, [6] = 82, [7] = 91 }, [2] = { [0] = 241, [1] = 236, [2] = 238, [3] = 245, [4] = 243, [5] = 239, [6] = 240, [7] = 241 }, [3] = { [0] = 151, [1] = 158, [2] = 148, [3] = 161, [4] = 157, [5] = 157, [6] = 150, [7] = 153 } })[R[19]][R[10]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [0] = 121, [1] = 120, [2] = 112, [3] = 131, [4] = 122, [5] = 112, [6] = 124, [7] = 106 }, [1] = { [0] = 31, [1] = 30, [2] = 22, [3] = 41, [4] = 32, [5] = 22, [6] = 34, [7] = 16 }, [2] = { [0] = 150, [1] = 161, [2] = 141, [3] = 162, [4] = 151, [5] = 141, [6] = 153, [7] = 135 }, [3] = { [0] = 237, [1] = 236, [2] = 228, [3] = 247, [4] = 238, [5] = 228, [6] = 240, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 9, [1] = 10, [2] = 18, [3] = 30, [4] = 30, [5] = 28, [6] = 15, [7] = 30 }, [1] = { [0] = 76, [1] = 77, [2] = 85, [3] = 97, [4] = 97, [5] = 95, [6] = 82, [7] = 97 }, [2] = { [0] = 234, [1] = 223, [2] = 243, [3] = 249, [4] = 251, [5] = 245, [6] = 240, [7] = 247 }, [3] = { [0] = 144, [1] = 145, [2] = 153, [3] = 165, [4] = 165, [5] = 163, [6] = 150, [7] = 159 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 3 or R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [3] = 115, [4] = 122 }, [1] = { [3] = 25, [4] = 32 }, [2] = { [3] = 146, [4] = 151 }, [3] = { [3] = 231, [4] = 238 } })[R[19]][R[10]], ({ [0] = { [3] = 30, [4] = 14 }, [1] = { [3] = 97, [4] = 81 }, [2] = { [3] = 249, [4] = 235 }, [3] = { [3] = 165, [4] = 149 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 3 then
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [3] = 118, [4] = 133 }, [1] = { [3] = 28, [4] = 43 }, [2] = { [3] = 149, [4] = 162 }, [3] = { [3] = 234, [4] = 249 } })[R[19]][R[10]], ({ [0] = { [3] = 19, [4] = 26 }, [1] = { [3] = 86, [4] = 93 }, [2] = { [3] = 238, [4] = 247 }, [3] = { [3] = 154, [4] = 161 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 3 then
        if LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 4 then
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
    elseif R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = { [0] = 133, [1] = 121, [2] = 115, [5] = 122, [6] = 125, [7] = 106 }, [1] = { [0] = 43, [1] = 31, [2] = 25, [5] = 32, [6] = 35, [7] = 16 }, [2] = { [0] = 162, [1] = 162, [2] = 144, [5] = 151, [6] = 154, [7] = 135 }, [3] = { [0] = 249, [1] = 237, [2] = 231, [5] = 238, [6] = 241, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 17, [2] = 24, [5] = 27, [6] = 23, [7] = 17 }, [1] = { [0] = 83, [1] = 84, [2] = 91, [5] = 94, [6] = 90, [7] = 84 }, [2] = { [0] = 241, [1] = 230, [2] = 249, [5] = 244, [6] = 248, [7] = 234 }, [3] = { [0] = 151, [1] = 152, [2] = 159, [5] = 162, [6] = 158, [7] = 146 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 0 then
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
      elseif R[10] == 1 then
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
      elseif R[10] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[19]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[19]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[19]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[10] == 7 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [0] = 110, [1] = 121, [2] = 124, [5] = 112, [6] = 116, [7] = 122 }, [1] = { [0] = 20, [1] = 31, [2] = 34, [5] = 22, [6] = 26, [7] = 32 }, [2] = { [0] = 139, [1] = 162, [2] = 153, [5] = 141, [6] = 145, [7] = 151 }, [3] = { [0] = 226, [1] = 237, [2] = 240, [5] = 228, [6] = 232, [7] = 238 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 27, [2] = 24, [5] = 15, [6] = 23, [7] = 29 }, [1] = { [0] = 83, [1] = 94, [2] = 91, [5] = 82, [6] = 90, [7] = 96 }, [2] = { [0] = 241, [1] = 240, [2] = 249, [5] = 232, [6] = 248, [7] = 246 }, [3] = { [0] = 151, [1] = 162, [2] = 159, [5] = 150, [6] = 158, [7] = 158 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 0 or R[10] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [0] = 121, [1] = 120 }, [1] = { [0] = 31, [1] = 30 }, [2] = { [0] = 150, [1] = 161 }, [3] = { [0] = 237, [1] = 236 } })[R[19]][R[10]], ({ [0] = { [0] = 23, [1] = 35 }, [1] = { [0] = 90, [1] = 102 }, [2] = { [0] = 248, [1] = 248 }, [3] = { [0] = 158, [1] = 170 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 2 or R[10] == 5 or R[10] == 6 or R[10] == 7 then
      else
        unseen("R[10]", R[10])
      end
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [0] = 110, [1] = 111, [2] = 132, [3] = 124, [4] = 114, [5] = 102, [6] = 108, [7] = 114 }, [1] = { [0] = 20, [1] = 21, [2] = 42, [3] = 34, [4] = 24, [5] = 12, [6] = 18, [7] = 24 }, [2] = { [0] = 139, [1] = 152, [2] = 161, [3] = 155, [4] = 143, [5] = 131, [6] = 137, [7] = 143 }, [3] = { [0] = 226, [1] = 227, [2] = 248, [3] = 240, [4] = 230, [5] = 218, [6] = 224, [7] = 230 } })[R[19]][R[10]], ({ [0] = { [0] = 25, [1] = 32, [2] = 18, [3] = 13, [4] = 18, [5] = 22, [6] = 23, [7] = 33 }, [1] = { [0] = 92, [1] = 99, [2] = 85, [3] = 80, [4] = 85, [5] = 89, [6] = 90, [7] = 100 }, [2] = { [0] = 250, [1] = 245, [2] = 243, [3] = 232, [4] = 239, [5] = 239, [6] = 248, [7] = 250 }, [3] = { [0] = 160, [1] = 167, [2] = 153, [3] = 148, [4] = 153, [5] = 157, [6] = 158, [7] = 162 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 117, [1] = 110, [2] = 128, [3] = 113, [4] = 132, [5] = 120, [6] = 115, [7] = 124 }, [1] = { [0] = 27, [1] = 20, [2] = 38, [3] = 23, [4] = 42, [5] = 30, [6] = 25, [7] = 34 }, [2] = { [0] = 146, [1] = 151, [2] = 157, [3] = 144, [4] = 161, [5] = 149, [6] = 144, [7] = 153 }, [3] = { [0] = 233, [1] = 226, [2] = 244, [3] = 229, [4] = 248, [5] = 236, [6] = 231, [7] = 240 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 18, [2] = 22, [3] = 20, [4] = 22, [5] = 13, [6] = 28, [7] = 24 }, [1] = { [0] = 79, [1] = 85, [2] = 89, [3] = 87, [4] = 89, [5] = 80, [6] = 95, [7] = 91 }, [2] = { [0] = 237, [1] = 231, [2] = 247, [3] = 239, [4] = 243, [5] = 230, [6] = 253, [7] = 241 }, [3] = { [0] = 147, [1] = 153, [2] = 157, [3] = 155, [4] = 157, [5] = 148, [6] = 163, [7] = 153 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 115, [1] = 110, [2] = 128, [3] = 116, [4] = 134, [5] = 120, [6] = 113, [7] = 124 }, [1] = { [0] = 25, [1] = 20, [2] = 38, [3] = 26, [4] = 44, [5] = 30, [6] = 23, [7] = 34 }, [2] = { [0] = 144, [1] = 151, [2] = 157, [3] = 147, [4] = 163, [5] = 149, [6] = 142, [7] = 153 }, [3] = { [0] = 231, [1] = 226, [2] = 244, [3] = 232, [4] = 250, [5] = 236, [6] = 229, [7] = 240 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 16, [2] = 20, [3] = 16, [4] = 22, [5] = 15, [6] = 28, [7] = 26 }, [1] = { [0] = 79, [1] = 83, [2] = 87, [3] = 83, [4] = 89, [5] = 82, [6] = 95, [7] = 93 }, [2] = { [0] = 237, [1] = 229, [2] = 245, [3] = 235, [4] = 243, [5] = 232, [6] = 253, [7] = 243 }, [3] = { [0] = 147, [1] = 151, [2] = 155, [3] = 151, [4] = 157, [5] = 150, [6] = 163, [7] = 155 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[2].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 133, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 43, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 164, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 249, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 20, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 87, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 239, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 155, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 131, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 41, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 162, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 247, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 16, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 83, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 235, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 151, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 115, [1] = 110, [2] = 128, [3] = 119, [4] = 134, [5] = 120, [6] = 113, [7] = 124 }, [1] = { [0] = 25, [1] = 20, [2] = 38, [3] = 29, [4] = 44, [5] = 30, [6] = 23, [7] = 34 }, [2] = { [0] = 144, [1] = 151, [2] = 157, [3] = 150, [4] = 163, [5] = 149, [6] = 142, [7] = 153 }, [3] = { [0] = 231, [1] = 226, [2] = 244, [3] = 235, [4] = 250, [5] = 236, [6] = 229, [7] = 240 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 18, [2] = 20, [3] = 31, [4] = 22, [5] = 15, [6] = 28, [7] = 26 }, [1] = { [0] = 79, [1] = 85, [2] = 87, [3] = 98, [4] = 89, [5] = 82, [6] = 95, [7] = 93 }, [2] = { [0] = 237, [1] = 231, [2] = 245, [3] = 250, [4] = 243, [5] = 232, [6] = 253, [7] = 243 }, [3] = { [0] = 147, [1] = 153, [2] = 155, [3] = 166, [4] = 157, [5] = 150, [6] = 163, [7] = 155 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 115, [1] = 113, [2] = 128, [3] = 119, [4] = 134, [5] = 120, [6] = 113, [7] = 124 }, [1] = { [0] = 25, [1] = 23, [2] = 38, [3] = 29, [4] = 44, [5] = 30, [6] = 23, [7] = 34 }, [2] = { [0] = 144, [1] = 154, [2] = 157, [3] = 150, [4] = 163, [5] = 149, [6] = 142, [7] = 153 }, [3] = { [0] = 231, [1] = 229, [2] = 244, [3] = 235, [4] = 250, [5] = 236, [6] = 229, [7] = 240 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 18, [2] = 20, [3] = 31, [4] = 22, [5] = 15, [6] = 28, [7] = 26 }, [1] = { [0] = 79, [1] = 85, [2] = 87, [3] = 98, [4] = 89, [5] = 82, [6] = 95, [7] = 93 }, [2] = { [0] = 237, [1] = 231, [2] = 245, [3] = 250, [4] = 243, [5] = 232, [6] = 253, [7] = 243 }, [3] = { [0] = 147, [1] = 153, [2] = 155, [3] = 166, [4] = 157, [5] = 150, [6] = 163, [7] = 155 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 110, [2] = 110, [3] = 113, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 20, [2] = 20, [3] = 23, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 151, [2] = 139, [3] = 144, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 226, [2] = 226, [3] = 229, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 20, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 87, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 239, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 155, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 113, [2] = 128, [3] = 113, [4] = 127, [5] = 107, [6] = 120, [7] = 108 }, [1] = { [0] = 22, [1] = 23, [2] = 38, [3] = 23, [4] = 37, [5] = 17, [6] = 30, [7] = 18 }, [2] = { [0] = 141, [1] = 154, [2] = 157, [3] = 144, [4] = 156, [5] = 136, [6] = 149, [7] = 137 }, [3] = { [0] = 228, [1] = 229, [2] = 244, [3] = 229, [4] = 243, [5] = 223, [6] = 236, [7] = 224 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 12, [2] = 26, [3] = 20, [4] = 26, [5] = 12, [6] = 25, [7] = 24 }, [1] = { [0] = 79, [1] = 79, [2] = 93, [3] = 87, [4] = 93, [5] = 79, [6] = 92, [7] = 91 }, [2] = { [0] = 237, [1] = 225, [2] = 251, [3] = 239, [4] = 247, [5] = 229, [6] = 250, [7] = 241 }, [3] = { [0] = 147, [1] = 147, [2] = 161, [3] = 155, [4] = 161, [5] = 147, [6] = 160, [7] = 153 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 116, [2] = 124, [3] = 119, [4] = 129, [5] = 116, [6] = 129, [7] = 103 }, [1] = { [0] = 22, [1] = 26, [2] = 34, [3] = 29, [4] = 39, [5] = 26, [6] = 39, [7] = 13 }, [2] = { [0] = 141, [1] = 157, [2] = 153, [3] = 150, [4] = 158, [5] = 145, [6] = 158, [7] = 132 }, [3] = { [0] = 228, [1] = 232, [2] = 240, [3] = 235, [4] = 245, [5] = 232, [6] = 245, [7] = 219 } })[R[19]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 27, [3] = 31, [4] = 17, [5] = 20, [6] = 22, [7] = 21 }, [1] = { [0] = 76, [1] = 76, [2] = 94, [3] = 98, [4] = 84, [5] = 87, [6] = 89, [7] = 88 }, [2] = { [0] = 234, [1] = 222, [2] = 252, [3] = 250, [4] = 238, [5] = 237, [6] = 247, [7] = 238 }, [3] = { [0] = 144, [1] = 144, [2] = 162, [3] = 166, [4] = 152, [5] = 155, [6] = 157, [7] = 150 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 133, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 43, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 164, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 249, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 20, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 87, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 239, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 155, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 131, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 41, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 162, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 247, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 16, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 83, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 235, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 151, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 113, [2] = 128, [3] = 119, [4] = 127, [5] = 107, [6] = 120, [7] = 108 }, [1] = { [0] = 22, [1] = 23, [2] = 38, [3] = 29, [4] = 37, [5] = 17, [6] = 30, [7] = 18 }, [2] = { [0] = 141, [1] = 154, [2] = 157, [3] = 150, [4] = 156, [5] = 136, [6] = 149, [7] = 137 }, [3] = { [0] = 228, [1] = 229, [2] = 244, [3] = 235, [4] = 243, [5] = 223, [6] = 236, [7] = 224 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 12, [2] = 26, [3] = 31, [4] = 26, [5] = 12, [6] = 25, [7] = 24 }, [1] = { [0] = 79, [1] = 79, [2] = 93, [3] = 98, [4] = 93, [5] = 79, [6] = 92, [7] = 91 }, [2] = { [0] = 237, [1] = 225, [2] = 251, [3] = 250, [4] = 247, [5] = 229, [6] = 250, [7] = 241 }, [3] = { [0] = 147, [1] = 147, [2] = 161, [3] = 166, [4] = 161, [5] = 147, [6] = 160, [7] = 153 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 116, [2] = 124, [3] = 119, [4] = 129, [5] = 116, [6] = 129, [7] = 103 }, [1] = { [0] = 22, [1] = 26, [2] = 34, [3] = 29, [4] = 39, [5] = 26, [6] = 39, [7] = 13 }, [2] = { [0] = 141, [1] = 157, [2] = 153, [3] = 150, [4] = 158, [5] = 145, [6] = 158, [7] = 132 }, [3] = { [0] = 228, [1] = 232, [2] = 240, [3] = 235, [4] = 245, [5] = 232, [6] = 245, [7] = 219 } })[R[19]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 27, [3] = 31, [4] = 17, [5] = 20, [6] = 22, [7] = 21 }, [1] = { [0] = 76, [1] = 76, [2] = 94, [3] = 98, [4] = 84, [5] = 87, [6] = 89, [7] = 88 }, [2] = { [0] = 234, [1] = 222, [2] = 252, [3] = 250, [4] = 238, [5] = 237, [6] = 247, [7] = 238 }, [3] = { [0] = 144, [1] = 144, [2] = 162, [3] = 166, [4] = 152, [5] = 155, [6] = 157, [7] = 150 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 133, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 43, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 164, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 249, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 20, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 87, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 239, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 155, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 131, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 41, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 162, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 247, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 16, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 83, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 235, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 151, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 115, [1] = 110, [2] = 128, [3] = 119, [4] = 134, [5] = 120, [6] = 113, [7] = 124 }, [1] = { [0] = 25, [1] = 20, [2] = 38, [3] = 29, [4] = 44, [5] = 30, [6] = 23, [7] = 34 }, [2] = { [0] = 144, [1] = 151, [2] = 157, [3] = 150, [4] = 163, [5] = 149, [6] = 142, [7] = 153 }, [3] = { [0] = 231, [1] = 226, [2] = 244, [3] = 235, [4] = 250, [5] = 236, [6] = 229, [7] = 240 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 18, [2] = 20, [3] = 31, [4] = 22, [5] = 15, [6] = 28, [7] = 26 }, [1] = { [0] = 79, [1] = 85, [2] = 87, [3] = 98, [4] = 89, [5] = 82, [6] = 95, [7] = 93 }, [2] = { [0] = 237, [1] = 231, [2] = 245, [3] = 250, [4] = 243, [5] = 232, [6] = 253, [7] = 243 }, [3] = { [0] = 147, [1] = 153, [2] = 155, [3] = 166, [4] = 157, [5] = 150, [6] = 163, [7] = 155 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 113, [2] = 110, [3] = 119, [4] = 126, [5] = 108, [6] = 128, [7] = 123 }, [1] = { [0] = 36, [1] = 23, [2] = 20, [3] = 29, [4] = 36, [5] = 18, [6] = 38, [7] = 33 }, [2] = { [0] = 155, [1] = 154, [2] = 139, [3] = 150, [4] = 155, [5] = 137, [6] = 157, [7] = 152 }, [3] = { [0] = 242, [1] = 229, [2] = 226, [3] = 235, [4] = 242, [5] = 224, [6] = 244, [7] = 239 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 18, [2] = 23, [3] = 31, [4] = 30, [5] = 23, [6] = 15, [7] = 18 }, [1] = { [0] = 85, [1] = 85, [2] = 90, [3] = 98, [4] = 97, [5] = 90, [6] = 82, [7] = 85 }, [2] = { [0] = 243, [1] = 231, [2] = 248, [3] = 250, [4] = 251, [5] = 240, [6] = 240, [7] = 235 }, [3] = { [0] = 153, [1] = 153, [2] = 158, [3] = 166, [4] = 165, [5] = 158, [6] = 150, [7] = 147 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 113, [2] = 128, [3] = 113, [4] = 127, [5] = 107, [6] = 120, [7] = 108 }, [1] = { [0] = 22, [1] = 23, [2] = 38, [3] = 23, [4] = 37, [5] = 17, [6] = 30, [7] = 18 }, [2] = { [0] = 141, [1] = 154, [2] = 157, [3] = 144, [4] = 156, [5] = 136, [6] = 149, [7] = 137 }, [3] = { [0] = 228, [1] = 229, [2] = 244, [3] = 229, [4] = 243, [5] = 223, [6] = 236, [7] = 224 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 12, [2] = 26, [3] = 20, [4] = 26, [5] = 12, [6] = 25, [7] = 24 }, [1] = { [0] = 79, [1] = 79, [2] = 93, [3] = 87, [4] = 93, [5] = 79, [6] = 92, [7] = 91 }, [2] = { [0] = 237, [1] = 225, [2] = 251, [3] = 239, [4] = 247, [5] = 229, [6] = 250, [7] = 241 }, [3] = { [0] = 147, [1] = 147, [2] = 161, [3] = 155, [4] = 161, [5] = 147, [6] = 160, [7] = 153 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[10]], player = players[2], at = { ({ [0] = { [0] = 112, [1] = 116, [2] = 124, [3] = 119, [4] = 129, [5] = 116, [6] = 129, [7] = 103 }, [1] = { [0] = 22, [1] = 26, [2] = 34, [3] = 29, [4] = 39, [5] = 26, [6] = 39, [7] = 13 }, [2] = { [0] = 141, [1] = 157, [2] = 153, [3] = 150, [4] = 158, [5] = 145, [6] = 158, [7] = 132 }, [3] = { [0] = 228, [1] = 232, [2] = 240, [3] = 235, [4] = 245, [5] = 232, [6] = 245, [7] = 219 } })[R[19]][R[10]], ({ [0] = { [0] = 9, [1] = 9, [2] = 27, [3] = 31, [4] = 17, [5] = 20, [6] = 22, [7] = 21 }, [1] = { [0] = 76, [1] = 76, [2] = 94, [3] = 98, [4] = 84, [5] = 87, [6] = 89, [7] = 88 }, [2] = { [0] = 234, [1] = 222, [2] = 252, [3] = 250, [4] = 238, [5] = 237, [6] = 247, [7] = 238 }, [3] = { [0] = 144, [1] = 144, [2] = 162, [3] = 166, [4] = 152, [5] = 155, [6] = 157, [7] = 150 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 133, [1] = 119, [2] = 120, [3] = 123, [4] = 135, [5] = 108, [6] = 129, [7] = 117 }, [1] = { [0] = 43, [1] = 29, [2] = 30, [3] = 33, [4] = 45, [5] = 18, [6] = 39, [7] = 27 }, [2] = { [0] = 162, [1] = 160, [2] = 149, [3] = 154, [4] = 164, [5] = 137, [6] = 158, [7] = 146 }, [3] = { [0] = 249, [1] = 235, [2] = 236, [3] = 239, [4] = 251, [5] = 224, [6] = 245, [7] = 233 } })[R[19]][R[10]], ({ [0] = { [0] = 20, [1] = 22, [2] = 20, [3] = 17, [4] = 13, [5] = 29, [6] = 25, [7] = 23 }, [1] = { [0] = 87, [1] = 89, [2] = 87, [3] = 84, [4] = 80, [5] = 96, [6] = 92, [7] = 90 }, [2] = { [0] = 245, [1] = 235, [2] = 245, [3] = 236, [4] = 234, [5] = 246, [6] = 250, [7] = 240 }, [3] = { [0] = 155, [1] = 157, [2] = 155, [3] = 152, [4] = 148, [5] = 164, [6] = 160, [7] = 152 } })[R[19]][R[10]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 113, [2] = 115, [3] = 115, [4] = 122, [5] = 112, [6] = 115, [7] = 106 }, [1] = { [0] = 23, [1] = 23, [2] = 25, [3] = 25, [4] = 32, [5] = 22, [6] = 25, [7] = 16 }, [2] = { [0] = 142, [1] = 154, [2] = 144, [3] = 146, [4] = 151, [5] = 141, [6] = 144, [7] = 135 }, [3] = { [0] = 229, [1] = 229, [2] = 231, [3] = 231, [4] = 238, [5] = 228, [6] = 231, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 18, [3] = 26, [4] = 16, [5] = 18, [6] = 17, [7] = 20 }, [1] = { [0] = 83, [1] = 90, [2] = 85, [3] = 93, [4] = 83, [5] = 85, [6] = 84, [7] = 87 }, [2] = { [0] = 241, [1] = 236, [2] = 243, [3] = 245, [4] = 237, [5] = 235, [6] = 242, [7] = 237 }, [3] = { [0] = 151, [1] = 158, [2] = 153, [3] = 161, [4] = 151, [5] = 153, [6] = 152, [7] = 149 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 114, [1] = 114, [2] = 116, [3] = 115, [4] = 122, [5] = 112, [6] = 115, [7] = 106 }, [1] = { [0] = 24, [1] = 24, [2] = 26, [3] = 25, [4] = 32, [5] = 22, [6] = 25, [7] = 16 }, [2] = { [0] = 143, [1] = 155, [2] = 145, [3] = 146, [4] = 151, [5] = 141, [6] = 144, [7] = 135 }, [3] = { [0] = 230, [1] = 230, [2] = 232, [3] = 231, [4] = 238, [5] = 228, [6] = 231, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 18, [3] = 27, [4] = 17, [5] = 19, [6] = 18, [7] = 21 }, [1] = { [0] = 83, [1] = 90, [2] = 85, [3] = 94, [4] = 84, [5] = 86, [6] = 85, [7] = 88 }, [2] = { [0] = 241, [1] = 236, [2] = 243, [3] = 246, [4] = 238, [5] = 236, [6] = 243, [7] = 238 }, [3] = { [0] = 151, [1] = 158, [2] = 153, [3] = 162, [4] = 152, [5] = 154, [6] = 153, [7] = 150 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 115, [1] = 115, [2] = 117, [3] = 115, [4] = 122, [5] = 112, [6] = 115, [7] = 106 }, [1] = { [0] = 25, [1] = 25, [2] = 27, [3] = 25, [4] = 32, [5] = 22, [6] = 25, [7] = 16 }, [2] = { [0] = 144, [1] = 156, [2] = 146, [3] = 146, [4] = 151, [5] = 141, [6] = 144, [7] = 135 }, [3] = { [0] = 231, [1] = 231, [2] = 233, [3] = 231, [4] = 238, [5] = 228, [6] = 231, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 18, [3] = 28, [4] = 18, [5] = 20, [6] = 19, [7] = 22 }, [1] = { [0] = 83, [1] = 90, [2] = 85, [3] = 95, [4] = 85, [5] = 87, [6] = 86, [7] = 89 }, [2] = { [0] = 241, [1] = 236, [2] = 243, [3] = 247, [4] = 239, [5] = 237, [6] = 244, [7] = 239 }, [3] = { [0] = 151, [1] = 158, [2] = 153, [3] = 163, [4] = 153, [5] = 155, [6] = 154, [7] = 151 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 116, [1] = 116, [2] = 118, [3] = 116, [4] = 122, [5] = 112, [6] = 115, [7] = 106 }, [1] = { [0] = 26, [1] = 26, [2] = 28, [3] = 26, [4] = 32, [5] = 22, [6] = 25, [7] = 16 }, [2] = { [0] = 145, [1] = 157, [2] = 147, [3] = 147, [4] = 151, [5] = 141, [6] = 144, [7] = 135 }, [3] = { [0] = 232, [1] = 232, [2] = 234, [3] = 232, [4] = 238, [5] = 228, [6] = 231, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 15, [3] = 26, [4] = 19, [5] = 24, [6] = 20, [7] = 23 }, [1] = { [0] = 83, [1] = 90, [2] = 82, [3] = 93, [4] = 86, [5] = 91, [6] = 87, [7] = 90 }, [2] = { [0] = 241, [1] = 236, [2] = 240, [3] = 245, [4] = 240, [5] = 241, [6] = 245, [7] = 240 }, [3] = { [0] = 151, [1] = 158, [2] = 150, [3] = 161, [4] = 154, [5] = 159, [6] = 155, [7] = 152 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 117, [1] = 117, [2] = 118, [3] = 117, [4] = 122, [5] = 112, [6] = 115, [7] = 106 }, [1] = { [0] = 27, [1] = 27, [2] = 28, [3] = 27, [4] = 32, [5] = 22, [6] = 25, [7] = 16 }, [2] = { [0] = 146, [1] = 158, [2] = 147, [3] = 148, [4] = 151, [5] = 141, [6] = 144, [7] = 135 }, [3] = { [0] = 233, [1] = 233, [2] = 234, [3] = 233, [4] = 238, [5] = 228, [6] = 231, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 16, [3] = 22, [4] = 20, [5] = 25, [6] = 21, [7] = 24 }, [1] = { [0] = 83, [1] = 90, [2] = 83, [3] = 89, [4] = 87, [5] = 92, [6] = 88, [7] = 91 }, [2] = { [0] = 241, [1] = 236, [2] = 241, [3] = 241, [4] = 241, [5] = 242, [6] = 246, [7] = 241 }, [3] = { [0] = 151, [1] = 158, [2] = 151, [3] = 157, [4] = 155, [5] = 160, [6] = 156, [7] = 153 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 118, [1] = 118, [2] = 118, [3] = 117, [4] = 122, [5] = 112, [6] = 118, [7] = 106 }, [1] = { [0] = 28, [1] = 28, [2] = 28, [3] = 27, [4] = 32, [5] = 22, [6] = 28, [7] = 16 }, [2] = { [0] = 147, [1] = 159, [2] = 147, [3] = 148, [4] = 151, [5] = 141, [6] = 147, [7] = 135 }, [3] = { [0] = 234, [1] = 234, [2] = 234, [3] = 233, [4] = 238, [5] = 228, [6] = 234, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 17, [3] = 23, [4] = 24, [5] = 26, [6] = 15, [7] = 25 }, [1] = { [0] = 83, [1] = 90, [2] = 84, [3] = 90, [4] = 91, [5] = 93, [6] = 82, [7] = 92 }, [2] = { [0] = 241, [1] = 236, [2] = 242, [3] = 242, [4] = 245, [5] = 243, [6] = 240, [7] = 242 }, [3] = { [0] = 151, [1] = 158, [2] = 152, [3] = 158, [4] = 159, [5] = 161, [6] = 150, [7] = 154 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 119, [1] = 119, [2] = 118, [3] = 117, [4] = 122, [5] = 115, [6] = 119, [7] = 106 }, [1] = { [0] = 29, [1] = 29, [2] = 28, [3] = 27, [4] = 32, [5] = 25, [6] = 29, [7] = 16 }, [2] = { [0] = 148, [1] = 160, [2] = 147, [3] = 148, [4] = 151, [5] = 144, [6] = 148, [7] = 135 }, [3] = { [0] = 235, [1] = 235, [2] = 234, [3] = 233, [4] = 238, [5] = 231, [6] = 235, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 18, [3] = 24, [4] = 25, [5] = 22, [6] = 15, [7] = 26 }, [1] = { [0] = 83, [1] = 90, [2] = 85, [3] = 91, [4] = 92, [5] = 89, [6] = 82, [7] = 93 }, [2] = { [0] = 241, [1] = 236, [2] = 243, [3] = 243, [4] = 246, [5] = 239, [6] = 240, [7] = 243 }, [3] = { [0] = 151, [1] = 158, [2] = 153, [3] = 159, [4] = 160, [5] = 157, [6] = 150, [7] = 155 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 120, [2] = 118, [3] = 117, [4] = 122, [5] = 115, [6] = 119, [7] = 106 }, [1] = { [0] = 31, [1] = 30, [2] = 28, [3] = 27, [4] = 32, [5] = 25, [6] = 29, [7] = 16 }, [2] = { [0] = 150, [1] = 161, [2] = 147, [3] = 148, [4] = 151, [5] = 144, [6] = 148, [7] = 135 }, [3] = { [0] = 237, [1] = 236, [2] = 234, [3] = 233, [4] = 238, [5] = 231, [6] = 235, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 11, [1] = 12, [2] = 19, [3] = 25, [4] = 26, [5] = 28, [6] = 23, [7] = 27 }, [1] = { [0] = 78, [1] = 79, [2] = 86, [3] = 92, [4] = 93, [5] = 95, [6] = 90, [7] = 94 }, [2] = { [0] = 236, [1] = 225, [2] = 244, [3] = 244, [4] = 247, [5] = 245, [6] = 248, [7] = 244 }, [3] = { [0] = 146, [1] = 147, [2] = 154, [3] = 160, [4] = 161, [5] = 163, [6] = 158, [7] = 156 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 120, [2] = 118, [3] = 117, [4] = 122, [5] = 116, [6] = 120, [7] = 106 }, [1] = { [0] = 31, [1] = 30, [2] = 28, [3] = 27, [4] = 32, [5] = 26, [6] = 30, [7] = 16 }, [2] = { [0] = 150, [1] = 161, [2] = 147, [3] = 148, [4] = 151, [5] = 145, [6] = 149, [7] = 135 }, [3] = { [0] = 237, [1] = 236, [2] = 234, [3] = 233, [4] = 238, [5] = 232, [6] = 236, [7] = 222 } })[R[19]][R[10]], ({ [0] = { [0] = 12, [1] = 13, [2] = 20, [3] = 26, [4] = 27, [5] = 22, [6] = 15, [7] = 28 }, [1] = { [0] = 79, [1] = 80, [2] = 87, [3] = 93, [4] = 94, [5] = 89, [6] = 82, [7] = 95 }, [2] = { [0] = 237, [1] = 226, [2] = 245, [3] = 245, [4] = 248, [5] = 239, [6] = 240, [7] = 245 }, [3] = { [0] = 147, [1] = 148, [2] = 155, [3] = 161, [4] = 162, [5] = 157, [6] = 150, [7] = 157 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 120, [2] = 118, [3] = 118, [4] = 122, [5] = 116, [6] = 120, [7] = 109 }, [1] = { [0] = 31, [1] = 30, [2] = 28, [3] = 28, [4] = 32, [5] = 26, [6] = 30, [7] = 19 }, [2] = { [0] = 150, [1] = 161, [2] = 147, [3] = 149, [4] = 151, [5] = 145, [6] = 149, [7] = 138 }, [3] = { [0] = 237, [1] = 236, [2] = 234, [3] = 234, [4] = 238, [5] = 232, [6] = 236, [7] = 225 } })[R[19]][R[10]], ({ [0] = { [0] = 13, [1] = 14, [2] = 21, [3] = 22, [4] = 28, [5] = 28, [6] = 23, [7] = 17 }, [1] = { [0] = 80, [1] = 81, [2] = 88, [3] = 89, [4] = 95, [5] = 95, [6] = 90, [7] = 84 }, [2] = { [0] = 238, [1] = 227, [2] = 246, [3] = 241, [4] = 249, [5] = 245, [6] = 248, [7] = 234 }, [3] = { [0] = 148, [1] = 149, [2] = 156, [3] = 157, [4] = 163, [5] = 163, [6] = 158, [7] = 146 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 120, [2] = 118, [3] = 118, [4] = 125, [5] = 117, [6] = 121, [7] = 109 }, [1] = { [0] = 31, [1] = 30, [2] = 28, [3] = 28, [4] = 35, [5] = 27, [6] = 31, [7] = 19 }, [2] = { [0] = 150, [1] = 161, [2] = 147, [3] = 149, [4] = 154, [5] = 146, [6] = 150, [7] = 138 }, [3] = { [0] = 237, [1] = 236, [2] = 234, [3] = 234, [4] = 241, [5] = 233, [6] = 237, [7] = 225 } })[R[19]][R[10]], ({ [0] = { [0] = 14, [1] = 15, [2] = 22, [3] = 26, [4] = 14, [5] = 22, [6] = 15, [7] = 30 }, [1] = { [0] = 81, [1] = 82, [2] = 89, [3] = 93, [4] = 81, [5] = 89, [6] = 82, [7] = 97 }, [2] = { [0] = 239, [1] = 228, [2] = 247, [3] = 245, [4] = 235, [5] = 239, [6] = 240, [7] = 247 }, [3] = { [0] = 149, [1] = 150, [2] = 157, [3] = 161, [4] = 149, [5] = 157, [6] = 150, [7] = 159 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 120, [2] = 118, [3] = 119, [4] = 125, [5] = 117, [6] = 121, [7] = 110 }, [1] = { [0] = 31, [1] = 30, [2] = 28, [3] = 29, [4] = 35, [5] = 27, [6] = 31, [7] = 20 }, [2] = { [0] = 150, [1] = 161, [2] = 147, [3] = 150, [4] = 154, [5] = 146, [6] = 150, [7] = 139 }, [3] = { [0] = 237, [1] = 236, [2] = 234, [3] = 235, [4] = 241, [5] = 233, [6] = 237, [7] = 226 } })[R[19]][R[10]], ({ [0] = { [0] = 18, [1] = 23, [2] = 23, [3] = 26, [4] = 22, [5] = 28, [6] = 23, [7] = 17 }, [1] = { [0] = 85, [1] = 90, [2] = 90, [3] = 93, [4] = 89, [5] = 95, [6] = 90, [7] = 84 }, [2] = { [0] = 243, [1] = 236, [2] = 248, [3] = 245, [4] = 243, [5] = 245, [6] = 248, [7] = 234 }, [3] = { [0] = 153, [1] = 158, [2] = 158, [3] = 161, [4] = 157, [5] = 163, [6] = 158, [7] = 146 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 121, [2] = 118, [3] = 120, [4] = 125, [5] = 118, [6] = 122, [7] = 110 }, [1] = { [0] = 31, [1] = 31, [2] = 28, [3] = 30, [4] = 35, [5] = 28, [6] = 32, [7] = 20 }, [2] = { [0] = 150, [1] = 162, [2] = 147, [3] = 151, [4] = 154, [5] = 147, [6] = 151, [7] = 139 }, [3] = { [0] = 237, [1] = 237, [2] = 234, [3] = 236, [4] = 241, [5] = 234, [6] = 238, [7] = 226 } })[R[19]][R[10]], ({ [0] = { [0] = 19, [1] = 20, [2] = 24, [3] = 26, [4] = 30, [5] = 22, [6] = 15, [7] = 30 }, [1] = { [0] = 86, [1] = 87, [2] = 91, [3] = 93, [4] = 97, [5] = 89, [6] = 82, [7] = 97 }, [2] = { [0] = 244, [1] = 233, [2] = 249, [3] = 245, [4] = 251, [5] = 239, [6] = 240, [7] = 247 }, [3] = { [0] = 154, [1] = 155, [2] = 159, [3] = 161, [4] = 165, [5] = 157, [6] = 150, [7] = 159 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 121, [2] = 119, [3] = 121, [4] = 126, [5] = 118, [6] = 122, [7] = 111 }, [1] = { [0] = 31, [1] = 31, [2] = 29, [3] = 31, [4] = 36, [5] = 28, [6] = 32, [7] = 21 }, [2] = { [0] = 150, [1] = 162, [2] = 148, [3] = 152, [4] = 155, [5] = 147, [6] = 151, [7] = 140 }, [3] = { [0] = 237, [1] = 237, [2] = 235, [3] = 237, [4] = 242, [5] = 234, [6] = 238, [7] = 227 } })[R[19]][R[10]], ({ [0] = { [0] = 20, [1] = 21, [2] = 18, [3] = 19, [4] = 14, [5] = 28, [6] = 23, [7] = 17 }, [1] = { [0] = 87, [1] = 88, [2] = 85, [3] = 86, [4] = 81, [5] = 95, [6] = 90, [7] = 84 }, [2] = { [0] = 245, [1] = 234, [2] = 243, [3] = 238, [4] = 235, [5] = 245, [6] = 248, [7] = 234 }, [3] = { [0] = 155, [1] = 156, [2] = 153, [3] = 154, [4] = 149, [5] = 163, [6] = 158, [7] = 146 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 121, [2] = 119, [3] = 121, [4] = 126, [5] = 119, [6] = 124, [7] = 111 }, [1] = { [0] = 31, [1] = 31, [2] = 29, [3] = 31, [4] = 36, [5] = 29, [6] = 34, [7] = 21 }, [2] = { [0] = 150, [1] = 162, [2] = 148, [3] = 152, [4] = 155, [5] = 148, [6] = 153, [7] = 140 }, [3] = { [0] = 237, [1] = 237, [2] = 235, [3] = 237, [4] = 242, [5] = 235, [6] = 240, [7] = 227 } })[R[19]][R[10]], ({ [0] = { [0] = 21, [1] = 22, [2] = 24, [3] = 26, [4] = 22, [5] = 22, [6] = 17, [7] = 30 }, [1] = { [0] = 88, [1] = 89, [2] = 91, [3] = 93, [4] = 89, [5] = 89, [6] = 84, [7] = 97 }, [2] = { [0] = 246, [1] = 235, [2] = 249, [3] = 245, [4] = 243, [5] = 239, [6] = 242, [7] = 247 }, [3] = { [0] = 156, [1] = 157, [2] = 159, [3] = 161, [4] = 157, [5] = 157, [6] = 152, [7] = 159 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 124, [1] = 121, [2] = 120, [3] = 122, [4] = 126, [5] = 119, [6] = 124, [7] = 112 }, [1] = { [0] = 34, [1] = 31, [2] = 30, [3] = 32, [4] = 36, [5] = 29, [6] = 34, [7] = 22 }, [2] = { [0] = 153, [1] = 162, [2] = 149, [3] = 153, [4] = 155, [5] = 148, [6] = 153, [7] = 141 }, [3] = { [0] = 240, [1] = 237, [2] = 236, [3] = 238, [4] = 242, [5] = 235, [6] = 240, [7] = 228 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 23, [2] = 18, [3] = 19, [4] = 30, [5] = 28, [6] = 18, [7] = 17 }, [1] = { [0] = 83, [1] = 90, [2] = 85, [3] = 86, [4] = 97, [5] = 95, [6] = 85, [7] = 84 }, [2] = { [0] = 241, [1] = 236, [2] = 243, [3] = 238, [4] = 251, [5] = 245, [6] = 243, [7] = 234 }, [3] = { [0] = 151, [1] = 158, [2] = 153, [3] = 154, [4] = 165, [5] = 163, [6] = 153, [7] = 146 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 125, [1] = 121, [2] = 120, [3] = 123, [4] = 127, [5] = 120, [6] = 124, [7] = 112 }, [1] = { [0] = 35, [1] = 31, [2] = 30, [3] = 33, [4] = 37, [5] = 30, [6] = 34, [7] = 22 }, [2] = { [0] = 154, [1] = 162, [2] = 149, [3] = 154, [4] = 156, [5] = 149, [6] = 153, [7] = 141 }, [3] = { [0] = 241, [1] = 237, [2] = 236, [3] = 239, [4] = 243, [5] = 236, [6] = 240, [7] = 228 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 24, [2] = 24, [3] = 19, [4] = 14, [5] = 22, [6] = 19, [7] = 30 }, [1] = { [0] = 83, [1] = 91, [2] = 91, [3] = 86, [4] = 81, [5] = 89, [6] = 86, [7] = 97 }, [2] = { [0] = 241, [1] = 237, [2] = 249, [3] = 238, [4] = 235, [5] = 239, [6] = 244, [7] = 247 }, [3] = { [0] = 151, [1] = 159, [2] = 159, [3] = 154, [4] = 149, [5] = 157, [6] = 154, [7] = 159 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 126, [1] = 121, [2] = 121, [3] = 124, [4] = 127, [5] = 121, [6] = 124, [7] = 113 }, [1] = { [0] = 36, [1] = 31, [2] = 31, [3] = 34, [4] = 37, [5] = 31, [6] = 34, [7] = 23 }, [2] = { [0] = 155, [1] = 162, [2] = 150, [3] = 155, [4] = 156, [5] = 150, [6] = 153, [7] = 142 }, [3] = { [0] = 242, [1] = 237, [2] = 237, [3] = 240, [4] = 243, [5] = 237, [6] = 240, [7] = 229 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 25, [2] = 18, [3] = 19, [4] = 15, [5] = 22, [6] = 20, [7] = 17 }, [1] = { [0] = 83, [1] = 92, [2] = 85, [3] = 86, [4] = 82, [5] = 89, [6] = 87, [7] = 84 }, [2] = { [0] = 241, [1] = 238, [2] = 243, [3] = 238, [4] = 236, [5] = 239, [6] = 245, [7] = 234 }, [3] = { [0] = 151, [1] = 160, [2] = 153, [3] = 154, [4] = 150, [5] = 157, [6] = 155, [7] = 146 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 127, [1] = 121, [2] = 121, [3] = 125, [4] = 127, [5] = 122, [6] = 124, [7] = 113 }, [1] = { [0] = 37, [1] = 31, [2] = 31, [3] = 35, [4] = 37, [5] = 32, [6] = 34, [7] = 23 }, [2] = { [0] = 156, [1] = 162, [2] = 150, [3] = 156, [4] = 156, [5] = 151, [6] = 153, [7] = 142 }, [3] = { [0] = 243, [1] = 237, [2] = 237, [3] = 241, [4] = 243, [5] = 238, [6] = 240, [7] = 229 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 30, [2] = 24, [3] = 19, [4] = 22, [5] = 22, [6] = 21, [7] = 18 }, [1] = { [0] = 83, [1] = 97, [2] = 91, [3] = 86, [4] = 89, [5] = 89, [6] = 88, [7] = 85 }, [2] = { [0] = 241, [1] = 243, [2] = 249, [3] = 238, [4] = 243, [5] = 239, [6] = 246, [7] = 235 }, [3] = { [0] = 151, [1] = 165, [2] = 159, [3] = 154, [4] = 157, [5] = 157, [6] = 156, [7] = 147 } })[R[19]][R[10]] })
    game.create_tube({ ({ [0] = { [0] = 128, [1] = 121, [2] = 122, [3] = 126, [4] = 127, [5] = 122, [6] = 128, [7] = 113 }, [1] = { [0] = 38, [1] = 31, [2] = 32, [3] = 36, [4] = 37, [5] = 32, [6] = 38, [7] = 23 }, [2] = { [0] = 157, [1] = 162, [2] = 151, [3] = 157, [4] = 156, [5] = 151, [6] = 157, [7] = 142 }, [3] = { [0] = 244, [1] = 237, [2] = 238, [3] = 242, [4] = 243, [5] = 238, [6] = 244, [7] = 229 } })[R[19]][R[10]], ({ [0] = { [0] = 16, [1] = 31, [2] = 18, [3] = 19, [4] = 30, [5] = 23, [6] = 23, [7] = 19 }, [1] = { [0] = 83, [1] = 98, [2] = 85, [3] = 86, [4] = 97, [5] = 90, [6] = 90, [7] = 86 }, [2] = { [0] = 241, [1] = 244, [2] = 243, [3] = 238, [4] = 251, [5] = 240, [6] = 248, [7] = 236 }, [3] = { [0] = 151, [1] = 166, [2] = 153, [3] = 154, [4] = 165, [5] = 158, [6] = 158, [7] = 148 } })[R[19]][R[10]] })
    if R[10] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[19]] })
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [2] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 } })[R[55]][R[19]], ({ [0] = { [0] = 10, [1] = 77, [2] = 235, [3] = 145 }, [1] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 } })[R[55]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[19]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[19]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 153, [3] = 228 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 } })[R[56]][R[19]], ({ [0] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [1] = { [0] = 29, [1] = 96, [2] = 242, [3] = 164 }, [2] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 } })[R[56]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [2] = { [0] = 131, [1] = 41, [2] = 160, [3] = 247 } })[R[57]][R[19]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 } })[R[57]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[19]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [1] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [2] = { [0] = 112, [1] = 22, [2] = 143, [3] = 228 } })[R[58]][R[19]], ({ [0] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [1] = { [0] = 29, [1] = 96, [2] = 248, [3] = 164 }, [2] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 } })[R[58]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[19]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[19]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[19]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[19]] })
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 } })[R[59]][R[19]], ({ [0] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [1] = { [0] = 21, [1] = 88, [2] = 242, [3] = 156 }, [2] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 } })[R[59]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[19]] })
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 101, [1] = 11, [2] = 130, [3] = 217 }, [2] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[60]][R[19]], ({ [0] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 }, [1] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [2] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 } })[R[60]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[19]] })
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [2] = { [0] = 136, [1] = 46, [2] = 165, [3] = 252 } })[R[61]][R[19]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 } })[R[61]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[19]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[19]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[19]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[19]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[19]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[19]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[19]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[19]] })
        for i = 1, game.initial_units() do
          R[62] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 105, [1] = 15, [2] = 134, [3] = 221 } })[R[62]][R[19]], ({ [0] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [1] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [2] = { [0] = 34, [1] = 101, [2] = 251, [3] = 163 } })[R[62]][R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    R[37] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 10, [1] = 77, [2] = 223, [3] = 145 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    if R[37] == 0 or R[37] == 1 or R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 17, [1] = 84, [2] = 230, [3] = 152 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 27, [1] = 94, [2] = 244, [3] = 162 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 0 then
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
      elseif R[37] == 1 then
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
      elseif R[37] == 2 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[20]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[20]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[20]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[37] == 7 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[37]", R[37])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [7] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 29, [1] = 96, [2] = 246, [3] = 158 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 0 or R[37] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 } })[R[37]][R[20]], ({ [0] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [1] = { [0] = 35, [1] = 102, [2] = 248, [3] = 170 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[37] == 2 or R[37] == 5 or R[37] == 6 or R[37] == 7 then
      else
        unseen("R[37]", R[37])
      end
    elseif R[37] == 3 or R[37] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[37]][R[20]], ({ [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      if R[37] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 247, [3] = 161 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
      elseif R[37] == 3 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 118, [1] = 28, [2] = 149, [3] = 234 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[20]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[37]", R[37])
      end
    else
      unseen("R[37]", R[37])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 111, [1] = 21, [2] = 152, [3] = 227 }, [2] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [5] = { [0] = 102, [1] = 12, [2] = 131, [3] = 218 }, [6] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [7] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 } })[R[37]][R[20]], ({ [0] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [1] = { [0] = 32, [1] = 99, [2] = 245, [3] = 167 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 13, [1] = 80, [2] = 232, [3] = 148 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 33, [1] = 100, [2] = 250, [3] = 162 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 13, [1] = 80, [2] = 230, [3] = 148 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 16, [1] = 83, [2] = 229, [3] = 151 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[3].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[37]][R[20]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[37]][R[20]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[3].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[37]], player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[37]][R[20]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 135, [1] = 45, [2] = 164, [3] = 251 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 17, [1] = 84, [2] = 236, [3] = 152 }, [4] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [5] = { [0] = 29, [1] = 96, [2] = 246, [3] = 164 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[37]][R[20]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 }, [5] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 20, [1] = 87, [2] = 237, [3] = 149 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 27, [1] = 94, [2] = 246, [3] = 162 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 19, [1] = 86, [2] = 236, [3] = 154 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 115, [1] = 25, [2] = 156, [3] = 231 }, [2] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 28, [1] = 95, [2] = 247, [3] = 163 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 22, [1] = 89, [2] = 239, [3] = 151 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 19, [1] = 86, [2] = 240, [3] = 154 }, [5] = { [0] = 24, [1] = 91, [2] = 241, [3] = 159 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 117, [1] = 27, [2] = 158, [3] = 233 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 20, [1] = 87, [2] = 241, [3] = 155 }, [5] = { [0] = 25, [1] = 92, [2] = 242, [3] = 160 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 118, [1] = 28, [2] = 159, [3] = 234 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [3] = { [0] = 23, [1] = 90, [2] = 242, [3] = 158 }, [4] = { [0] = 24, [1] = 91, [2] = 245, [3] = 159 }, [5] = { [0] = 26, [1] = 93, [2] = 243, [3] = 161 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 25, [1] = 92, [2] = 242, [3] = 154 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 24, [1] = 91, [2] = 243, [3] = 159 }, [4] = { [0] = 25, [1] = 92, [2] = 246, [3] = 160 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [3] = { [0] = 25, [1] = 92, [2] = 244, [3] = 160 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 27, [1] = 94, [2] = 244, [3] = 156 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[37]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 13, [1] = 80, [2] = 226, [3] = 148 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 27, [1] = 94, [2] = 248, [3] = 162 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 28, [1] = 95, [2] = 245, [3] = 157 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 14, [1] = 81, [2] = 227, [3] = 149 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 28, [1] = 95, [2] = 249, [3] = 163 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[37]][R[20]], ({ [0] = { [0] = 14, [1] = 81, [2] = 239, [3] = 149 }, [1] = { [0] = 15, [1] = 82, [2] = 228, [3] = 150 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 120, [1] = 30, [2] = 151, [3] = 236 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[37]][R[20]], ({ [0] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [1] = { [0] = 20, [1] = 87, [2] = 233, [3] = 155 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[37]][R[20]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[37]][R[20]], ({ [0] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 122, [1] = 32, [2] = 153, [3] = 238 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 24, [1] = 91, [2] = 237, [3] = 159 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 25, [1] = 92, [2] = 238, [3] = 160 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 15, [1] = 82, [2] = 236, [3] = 150 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 30, [1] = 97, [2] = 243, [3] = 165 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[37]][R[20]] })
    game.create_tube({ ({ [0] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [3] = { [0] = 126, [1] = 36, [2] = 157, [3] = 242 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[37]][R[20]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 31, [1] = 98, [2] = 244, [3] = 166 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 19, [1] = 86, [2] = 236, [3] = 148 } })[R[37]][R[20]] })
    if R[37] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[20]] })
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [2] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 } })[R[63]][R[20]], ({ [0] = { [0] = 10, [1] = 77, [2] = 235, [3] = 145 }, [1] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 } })[R[63]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[20]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[20]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 153, [3] = 228 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 } })[R[64]][R[20]], ({ [0] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [1] = { [0] = 29, [1] = 96, [2] = 242, [3] = 164 }, [2] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 } })[R[64]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [2] = { [0] = 131, [1] = 41, [2] = 160, [3] = 247 } })[R[65]][R[20]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 } })[R[65]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[20]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[20]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [1] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [2] = { [0] = 112, [1] = 22, [2] = 143, [3] = 228 } })[R[66]][R[20]], ({ [0] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [1] = { [0] = 29, [1] = 96, [2] = 248, [3] = 164 }, [2] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 } })[R[66]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[20]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[20]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 } })[R[67]][R[20]], ({ [0] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [1] = { [0] = 21, [1] = 88, [2] = 242, [3] = 156 }, [2] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 } })[R[67]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[20]] })
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 101, [1] = 11, [2] = 130, [3] = 217 }, [2] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[68]][R[20]], ({ [0] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 }, [1] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [2] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 } })[R[68]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[20]] })
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [2] = { [0] = 136, [1] = 46, [2] = 165, [3] = 252 } })[R[69]][R[20]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 } })[R[69]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[37] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[20]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[20]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[20]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[20]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[20]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[20]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[20]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[20]] })
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 105, [1] = 15, [2] = 134, [3] = 221 } })[R[70]][R[20]], ({ [0] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [1] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [2] = { [0] = 34, [1] = 101, [2] = 251, [3] = 163 } })[R[70]][R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[37]", R[37])
    end
    R[71] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[71]][R[46]] })
    U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[71]][R[46]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 10, [1] = 77, [2] = 223, [3] = 145 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    if R[71] == 0 or R[71] == 1 or R[71] == 2 or R[71] == 5 or R[71] == 6 or R[71] == 7 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 17, [1] = 84, [2] = 230, [3] = 152 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 27, [1] = 94, [2] = 244, [3] = 162 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 0 then
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
      elseif R[71] == 1 then
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
      elseif R[71] == 2 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[46]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[46]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 124, [1] = 34, [2] = 153, [3] = 240 })[R[46]], ({ [0] = 18, [1] = 85, [2] = 243, [3] = 153 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[46]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[46]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[46]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 155 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 7 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[71]", R[71])
      end
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [7] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 29, [1] = 96, [2] = 246, [3] = 158 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 0 or R[71] == 1 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 } })[R[71]][R[46]], ({ [0] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [1] = { [0] = 35, [1] = 102, [2] = 248, [3] = 170 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 2 or R[71] == 5 or R[71] == 6 or R[71] == 7 then
      else
        unseen("R[71]", R[71])
      end
    elseif R[71] == 3 or R[71] == 4 then
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 } })[R[71]][R[46]], ({ [3] = { [0] = 30, [1] = 97, [2] = 249, [3] = 165 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 4 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[71] == 3 then
      else
        unseen("R[71]", R[71])
      end
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 } })[R[71]][R[46]], ({ [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      if R[71] == 3 then
        if LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[46]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[46]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[46]], ({ [0] = 19, [1] = 86, [2] = 238, [3] = 154 })[R[46]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[71] == 4 then
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
        unseen("R[71]", R[71])
      end
    else
      unseen("R[71]", R[71])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 111, [1] = 21, [2] = 152, [3] = 227 }, [2] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [5] = { [0] = 102, [1] = 12, [2] = 131, [3] = 218 }, [6] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [7] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 } })[R[71]][R[46]], ({ [0] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [1] = { [0] = 32, [1] = 99, [2] = 245, [3] = 167 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 13, [1] = 80, [2] = 232, [3] = 148 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 33, [1] = 100, [2] = 250, [3] = 162 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 132, [1] = 42, [2] = 161, [3] = 248 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[71]][R[46]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 13, [1] = 80, [2] = 230, [3] = 148 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[71]][R[46]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 16, [1] = 83, [2] = 229, [3] = 151 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if LEVEL_OF[players[4].difficulty] == 0 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[71]][R[46]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[71]][R[46]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[71]][R[46]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "ConVec", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[71]][R[46]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "CargoTruck", [2] = "ConVec", [3] = "CargoTruck", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[71]][R[46]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[71]][R[46]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[71]][R[46]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 2 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[71]][R[46]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[71]][R[46]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "ConVec", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[71]][R[46]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[71]][R[46]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    elseif LEVEL_OF[players[4].difficulty] == 1 then
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboMiner", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 133, [1] = 43, [2] = 164, [3] = 249 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[71]][R[46]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "ConVec", [1] = "ConVec", [2] = "ConVec", [3] = "RoboSurveyor", [4] = "ConVec", [5] = "ConVec", [6] = "ConVec", [7] = "ConVec" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 131, [1] = 41, [2] = 162, [3] = 247 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[71]][R[46]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 16, [1] = 83, [2] = 235, [3] = 151 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "ConVec", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "CargoTruck", [7] = "CargoTruck" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 110, [1] = 20, [2] = 151, [3] = 226 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 134, [1] = 44, [2] = 163, [3] = 250 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [7] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 } })[R[71]][R[46]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 15, [1] = 82, [2] = 232, [3] = 150 }, [6] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[71]][R[46]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 18, [1] = 85, [2] = 231, [3] = 153 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboSurveyor", [1] = "RoboSurveyor", [2] = "RoboSurveyor", [3] = "CargoTruck", [4] = "RoboSurveyor", [5] = "RoboSurveyor", [6] = "RoboSurveyor", [7] = "RoboSurveyor" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [3] = { [0] = 113, [1] = 23, [2] = 144, [3] = 229 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 107, [1] = 17, [2] = 136, [3] = 223 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 } })[R[71]][R[46]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 }, [3] = { [0] = 20, [1] = 87, [2] = 239, [3] = 155 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 12, [1] = 79, [2] = 229, [3] = 147 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "ConVec", [4] = "RoboMiner", [5] = "RoboMiner", [6] = "RoboMiner", [7] = "RoboMiner" })[R[71]], player = players[4], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 103, [1] = 13, [2] = 132, [3] = 219 } })[R[71]][R[46]], ({ [0] = { [0] = 9, [1] = 76, [2] = 234, [3] = 144 }, [1] = { [0] = 9, [1] = 76, [2] = 222, [3] = 144 }, [2] = { [0] = 27, [1] = 94, [2] = 252, [3] = 162 }, [3] = { [0] = 31, [1] = 98, [2] = 250, [3] = 166 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 133, [1] = 43, [2] = 162, [3] = 249 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 135, [1] = 45, [2] = 164, [3] = 251 }, [5] = { [0] = 108, [1] = 18, [2] = 137, [3] = 224 }, [6] = { [0] = 129, [1] = 39, [2] = 158, [3] = 245 }, [7] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 } })[R[71]][R[46]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 17, [1] = 84, [2] = 236, [3] = 152 }, [4] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [5] = { [0] = 29, [1] = 96, [2] = 246, [3] = 164 }, [6] = { [0] = 25, [1] = 92, [2] = 250, [3] = 160 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[71]][R[46]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    game.create_tube({ ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 113, [1] = 23, [2] = 154, [3] = 229 }, [2] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 }, [5] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 20, [1] = 87, [2] = 237, [3] = 149 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 27, [1] = 94, [2] = 246, [3] = 162 }, [4] = { [0] = 17, [1] = 84, [2] = 238, [3] = 152 }, [5] = { [0] = 19, [1] = 86, [2] = 236, [3] = 154 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 21, [1] = 88, [2] = 238, [3] = 150 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [1] = { [0] = 115, [1] = 25, [2] = 156, [3] = 231 }, [2] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [3] = { [0] = 115, [1] = 25, [2] = 146, [3] = 231 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 28, [1] = 95, [2] = 247, [3] = 163 }, [4] = { [0] = 18, [1] = 85, [2] = 239, [3] = 153 }, [5] = { [0] = 20, [1] = 87, [2] = 237, [3] = 155 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 22, [1] = 89, [2] = 239, [3] = 151 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [1] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 116, [1] = 26, [2] = 147, [3] = 232 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 19, [1] = 86, [2] = 240, [3] = 154 }, [5] = { [0] = 24, [1] = 91, [2] = 241, [3] = 159 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 23, [1] = 90, [2] = 240, [3] = 152 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [1] = { [0] = 117, [1] = 27, [2] = 158, [3] = 233 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 20, [1] = 87, [2] = 241, [3] = 155 }, [5] = { [0] = 25, [1] = 92, [2] = 242, [3] = 160 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 24, [1] = 91, [2] = 241, [3] = 153 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 118, [1] = 28, [2] = 159, [3] = 234 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 }, [6] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [3] = { [0] = 23, [1] = 90, [2] = 242, [3] = 158 }, [4] = { [0] = 24, [1] = 91, [2] = 245, [3] = 159 }, [5] = { [0] = 26, [1] = 93, [2] = 243, [3] = 161 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 25, [1] = 92, [2] = 242, [3] = 154 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [1] = { [0] = 119, [1] = 29, [2] = 160, [3] = 235 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 24, [1] = 91, [2] = 243, [3] = 159 }, [4] = { [0] = 25, [1] = 92, [2] = 246, [3] = 160 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 26, [1] = 93, [2] = 243, [3] = 155 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [6] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[71]][R[46]], ({ [0] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [1] = { [0] = 12, [1] = 79, [2] = 225, [3] = 147 }, [2] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [3] = { [0] = 25, [1] = 92, [2] = 244, [3] = 160 }, [4] = { [0] = 26, [1] = 93, [2] = 247, [3] = 161 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 27, [1] = 94, [2] = 244, [3] = 156 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 117, [1] = 27, [2] = 148, [3] = 233 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 106, [1] = 16, [2] = 135, [3] = 222 } })[R[71]][R[46]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 13, [1] = 80, [2] = 226, [3] = 148 }, [2] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 27, [1] = 94, [2] = 248, [3] = 162 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 28, [1] = 95, [2] = 245, [3] = 157 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [5] = { [0] = 116, [1] = 26, [2] = 145, [3] = 232 }, [6] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[71]][R[46]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 14, [1] = 81, [2] = 227, [3] = 149 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [3] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [4] = { [0] = 28, [1] = 95, [2] = 249, [3] = 163 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 118, [1] = 28, [2] = 149, [3] = 234 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 109, [1] = 19, [2] = 138, [3] = 225 } })[R[71]][R[46]], ({ [0] = { [0] = 14, [1] = 81, [2] = 239, [3] = 149 }, [1] = { [0] = 15, [1] = 82, [2] = 228, [3] = 150 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 120, [1] = 30, [2] = 161, [3] = 236 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 119, [1] = 29, [2] = 150, [3] = 235 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [6] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[71]][R[46]], ({ [0] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [3] = { [0] = 120, [1] = 30, [2] = 151, [3] = 236 }, [4] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 } })[R[71]][R[46]], ({ [0] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [1] = { [0] = 20, [1] = 87, [2] = 233, [3] = 155 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 15, [1] = 82, [2] = 240, [3] = 150 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [6] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[71]][R[46]], ({ [0] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [1] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [3] = { [0] = 121, [1] = 31, [2] = 152, [3] = 237 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 } })[R[71]][R[46]], ({ [0] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [1] = { [0] = 22, [1] = 89, [2] = 235, [3] = 157 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 17, [1] = 84, [2] = 242, [3] = 152 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 122, [1] = 32, [2] = 153, [3] = 238 }, [4] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [5] = { [0] = 119, [1] = 29, [2] = 148, [3] = 235 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 23, [1] = 90, [2] = 236, [3] = 158 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 28, [1] = 95, [2] = 245, [3] = 163 }, [6] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [3] = { [0] = 123, [1] = 33, [2] = 154, [3] = 239 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 120, [1] = 30, [2] = 149, [3] = 236 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 112, [1] = 22, [2] = 141, [3] = 228 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 24, [1] = 91, [2] = 237, [3] = 159 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 14, [1] = 81, [2] = 235, [3] = 149 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [7] = { [0] = 30, [1] = 97, [2] = 247, [3] = 159 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 25, [1] = 92, [2] = 238, [3] = 160 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 15, [1] = 82, [2] = 236, [3] = 150 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 20, [1] = 87, [2] = 245, [3] = 155 }, [7] = { [0] = 17, [1] = 84, [2] = 234, [3] = 146 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 121, [1] = 31, [2] = 150, [3] = 237 }, [3] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 124, [1] = 34, [2] = 153, [3] = 240 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 30, [1] = 97, [2] = 243, [3] = 165 }, [2] = { [0] = 24, [1] = 91, [2] = 249, [3] = 159 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 22, [1] = 89, [2] = 243, [3] = 157 }, [5] = { [0] = 22, [1] = 89, [2] = 239, [3] = 157 }, [6] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 }, [7] = { [0] = 18, [1] = 85, [2] = 235, [3] = 147 } })[R[71]][R[46]] })
    game.create_tube({ ({ [0] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [1] = { [0] = 121, [1] = 31, [2] = 162, [3] = 237 }, [2] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [3] = { [0] = 126, [1] = 36, [2] = 157, [3] = 242 }, [4] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [5] = { [0] = 122, [1] = 32, [2] = 151, [3] = 238 }, [6] = { [0] = 128, [1] = 38, [2] = 157, [3] = 244 }, [7] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 } })[R[71]][R[46]], ({ [0] = { [0] = 16, [1] = 83, [2] = 241, [3] = 151 }, [1] = { [0] = 31, [1] = 98, [2] = 244, [3] = 166 }, [2] = { [0] = 18, [1] = 85, [2] = 243, [3] = 153 }, [3] = { [0] = 19, [1] = 86, [2] = 238, [3] = 154 }, [4] = { [0] = 30, [1] = 97, [2] = 251, [3] = 165 }, [5] = { [0] = 23, [1] = 90, [2] = 240, [3] = 158 }, [6] = { [0] = 23, [1] = 90, [2] = 248, [3] = 158 }, [7] = { [0] = 19, [1] = 86, [2] = 236, [3] = 148 } })[R[71]][R[46]] })
    if R[71] == 0 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[46]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[46]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[46]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[46]], ({ [0] = 16, [1] = 83, [2] = 241, [3] = 151 })[R[46]] })
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 127, [1] = 37, [2] = 156, [3] = 243 }, [1] = { [0] = 114, [1] = 24, [2] = 143, [3] = 230 }, [2] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 } })[R[72]][R[46]], ({ [0] = { [0] = 10, [1] = 77, [2] = 235, [3] = 145 }, [1] = { [0] = 19, [1] = 86, [2] = 244, [3] = 154 }, [2] = { [0] = 22, [1] = 89, [2] = 247, [3] = 157 } })[R[72]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[46]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[46]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[46]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[46]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[46]], ({ [0] = 32, [1] = 99, [2] = 245, [3] = 167 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 162, [3] = 237 })[R[46]], ({ [0] = 33, [1] = 100, [2] = 246, [3] = 168 })[R[46]] })
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 112, [1] = 22, [2] = 153, [3] = 228 }, [1] = { [0] = 114, [1] = 24, [2] = 155, [3] = 230 }, [2] = { [0] = 116, [1] = 26, [2] = 157, [3] = 232 } })[R[73]][R[46]], ({ [0] = { [0] = 27, [1] = 94, [2] = 240, [3] = 162 }, [1] = { [0] = 29, [1] = 96, [2] = 242, [3] = 164 }, [2] = { [0] = 21, [1] = 88, [2] = 234, [3] = 156 } })[R[73]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 2 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 113, [1] = 23, [2] = 142, [3] = 229 }, [1] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [2] = { [0] = 131, [1] = 41, [2] = 160, [3] = 247 } })[R[74]][R[46]], ({ [0] = { [0] = 12, [1] = 79, [2] = 237, [3] = 147 }, [1] = { [0] = 28, [1] = 95, [2] = 253, [3] = 163 }, [2] = { [0] = 21, [1] = 88, [2] = 246, [3] = 156 } })[R[74]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[46]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[46]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[46]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[46]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[46]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 124, [1] = 34, [2] = 155, [3] = 240 }, [1] = { [0] = 125, [1] = 35, [2] = 156, [3] = 241 }, [2] = { [0] = 112, [1] = 22, [2] = 143, [3] = 228 } })[R[75]][R[46]], ({ [0] = { [0] = 22, [1] = 89, [2] = 241, [3] = 157 }, [1] = { [0] = 29, [1] = 96, [2] = 248, [3] = 164 }, [2] = { [0] = 26, [1] = 93, [2] = 245, [3] = 161 } })[R[75]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 126, [1] = 36, [2] = 157, [3] = 242 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 127, [1] = 37, [2] = 158, [3] = 243 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 159, [3] = 244 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 160, [3] = 245 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 241, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 242, [3] = 158 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[46]], ({ [0] = 24, [1] = 91, [2] = 243, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[46]], ({ [0] = 25, [1] = 92, [2] = 244, [3] = 160 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 161, [3] = 246 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 245, [3] = 161 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[46]], ({ [0] = 27, [1] = 94, [2] = 246, [3] = 162 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 162, [3] = 247 })[R[46]], ({ [0] = 28, [1] = 95, [2] = 247, [3] = 163 })[R[46]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[46]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[46]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[46]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[46]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[46]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[46]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[46]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[46]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[46]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[46]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[46]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[46]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[46]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[46]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[46]], ({ [0] = 15, [1] = 82, [2] = 236, [3] = 150 })[R[46]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[46]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 128, [1] = 38, [2] = 157, [3] = 244 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[46]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[46]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[46]], ({ [0] = 16, [1] = 83, [2] = 237, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 243, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 244, [3] = 158 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 24, [1] = 91, [2] = 245, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 251, [3] = 165 })[R[46]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[46]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[46]] })
        game.create_tube({ ({ [0] = 132, [1] = 42, [2] = 161, [3] = 248 })[R[46]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[46]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 19, [1] = 86, [2] = 240, [3] = 154 })[R[46]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 20, [1] = 87, [2] = 241, [3] = 155 })[R[46]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 21, [1] = 88, [2] = 242, [3] = 156 })[R[46]] })
        game.create_tube({ ({ [0] = 133, [1] = 43, [2] = 162, [3] = 249 })[R[46]], ({ [0] = 29, [1] = 96, [2] = 250, [3] = 164 })[R[46]] })
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 126, [1] = 36, [2] = 155, [3] = 242 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 125, [1] = 35, [2] = 154, [3] = 241 } })[R[76]][R[46]], ({ [0] = { [0] = 13, [1] = 80, [2] = 234, [3] = 148 }, [1] = { [0] = 21, [1] = 88, [2] = 242, [3] = 156 }, [2] = { [0] = 16, [1] = 83, [2] = 237, [3] = 151 } })[R[76]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 5 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[46]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[46]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[46]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 122, [1] = 32, [2] = 151, [3] = 238 })[R[46]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 160 })[R[46]] })
        for i = 1, game.initial_units() do
          R[77] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 118, [1] = 28, [2] = 147, [3] = 234 }, [1] = { [0] = 101, [1] = 11, [2] = 130, [3] = 217 }, [2] = { [0] = 123, [1] = 33, [2] = 152, [3] = 239 } })[R[77]][R[46]], ({ [0] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 }, [1] = { [0] = 18, [1] = 85, [2] = 235, [3] = 153 }, [2] = { [0] = 31, [1] = 98, [2] = 248, [3] = 166 } })[R[77]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 6 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 129, [1] = 39, [2] = 158, [3] = 245 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[46]] })
        game.create_tube({ ({ [0] = 130, [1] = 40, [2] = 159, [3] = 246 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[46]] })
        game.create_tube({ ({ [0] = 131, [1] = 41, [2] = 160, [3] = 247 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 248, [3] = 158 })[R[46]] })
        for i = 1, game.initial_units() do
          R[78] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 110, [1] = 20, [2] = 139, [3] = 226 }, [1] = { [0] = 115, [1] = 25, [2] = 144, [3] = 231 }, [2] = { [0] = 136, [1] = 46, [2] = 165, [3] = 252 } })[R[78]][R[46]], ({ [0] = { [0] = 13, [1] = 80, [2] = 238, [3] = 148 }, [1] = { [0] = 11, [1] = 78, [2] = 236, [3] = 146 }, [2] = { [0] = 26, [1] = 93, [2] = 251, [3] = 161 } })[R[78]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[71] == 7 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[46]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 28, [1] = 95, [2] = 245, [3] = 157 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 29, [1] = 96, [2] = 246, [3] = 158 })[R[46]] })
        game.create_tube({ ({ [0] = 113, [1] = 23, [2] = 142, [3] = 229 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 114, [1] = 24, [2] = 143, [3] = 230 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 115, [1] = 25, [2] = 144, [3] = 231 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 116, [1] = 26, [2] = 145, [3] = 232 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 117, [1] = 27, [2] = 146, [3] = 233 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 118, [1] = 28, [2] = 147, [3] = 234 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[46]], ({ [0] = 17, [1] = 84, [2] = 234, [3] = 146 })[R[46]] })
        game.create_tube({ ({ [0] = 119, [1] = 29, [2] = 148, [3] = 235 })[R[46]], ({ [0] = 30, [1] = 97, [2] = 247, [3] = 159 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 19, [1] = 86, [2] = 236, [3] = 148 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 20, [1] = 87, [2] = 237, [3] = 149 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 21, [1] = 88, [2] = 238, [3] = 150 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 22, [1] = 89, [2] = 239, [3] = 151 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 23, [1] = 90, [2] = 240, [3] = 152 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 24, [1] = 91, [2] = 241, [3] = 153 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 25, [1] = 92, [2] = 242, [3] = 154 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 26, [1] = 93, [2] = 243, [3] = 155 })[R[46]] })
        game.create_tube({ ({ [0] = 121, [1] = 31, [2] = 150, [3] = 237 })[R[46]], ({ [0] = 27, [1] = 94, [2] = 244, [3] = 156 })[R[46]] })
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 111, [1] = 21, [2] = 140, [3] = 227 }, [1] = { [0] = 117, [1] = 27, [2] = 146, [3] = 233 }, [2] = { [0] = 105, [1] = 15, [2] = 134, [3] = 221 } })[R[79]][R[46]], ({ [0] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [1] = { [0] = 13, [1] = 80, [2] = 230, [3] = 142 }, [2] = { [0] = 34, [1] = 101, [2] = 251, [3] = 163 } })[R[79]][R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[71]", R[71])
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
    trigger.time{min = 1200, max = 1800, one_shot = false, on = Meteor}  -- after 12 to 18 marks
  end
  return true
end
