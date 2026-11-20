-- ml6_01Lua.lua  -  6 Player, LastOne, 'Axen's Home' map. (Lua)
--
-- Converted by op2dll from ml6_01.dll ("6 Player, LastOne, 'Axen's Home' map."): its setup replayed. `on_init` makes the original's
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

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Meteors, Tornados

function Meteors(t)
  local r1 = game.rand(255)
  local r2 = game.rand(512)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function Tornados(t)
  local r1 = game.rand(10)
  local r2 = game.rand(255)
  local r3 = game.rand(512)
  game.create_lightning({ r3 + 1, r2 + 2 }, nil, r1 + 10)
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 114, 50 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 160, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 59, 204 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 430, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 315, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 238, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 454, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 431, 79 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 380, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 393, 67 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 380, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 331, 69 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 364, 107 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 353, 137 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 293, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 343, 173 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 314, 209 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 384, 215 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 244, 168 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 213, 229 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 182, 184 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 153, 230 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 131, 187 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 82, 247 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 14, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 150 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 90, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 15, 146 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 10, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 497, 154 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 507, 213 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 465, 245 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 437, 225 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 393, 241 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 501, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 70, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 110, 13 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 196, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 182, 87 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 228, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 257, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 438, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 390, 153 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 12, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 156, 22 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 325, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 406, 104 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 484, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 500, 113 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 219 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 193, 105 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 103, 104 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 264, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 156, 131 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 49, 179 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 101, 57 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 456, 195 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 417, 9 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 176, 129 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 214, 185 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 449, 44 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 467, 28 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 360, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 351, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 470, 207 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 383, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 267, 140 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 311, 87 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 119, 53 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 87, 68 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 54, 162 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 129, 91 } }
    R[0] = game.rand(7)
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[0]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[0]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[0]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[0]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[0]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[0]] })
    if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 5 or R[0] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[0]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[0]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[0]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[0]] })
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 5 or R[0] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[0]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[0]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[0]] })
        if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[0]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[0]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[0]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[0]] })
          if R[0] == 0 or R[0] == 1 or R[0] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[0]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[0]] })
            if R[0] == 0 then
            elseif R[0] == 1 or R[0] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[0]], ({ [1] = 31, [2] = 160 })[R[0]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[0]], ({ [1] = 32, [2] = 160 })[R[0]] })
              if R[0] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[0] == 1 then
              else
                unseen("R[0]", R[0])
              end
            else
              unseen("R[0]", R[0])
            end
          elseif R[0] == 6 then
          else
            unseen("R[0]", R[0])
          end
        elseif R[0] == 5 then
        else
          unseen("R[0]", R[0])
        end
      elseif R[0] == 3 then
      else
        unseen("R[0]", R[0])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[0]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      players[1]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[0]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[0]] })
      if R[0] == 0 or R[0] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 43, [3] = 247 })[R[0]], ({ [0] = 201, [3] = 89 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [3] = 252 })[R[0]], ({ [0] = 194, [3] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[0] == 0 then
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
        elseif R[0] == 3 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[0]", R[0])
        end
      elseif R[0] == 1 or R[0] == 2 or R[0] == 5 or R[0] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[0]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[0]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[0]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[0]", R[0])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[0]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[0] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      elseif R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 5 or R[0] == 6 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[1]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[0]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[0]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[0]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[0] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 or LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[0]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[1].difficulty] == 2 then
      elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if R[0] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[1] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[1]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[1]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[2] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[2]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[2]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[3] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[3]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[3]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[0] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[4] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[4]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[4]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[5] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[5]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[5]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[6] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[6]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[6]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[7] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[7]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[7]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[8] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[8]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[8]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[9] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[9]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[9]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[0]", R[0])
    end
    R[10] = draw_avoid(7, { R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[10]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[10]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[10]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[10]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[10]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[10]] })
    if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 5 or R[10] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[10]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[10]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[10]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[10]] })
      if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[10]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[10]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[10]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[10]] })
        if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[10]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[10]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[10]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[10]] })
          if R[10] == 6 then
          elseif R[10] == 0 or R[10] == 1 or R[10] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[10]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[10]] })
            if R[10] == 1 or R[10] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[10]], ({ [1] = 31, [2] = 160 })[R[10]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[10]], ({ [1] = 32, [2] = 160 })[R[10]] })
              if R[10] == 1 then
              elseif R[10] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              else
                unseen("R[10]", R[10])
              end
            elseif R[10] == 0 then
            else
              unseen("R[10]", R[10])
            end
          else
            unseen("R[10]", R[10])
          end
        elseif R[10] == 5 then
        else
          unseen("R[10]", R[10])
        end
      elseif R[10] == 3 then
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[10]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      players[2]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[10]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[10]] })
      if R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[10]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[10]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[10]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 0 or R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 43, [3] = 247 })[R[10]], ({ [0] = 201, [3] = 89 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 58, [3] = 252 })[R[10]], ({ [0] = 194, [3] = 97 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        elseif R[10] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[10]", R[10])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[10]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 5 or R[10] == 6 then
      elseif R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[2]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[10]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 0 or R[10] == 2 or R[10] == 3 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[10]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[10]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[10] == 2 or R[10] == 3 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[10]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 or LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[2].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[11] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[11]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[11]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[12] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[12]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[12]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[13] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[13]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[13]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[14] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[14]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[14]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[15] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[15]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[15]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[16] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[16]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[17] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[17]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[17]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[18]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[18]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[19] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[19]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[19]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 114, 50 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 160, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 59, 204 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 430, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 315, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 238, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 454, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 431, 79 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 380, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 393, 67 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 380, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 331, 69 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 364, 107 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 353, 137 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 293, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 343, 173 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 314, 209 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 384, 215 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 244, 168 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 213, 229 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 182, 184 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 153, 230 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 131, 187 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 82, 247 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 14, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 150 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 90, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 15, 146 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 10, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 497, 154 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 507, 213 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 465, 245 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 437, 225 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 393, 241 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 501, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 70, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 110, 13 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 196, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 182, 87 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 228, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 257, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 438, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 390, 153 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 12, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 156, 22 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 325, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 406, 104 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 484, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 500, 113 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 219 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 193, 105 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 103, 104 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 264, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 156, 131 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 49, 179 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 101, 57 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 456, 195 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 417, 9 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 176, 129 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 214, 185 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 449, 44 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 467, 28 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 360, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 351, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 470, 207 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 383, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 267, 140 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 311, 87 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 119, 53 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 87, 68 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 54, 162 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 129, 91 } }
    R[0] = game.rand(7)
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[0]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[0]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[0]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[0]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[0]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[0]] })
    if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 5 or R[0] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[0]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[0]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[0]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[0]] })
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 5 or R[0] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[0]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[0]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[0]] })
        if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[0]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[0]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[0]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[0]] })
          if R[0] == 0 or R[0] == 1 or R[0] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[0]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[0]] })
            if R[0] == 0 then
            elseif R[0] == 1 or R[0] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[0]], ({ [1] = 31, [2] = 160 })[R[0]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[0]], ({ [1] = 32, [2] = 160 })[R[0]] })
              if R[0] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[0] == 1 then
              else
                unseen("R[0]", R[0])
              end
            else
              unseen("R[0]", R[0])
            end
          elseif R[0] == 6 then
          else
            unseen("R[0]", R[0])
          end
        elseif R[0] == 5 then
        else
          unseen("R[0]", R[0])
        end
      elseif R[0] == 3 then
      else
        unseen("R[0]", R[0])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[0]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      players[1]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[0]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[0]] })
      if R[0] == 0 or R[0] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 43, [3] = 247 })[R[0]], ({ [0] = 201, [3] = 89 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [3] = 252 })[R[0]], ({ [0] = 194, [3] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[0] == 0 then
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
        elseif R[0] == 3 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[0]", R[0])
        end
      elseif R[0] == 1 or R[0] == 2 or R[0] == 5 or R[0] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[0]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[0]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[0]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[0]", R[0])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[0]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[0] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      elseif R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 5 or R[0] == 6 then
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[1]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[0]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[0]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[0]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[0] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 or LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[0]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[1].difficulty] == 2 then
      elseif LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if R[0] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[20] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[20]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[20]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[21] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[21]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[21]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[22] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[22]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[22]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[0] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[23] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[23]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[23]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[24] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[24]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[24]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[25] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[25]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[25]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[26] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[26]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[26]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[27]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[27]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[28]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[28]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[0]", R[0])
    end
    R[10] = draw_avoid(7, { R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[10]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[10]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[10]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[10]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[10]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[10]] })
    if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 5 or R[10] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[10]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[10]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[10]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[10]] })
      if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[10]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[10]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[10]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[10]] })
        if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[10]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[10]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[10]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[10]] })
          if R[10] == 6 then
          elseif R[10] == 0 or R[10] == 1 or R[10] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[10]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[10]] })
            if R[10] == 0 then
            elseif R[10] == 1 or R[10] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[10]], ({ [1] = 31, [2] = 160 })[R[10]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[10]], ({ [1] = 32, [2] = 160 })[R[10]] })
              if R[10] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[10] == 1 then
              else
                unseen("R[10]", R[10])
              end
            else
              unseen("R[10]", R[10])
            end
          else
            unseen("R[10]", R[10])
          end
        elseif R[10] == 5 then
        else
          unseen("R[10]", R[10])
        end
      elseif R[10] == 3 then
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[10]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      players[2]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[10]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[10]] })
      if R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[10]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[10]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[10]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 0 or R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 43, [3] = 247 })[R[10]], ({ [0] = 201, [3] = 89 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 58, [3] = 252 })[R[10]], ({ [0] = 194, [3] = 97 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        elseif R[10] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[10]", R[10])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[10]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 5 or R[10] == 6 then
      elseif R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[2]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[10]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 0 or R[10] == 2 or R[10] == 3 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[10]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[10]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[10] == 2 or R[10] == 3 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[10]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 or LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[2].difficulty] == 2 then
      elseif LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[2].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[29] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[29]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[29]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[30] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[30]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[30]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[31] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[31]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[31]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[32]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[32]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[33]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[33]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[34]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[34]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[35] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[35]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[36] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[36]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[37] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[37]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[37]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    R[38] = draw_avoid(7, { R[10], R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[38]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[38]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[38]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[38]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[38]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[38]] })
    if R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 3 or R[38] == 5 or R[38] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[38]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[38]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[38]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[38]] })
      if R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 5 or R[38] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[38]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[38]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[38]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[38]] })
        if R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[38]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[38]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[38]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[38]] })
          if R[38] == 0 or R[38] == 1 or R[38] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[38]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[38]] })
            if R[38] == 1 or R[38] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[38]], ({ [1] = 31, [2] = 160 })[R[38]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[38]], ({ [1] = 32, [2] = 160 })[R[38]] })
              if R[38] == 1 then
              elseif R[38] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              else
                unseen("R[38]", R[38])
              end
            elseif R[38] == 0 then
            else
              unseen("R[38]", R[38])
            end
          elseif R[38] == 6 then
          else
            unseen("R[38]", R[38])
          end
        elseif R[38] == 5 then
        else
          unseen("R[38]", R[38])
        end
      elseif R[38] == 3 then
      else
        unseen("R[38]", R[38])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[38]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      players[3]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[38]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[38]] })
      if R[38] == 1 or R[38] == 2 or R[38] == 5 or R[38] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[38]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[38]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[38]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[38] == 0 or R[38] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 43, [3] = 247 })[R[38]], ({ [0] = 201, [3] = 89 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 58, [3] = 252 })[R[38]], ({ [0] = 194, [3] = 97 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        if R[38] == 0 then
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
        elseif R[38] == 3 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[38]", R[38])
        end
      else
        unseen("R[38]", R[38])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[38]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      if R[38] == 1 or R[38] == 2 or R[38] == 3 or R[38] == 5 or R[38] == 6 then
      elseif R[38] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[38]", R[38])
      end
    elseif R[38] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[3]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[38]", R[38])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[38]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
    if R[38] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[3].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif LEVEL_OF[players[3].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    elseif R[38] == 0 or R[38] == 2 or R[38] == 3 or R[38] == 4 or R[38] == 5 or R[38] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[38]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[38]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[38] == 2 or R[38] == 3 or R[38] == 4 or R[38] == 5 or R[38] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[38]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[38] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 or LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[38]", R[38])
      end
    else
      unseen("R[38]", R[38])
    end
    U[#U]:set_lights(true)
    if R[38] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[39] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[39]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[39]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[40] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[40]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[40]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[41] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[41]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[41]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[38] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[42]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[42]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[43]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[43]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[44]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[44]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[45]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[45]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[46] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[46]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[46]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[47]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[47]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[38]", R[38])
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
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 114, 50 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 160, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 59, 204 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 430, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 315, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 238, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 454, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 431, 79 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 380, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 393, 67 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 380, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 331, 69 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 364, 107 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 353, 137 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 293, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 343, 173 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 314, 209 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 384, 215 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 244, 168 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 213, 229 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 182, 184 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 153, 230 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 131, 187 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 82, 247 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 14, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 150 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 90, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 15, 146 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 10, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 497, 154 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 507, 213 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 465, 245 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 437, 225 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 393, 241 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 501, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 70, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 110, 13 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 196, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 182, 87 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 228, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 257, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 438, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 390, 153 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 12, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 156, 22 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 325, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 406, 104 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 484, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 500, 113 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 219 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 193, 105 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 103, 104 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 264, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 156, 131 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 49, 179 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 101, 57 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 456, 195 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 417, 9 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 176, 129 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 214, 185 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 449, 44 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 467, 28 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 360, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 351, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 470, 207 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 383, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 267, 140 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 311, 87 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 119, 53 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 87, 68 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 54, 162 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 129, 91 } }
    R[0] = game.rand(7)
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[0]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[0]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[0]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[0]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[0]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[0]] })
    if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 5 or R[0] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[0]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[0]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[0]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[0]] })
      if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 5 or R[0] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[0]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[0]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[0]] })
        if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[0]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[0]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[0]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[0]] })
          if R[0] == 6 then
          elseif R[0] == 0 or R[0] == 1 or R[0] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[0]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[0]] })
            if R[0] == 0 then
            elseif R[0] == 1 or R[0] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[0]], ({ [1] = 31, [2] = 160 })[R[0]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[0]], ({ [1] = 32, [2] = 160 })[R[0]] })
              if R[0] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[0] == 1 then
              else
                unseen("R[0]", R[0])
              end
            else
              unseen("R[0]", R[0])
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[0] == 5 then
        else
          unseen("R[0]", R[0])
        end
      elseif R[0] == 3 then
      else
        unseen("R[0]", R[0])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[0]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      players[1]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[0]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[0]] })
      if R[0] == 1 or R[0] == 2 or R[0] == 5 or R[0] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[0]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[0]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[0]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[0] == 0 or R[0] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 43, [3] = 247 })[R[0]], ({ [0] = 201, [3] = 89 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [3] = 252 })[R[0]], ({ [0] = 194, [3] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[0] == 0 then
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
        elseif R[0] == 3 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[0]", R[0])
        end
      else
        unseen("R[0]", R[0])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[0]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 5 or R[0] == 6 then
      elseif R[0] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[1]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[0]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[0]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[0]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[0]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[0] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 or LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if R[0] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[48] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[48]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[48]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[49] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[49]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[49]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[50] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[50]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[50]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[0] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[51]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[51]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[52]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[52]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[53] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[53]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[53]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[54]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[54]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[55]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[55]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[56]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[56]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[0]", R[0])
    end
    R[10] = draw_avoid(7, { R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[10]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[10]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[10]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[10]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[10]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[10]] })
    if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 5 or R[10] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[10]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[10]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[10]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[10]] })
      if R[10] == 3 then
      elseif R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[10]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[10]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[10]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[10]] })
        if R[10] == 5 then
        elseif R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[10]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[10]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[10]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[10]] })
          if R[10] == 0 or R[10] == 1 or R[10] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[10]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[10]] })
            if R[10] == 1 or R[10] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[10]], ({ [1] = 31, [2] = 160 })[R[10]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[10]], ({ [1] = 32, [2] = 160 })[R[10]] })
              if R[10] == 1 then
              elseif R[10] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              else
                unseen("R[10]", R[10])
              end
            elseif R[10] == 0 then
            else
              unseen("R[10]", R[10])
            end
          elseif R[10] == 6 then
          else
            unseen("R[10]", R[10])
          end
        else
          unseen("R[10]", R[10])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[10]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      players[2]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[10]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[10]] })
      if R[10] == 0 or R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 43, [3] = 247 })[R[10]], ({ [0] = 201, [3] = 89 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 58, [3] = 252 })[R[10]], ({ [0] = 194, [3] = 97 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        elseif R[10] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[10]", R[10])
        end
      elseif R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[10]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[10]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[10]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[10]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 5 or R[10] == 6 then
      elseif R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[2]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[10]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 0 or R[10] == 2 or R[10] == 3 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[10]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[10]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[10] == 2 or R[10] == 3 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[10]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 or LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[2].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[57] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[57]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[57]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[58] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[58]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[58]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[59] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[59]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[59]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[60]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[60]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[61]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[61]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[62] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[62]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[63]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[63]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[64]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[64]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[65]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[65]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    R[38] = draw_avoid(7, { R[10], R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[38]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[38]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[38]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[38]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[38]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[38]] })
    if R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 3 or R[38] == 5 or R[38] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[38]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[38]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[38]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[38]] })
      if R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 5 or R[38] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[38]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[38]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[38]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[38]] })
        if R[38] == 5 then
        elseif R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[38]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[38]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[38]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[38]] })
          if R[38] == 0 or R[38] == 1 or R[38] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[38]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[38]] })
            if R[38] == 0 then
            elseif R[38] == 1 or R[38] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[38]], ({ [1] = 31, [2] = 160 })[R[38]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[38]], ({ [1] = 32, [2] = 160 })[R[38]] })
              if R[38] == 1 then
              elseif R[38] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              else
                unseen("R[38]", R[38])
              end
            else
              unseen("R[38]", R[38])
            end
          elseif R[38] == 6 then
          else
            unseen("R[38]", R[38])
          end
        else
          unseen("R[38]", R[38])
        end
      elseif R[38] == 3 then
      else
        unseen("R[38]", R[38])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[38]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      players[3]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[38]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[38]] })
      if R[38] == 1 or R[38] == 2 or R[38] == 5 or R[38] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[38]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[38]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[38]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[38] == 0 or R[38] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 43, [3] = 247 })[R[38]], ({ [0] = 201, [3] = 89 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 58, [3] = 252 })[R[38]], ({ [0] = 194, [3] = 97 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        if R[38] == 0 then
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
        elseif R[38] == 3 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[38]", R[38])
        end
      else
        unseen("R[38]", R[38])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[38]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      if R[38] == 1 or R[38] == 2 or R[38] == 3 or R[38] == 5 or R[38] == 6 then
      elseif R[38] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[38]", R[38])
      end
    elseif R[38] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[3]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[38]", R[38])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[38]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
    if R[38] == 0 or R[38] == 2 or R[38] == 3 or R[38] == 4 or R[38] == 5 or R[38] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[38]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[38]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[38] == 2 or R[38] == 3 or R[38] == 4 or R[38] == 5 or R[38] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[38]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[38] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 or LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[38]", R[38])
      end
    elseif R[38] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[3].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif LEVEL_OF[players[3].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[38]", R[38])
    end
    U[#U]:set_lights(true)
    if R[38] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[66] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[66]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[66]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[67] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[67]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[67]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[68] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[68]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[68]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[38] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[69]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[69]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[70]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[70]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[71] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[71]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[71]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[72]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[72]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[73]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[73]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[74]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[74]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[38]", R[38])
    end
    R[75] = draw_avoid(7, { R[38], R[10], R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[75]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[75]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[75]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[75]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[75]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[75]] })
    if R[75] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[4]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    elseif R[75] == 0 or R[75] == 1 or R[75] == 2 or R[75] == 3 or R[75] == 5 or R[75] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[75]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[75]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[75]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[75]] })
      if R[75] == 0 or R[75] == 1 or R[75] == 2 or R[75] == 5 or R[75] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[75]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[75]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[75]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[75]] })
        if R[75] == 0 or R[75] == 1 or R[75] == 2 or R[75] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[75]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[75]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[75]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[75]] })
          if R[75] == 6 then
          elseif R[75] == 0 or R[75] == 1 or R[75] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[75]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[75]] })
            if R[75] == 1 or R[75] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[75]], ({ [1] = 31, [2] = 160 })[R[75]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[75]], ({ [1] = 32, [2] = 160 })[R[75]] })
              if R[75] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[75] == 1 then
              else
                unseen("R[75]", R[75])
              end
            elseif R[75] == 0 then
            else
              unseen("R[75]", R[75])
            end
          else
            unseen("R[75]", R[75])
          end
        elseif R[75] == 5 then
        else
          unseen("R[75]", R[75])
        end
      elseif R[75] == 3 then
      else
        unseen("R[75]", R[75])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[75]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      players[4]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[75]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[75]] })
      if R[75] == 1 or R[75] == 2 or R[75] == 5 or R[75] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[75]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[75]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[75]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[75] == 0 or R[75] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 43, [3] = 247 })[R[75]], ({ [0] = 201, [3] = 89 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 58, [3] = 252 })[R[75]], ({ [0] = 194, [3] = 97 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        if R[75] == 0 then
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
        elseif R[75] == 3 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        else
          unseen("R[75]", R[75])
        end
      else
        unseen("R[75]", R[75])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[75]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      if R[75] == 1 or R[75] == 2 or R[75] == 3 or R[75] == 5 or R[75] == 6 then
      elseif R[75] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[75]", R[75])
      end
    else
      unseen("R[75]", R[75])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[75]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
    if R[75] == 0 or R[75] == 2 or R[75] == 3 or R[75] == 4 or R[75] == 5 or R[75] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[75]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[75]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[75] == 2 or R[75] == 3 or R[75] == 4 or R[75] == 5 or R[75] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[75]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[75]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[75]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[4].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[75]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[75] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 1 or LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[75]", R[75])
      end
    elseif R[75] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[4].difficulty] == 1 then
        elseif LEVEL_OF[players[4].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif LEVEL_OF[players[4].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[75]", R[75])
    end
    U[#U]:set_lights(true)
    if R[75] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[76] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[76]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[76]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[4].difficulty] == 1 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[77] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[77]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[77]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[78] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[78]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[78]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[75] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[79]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[79]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[80] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[80]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[80]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[81] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[81]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[81]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[82] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[82]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[82]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[83] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[83]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[83]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[84] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[84]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[84]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[75]", R[75])
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
  elseif n == 5 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 114, 50 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 160, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 59, 204 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 430, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 315, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 238, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 454, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 431, 79 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 380, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 393, 67 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 380, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 331, 69 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 364, 107 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 353, 137 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 293, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 343, 173 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 314, 209 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 384, 215 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 244, 168 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 213, 229 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 182, 184 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 153, 230 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 131, 187 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 82, 247 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 14, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 150 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 90, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 15, 146 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 10, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 497, 154 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 507, 213 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 465, 245 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 437, 225 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 393, 241 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 501, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 70, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 110, 13 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 196, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 182, 87 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 228, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 257, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 438, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 390, 153 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 12, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 156, 22 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 325, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 406, 104 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 484, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 500, 113 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 219 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 193, 105 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 103, 104 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 264, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 156, 131 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 49, 179 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 101, 57 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 456, 195 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 417, 9 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 176, 129 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 214, 185 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 449, 44 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 467, 28 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 360, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 351, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 470, 207 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 383, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 267, 140 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 311, 87 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 119, 53 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 87, 68 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 54, 162 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 129, 91 } }
    R[0] = game.rand(7)
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[0]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[0]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[0]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[0]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[0]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[0]] })
    if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 5 or R[0] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[0]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[0]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[0]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[0]] })
      if R[0] == 3 then
      elseif R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 5 or R[0] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[0]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[0]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[0]] })
        if R[0] == 5 then
        elseif R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[0]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[0]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[0]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[0]] })
          if R[0] == 0 or R[0] == 1 or R[0] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[0]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[0]] })
            if R[0] == 1 or R[0] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[0]], ({ [1] = 31, [2] = 160 })[R[0]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[0]], ({ [1] = 32, [2] = 160 })[R[0]] })
              if R[0] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[0] == 1 then
              else
                unseen("R[0]", R[0])
              end
            elseif R[0] == 0 then
            else
              unseen("R[0]", R[0])
            end
          elseif R[0] == 6 then
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[0]", R[0])
        end
      else
        unseen("R[0]", R[0])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[0]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      players[1]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[0]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[0]] })
      if R[0] == 0 or R[0] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 43, [3] = 247 })[R[0]], ({ [0] = 201, [3] = 89 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [3] = 252 })[R[0]], ({ [0] = 194, [3] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[0] == 0 then
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
        elseif R[0] == 3 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[0]", R[0])
        end
      elseif R[0] == 1 or R[0] == 2 or R[0] == 5 or R[0] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[0]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[0]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[0]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[0]", R[0])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[0]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 5 or R[0] == 6 then
      elseif R[0] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[1]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[0]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[0]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[0]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[0]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[0] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 or LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if R[0] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[85] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[85]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[85]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[86] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[86]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[86]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[87] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[87]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[87]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[0] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[88] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[88]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[88]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[89] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[89]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[89]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[90] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[90]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[90]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[91] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[91]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[91]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[92] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[92]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[92]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[93] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[93]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[93]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[0]", R[0])
    end
    R[10] = draw_avoid(7, { R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[10]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[10]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[10]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[10]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[10]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[10]] })
    if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 5 or R[10] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[10]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[10]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[10]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[10]] })
      if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[10]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[10]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[10]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[10]] })
        if R[10] == 5 then
        elseif R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[10]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[10]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[10]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[10]] })
          if R[10] == 0 or R[10] == 1 or R[10] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[10]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[10]] })
            if R[10] == 0 then
            elseif R[10] == 1 or R[10] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[10]], ({ [1] = 31, [2] = 160 })[R[10]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[10]], ({ [1] = 32, [2] = 160 })[R[10]] })
              if R[10] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[10] == 1 then
              else
                unseen("R[10]", R[10])
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[10] == 6 then
          else
            unseen("R[10]", R[10])
          end
        else
          unseen("R[10]", R[10])
        end
      elseif R[10] == 3 then
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[10]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      players[2]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[10]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[10]] })
      if R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[10]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[10]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[10]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 0 or R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 43, [3] = 247 })[R[10]], ({ [0] = 201, [3] = 89 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 58, [3] = 252 })[R[10]], ({ [0] = 194, [3] = 97 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        elseif R[10] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[10]", R[10])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[10]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 5 or R[10] == 6 then
      elseif R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[2]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[10]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 0 or R[10] == 2 or R[10] == 3 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[10]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[10]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[10] == 2 or R[10] == 3 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[10]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 or LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[2].difficulty] == 2 then
      elseif LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[2].difficulty] == 1 then
        elseif LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[94] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[94]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[94]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[95] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[95]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[95]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[96] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[96]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[96]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[97] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[97]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[97]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[98] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[98]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[98]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[99] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[99]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[99]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[100] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[100]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[100]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[101] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[101]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[101]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[102] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[102]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[102]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    R[38] = draw_avoid(7, { R[10], R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[38]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[38]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[38]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[38]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[38]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[38]] })
    if R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 3 or R[38] == 5 or R[38] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[38]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[38]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[38]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[38]] })
      if R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 5 or R[38] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[38]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[38]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[38]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[38]] })
        if R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[38]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[38]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[38]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[38]] })
          if R[38] == 0 or R[38] == 1 or R[38] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[38]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[38]] })
            if R[38] == 0 then
            elseif R[38] == 1 or R[38] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[38]], ({ [1] = 31, [2] = 160 })[R[38]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[38]], ({ [1] = 32, [2] = 160 })[R[38]] })
              if R[38] == 1 then
              elseif R[38] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              else
                unseen("R[38]", R[38])
              end
            else
              unseen("R[38]", R[38])
            end
          elseif R[38] == 6 then
          else
            unseen("R[38]", R[38])
          end
        elseif R[38] == 5 then
        else
          unseen("R[38]", R[38])
        end
      elseif R[38] == 3 then
      else
        unseen("R[38]", R[38])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[38]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      players[3]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[38]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[38]] })
      if R[38] == 0 or R[38] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 43, [3] = 247 })[R[38]], ({ [0] = 201, [3] = 89 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 58, [3] = 252 })[R[38]], ({ [0] = 194, [3] = 97 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        if R[38] == 0 then
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
        elseif R[38] == 3 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[38]", R[38])
        end
      elseif R[38] == 1 or R[38] == 2 or R[38] == 5 or R[38] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[38]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[38]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[38]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[38]", R[38])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[38]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      if R[38] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      elseif R[38] == 1 or R[38] == 2 or R[38] == 3 or R[38] == 5 or R[38] == 6 then
      else
        unseen("R[38]", R[38])
      end
    elseif R[38] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[3]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[38]", R[38])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[38]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
    if R[38] == 0 or R[38] == 2 or R[38] == 3 or R[38] == 4 or R[38] == 5 or R[38] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[38]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[38]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[38] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 or LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[38] == 2 or R[38] == 3 or R[38] == 4 or R[38] == 5 or R[38] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[38]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[38]", R[38])
      end
    elseif R[38] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[3].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif LEVEL_OF[players[3].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[38]", R[38])
    end
    U[#U]:set_lights(true)
    if R[38] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[103] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[103]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[103]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[104] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[104]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[104]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[105] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[105]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[105]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[38] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[106] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[106]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[106]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[107] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[107]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[107]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[108] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[108]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[108]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[109] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[109]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[109]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[110] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[110]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[110]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[111] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[111]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[111]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[38]", R[38])
    end
    R[75] = draw_avoid(7, { R[38], R[10], R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[75]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[75]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[75]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[75]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[75]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[75]] })
    if R[75] == 0 or R[75] == 1 or R[75] == 2 or R[75] == 3 or R[75] == 5 or R[75] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[75]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[75]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[75]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[75]] })
      if R[75] == 0 or R[75] == 1 or R[75] == 2 or R[75] == 5 or R[75] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[75]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[75]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[75]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[75]] })
        if R[75] == 0 or R[75] == 1 or R[75] == 2 or R[75] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[75]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[75]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[75]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[75]] })
          if R[75] == 0 or R[75] == 1 or R[75] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[75]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[75]] })
            if R[75] == 1 or R[75] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[75]], ({ [1] = 31, [2] = 160 })[R[75]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[75]], ({ [1] = 32, [2] = 160 })[R[75]] })
              if R[75] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[75] == 1 then
              else
                unseen("R[75]", R[75])
              end
            elseif R[75] == 0 then
            else
              unseen("R[75]", R[75])
            end
          elseif R[75] == 6 then
          else
            unseen("R[75]", R[75])
          end
        elseif R[75] == 5 then
        else
          unseen("R[75]", R[75])
        end
      elseif R[75] == 3 then
      else
        unseen("R[75]", R[75])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[75]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      players[4]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[75]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[75]] })
      if R[75] == 1 or R[75] == 2 or R[75] == 5 or R[75] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[75]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[75]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[75]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[75] == 0 or R[75] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 43, [3] = 247 })[R[75]], ({ [0] = 201, [3] = 89 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 58, [3] = 252 })[R[75]], ({ [0] = 194, [3] = 97 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        if R[75] == 0 then
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
        elseif R[75] == 3 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        else
          unseen("R[75]", R[75])
        end
      else
        unseen("R[75]", R[75])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[75]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      if R[75] == 1 or R[75] == 2 or R[75] == 3 or R[75] == 5 or R[75] == 6 then
      elseif R[75] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[75]", R[75])
      end
    elseif R[75] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[4]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[75]", R[75])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[75]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
    if R[75] == 0 or R[75] == 2 or R[75] == 3 or R[75] == 4 or R[75] == 5 or R[75] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[75]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[75]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[75] == 2 or R[75] == 3 or R[75] == 4 or R[75] == 5 or R[75] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[75]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[75]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[75]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[4].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[75]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[75] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[4].difficulty] == 1 or LEVEL_OF[players[4].difficulty] == 2 then
        elseif LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[75]", R[75])
      end
    elseif R[75] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[4].difficulty] == 2 then
      elseif LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[4].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[75]", R[75])
    end
    U[#U]:set_lights(true)
    if R[75] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[112] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[112]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[112]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[4].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[113] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[113]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[113]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[114] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[114]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[114]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[75] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[115] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[115]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[115]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[116] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[116]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[116]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[117] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[117]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[117]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[118] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[118]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[118]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[119] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[119]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[119]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[120] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[120]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[120]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[75]", R[75])
    end
    R[121] = draw_avoid(7, { R[75], R[38], R[10], R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[121]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[121]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[121]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[121]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[121]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[121]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[121]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[121]] })
    if R[121] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[5], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[5], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[5], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[5]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[5], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    elseif R[121] == 0 or R[121] == 1 or R[121] == 2 or R[121] == 3 or R[121] == 5 or R[121] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[121]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[121]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[121]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[121]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[121]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[121]] })
      if R[121] == 0 or R[121] == 1 or R[121] == 2 or R[121] == 5 or R[121] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[121]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[121]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[121]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[121]] })
        if R[121] == 0 or R[121] == 1 or R[121] == 2 or R[121] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[121]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[121]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[121]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[121]] })
          if R[121] == 0 or R[121] == 1 or R[121] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[121]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[121]] })
            if R[121] == 1 or R[121] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[121]], ({ [1] = 31, [2] = 160 })[R[121]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[121]], ({ [1] = 32, [2] = 160 })[R[121]] })
              if R[121] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[121] == 1 then
              else
                unseen("R[121]", R[121])
              end
            elseif R[121] == 0 then
            else
              unseen("R[121]", R[121])
            end
          elseif R[121] == 6 then
          else
            unseen("R[121]", R[121])
          end
        elseif R[121] == 5 then
        else
          unseen("R[121]", R[121])
        end
      elseif R[121] == 3 then
      else
        unseen("R[121]", R[121])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[5], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[121]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      players[5]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[121]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[121]] })
      if R[121] == 1 or R[121] == 2 or R[121] == 5 or R[121] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[5], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[121]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[5], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[121]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[121]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[121] == 0 or R[121] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[5], at = { ({ [0] = 43, [3] = 247 })[R[121]], ({ [0] = 201, [3] = 89 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[5], at = { ({ [0] = 58, [3] = 252 })[R[121]], ({ [0] = 194, [3] = 97 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
        if R[121] == 0 then
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
        elseif R[121] == 3 then
          if LEVEL_OF[players[5].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[5].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[5].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
          end
        else
          unseen("R[121]", R[121])
        end
      else
        unseen("R[121]", R[121])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[5], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[121]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      if R[121] == 1 or R[121] == 2 or R[121] == 3 or R[121] == 5 or R[121] == 6 then
      elseif R[121] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[121]", R[121])
      end
    else
      unseen("R[121]", R[121])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[5], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[121]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
    if R[121] == 0 or R[121] == 2 or R[121] == 3 or R[121] == 4 or R[121] == 5 or R[121] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[121]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[121]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[121] == 2 or R[121] == 3 or R[121] == 4 or R[121] == 5 or R[121] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[121]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[5].difficulty] == 0 or LEVEL_OF[players[5].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[121]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[5].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[121]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[5].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
          end
        elseif LEVEL_OF[players[5].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[5], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[121]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[121] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[5], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[5].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[5].difficulty] == 1 or LEVEL_OF[players[5].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
        end
      else
        unseen("R[121]", R[121])
      end
    elseif R[121] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[5].difficulty] == 0 or LEVEL_OF[players[5].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[5].difficulty] == 1 then
        elseif LEVEL_OF[players[5].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
        end
      elseif LEVEL_OF[players[5].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[5], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[121]", R[121])
    end
    U[#U]:set_lights(true)
    if R[121] == 0 then
      if LEVEL_OF[players[5].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[122] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[122]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[122]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[5].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[123] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[123]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[123]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[5].difficulty] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[124] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[124]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[124]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
      end
    elseif R[121] == 1 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[125] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[125]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[125]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[121] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[126] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[126]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[126]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[121] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[127] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[127]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[127]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[121] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[128] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[128]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[128]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[121] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[129] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[129]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[129]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[121] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[130] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[130]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[130]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[121]", R[121])
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
    players[({ [0] = 3, [1] = 3, [2] = 4 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[4]:mark_research(3305)
      players[({ [0] = 3, [1] = 4 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[5].difficulty] == 0 then
        players[5]:mark_research(3303)
      elseif LEVEL_OF[players[5].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[5].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[5].difficulty]]
    players[5].scientists = 18 - 3 * LEVEL_OF[players[5].difficulty]
    players[5].kids = 22 - 2 * LEVEL_OF[players[5].difficulty]
    players[5].food = 3000 - 1000 * LEVEL_OF[players[5].difficulty]
    players[5].ore = 6000 - 2000 * LEVEL_OF[players[5].difficulty]
    if LEVEL_OF[players[5].difficulty] == 0 or LEVEL_OF[players[5].difficulty] == 1 then
      players[5]:mark_research(3304)
      players[5]:mark_research(3305)
      if LEVEL_OF[players[5].difficulty] == 0 then
        players[5]:mark_research(3401)
      elseif LEVEL_OF[players[5].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
      end
    elseif LEVEL_OF[players[5].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
    end
    game.set_daylight_everywhere(({ [0] = 1, [1] = 0 })[(game.uses_day_night() and 1 or 0)] ~= 0)
    if (game.uses_morale() and 1 or 0) == 0 then
      game.morale_steady("Good")
    elseif (game.uses_morale() and 1 or 0) == 1 then
      game.free_morale()
    else
      unseen("(game.uses_morale() and 1 or 0)", (game.uses_morale() and 1 or 0))
    end
  elseif n == 6 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 114, 50 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 160, 171 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 59, 204 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 430, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 315, 42 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 238, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 454, 6 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 431, 79 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 380, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 393, 67 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 380, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 331, 69 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 364, 107 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 353, 137 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 293, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 343, 173 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 314, 209 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 384, 215 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 244, 168 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 213, 229 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 182, 184 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 153, 230 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 131, 187 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 82, 247 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 14, 240 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 150 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 90, 108 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 15, 146 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 10, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 497, 154 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 507, 213 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 465, 245 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 437, 225 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 393, 241 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 501, 21 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 36, 54 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 70, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 110, 13 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 196, 20 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 182, 87 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 228, 70 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 257, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 438, 122 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 390, 153 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 12, 74 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 156, 22 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 325, 124 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 406, 104 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 484, 63 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 500, 113 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 109, 219 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 193, 105 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 103, 104 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 264, 80 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 156, 131 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 49, 179 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 101, 57 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 456, 195 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 417, 9 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 176, 129 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 214, 185 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 449, 44 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 467, 28 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 360, 56 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 351, 27 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 470, 207 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 383, 178 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 267, 140 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 311, 87 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 119, 53 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 87, 68 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 54, 162 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 129, 91 } }
    R[0] = game.rand(7)
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[0]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[0]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[0]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[0]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[0]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[0]] })
    if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 5 or R[0] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[0]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[0]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[0]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[0]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[0]] })
      if R[0] == 3 then
      elseif R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 5 or R[0] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[0]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[0]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[0]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[0]] })
        if R[0] == 0 or R[0] == 1 or R[0] == 2 or R[0] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[0]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[0]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[0]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[0]] })
          if R[0] == 0 or R[0] == 1 or R[0] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[0]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[0]] })
            if R[0] == 1 or R[0] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[0]], ({ [1] = 31, [2] = 160 })[R[0]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[0]], ({ [1] = 32, [2] = 160 })[R[0]] })
              if R[0] == 1 then
              elseif R[0] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              else
                unseen("R[0]", R[0])
              end
            elseif R[0] == 0 then
            else
              unseen("R[0]", R[0])
            end
          elseif R[0] == 6 then
          else
            unseen("R[0]", R[0])
          end
        elseif R[0] == 5 then
        else
          unseen("R[0]", R[0])
        end
      else
        unseen("R[0]", R[0])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[0]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      players[1]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[0]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[0]] })
      if R[0] == 0 or R[0] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 43, [3] = 247 })[R[0]], ({ [0] = 201, [3] = 89 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [3] = 252 })[R[0]], ({ [0] = 194, [3] = 97 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        if R[0] == 0 then
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
        elseif R[0] == 3 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[0]", R[0])
        end
      elseif R[0] == 1 or R[0] == 2 or R[0] == 5 or R[0] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[0]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[0]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[0]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[0]", R[0])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[0]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      if R[0] == 1 or R[0] == 2 or R[0] == 3 or R[0] == 5 or R[0] == 6 then
      elseif R[0] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[1]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[0]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
    if R[0] == 0 or R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[0]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[0]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[0] == 2 or R[0] == 3 or R[0] == 4 or R[0] == 5 or R[0] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[0]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[0]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[0]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[0] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 or LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[0]", R[0])
      end
    elseif R[0] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[0]", R[0])
    end
    U[#U]:set_lights(true)
    if R[0] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[131] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[131]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[131]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[1].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[132] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[132]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[132]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[133] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[133]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[133]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[0] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[134] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[134]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[134]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[135] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[135]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[135]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[136] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[136]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[136]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[137] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[137]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[137]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[138] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[138]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[138]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[0] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[139] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[139]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[139]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[0]", R[0])
    end
    R[10] = draw_avoid(7, { R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[10]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[10]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[10]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[10]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[10]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[10]] })
    if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 5 or R[10] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[10]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[10]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[10]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[10]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[10]] })
      if R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[10]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[10]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[10]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[10]] })
        if R[10] == 5 then
        elseif R[10] == 0 or R[10] == 1 or R[10] == 2 or R[10] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[10]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[10]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[10]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[10]] })
          if R[10] == 6 then
          elseif R[10] == 0 or R[10] == 1 or R[10] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[10]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[10]] })
            if R[10] == 0 then
            elseif R[10] == 1 or R[10] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[10]], ({ [1] = 31, [2] = 160 })[R[10]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[10]], ({ [1] = 32, [2] = 160 })[R[10]] })
              if R[10] == 1 then
              elseif R[10] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              else
                unseen("R[10]", R[10])
              end
            else
              unseen("R[10]", R[10])
            end
          else
            unseen("R[10]", R[10])
          end
        else
          unseen("R[10]", R[10])
        end
      elseif R[10] == 3 then
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[10]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      players[2]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[10]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[10]] })
      if R[10] == 1 or R[10] == 2 or R[10] == 5 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[10]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[10]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[10]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 0 or R[10] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 43, [3] = 247 })[R[10]], ({ [0] = 201, [3] = 89 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 58, [3] = 252 })[R[10]], ({ [0] = 194, [3] = 97 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
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
        elseif R[10] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[10]", R[10])
        end
      else
        unseen("R[10]", R[10])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[10]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      if R[10] == 1 or R[10] == 2 or R[10] == 3 or R[10] == 5 or R[10] == 6 then
      elseif R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[2]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[10]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
    if R[10] == 0 or R[10] == 2 or R[10] == 3 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[10]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[10]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[10] == 2 or R[10] == 3 or R[10] == 4 or R[10] == 5 or R[10] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[10]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[10]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[10]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[10] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 or LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[10]", R[10])
      end
    elseif R[10] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[2].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif LEVEL_OF[players[2].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[10]", R[10])
    end
    U[#U]:set_lights(true)
    if R[10] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[140] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[140]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[140]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[2].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[141] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[141]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[141]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[142] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[142]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[142]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[10] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[143] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[143]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[143]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[144] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[144]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[144]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[145] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[145]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[145]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[146] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[146]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[146]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[147] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[147]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[147]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[10] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[148] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[148]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[148]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[10]", R[10])
    end
    R[38] = draw_avoid(7, { R[10], R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[38]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[38]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[38]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[38]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[38]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[38]] })
    if R[38] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[3]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    elseif R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 3 or R[38] == 5 or R[38] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[38]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[38]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[38]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[38]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[38]] })
      if R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 5 or R[38] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[38]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[38]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[38]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[38]] })
        if R[38] == 0 or R[38] == 1 or R[38] == 2 or R[38] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[38]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[38]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[38]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[38]] })
          if R[38] == 0 or R[38] == 1 or R[38] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[38]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[38]] })
            if R[38] == 0 then
            elseif R[38] == 1 or R[38] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[38]], ({ [1] = 31, [2] = 160 })[R[38]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[38]], ({ [1] = 32, [2] = 160 })[R[38]] })
              if R[38] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[38] == 1 then
              else
                unseen("R[38]", R[38])
              end
            else
              unseen("R[38]", R[38])
            end
          elseif R[38] == 6 then
          else
            unseen("R[38]", R[38])
          end
        elseif R[38] == 5 then
        else
          unseen("R[38]", R[38])
        end
      elseif R[38] == 3 then
      else
        unseen("R[38]", R[38])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[38]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      players[3]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[38]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[38]] })
      if R[38] == 0 or R[38] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 43, [3] = 247 })[R[38]], ({ [0] = 201, [3] = 89 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 58, [3] = 252 })[R[38]], ({ [0] = 194, [3] = 97 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        if R[38] == 0 then
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
        elseif R[38] == 3 then
          if LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[38]", R[38])
        end
      elseif R[38] == 1 or R[38] == 2 or R[38] == 5 or R[38] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[38]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[38]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[38]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[38]", R[38])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[38]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      if R[38] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      elseif R[38] == 1 or R[38] == 2 or R[38] == 3 or R[38] == 5 or R[38] == 6 then
      else
        unseen("R[38]", R[38])
      end
    else
      unseen("R[38]", R[38])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[38]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
    if R[38] == 0 or R[38] == 2 or R[38] == 3 or R[38] == 4 or R[38] == 5 or R[38] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[38]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[38]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[38] == 2 or R[38] == 3 or R[38] == 4 or R[38] == 5 or R[38] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[38]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[38]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[38]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[38] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 1 or LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[38]", R[38])
      end
    elseif R[38] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[3].difficulty] == 1 then
        elseif LEVEL_OF[players[3].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif LEVEL_OF[players[3].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[38]", R[38])
    end
    U[#U]:set_lights(true)
    if R[38] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[149] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[149]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[149]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[3].difficulty] == 1 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[150] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[150]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[150]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[151] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[151]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[151]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        elseif game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[38] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[152] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[152]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[152]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[153] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[153]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[153]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[154] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[154]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[154]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[155] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[155]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[155]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[156] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[156]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[156]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[38] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[157] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[157]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[157]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[38]", R[38])
    end
    R[75] = draw_avoid(7, { R[38], R[10], R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[75]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[75]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[75]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[75]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[75]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[75]] })
    if R[75] == 0 or R[75] == 1 or R[75] == 2 or R[75] == 3 or R[75] == 5 or R[75] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[75]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[75]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[75]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[75]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[75]] })
      if R[75] == 0 or R[75] == 1 or R[75] == 2 or R[75] == 5 or R[75] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[75]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[75]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[75]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[75]] })
        if R[75] == 0 or R[75] == 1 or R[75] == 2 or R[75] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[75]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[75]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[75]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[75]] })
          if R[75] == 0 or R[75] == 1 or R[75] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[75]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[75]] })
            if R[75] == 1 or R[75] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[75]], ({ [1] = 31, [2] = 160 })[R[75]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[75]], ({ [1] = 32, [2] = 160 })[R[75]] })
              if R[75] == 1 then
              elseif R[75] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              else
                unseen("R[75]", R[75])
              end
            elseif R[75] == 0 then
            else
              unseen("R[75]", R[75])
            end
          elseif R[75] == 6 then
          else
            unseen("R[75]", R[75])
          end
        elseif R[75] == 5 then
        else
          unseen("R[75]", R[75])
        end
      elseif R[75] == 3 then
      else
        unseen("R[75]", R[75])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[75]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      players[4]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[75]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[75]] })
      if R[75] == 1 or R[75] == 2 or R[75] == 5 or R[75] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[75]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[75]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[75]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[75] == 0 or R[75] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 43, [3] = 247 })[R[75]], ({ [0] = 201, [3] = 89 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 58, [3] = 252 })[R[75]], ({ [0] = 194, [3] = 97 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        if R[75] == 0 then
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
        elseif R[75] == 3 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        else
          unseen("R[75]", R[75])
        end
      else
        unseen("R[75]", R[75])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[75]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      if R[75] == 1 or R[75] == 2 or R[75] == 3 or R[75] == 5 or R[75] == 6 then
      elseif R[75] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[75]", R[75])
      end
    elseif R[75] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[4]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[75]", R[75])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[75]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
    if R[75] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[4].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif LEVEL_OF[players[4].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    elseif R[75] == 0 or R[75] == 2 or R[75] == 3 or R[75] == 4 or R[75] == 5 or R[75] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[75]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[75]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[75] == 2 or R[75] == 3 or R[75] == 4 or R[75] == 5 or R[75] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[75]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[75]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[75]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[4].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[75]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[75]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[75] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[4].difficulty] == 1 or LEVEL_OF[players[4].difficulty] == 2 then
        elseif LEVEL_OF[players[4].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[75]", R[75])
      end
    else
      unseen("R[75]", R[75])
    end
    U[#U]:set_lights(true)
    if R[75] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[158] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[158]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[158]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[4].difficulty] == 1 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[159] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[159]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[159]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[160] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[160]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[160]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[75] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[161] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[161]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[161]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[162] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[162]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[162]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[163] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[163]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[163]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[164] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[164]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[164]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[165] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[165]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[165]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[75] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[166] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[166]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[166]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[75]", R[75])
    end
    R[121] = draw_avoid(7, { R[75], R[38], R[10], R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[121]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[121]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[121]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[121]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[121]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[121]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[121]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[121]] })
    if R[121] == 0 or R[121] == 1 or R[121] == 2 or R[121] == 3 or R[121] == 5 or R[121] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[121]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[121]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[121]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[121]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[121]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[121]] })
      if R[121] == 0 or R[121] == 1 or R[121] == 2 or R[121] == 5 or R[121] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[121]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[121]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[121]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[121]] })
        if R[121] == 0 or R[121] == 1 or R[121] == 2 or R[121] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[121]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[121]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[121]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[121]] })
          if R[121] == 0 or R[121] == 1 or R[121] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[121]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[121]] })
            if R[121] == 1 or R[121] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[121]], ({ [1] = 31, [2] = 160 })[R[121]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[121]], ({ [1] = 32, [2] = 160 })[R[121]] })
              if R[121] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[121] == 1 then
              else
                unseen("R[121]", R[121])
              end
            elseif R[121] == 0 then
            else
              unseen("R[121]", R[121])
            end
          elseif R[121] == 6 then
          else
            unseen("R[121]", R[121])
          end
        elseif R[121] == 5 then
        else
          unseen("R[121]", R[121])
        end
      elseif R[121] == 3 then
      else
        unseen("R[121]", R[121])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[5], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[121]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      players[5]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[121]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[121]] })
      if R[121] == 1 or R[121] == 2 or R[121] == 5 or R[121] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[5], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[121]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[5], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[121]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[121]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[121] == 0 or R[121] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[5], at = { ({ [0] = 43, [3] = 247 })[R[121]], ({ [0] = 201, [3] = 89 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[5], at = { ({ [0] = 58, [3] = 252 })[R[121]], ({ [0] = 194, [3] = 97 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
        if R[121] == 0 then
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
        elseif R[121] == 3 then
          if LEVEL_OF[players[5].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[5].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[5].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
          end
        else
          unseen("R[121]", R[121])
        end
      else
        unseen("R[121]", R[121])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[5], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[121]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      if R[121] == 1 or R[121] == 2 or R[121] == 3 or R[121] == 5 or R[121] == 6 then
      elseif R[121] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[121]", R[121])
      end
    elseif R[121] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[5], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[5], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[5], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[5], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[5]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[5], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[121]", R[121])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[5], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[121]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
    if R[121] == 0 or R[121] == 2 or R[121] == 3 or R[121] == 4 or R[121] == 5 or R[121] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[121]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[121]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[121] == 2 or R[121] == 3 or R[121] == 4 or R[121] == 5 or R[121] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[121]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[5].difficulty] == 0 or LEVEL_OF[players[5].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[121]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[5].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[121]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[5].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
          end
        elseif LEVEL_OF[players[5].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[5], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[121]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[121]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[121] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[5], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[5].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[5].difficulty] == 1 or LEVEL_OF[players[5].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
        end
      else
        unseen("R[121]", R[121])
      end
    elseif R[121] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[5].difficulty] == 0 or LEVEL_OF[players[5].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[5].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[5].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
        end
      elseif LEVEL_OF[players[5].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[5], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[5], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[121]", R[121])
    end
    U[#U]:set_lights(true)
    if R[121] == 0 then
      if LEVEL_OF[players[5].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[167] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[167]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[167]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[5].difficulty] == 1 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[168] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[168]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[168]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[5].difficulty] == 2 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[5], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[169] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[169]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[169]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
      end
    elseif R[121] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[170] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[170]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[170]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[121] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[171] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[171]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[171]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[121] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[172] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[172]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[172]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[121] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[173] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[173]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[173]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[121] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[174] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[174]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[174]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[121] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[5], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[5], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[175] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[5], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[175]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[175]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[5].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[121]", R[121])
    end
    R[176] = draw_avoid(7, { R[121], R[75], R[38], R[10], R[0] })
    game.create_tube({ ({ [0] = 43, [1] = 97, [2] = 161, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[176]], ({ [0] = 198, [1] = 25, [2] = 152, [3] = 89, [4] = 55, [5] = 181, [6] = 28 })[R[176]] })
    game.create_tube({ ({ [0] = 43, [1] = 98, [2] = 162, [3] = 250, [4] = 321, [5] = 428, [6] = 424 })[R[176]], ({ [0] = 199, [1] = 25, [2] = 152, [3] = 90, [4] = 56, [5] = 188, [6] = 29 })[R[176]] })
    game.create_tube({ ({ [0] = 46, [1] = 99, [2] = 162, [3] = 250, [4] = 322, [5] = 429, [6] = 425 })[R[176]], ({ [0] = 201, [1] = 25, [2] = 153, [3] = 91, [4] = 60, [5] = 181, [6] = 28 })[R[176]] })
    game.create_tube({ ({ [0] = 47, [1] = 100, [2] = 162, [3] = 250, [4] = 324, [5] = 429, [6] = 428 })[R[176]], ({ [0] = 201, [1] = 25, [2] = 154, [3] = 92, [4] = 53, [5] = 182, [6] = 25 })[R[176]] })
    if R[176] == 0 or R[176] == 1 or R[176] == 2 or R[176] == 3 or R[176] == 5 or R[176] == 6 then
      game.create_tube({ ({ [0] = 48, [1] = 101, [2] = 162, [3] = 250, [5] = 429, [6] = 428 })[R[176]], ({ [0] = 201, [1] = 25, [2] = 155, [3] = 93, [5] = 183, [6] = 26 })[R[176]] })
      game.create_tube({ ({ [0] = 49, [1] = 102, [2] = 162, [3] = 250, [5] = 429, [6] = 429 })[R[176]], ({ [0] = 201, [1] = 25, [2] = 156, [3] = 94, [5] = 184, [6] = 25 })[R[176]] })
      game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [3] = 250, [5] = 432, [6] = 430 })[R[176]], ({ [0] = 197, [1] = 24, [2] = 158, [3] = 95, [5] = 176, [6] = 25 })[R[176]] })
      if R[176] == 0 or R[176] == 1 or R[176] == 2 or R[176] == 5 or R[176] == 6 then
        game.create_tube({ ({ [0] = 50, [1] = 108, [2] = 167, [5] = 432, [6] = 431 })[R[176]], ({ [0] = 198, [1] = 25, [2] = 159, [5] = 177, [6] = 25 })[R[176]] })
        game.create_tube({ ({ [0] = 50, [1] = 109, [2] = 167, [5] = 433, [6] = 432 })[R[176]], ({ [0] = 199, [1] = 25, [2] = 160, [5] = 176, [6] = 25 })[R[176]] })
        if R[176] == 0 or R[176] == 1 or R[176] == 2 or R[176] == 6 then
          game.create_tube({ ({ [0] = 53, [1] = 111, [2] = 167, [6] = 433 })[R[176]], ({ [0] = 195, [1] = 28, [2] = 161, [6] = 25 })[R[176]] })
          game.create_tube({ ({ [0] = 54, [1] = 111, [2] = 167, [6] = 435 })[R[176]], ({ [0] = 195, [1] = 29, [2] = 162, [6] = 23 })[R[176]] })
          if R[176] == 0 or R[176] == 1 or R[176] == 2 then
            game.create_tube({ ({ [0] = 55, [1] = 111, [2] = 168 })[R[176]], ({ [0] = 195, [1] = 30, [2] = 160 })[R[176]] })
            if R[176] == 0 then
            elseif R[176] == 1 or R[176] == 2 then
              game.create_tube({ ({ [1] = 111, [2] = 169 })[R[176]], ({ [1] = 31, [2] = 160 })[R[176]] })
              game.create_tube({ ({ [1] = 111, [2] = 170 })[R[176]], ({ [1] = 32, [2] = 160 })[R[176]] })
              if R[176] == 2 then
                game.create_tube({ 172, 157 })
                game.create_tube({ 172, 158 })
              elseif R[176] == 1 then
              else
                unseen("R[176]", R[176])
              end
            else
              unseen("R[176]", R[176])
            end
          elseif R[176] == 6 then
          else
            unseen("R[176]", R[176])
          end
        elseif R[176] == 5 then
        else
          unseen("R[176]", R[176])
        end
      elseif R[176] == 3 then
      else
        unseen("R[176]", R[176])
      end
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[6], at = { ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[176]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
      players[6]:center_view({ ({ [0] = 51, [1] = 111, [2] = 166, [3] = 242, [5] = 425, [6] = 427 })[R[176]], ({ [0] = 201, [1] = 26, [2] = 164, [3] = 88, [5] = 181, [6] = 28 })[R[176]] })
      if R[176] == 0 or R[176] == 3 then
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[6], at = { ({ [0] = 43, [3] = 247 })[R[176]], ({ [0] = 201, [3] = 89 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[6], at = { ({ [0] = 58, [3] = 252 })[R[176]], ({ [0] = 194, [3] = 97 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
        if R[176] == 0 then
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
        elseif R[176] == 3 then
          if LEVEL_OF[players[6].difficulty] == 1 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[6], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[6].difficulty] == 0 then
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[6], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[6].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[6], at = { 253, 101 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[6].difficulty]", LEVEL_OF[players[6].difficulty])
          end
        else
          unseen("R[176]", R[176])
        end
      elseif R[176] == 1 or R[176] == 2 or R[176] == 5 or R[176] == 6 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[6], at = { ({ [1] = 105, [2] = 164, [5] = 431, [6] = 421 })[R[176]], ({ [1] = 24, [2] = 158, [5] = 179, [6] = 29 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[6], at = { ({ [1] = 111, [2] = 158, [5] = 436, [6] = 429 })[R[176]], ({ [1] = 34, [2] = 152, [5] = 175, [6] = 22 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[6], at = { ({ [1] = 94, [2] = 172, [5] = 428, [6] = 435 })[R[176]], ({ [1] = 25, [2] = 160, [5] = 186, [6] = 21 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[176]", R[176])
      end
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[6], at = { ({ [0] = 43, [1] = 94, [2] = 172, [3] = 254, [5] = 427, [6] = 435 })[R[176]], ({ [0] = 196, [1] = 28, [2] = 155, [3] = 104, [5] = 190, [6] = 25 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
      if R[176] == 0 then
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[6], at = { 50, 195 }, direction = "East", lights = false, exact = true }[1]
      elseif R[176] == 1 or R[176] == 2 or R[176] == 3 or R[176] == 5 or R[176] == 6 then
      else
        unseen("R[176]", R[176])
      end
    elseif R[176] == 4 then
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[6], at = { 318, 62 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[6], at = { 323, 62 }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[6], at = { 322, 58 }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[6], at = { 321, 53 }, direction = "East", lights = false, exact = true }[1]
      players[6]:center_view({ 321, 53 })
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[6], at = { 327, 52 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[176]", R[176])
    end
    U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[6], at = { ({ [0] = 48, [1] = 95, [2] = 183, [3] = 247, [4] = 337, [5] = 454, [6] = 423 })[R[176]], ({ [0] = 164, [1] = 35, [2] = 165, [3] = 107, [4] = 51, [5] = 177, [6] = 39 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
    if R[176] == 0 or R[176] == 2 or R[176] == 3 or R[176] == 4 or R[176] == 5 or R[176] == 6 then
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[6], at = { ({ [0] = 46, [2] = 155, [3] = 244, [4] = 331, [5] = 436, [6] = 427 })[R[176]], ({ [0] = 206, [2] = 156, [3] = 94, [4] = 54, [5] = 179, [6] = 16 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[6], at = { ({ [0] = 43, [2] = 157, [3] = 242, [4] = 333, [5] = 439, [6] = 434 })[R[176]], ({ [0] = 204, [2] = 155, [3] = 92, [4] = 55, [5] = 176, [6] = 17 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if R[176] == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 46, 203 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[6], at = { 48, 202 }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[6].difficulty] == 0 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[6].difficulty] == 1 or LEVEL_OF[players[6].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[6].difficulty]", LEVEL_OF[players[6].difficulty])
        end
      elseif R[176] == 2 or R[176] == 3 or R[176] == 4 or R[176] == 5 or R[176] == 6 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[176]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[6].difficulty] == 0 or LEVEL_OF[players[6].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[176]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          if LEVEL_OF[players[6].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { ({ [2] = 162, [3] = 255, [4] = 326, [5] = 433, [6] = 420 })[R[176]], ({ [2] = 162, [3] = 97, [4] = 65, [5] = 185, [6] = 33 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[6].difficulty] == 1 then
          else
            unseen("LEVEL_OF[players[6].difficulty]", LEVEL_OF[players[6].difficulty])
          end
        elseif LEVEL_OF[players[6].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[6].difficulty]", LEVEL_OF[players[6].difficulty])
        end
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[6], at = { ({ [2] = 157, [3] = 234, [4] = 332, [5] = 442, [6] = 439 })[R[176]], ({ [2] = 160, [3] = 94, [4] = 52, [5] = 180, [6] = 15 })[R[176]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[176]", R[176])
      end
    elseif R[176] == 1 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      if LEVEL_OF[players[6].difficulty] == 0 or LEVEL_OF[players[6].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        if LEVEL_OF[players[6].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 105, 28 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[6].difficulty] == 1 then
        else
          unseen("LEVEL_OF[players[6].difficulty]", LEVEL_OF[players[6].difficulty])
        end
      elseif LEVEL_OF[players[6].difficulty] == 2 then
      else
        unseen("LEVEL_OF[players[6].difficulty]", LEVEL_OF[players[6].difficulty])
      end
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 103, 31 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[6], at = { 115, 36 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[6], at = { 113, 37 }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[6], at = { 116, 32 }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[176]", R[176])
    end
    U[#U]:set_lights(true)
    if R[176] == 0 then
      if LEVEL_OF[players[6].difficulty] == 0 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[177] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[177]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[177]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[6].difficulty] == 1 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[178] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[178]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[178]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      elseif LEVEL_OF[players[6].difficulty] == 2 then
        if game.initial_units() == 0 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 53, 197 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[6], at = { 62, 194 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          for i = 1, game.initial_units() do
            R[179] = game.rand(3)
            U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 49, [1] = 57, [2] = 64 })[R[179]], ({ [0] = 190, [1] = 186, [2] = 189 })[R[179]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          end
        else
          unseen("game.initial_units()", game.initial_units())
        end
      else
        unseen("LEVEL_OF[players[6].difficulty]", LEVEL_OF[players[6].difficulty])
      end
    elseif R[176] == 1 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 116, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[180] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 93, [1] = 88, [2] = 102 })[R[180]], ({ [0] = 19, [1] = 32, [2] = 36 })[R[180]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[176] == 2 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 154, 161 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 166, 154 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[181] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 152, [1] = 177, [2] = 161 })[R[181]], ({ [0] = 164, [1] = 153, [2] = 146 })[R[181]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[176] == 3 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 240, 95 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 253, 92 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[182] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 233, [1] = 234, [2] = 257 })[R[182]], ({ [0] = 90, [1] = 98, [2] = 94 })[R[182]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[176] == 4 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 329, 57 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 325, 56 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[183] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 333, [1] = 321, [2] = 336 })[R[183]], ({ [0] = 44, [1] = 67, [2] = 64 })[R[183]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[176] == 5 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 439, 181 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 431, 188 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[184] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 447, [1] = 441, [2] = 433 })[R[184]], ({ [0] = 169, [1] = 185, [2] = 191 })[R[184]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[176] == 6 then
      if game.initial_units() == 0 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[6], at = { 435, 14 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[6], at = { 427, 34 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        for i = 1, game.initial_units() do
          R[185] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[6], at = { ({ [0] = 433, [1] = 437, [2] = 414 })[R[185]], ({ [0] = 11, [1] = 37, [2] = 41 })[R[185]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[6].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[176]", R[176])
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
    players[({ [0] = 3, [1] = 3, [2] = 4 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[4]:mark_research(3305)
      players[({ [0] = 3, [1] = 4 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[5].difficulty] == 0 then
        players[5]:mark_research(3303)
      elseif LEVEL_OF[players[5].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[5].difficulty]", LEVEL_OF[players[5].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[5].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[5].difficulty]]
    players[5].scientists = 18 - 3 * LEVEL_OF[players[5].difficulty]
    players[5].kids = 22 - 2 * LEVEL_OF[players[5].difficulty]
    players[5].food = 3000 - 1000 * LEVEL_OF[players[5].difficulty]
    players[5].ore = 6000 - 2000 * LEVEL_OF[players[5].difficulty]
    players[({ [0] = 4, [1] = 4, [2] = 5 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[5]:mark_research(3305)
      players[({ [0] = 4, [1] = 5 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[6].difficulty] == 0 then
        players[6]:mark_research(3303)
      elseif LEVEL_OF[players[6].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[6].difficulty]", LEVEL_OF[players[6].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[6].workers = ({ [0] = 27, [1] = 24, [2] = 20 })[LEVEL_OF[players[6].difficulty]]
    players[6].scientists = 18 - 3 * LEVEL_OF[players[6].difficulty]
    players[6].kids = 22 - 2 * LEVEL_OF[players[6].difficulty]
    players[6].food = 3000 - 1000 * LEVEL_OF[players[6].difficulty]
    players[6].ore = 6000 - 2000 * LEVEL_OF[players[6].difficulty]
    if LEVEL_OF[players[6].difficulty] == 0 or LEVEL_OF[players[6].difficulty] == 1 then
      players[6]:mark_research(3304)
      players[6]:mark_research(3305)
      if LEVEL_OF[players[6].difficulty] == 0 then
        players[6]:mark_research(3401)
      elseif LEVEL_OF[players[6].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[6].difficulty]", LEVEL_OF[players[6].difficulty])
      end
    elseif LEVEL_OF[players[6].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[6].difficulty]", LEVEL_OF[players[6].difficulty])
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
