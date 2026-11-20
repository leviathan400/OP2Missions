-- ml4_08Lua.lua  -  4 Player, LastOne, 'The Rift' map. (Lua)
--
-- Converted by op2dll from ml4_08.dll ("4 Player, LastOne, 'The Rift' map."): its setup replayed. `on_init` makes the original's
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
local Meteor, Vortex

function Meteor(t)
  local r1 = game.rand(128)
  local r2 = game.rand(256)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function Vortex(t)
  local r1 = game.rand(1)
  local r2 = game.rand(12)
  local r3 = game.rand(21)
  local r4 = game.rand(7)
  local r5 = game.rand(120)
  game.create_tornado({ r5 + 84, 2 }, { r3 + 116, r2 + 66 }, r4 + 10)
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 115, 79 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 136, 59 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 116, 89 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 132, 19 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 171, 6 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 81, 125 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 78, 90 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 107, 99 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 112, 113 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 139, 44 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 129, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 183, 85 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 190, 119 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 71, 34 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 45, 57 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[0]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[1]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[2]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[3]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[4]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[5]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[6]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[7]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[8]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[9]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[10]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[11]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[12]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[13]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[14]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[15]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[15]] } }
    R[16] = game.rand(4)
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 64, [1] = 23, [2] = 163, [3] = 237 })[R[16]], ({ [0] = 16, [1] = 71, [2] = 115, [3] = 79 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[17] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[17]][R[16]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[17]][R[16]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[17]][R[16]] })
    if R[17] == 1 or R[17] == 2 or R[17] == 3 or R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [4] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[17]][R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 22, [1] = 46, [2] = 96, [3] = 87 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 1 or R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 } })[R[17]][R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[17]][R[16]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 } })[R[17]][R[16]], ({ [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 } })[R[17]][R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[17]][R[16]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      if R[17] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      if R[17] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [3] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 } })[R[17]][R[16]], ({ [1] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [3] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [4] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 5 or R[17] == 6 or R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [6] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [7] = { [0] = 53, [1] = 23, [2] = 170, [3] = 230 } })[R[17]][R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 61, [1] = 31, [2] = 161, [3] = 238 } })[R[17]][R[16]], ({ [5] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [6] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [7] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 7 then
        if R[16] == 0 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 1 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 2 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 3 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 }, [7] = { [0] = 56, [1] = 26, [2] = 168, [3] = 233 } })[R[17]][R[16]], ({ [5] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [6] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [7] = { [0] = 24, [1] = 48, [2] = 100, [3] = 89 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 7 then
        if R[16] == 0 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 1 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 2 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 3 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[17] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 7 then
      if R[16] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 63, 31 }, direction = "East", lights = false, exact = true }[1]
      elseif R[16] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 33, 55 }, direction = "East", lights = false, exact = true }[1]
      elseif R[16] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[16] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 240, 96 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[16]", R[16])
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboMiner", [3] = "CargoTruck" } })[R[17]][R[16]], player = players[1], at = { ({ [0] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [3] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [5] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [6] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [7] = { [0] = 62, [1] = 32, [2] = 165, [3] = 239 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [5] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [6] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [7] = { [0] = 34, [1] = 58, [2] = 102, [3] = 99 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [1] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [2] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [3] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "Earthworker", [3] = "CargoTruck" } })[R[17]][R[16]], player = players[1], at = { ({ [0] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [1] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [3] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [4] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [7] = { [0] = 63, [1] = 33, [2] = 166, [3] = 240 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [3] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [4] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [5] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [6] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [7] = { [0] = 34, [1] = 58, [2] = 101, [3] = 99 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[18] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[18]][R[16]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 31, [1] = 55, [2] = 105, [3] = 96 } })[R[18]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        for i = 1, game.initial_units() do
          R[19] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 59, [1] = 29, [2] = 167, [3] = 236 } })[R[19]][R[16]], ({ [0] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [1] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[19]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        for i = 1, game.initial_units() do
          R[20] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[20]][R[16]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[20]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        for i = 1, game.initial_units() do
          R[21] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[21]][R[16]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[21]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] })
        for i = 1, game.initial_units() do
          R[22] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[22]][R[16]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[22]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 } })[R[23]][R[16]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 } })[R[23]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[24]][R[16]], ({ [0] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 } })[R[24]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
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
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 26, [2] = 170, [3] = 233 }, [1] = { [0] = 52, [1] = 22, [2] = 169, [3] = 229 }, [2] = { [0] = 62, [1] = 32, [2] = 166, [3] = 239 } })[R[25]][R[16]], ({ [0] = { [0] = 32, [1] = 56, [2] = 97, [3] = 97 }, [1] = { [0] = 28, [1] = 52, [2] = 103, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 104, [3] = 88 } })[R[25]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 23, [1] = 64, [2] = 237, [3] = 163 })[R[16]], ({ [0] = 71, [1] = 16, [2] = 79, [3] = 115 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[26] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 27, [1] = 57, [2] = 234, [3] = 165 }, [1] = { [0] = 31, [1] = 61, [2] = 238, [3] = 169 }, [2] = { [0] = 31, [1] = 61, [2] = 238, [3] = 169 }, [3] = { [0] = 23, [1] = 53, [2] = 230, [3] = 161 }, [4] = { [0] = 27, [1] = 57, [2] = 234, [3] = 165 }, [5] = { [0] = 26, [1] = 56, [2] = 233, [3] = 164 }, [6] = { [0] = 23, [1] = 53, [2] = 230, [3] = 161 }, [7] = { [0] = 29, [1] = 59, [2] = 236, [3] = 161 } })[R[26]][R[16]], ({ [0] = { [0] = 53, [1] = 29, [2] = 94, [3] = 103 }, [1] = { [0] = 49, [1] = 25, [2] = 90, [3] = 99 }, [2] = { [0] = 53, [1] = 29, [2] = 94, [3] = 103 }, [3] = { [0] = 49, [1] = 25, [2] = 90, [3] = 99 }, [4] = { [0] = 52, [1] = 28, [2] = 93, [3] = 102 }, [5] = { [0] = 50, [1] = 26, [2] = 91, [3] = 100 }, [6] = { [0] = 47, [1] = 23, [2] = 88, [3] = 97 }, [7] = { [0] = 50, [1] = 26, [2] = 91, [3] = 97 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 27, [1] = 57, [2] = 234, [3] = 165 }, [1] = { [0] = 31, [1] = 61, [2] = 238, [3] = 169 }, [2] = { [0] = 31, [1] = 61, [2] = 238, [3] = 169 }, [3] = { [0] = 23, [1] = 53, [2] = 230, [3] = 161 }, [4] = { [0] = 27, [1] = 57, [2] = 234, [3] = 165 }, [5] = { [0] = 26, [1] = 56, [2] = 233, [3] = 164 }, [6] = { [0] = 23, [1] = 53, [2] = 230, [3] = 161 }, [7] = { [0] = 29, [1] = 59, [2] = 236, [3] = 161 } })[R[26]][R[16]], ({ [0] = { [0] = 53, [1] = 29, [2] = 94, [3] = 103 }, [1] = { [0] = 49, [1] = 25, [2] = 90, [3] = 99 }, [2] = { [0] = 53, [1] = 29, [2] = 94, [3] = 103 }, [3] = { [0] = 49, [1] = 25, [2] = 90, [3] = 99 }, [4] = { [0] = 52, [1] = 28, [2] = 93, [3] = 102 }, [5] = { [0] = 50, [1] = 26, [2] = 91, [3] = 100 }, [6] = { [0] = 47, [1] = 23, [2] = 88, [3] = 97 }, [7] = { [0] = 50, [1] = 26, [2] = 91, [3] = 97 } })[R[26]][R[16]] })
    if R[26] == 5 or R[26] == 6 or R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [5] = { [0] = 23, [1] = 53, [2] = 230, [3] = 161 }, [6] = { [0] = 32, [1] = 62, [2] = 239, [3] = 170 }, [7] = { [0] = 23, [1] = 53, [2] = 230, [3] = 170 } })[R[26]][R[16]], ({ [0] = 57, [1] = 33, [2] = 98, [3] = 107 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [5] = { [0] = 31, [1] = 61, [2] = 238, [3] = 169 }, [6] = { [0] = 23, [1] = 53, [2] = 230, [3] = 161 }, [7] = { [0] = 31, [1] = 61, [2] = 238, [3] = 161 } })[R[26]][R[16]], ({ [5] = { [0] = 51, [1] = 27, [2] = 92, [3] = 101 }, [6] = { [0] = 56, [1] = 32, [2] = 97, [3] = 106 }, [7] = { [0] = 56, [1] = 32, [2] = 97, [3] = 106 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 31, [1] = 61, [2] = 238, [3] = 169 })[R[16]], ({ [0] = 47, [1] = 23, [2] = 88, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 47, [1] = 23, [2] = 88, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 53, [1] = 29, [2] = 94, [3] = 103 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 52, [1] = 28, [2] = 93, [3] = 102 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 54, [1] = 30, [2] = 95, [3] = 104 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 31, [1] = 61, [2] = 238, [3] = 169 })[R[16]], ({ [0] = 47, [1] = 23, [2] = 88, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 47, [1] = 23, [2] = 88, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 53, [1] = 29, [2] = 94, [3] = 103 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 52, [1] = 28, [2] = 93, [3] = 102 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 54, [1] = 30, [2] = 95, [3] = 104 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 31, [1] = 61, [2] = 238, [3] = 169 })[R[16]], ({ [0] = 47, [1] = 23, [2] = 88, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 47, [1] = 23, [2] = 88, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 53, [1] = 29, [2] = 94, [3] = 103 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 52, [1] = 28, [2] = 93, [3] = 102 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 54, [1] = 30, [2] = 95, [3] = 104 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 53, [1] = 29, [2] = 94, [3] = 103 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 50, [1] = 26, [2] = 91, [3] = 100 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 28, [1] = 58, [2] = 235, [3] = 166 })[R[16]], ({ [0] = 48, [1] = 24, [2] = 89, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 53, [1] = 29, [2] = 94, [3] = 103 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 50, [1] = 26, [2] = 91, [3] = 100 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 28, [1] = 58, [2] = 235, [3] = 166 })[R[16]], ({ [0] = 48, [1] = 24, [2] = 89, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 53, [1] = 29, [2] = 94, [3] = 103 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 50, [1] = 26, [2] = 91, [3] = 100 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 28, [1] = 58, [2] = 235, [3] = 166 })[R[16]], ({ [0] = 48, [1] = 24, [2] = 89, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 7 then
        if R[16] == 0 then
          if LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[16] == 1 then
          if LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[16] == 2 then
          if LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[16] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [5] = { [0] = 33, [1] = 63, [2] = 240, [3] = 171 }, [6] = { [0] = 30, [1] = 60, [2] = 237, [3] = 168 }, [7] = { [0] = 26, [1] = 56, [2] = 233, [3] = 168 } })[R[26]][R[16]], ({ [5] = { [0] = 49, [1] = 25, [2] = 90, [3] = 99 }, [6] = { [0] = 50, [1] = 26, [2] = 91, [3] = 100 }, [7] = { [0] = 48, [1] = 24, [2] = 89, [3] = 100 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 33, [1] = 63, [2] = 240, [3] = 171 })[R[16]], ({ [0] = 49, [1] = 25, [2] = 90, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 50, [1] = 26, [2] = 91, [3] = 100 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 50, [1] = 26, [2] = 91, [3] = 100 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 55, [2] = 232, [3] = 163 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 57, [1] = 33, [2] = 98, [3] = 107 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 7 then
        if R[16] == 0 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[16] == 1 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[16] == 2 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[16] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[26]", R[26])
      end
    elseif R[26] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 24, [1] = 54, [2] = 231, [3] = 162 })[R[16]], ({ [0] = 56, [1] = 32, [2] = 97, [3] = 106 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 29, [1] = 59, [2] = 236, [3] = 167 })[R[16]], ({ [0] = 56, [1] = 32, [2] = 97, [3] = 106 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 53, [1] = 29, [2] = 94, [3] = 103 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 31, [1] = 61, [2] = 238, [3] = 169 })[R[16]], ({ [0] = 53, [1] = 29, [2] = 94, [3] = 103 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 32, [1] = 62, [2] = 239, [3] = 170 })[R[16]], ({ [0] = 47, [1] = 23, [2] = 88, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 61, [2] = 238, [3] = 169 })[R[16]], ({ [0] = 57, [1] = 33, [2] = 98, [3] = 107 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 33, [1] = 63, [2] = 240, [3] = 171 })[R[16]], ({ [0] = 56, [1] = 32, [2] = 97, [3] = 106 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 1 or R[26] == 2 or R[26] == 3 or R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [1] = { [0] = 31, [1] = 61, [2] = 238, [3] = 169 }, [2] = { [0] = 24, [1] = 54, [2] = 231, [3] = 162 }, [3] = { [0] = 28, [1] = 58, [2] = 235, [3] = 166 }, [4] = { [0] = 24, [1] = 54, [2] = 231, [3] = 162 } })[R[26]][R[16]], ({ [0] = 56, [1] = 32, [2] = 97, [3] = 106 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 24, [1] = 54, [2] = 231, [3] = 162 })[R[16]], ({ [0] = 48, [1] = 24, [2] = 89, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 28, [1] = 58, [2] = 235, [3] = 166 })[R[16]], ({ [0] = 49, [1] = 25, [2] = 90, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 52, [1] = 28, [2] = 93, [3] = 102 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 32, [1] = 62, [2] = 239, [3] = 170 })[R[16]], ({ [0] = 57, [1] = 33, [2] = 98, [3] = 107 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 46, [1] = 22, [2] = 87, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 47, [1] = 23, [2] = 88, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 57, [1] = 33, [2] = 98, [3] = 107 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 53, [1] = 29, [2] = 94, [3] = 103 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 24, [1] = 54, [2] = 231, [3] = 162 })[R[16]], ({ [0] = 52, [1] = 28, [2] = 93, [3] = 102 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 32, [1] = 62, [2] = 239, [3] = 170 })[R[16]], ({ [0] = 47, [1] = 23, [2] = 88, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 29, [1] = 59, [2] = 236, [3] = 167 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 57, [1] = 33, [2] = 98, [3] = 107 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 1 or R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [1] = { [0] = 22, [1] = 52, [2] = 229, [3] = 160 }, [2] = { [0] = 23, [1] = 53, [2] = 230, [3] = 161 } })[R[26]][R[16]], ({ [0] = 47, [1] = 23, [2] = 88, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 31, [1] = 61, [2] = 238, [3] = 169 })[R[16]], ({ [1] = { [0] = 52, [1] = 28, [2] = 93, [3] = 102 }, [2] = { [0] = 56, [1] = 32, [2] = 97, [3] = 106 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [1] = { [0] = 26, [1] = 56, [2] = 233, [3] = 164 }, [2] = { [0] = 27, [1] = 57, [2] = 234, [3] = 165 } })[R[26]][R[16]], ({ [1] = { [0] = 57, [1] = 33, [2] = 98, [3] = 107 }, [2] = { [0] = 53, [1] = 29, [2] = 94, [3] = 103 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [1] = { [0] = 26, [1] = 56, [2] = 233, [3] = 164 }, [2] = { [0] = 31, [1] = 61, [2] = 238, [3] = 169 } })[R[26]][R[16]], ({ [1] = { [0] = 53, [1] = 29, [2] = 94, [3] = 103 }, [2] = { [0] = 50, [1] = 26, [2] = 91, [3] = 100 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 32, [1] = 62, [2] = 239, [3] = 170 }, [2] = { [0] = 30, [1] = 60, [2] = 237, [3] = 168 } })[R[26]][R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [1] = { [0] = 33, [1] = 63, [2] = 240, [3] = 171 }, [2] = { [0] = 32, [1] = 62, [2] = 239, [3] = 170 } })[R[26]][R[16]], ({ [1] = { [0] = 57, [1] = 33, [2] = 98, [3] = 107 }, [2] = { [0] = 58, [1] = 34, [2] = 99, [3] = 108 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      if R[26] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 28, [1] = 58, [2] = 235, [3] = 166 })[R[16]], ({ [0] = 57, [1] = 33, [2] = 98, [3] = 107 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 31, [1] = 61, [2] = 238, [3] = 169 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 21, [1] = 51, [2] = 228, [3] = 159 })[R[16]], ({ [0] = 54, [1] = 30, [2] = 95, [3] = 104 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 47, [1] = 23, [2] = 88, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      if R[26] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 33, [1] = 63, [2] = 240, [3] = 171 })[R[16]], ({ [0] = 54, [1] = 30, [2] = 95, [3] = 104 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 55, [2] = 232, [3] = 163 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 55, [2] = 232, [3] = 163 })[R[16]], ({ [0] = 54, [1] = 30, [2] = 95, [3] = 104 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 55, [2] = 232, [3] = 163 })[R[16]], ({ [0] = 50, [1] = 26, [2] = 91, [3] = 100 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 21, [1] = 51, [2] = 228, [3] = 159 })[R[16]], ({ [0] = 54, [1] = 30, [2] = 95, [3] = 104 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [1] = { [0] = 33, [1] = 63, [2] = 240, [3] = 171 }, [2] = { [0] = 25, [1] = 55, [2] = 232, [3] = 163 }, [3] = { [0] = 25, [1] = 55, [2] = 232, [3] = 163 }, [4] = { [0] = 25, [1] = 55, [2] = 232, [3] = 163 } })[R[26]][R[16]], ({ [1] = { [0] = 54, [1] = 30, [2] = 95, [3] = 104 }, [2] = { [0] = 58, [1] = 34, [2] = 99, [3] = 108 }, [3] = { [0] = 54, [1] = 30, [2] = 95, [3] = 104 }, [4] = { [0] = 50, [1] = 26, [2] = 91, [3] = 100 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 22, [1] = 52, [2] = 229, [3] = 160 })[R[16]], ({ [0] = 49, [1] = 25, [2] = 90, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 22, [1] = 52, [2] = 229, [3] = 160 })[R[16]], ({ [0] = 49, [1] = 25, [2] = 90, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 33, [1] = 63, [2] = 240, [3] = 171 })[R[16]], ({ [0] = 54, [1] = 30, [2] = 95, [3] = 104 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 53, [1] = 29, [2] = 94, [3] = 103 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 53, [1] = 29, [2] = 94, [3] = 103 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 55, [2] = 232, [3] = 163 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 49, [1] = 25, [2] = 90, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 49, [1] = 25, [2] = 90, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 55, [2] = 232, [3] = 163 })[R[16]], ({ [0] = 54, [1] = 30, [2] = 95, [3] = 104 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 50, [1] = 26, [2] = 91, [3] = 100 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 50, [1] = 26, [2] = 91, [3] = 100 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 25, [1] = 55, [2] = 232, [3] = 163 })[R[16]], ({ [0] = 50, [1] = 26, [2] = 91, [3] = 100 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 22, [1] = 52, [2] = 229, [3] = 160 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 33, [1] = 63, [2] = 240, [3] = 171 })[R[16]], ({ [0] = 49, [1] = 25, [2] = 90, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 33, [1] = 63, [2] = 240, [3] = 171 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 50, [1] = 26, [2] = 91, [3] = 100 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 25, [1] = 55, [2] = 232, [3] = 163 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 57, [1] = 33, [2] = 98, [3] = 107 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 28, [1] = 58, [2] = 235, [3] = 166 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 51, [1] = 27, [2] = 92, [3] = 101 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 28, [1] = 58, [2] = 235, [3] = 166 })[R[16]], ({ [0] = 58, [1] = 34, [2] = 99, [3] = 108 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 51, [1] = 27, [2] = 92, [3] = 101 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 7 then
      if R[16] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 33, 55 }, direction = "East", lights = false, exact = true }[1]
      elseif R[16] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 63, 31 }, direction = "East", lights = false, exact = true }[1]
      elseif R[16] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 240, 96 }, direction = "East", lights = false, exact = true }[1]
      elseif R[16] == 3 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[16]", R[16])
      end
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "RoboMiner" } })[R[26]][R[16]], player = players[2], at = { ({ [0] = { [0] = 23, [1] = 53, [2] = 230, [3] = 161 }, [1] = { [0] = 22, [1] = 52, [2] = 229, [3] = 160 }, [2] = { [0] = 28, [1] = 58, [2] = 235, [3] = 166 }, [3] = { [0] = 27, [1] = 57, [2] = 234, [3] = 165 }, [4] = { [0] = 25, [1] = 55, [2] = 232, [3] = 163 }, [5] = { [0] = 32, [1] = 62, [2] = 239, [3] = 170 }, [6] = { [0] = 27, [1] = 57, [2] = 234, [3] = 165 }, [7] = { [0] = 32, [1] = 62, [2] = 239, [3] = 165 } })[R[26]][R[16]], ({ [0] = { [0] = 50, [1] = 26, [2] = 91, [3] = 100 }, [1] = { [0] = 52, [1] = 28, [2] = 93, [3] = 102 }, [2] = { [0] = 48, [1] = 24, [2] = 89, [3] = 98 }, [3] = { [0] = 49, [1] = 25, [2] = 90, [3] = 99 }, [4] = { [0] = 58, [1] = 34, [2] = 99, [3] = 108 }, [5] = { [0] = 53, [1] = 29, [2] = 94, [3] = 103 }, [6] = { [0] = 52, [1] = 28, [2] = 93, [3] = 102 }, [7] = { [0] = 58, [1] = 34, [2] = 99, [3] = 102 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [1] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [2] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [3] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "Earthworker" } })[R[26]][R[16]], player = players[2], at = { ({ [0] = { [0] = 24, [1] = 54, [2] = 231, [3] = 162 }, [1] = { [0] = 24, [1] = 54, [2] = 231, [3] = 162 }, [2] = { [0] = 27, [1] = 57, [2] = 234, [3] = 165 }, [3] = { [0] = 26, [1] = 56, [2] = 233, [3] = 164 }, [4] = { [0] = 26, [1] = 56, [2] = 233, [3] = 164 }, [5] = { [0] = 33, [1] = 63, [2] = 240, [3] = 171 }, [6] = { [0] = 28, [1] = 58, [2] = 235, [3] = 166 }, [7] = { [0] = 33, [1] = 63, [2] = 240, [3] = 166 } })[R[26]][R[16]], ({ [0] = { [0] = 50, [1] = 26, [2] = 91, [3] = 100 }, [1] = { [0] = 51, [1] = 27, [2] = 92, [3] = 101 }, [2] = { [0] = 47, [1] = 23, [2] = 88, [3] = 97 }, [3] = { [0] = 48, [1] = 24, [2] = 89, [3] = 98 }, [4] = { [0] = 57, [1] = 33, [2] = 98, [3] = 107 }, [5] = { [0] = 52, [1] = 28, [2] = 93, [3] = 102 }, [6] = { [0] = 51, [1] = 27, [2] = 92, [3] = 101 }, [7] = { [0] = 58, [1] = 34, [2] = 99, [3] = 101 } })[R[26]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[27] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 52, [2] = 229, [3] = 160 }, [1] = { [0] = 27, [1] = 57, [2] = 234, [3] = 165 }, [2] = { [0] = 32, [1] = 62, [2] = 239, [3] = 170 } })[R[27]][R[16]], ({ [0] = { [0] = 46, [1] = 22, [2] = 87, [3] = 96 }, [1] = { [0] = 49, [1] = 25, [2] = 90, [3] = 99 }, [2] = { [0] = 55, [1] = 31, [2] = 96, [3] = 105 } })[R[27]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 26, [1] = 56, [2] = 233, [3] = 164 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] })
        for i = 1, game.initial_units() do
          R[28] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 22, [1] = 52, [2] = 229, [3] = 160 }, [1] = { [0] = 26, [1] = 56, [2] = 233, [3] = 164 }, [2] = { [0] = 29, [1] = 59, [2] = 236, [3] = 167 } })[R[28]][R[16]], ({ [0] = { [0] = 56, [1] = 32, [2] = 97, [3] = 106 }, [1] = { [0] = 50, [1] = 26, [2] = 91, [3] = 100 }, [2] = { [0] = 46, [1] = 22, [2] = 87, [3] = 96 } })[R[28]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] })
        game.create_tube({ ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 56, [1] = 32, [2] = 97, [3] = 106 })[R[16]] })
        game.create_tube({ ({ [0] = 28, [1] = 58, [2] = 235, [3] = 166 })[R[16]], ({ [0] = 56, [1] = 32, [2] = 97, [3] = 106 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] })
        game.create_tube({ ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 56, [1] = 32, [2] = 97, [3] = 106 })[R[16]] })
        game.create_tube({ ({ [0] = 28, [1] = 58, [2] = 235, [3] = 166 })[R[16]], ({ [0] = 56, [1] = 32, [2] = 97, [3] = 106 })[R[16]] })
        for i = 1, game.initial_units() do
          R[29] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 61, [2] = 238, [3] = 169 }, [1] = { [0] = 23, [1] = 53, [2] = 230, [3] = 161 }, [2] = { [0] = 27, [1] = 57, [2] = 234, [3] = 165 } })[R[29]][R[16]], ({ [0] = { [0] = 46, [1] = 22, [2] = 87, [3] = 96 }, [1] = { [0] = 51, [1] = 27, [2] = 92, [3] = 101 }, [2] = { [0] = 56, [1] = 32, [2] = 97, [3] = 106 } })[R[29]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 3 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 24, [1] = 54, [2] = 231, [3] = 162 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] })
        game.create_tube({ ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 52, [1] = 28, [2] = 93, [3] = 102 })[R[16]] })
        game.create_tube({ ({ [0] = 28, [1] = 58, [2] = 235, [3] = 166 })[R[16]], ({ [0] = 52, [1] = 28, [2] = 93, [3] = 102 })[R[16]] })
        game.create_tube({ ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] })
        game.create_tube({ ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 56, [1] = 32, [2] = 97, [3] = 106 })[R[16]] })
        for i = 1, game.initial_units() do
          R[30] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 62, [2] = 239, [3] = 170 }, [1] = { [0] = 28, [1] = 58, [2] = 235, [3] = 166 }, [2] = { [0] = 24, [1] = 54, [2] = 231, [3] = 162 } })[R[30]][R[16]], ({ [0] = { [0] = 57, [1] = 33, [2] = 98, [3] = 107 }, [1] = { [0] = 51, [1] = 27, [2] = 92, [3] = 101 }, [2] = { [0] = 46, [1] = 22, [2] = 87, [3] = 96 } })[R[30]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 24, [1] = 54, [2] = 231, [3] = 162 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] })
        game.create_tube({ ({ [0] = 27, [1] = 57, [2] = 234, [3] = 165 })[R[16]], ({ [0] = 52, [1] = 28, [2] = 93, [3] = 102 })[R[16]] })
        game.create_tube({ ({ [0] = 28, [1] = 58, [2] = 235, [3] = 166 })[R[16]], ({ [0] = 52, [1] = 28, [2] = 93, [3] = 102 })[R[16]] })
        game.create_tube({ ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 55, [1] = 31, [2] = 96, [3] = 105 })[R[16]] })
        game.create_tube({ ({ [0] = 30, [1] = 60, [2] = 237, [3] = 168 })[R[16]], ({ [0] = 56, [1] = 32, [2] = 97, [3] = 106 })[R[16]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 54, [1] = 30, [2] = 95, [3] = 104 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 23, [1] = 53, [2] = 230, [3] = 161 })[R[16]], ({ [0] = 54, [1] = 30, [2] = 95, [3] = 104 })[R[16]] })
        for i = 1, game.initial_units() do
          R[31] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 31, [1] = 61, [2] = 238, [3] = 169 }, [1] = { [0] = 32, [1] = 62, [2] = 239, [3] = 170 }, [2] = { [0] = 28, [1] = 58, [2] = 235, [3] = 166 } })[R[31]][R[16]], ({ [0] = { [0] = 46, [1] = 22, [2] = 87, [3] = 96 }, [1] = { [0] = 52, [1] = 28, [2] = 93, [3] = 102 }, [2] = { [0] = 56, [1] = 32, [2] = 97, [3] = 106 } })[R[31]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[32] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 28, [1] = 58, [2] = 235, [3] = 166 }, [1] = { [0] = 22, [1] = 52, [2] = 229, [3] = 160 }, [2] = { [0] = 22, [1] = 52, [2] = 229, [3] = 160 } })[R[32]][R[16]], ({ [0] = { [0] = 57, [1] = 33, [2] = 98, [3] = 107 }, [1] = { [0] = 52, [1] = 28, [2] = 93, [3] = 102 }, [2] = { [0] = 47, [1] = 23, [2] = 88, [3] = 97 } })[R[32]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[33] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 32, [1] = 62, [2] = 239, [3] = 170 }, [1] = { [0] = 31, [1] = 61, [2] = 238, [3] = 169 }, [2] = { [0] = 28, [1] = 58, [2] = 235, [3] = 166 } })[R[33]][R[16]], ({ [0] = { [0] = 47, [1] = 23, [2] = 88, [3] = 97 }, [1] = { [0] = 53, [1] = 29, [2] = 94, [3] = 103 }, [2] = { [0] = 54, [1] = 30, [2] = 95, [3] = 104 } })[R[33]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[34] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 26, [1] = 56, [2] = 233, [3] = 170 }, [1] = { [0] = 22, [1] = 52, [2] = 229, [3] = 169 }, [2] = { [0] = 32, [1] = 62, [2] = 239, [3] = 166 } })[R[34]][R[16]], ({ [0] = { [0] = 56, [1] = 32, [2] = 97, [3] = 97 }, [1] = { [0] = 52, [1] = 28, [2] = 93, [3] = 103 }, [2] = { [0] = 47, [1] = 23, [2] = 88, [3] = 104 } })[R[34]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[26]", R[26])
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
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 115, 79 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 136, 59 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 116, 89 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 132, 19 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 171, 6 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 81, 125 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 78, 90 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 107, 99 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 112, 113 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 139, 44 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 129, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 183, 85 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 190, 119 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 71, 34 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 45, 57 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[0]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[1]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[2]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[3]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[4]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[5]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[6]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[7]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[8]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[9]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[10]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[11]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[12]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[13]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[14]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[15]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[15]] } }
    pick(4, 3, { 16, 35, 36 })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 64, [1] = 23, [2] = 163, [3] = 237 })[R[16]], ({ [0] = 16, [1] = 71, [2] = 115, [3] = 79 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[17] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[17]][R[16]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[17]][R[16]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[17]][R[16]] })
    if R[17] == 5 or R[17] == 6 or R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [6] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [7] = { [0] = 53, [1] = 23, [2] = 170, [3] = 230 } })[R[17]][R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 61, [1] = 31, [2] = 161, [3] = 238 } })[R[17]][R[16]], ({ [5] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [6] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [7] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 7 then
        if R[16] == 0 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 1 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 2 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 3 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 }, [7] = { [0] = 56, [1] = 26, [2] = 168, [3] = 233 } })[R[17]][R[16]], ({ [5] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [6] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [7] = { [0] = 24, [1] = 48, [2] = 100, [3] = 89 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 7 then
        if R[16] == 0 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 1 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 2 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 3 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[17] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 1 or R[17] == 2 or R[17] == 3 or R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [4] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[17]][R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 1 or R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 } })[R[17]][R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[17]][R[16]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 } })[R[17]][R[16]], ({ [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 } })[R[17]][R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[17]][R[16]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 22, [1] = 46, [2] = 96, [3] = 87 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      if R[17] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      if R[17] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [3] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 } })[R[17]][R[16]], ({ [1] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [3] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [4] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 7 then
      if R[16] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 63, 31 }, direction = "East", lights = false, exact = true }[1]
      elseif R[16] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 33, 55 }, direction = "East", lights = false, exact = true }[1]
      elseif R[16] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[16] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 240, 96 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[16]", R[16])
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboMiner", [3] = "CargoTruck" } })[R[17]][R[16]], player = players[1], at = { ({ [0] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [3] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [5] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [6] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [7] = { [0] = 62, [1] = 32, [2] = 165, [3] = 239 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [5] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [6] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [7] = { [0] = 34, [1] = 58, [2] = 102, [3] = 99 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [1] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [2] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [3] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "Earthworker", [3] = "CargoTruck" } })[R[17]][R[16]], player = players[1], at = { ({ [0] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [1] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [3] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [4] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [7] = { [0] = 63, [1] = 33, [2] = 166, [3] = 240 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [3] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [4] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [5] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [6] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [7] = { [0] = 34, [1] = 58, [2] = 101, [3] = 99 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[37] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[37]][R[16]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 31, [1] = 55, [2] = 105, [3] = 96 } })[R[37]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        for i = 1, game.initial_units() do
          R[38] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 59, [1] = 29, [2] = 167, [3] = 236 } })[R[38]][R[16]], ({ [0] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [1] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[38]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        for i = 1, game.initial_units() do
          R[39] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[39]][R[16]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[39]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        for i = 1, game.initial_units() do
          R[40] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[40]][R[16]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[40]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] })
        for i = 1, game.initial_units() do
          R[41] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[41]][R[16]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[41]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[42] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 } })[R[42]][R[16]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 } })[R[42]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[43] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[43]][R[16]], ({ [0] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 } })[R[43]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[44] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 26, [2] = 170, [3] = 233 }, [1] = { [0] = 52, [1] = 22, [2] = 169, [3] = 229 }, [2] = { [0] = 62, [1] = 32, [2] = 166, [3] = 239 } })[R[44]][R[16]], ({ [0] = { [0] = 32, [1] = 56, [2] = 97, [3] = 97 }, [1] = { [0] = 28, [1] = 52, [2] = 103, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 104, [3] = 88 } })[R[44]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 64, [1] = 23, [2] = 163, [3] = 237 })[R[35]], ({ [0] = 16, [1] = 71, [2] = 115, [3] = 79 })[R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[26] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 61, [2] = 61, [3] = 53, [4] = 57, [5] = 56, [6] = 53, [7] = 59 }, [1] = { [0] = 27, [1] = 31, [2] = 31, [3] = 23, [4] = 27, [5] = 26, [6] = 23, [7] = 29 }, [2] = { [0] = 165, [1] = 169, [2] = 169, [3] = 161, [4] = 165, [5] = 164, [6] = 161, [7] = 161 }, [3] = { [0] = 234, [1] = 238, [2] = 238, [3] = 230, [4] = 234, [5] = 233, [6] = 230, [7] = 236 } })[R[35]][R[26]], ({ [0] = { [0] = 29, [1] = 25, [2] = 29, [3] = 25, [4] = 28, [5] = 26, [6] = 23, [7] = 26 }, [1] = { [0] = 53, [1] = 49, [2] = 53, [3] = 49, [4] = 52, [5] = 50, [6] = 47, [7] = 50 }, [2] = { [0] = 103, [1] = 99, [2] = 103, [3] = 99, [4] = 102, [5] = 100, [6] = 97, [7] = 97 }, [3] = { [0] = 94, [1] = 90, [2] = 94, [3] = 90, [4] = 93, [5] = 91, [6] = 88, [7] = 91 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 57, [1] = 61, [2] = 61, [3] = 53, [4] = 57, [5] = 56, [6] = 53, [7] = 59 }, [1] = { [0] = 27, [1] = 31, [2] = 31, [3] = 23, [4] = 27, [5] = 26, [6] = 23, [7] = 29 }, [2] = { [0] = 165, [1] = 169, [2] = 169, [3] = 161, [4] = 165, [5] = 164, [6] = 161, [7] = 161 }, [3] = { [0] = 234, [1] = 238, [2] = 238, [3] = 230, [4] = 234, [5] = 233, [6] = 230, [7] = 236 } })[R[35]][R[26]], ({ [0] = { [0] = 29, [1] = 25, [2] = 29, [3] = 25, [4] = 28, [5] = 26, [6] = 23, [7] = 26 }, [1] = { [0] = 53, [1] = 49, [2] = 53, [3] = 49, [4] = 52, [5] = 50, [6] = 47, [7] = 50 }, [2] = { [0] = 103, [1] = 99, [2] = 103, [3] = 99, [4] = 102, [5] = 100, [6] = 97, [7] = 97 }, [3] = { [0] = 94, [1] = 90, [2] = 94, [3] = 90, [4] = 93, [5] = 91, [6] = 88, [7] = 91 } })[R[35]][R[26]] })
    if R[26] == 5 or R[26] == 6 or R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 53, [6] = 62, [7] = 53 }, [1] = { [5] = 23, [6] = 32, [7] = 23 }, [2] = { [5] = 161, [6] = 170, [7] = 170 }, [3] = { [5] = 230, [6] = 239, [7] = 230 } })[R[35]][R[26]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 61, [6] = 53, [7] = 61 }, [1] = { [5] = 31, [6] = 23, [7] = 31 }, [2] = { [5] = 169, [6] = 161, [7] = 161 }, [3] = { [5] = 238, [6] = 230, [7] = 238 } })[R[35]][R[26]], ({ [0] = { [5] = 27, [6] = 32, [7] = 32 }, [1] = { [5] = 51, [6] = 56, [7] = 56 }, [2] = { [5] = 101, [6] = 106, [7] = 106 }, [3] = { [5] = 92, [6] = 97, [7] = 97 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 7 then
        if R[35] == 0 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 1 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 2 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[35]", R[35])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 63, [6] = 60, [7] = 56 }, [1] = { [5] = 33, [6] = 30, [7] = 26 }, [2] = { [5] = 171, [6] = 168, [7] = 168 }, [3] = { [5] = 240, [6] = 237, [7] = 233 } })[R[35]][R[26]], ({ [0] = { [5] = 25, [6] = 26, [7] = 24 }, [1] = { [5] = 49, [6] = 50, [7] = 48 }, [2] = { [5] = 99, [6] = 100, [7] = 100 }, [3] = { [5] = 90, [6] = 91, [7] = 89 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 7 then
        if R[35] == 0 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 1 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 2 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[35]", R[35])
        end
      else
        unseen("R[26]", R[26])
      end
    elseif R[26] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 1 or R[26] == 2 or R[26] == 3 or R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 61, [2] = 54, [3] = 58, [4] = 54 }, [1] = { [1] = 31, [2] = 24, [3] = 28, [4] = 24 }, [2] = { [1] = 169, [2] = 162, [3] = 166, [4] = 162 }, [3] = { [1] = 238, [2] = 231, [3] = 235, [4] = 231 } })[R[35]][R[26]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[35]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 22, [1] = 46, [2] = 96, [3] = 87 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 1 or R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 52, [2] = 53 }, [1] = { [1] = 22, [2] = 23 }, [2] = { [1] = 160, [2] = 161 }, [3] = { [1] = 229, [2] = 230 } })[R[35]][R[26]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = { [1] = 28, [2] = 32 }, [1] = { [1] = 52, [2] = 56 }, [2] = { [1] = 102, [2] = 106 }, [3] = { [1] = 93, [2] = 97 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 56, [2] = 57 }, [1] = { [1] = 26, [2] = 27 }, [2] = { [1] = 164, [2] = 165 }, [3] = { [1] = 233, [2] = 234 } })[R[35]][R[26]], ({ [0] = { [1] = 33, [2] = 29 }, [1] = { [1] = 57, [2] = 53 }, [2] = { [1] = 107, [2] = 103 }, [3] = { [1] = 98, [2] = 94 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 56, [2] = 61 }, [1] = { [1] = 26, [2] = 31 }, [2] = { [1] = 164, [2] = 169 }, [3] = { [1] = 233, [2] = 238 } })[R[35]][R[26]], ({ [0] = { [1] = 29, [2] = 26 }, [1] = { [1] = 53, [2] = 50 }, [2] = { [1] = 103, [2] = 100 }, [3] = { [1] = 94, [2] = 91 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 62, [2] = 60 }, [1] = { [1] = 32, [2] = 30 }, [2] = { [1] = 170, [2] = 168 }, [3] = { [1] = 239, [2] = 237 } })[R[35]][R[26]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 63, [2] = 62 }, [1] = { [1] = 33, [2] = 32 }, [2] = { [1] = 171, [2] = 170 }, [3] = { [1] = 240, [2] = 239 } })[R[35]][R[26]], ({ [0] = { [1] = 33, [2] = 34 }, [1] = { [1] = 57, [2] = 58 }, [2] = { [1] = 107, [2] = 108 }, [3] = { [1] = 98, [2] = 99 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      if R[26] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      if R[26] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 63, [2] = 55, [3] = 55, [4] = 55 }, [1] = { [1] = 33, [2] = 25, [3] = 25, [4] = 25 }, [2] = { [1] = 171, [2] = 163, [3] = 163, [4] = 163 }, [3] = { [1] = 240, [2] = 232, [3] = 232, [4] = 232 } })[R[35]][R[26]], ({ [0] = { [1] = 30, [2] = 34, [3] = 30, [4] = 26 }, [1] = { [1] = 54, [2] = 58, [3] = 54, [4] = 50 }, [2] = { [1] = 104, [2] = 108, [3] = 104, [4] = 100 }, [3] = { [1] = 95, [2] = 99, [3] = 95, [4] = 91 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 7 then
      if R[35] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 63, 31 }, direction = "East", lights = false, exact = true }[1]
      elseif R[35] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 33, 55 }, direction = "East", lights = false, exact = true }[1]
      elseif R[35] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[35] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 240, 96 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[35]", R[35])
      end
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" } })[R[35]][R[26]], player = players[2], at = { ({ [0] = { [0] = 53, [1] = 52, [2] = 58, [3] = 57, [4] = 55, [5] = 62, [6] = 57, [7] = 62 }, [1] = { [0] = 23, [1] = 22, [2] = 28, [3] = 27, [4] = 25, [5] = 32, [6] = 27, [7] = 32 }, [2] = { [0] = 161, [1] = 160, [2] = 166, [3] = 165, [4] = 163, [5] = 170, [6] = 165, [7] = 165 }, [3] = { [0] = 230, [1] = 229, [2] = 235, [3] = 234, [4] = 232, [5] = 239, [6] = 234, [7] = 239 } })[R[35]][R[26]], ({ [0] = { [0] = 26, [1] = 28, [2] = 24, [3] = 25, [4] = 34, [5] = 29, [6] = 28, [7] = 34 }, [1] = { [0] = 50, [1] = 52, [2] = 48, [3] = 49, [4] = 58, [5] = 53, [6] = 52, [7] = 58 }, [2] = { [0] = 100, [1] = 102, [2] = 98, [3] = 99, [4] = 108, [5] = 103, [6] = 102, [7] = 102 }, [3] = { [0] = 91, [1] = 93, [2] = 89, [3] = 90, [4] = 99, [5] = 94, [6] = 93, [7] = 99 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" }, [1] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" }, [2] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "Earthworker" }, [3] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" } })[R[35]][R[26]], player = players[2], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 57, [3] = 56, [4] = 56, [5] = 63, [6] = 58, [7] = 63 }, [1] = { [0] = 24, [1] = 24, [2] = 27, [3] = 26, [4] = 26, [5] = 33, [6] = 28, [7] = 33 }, [2] = { [0] = 162, [1] = 162, [2] = 165, [3] = 164, [4] = 164, [5] = 171, [6] = 166, [7] = 166 }, [3] = { [0] = 231, [1] = 231, [2] = 234, [3] = 233, [4] = 233, [5] = 240, [6] = 235, [7] = 240 } })[R[35]][R[26]], ({ [0] = { [0] = 26, [1] = 27, [2] = 23, [3] = 24, [4] = 33, [5] = 28, [6] = 27, [7] = 34 }, [1] = { [0] = 50, [1] = 51, [2] = 47, [3] = 48, [4] = 57, [5] = 52, [6] = 51, [7] = 58 }, [2] = { [0] = 100, [1] = 101, [2] = 97, [3] = 98, [4] = 107, [5] = 102, [6] = 101, [7] = 101 }, [3] = { [0] = 91, [1] = 92, [2] = 88, [3] = 89, [4] = 98, [5] = 93, [6] = 92, [7] = 99 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[45] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[45]][R[35]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 31, [1] = 55, [2] = 105, [3] = 96 } })[R[45]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        for i = 1, game.initial_units() do
          R[46] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 59, [1] = 29, [2] = 167, [3] = 236 } })[R[46]][R[35]], ({ [0] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [1] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[46]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 2 then
      if game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
        for i = 1, game.initial_units() do
          R[47] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[47]][R[35]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[47]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      elseif game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
        for i = 1, game.initial_units() do
          R[48] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[48]][R[35]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[48]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] })
        for i = 1, game.initial_units() do
          R[49] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[49]][R[35]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[49]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[50] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 } })[R[50]][R[35]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 } })[R[50]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[51] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[51]][R[35]], ({ [0] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 } })[R[51]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[52] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 56, [1] = 26, [2] = 170, [3] = 233 }, [1] = { [0] = 52, [1] = 22, [2] = 169, [3] = 229 }, [2] = { [0] = 62, [1] = 32, [2] = 166, [3] = 239 } })[R[52]][R[35]], ({ [0] = { [0] = 32, [1] = 56, [2] = 97, [3] = 97 }, [1] = { [0] = 28, [1] = 52, [2] = 103, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 104, [3] = 88 } })[R[52]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[26]", R[26])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 64, [1] = 23, [2] = 163, [3] = 237 })[R[36]], ({ [0] = 16, [1] = 71, [2] = 115, [3] = 79 })[R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[53] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[53]][R[36]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[53]][R[36]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[53]][R[36]] })
    if R[53] == 5 or R[53] == 6 or R[53] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [6] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [7] = { [0] = 53, [1] = 23, [2] = 170, [3] = 230 } })[R[53]][R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 61, [1] = 31, [2] = 161, [3] = 238 } })[R[53]][R[36]], ({ [5] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [6] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [7] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 5 then
        if LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[3].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 7 then
        if R[36] == 0 then
          if LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 1 then
          if LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 2 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 3 then
          if LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[36]", R[36])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 }, [7] = { [0] = 56, [1] = 26, [2] = 168, [3] = 233 } })[R[53]][R[36]], ({ [5] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [6] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [7] = { [0] = 24, [1] = 48, [2] = 100, [3] = 89 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 7 then
        if R[36] == 0 then
          if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 1 then
          if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 2 then
          if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 3 then
          if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[36]", R[36])
        end
      else
        unseen("R[53]", R[53])
      end
    elseif R[53] == 1 or R[53] == 2 or R[53] == 3 or R[53] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [4] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[53]][R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 1 or R[53] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 } })[R[53]][R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[53]][R[36]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 } })[R[53]][R[36]], ({ [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 } })[R[53]][R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[53]][R[36]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[36]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 22, [1] = 46, [2] = 96, [3] = 87 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U]:set_lights(true)
      if R[53] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U]:set_lights(true)
      if R[53] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [3] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 } })[R[53]][R[36]], ({ [1] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [3] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [4] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[53]", R[53])
    end
    U[#U]:set_lights(true)
    if R[53] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 7 then
      if R[36] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 63, 31 }, direction = "East", lights = false, exact = true }[1]
      elseif R[36] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 33, 55 }, direction = "East", lights = false, exact = true }[1]
      elseif R[36] == 2 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[36] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 240, 96 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[36]", R[36])
      end
    else
      unseen("R[53]", R[53])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboMiner", [3] = "CargoTruck" } })[R[53]][R[36]], player = players[3], at = { ({ [0] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [3] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [5] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [6] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [7] = { [0] = 62, [1] = 32, [2] = 165, [3] = 239 } })[R[53]][R[36]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [5] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [6] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [7] = { [0] = 34, [1] = 58, [2] = 102, [3] = 99 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [1] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [2] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [3] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "Earthworker", [3] = "CargoTruck" } })[R[53]][R[36]], player = players[3], at = { ({ [0] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [1] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [3] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [4] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [7] = { [0] = 63, [1] = 33, [2] = 166, [3] = 240 } })[R[53]][R[36]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [3] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [4] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [5] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [6] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [7] = { [0] = 34, [1] = 58, [2] = 101, [3] = 99 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[53] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[54] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[54]][R[36]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 31, [1] = 55, [2] = 105, [3] = 96 } })[R[54]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        for i = 1, game.initial_units() do
          R[55] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 59, [1] = 29, [2] = 167, [3] = 236 } })[R[55]][R[36]], ({ [0] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [1] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[55]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
        for i = 1, game.initial_units() do
          R[56] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[56]][R[36]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[56]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
        for i = 1, game.initial_units() do
          R[57] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[57]][R[36]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[57]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] })
        for i = 1, game.initial_units() do
          R[58] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[58]][R[36]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[58]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[59] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 } })[R[59]][R[36]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 } })[R[59]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[60] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[60]][R[36]], ({ [0] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 } })[R[60]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[61] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 56, [1] = 26, [2] = 170, [3] = 233 }, [1] = { [0] = 52, [1] = 22, [2] = 169, [3] = 229 }, [2] = { [0] = 62, [1] = 32, [2] = 166, [3] = 239 } })[R[61]][R[36]], ({ [0] = { [0] = 32, [1] = 56, [2] = 97, [3] = 97 }, [1] = { [0] = 28, [1] = 52, [2] = 103, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 104, [3] = 88 } })[R[61]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[53]", R[53])
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
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 115, 79 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 136, 59 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 116, 89 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 132, 19 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 171, 6 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 81, 125 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 78, 90 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 107, 99 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 112, 113 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 139, 44 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 129, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 183, 85 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 190, 119 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 71, 34 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 45, 57 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[0]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[1]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[2]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[3]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[4]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[5]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[6]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[7]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[8]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[9]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[10]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[11]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[12]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[13]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[14]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[15]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[15]] } }
    pick(4, 4, { 16, 35, 36, 62 })
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[1], at = { ({ [0] = 64, [1] = 23, [2] = 163, [3] = 237 })[R[16]], ({ [0] = 16, [1] = 71, [2] = 115, [3] = 79 })[R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[17] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[17]][R[16]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    players[1]:center_view({ ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[17]][R[16]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[17]][R[16]] })
    if R[17] == 1 or R[17] == 2 or R[17] == 3 or R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [4] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[17]][R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 22, [1] = 46, [2] = 96, [3] = 87 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 1 or R[17] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 } })[R[17]][R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[17]][R[16]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 } })[R[17]][R[16]], ({ [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 } })[R[17]][R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[17]", R[17])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[17]], player = players[1], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [3] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[17]][R[16]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [3] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [4] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[17]], player = players[1], at = { ({ [1] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [3] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [4] = { [0] = 51, [1] = 21, [2] = 159, [3] = 228 } })[R[17]][R[16]], ({ [1] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [2] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [3] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [4] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [3] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 } })[R[17]][R[16]], ({ [1] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [3] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [4] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[17] == 4 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[17] == 5 or R[17] == 6 or R[17] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [5] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [6] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [7] = { [0] = 53, [1] = 23, [2] = 170, [3] = 230 } })[R[17]][R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [5] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 61, [1] = 31, [2] = 161, [3] = 238 } })[R[17]][R[16]], ({ [5] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [6] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [7] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 7 then
        if R[16] == 0 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 1 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 2 then
          if LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 3 then
          if LEVEL_OF[players[1].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[1].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 }, [7] = { [0] = 56, [1] = 26, [2] = 168, [3] = 233 } })[R[17]][R[16]], ({ [5] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [6] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [7] = { [0] = 24, [1] = 48, [2] = 100, [3] = 89 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
      if R[17] == 5 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 6 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[17] == 7 then
        if R[16] == 0 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 1 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 2 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        elseif R[16] == 3 then
          if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[1].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
          end
        else
          unseen("R[16]", R[16])
        end
      else
        unseen("R[17]", R[17])
      end
    elseif R[17] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[1], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[1], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[1], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[16]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 1 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 2 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 3 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[17] == 6 then
      if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[1].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[16]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
      end
    elseif R[17] == 7 then
      if R[16] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 63, 31 }, direction = "East", lights = false, exact = true }[1]
      elseif R[16] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 33, 55 }, direction = "East", lights = false, exact = true }[1]
      elseif R[16] == 2 then
        if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[1].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
        end
      elseif R[16] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { 240, 96 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[16]", R[16])
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboMiner", [3] = "CargoTruck" } })[R[17]][R[16]], player = players[1], at = { ({ [0] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [3] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [5] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [6] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [7] = { [0] = 62, [1] = 32, [2] = 165, [3] = 239 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [5] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [6] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [7] = { [0] = 34, [1] = 58, [2] = 102, [3] = 99 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [1] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [2] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [3] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "Earthworker", [3] = "CargoTruck" } })[R[17]][R[16]], player = players[1], at = { ({ [0] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [1] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [3] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [4] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [7] = { [0] = 63, [1] = 33, [2] = 166, [3] = 240 } })[R[17]][R[16]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [3] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [4] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [5] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [6] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [7] = { [0] = 34, [1] = 58, [2] = 101, [3] = 99 } })[R[17]][R[16]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[17] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[63] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[63]][R[16]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 31, [1] = 55, [2] = 105, [3] = 96 } })[R[63]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        for i = 1, game.initial_units() do
          R[64] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 59, [1] = 29, [2] = 167, [3] = 236 } })[R[64]][R[16]], ({ [0] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [1] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[64]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        for i = 1, game.initial_units() do
          R[65] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[65]][R[16]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[65]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[16]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[16]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[16]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[16]] })
        for i = 1, game.initial_units() do
          R[66] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[66]][R[16]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[66]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[16]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[16]] })
        for i = 1, game.initial_units() do
          R[67] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[67]][R[16]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[67]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[68] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 } })[R[68]][R[16]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 } })[R[68]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[69] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[69]][R[16]], ({ [0] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 } })[R[69]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[17] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[70] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { ({ [0] = { [0] = 56, [1] = 26, [2] = 170, [3] = 233 }, [1] = { [0] = 52, [1] = 22, [2] = 169, [3] = 229 }, [2] = { [0] = 62, [1] = 32, [2] = 166, [3] = 239 } })[R[70]][R[16]], ({ [0] = { [0] = 32, [1] = 56, [2] = 97, [3] = 97 }, [1] = { [0] = 28, [1] = 52, [2] = 103, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 104, [3] = 88 } })[R[70]][R[16]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[1].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[17]", R[17])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[2], at = { ({ [0] = 64, [1] = 23, [2] = 163, [3] = 237 })[R[35]], ({ [0] = 16, [1] = 71, [2] = 115, [3] = 79 })[R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[26] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 61, [2] = 61, [3] = 53, [4] = 57, [5] = 56, [6] = 53, [7] = 59 }, [1] = { [0] = 27, [1] = 31, [2] = 31, [3] = 23, [4] = 27, [5] = 26, [6] = 23, [7] = 29 }, [2] = { [0] = 165, [1] = 169, [2] = 169, [3] = 161, [4] = 165, [5] = 164, [6] = 161, [7] = 161 }, [3] = { [0] = 234, [1] = 238, [2] = 238, [3] = 230, [4] = 234, [5] = 233, [6] = 230, [7] = 236 } })[R[35]][R[26]], ({ [0] = { [0] = 29, [1] = 25, [2] = 29, [3] = 25, [4] = 28, [5] = 26, [6] = 23, [7] = 26 }, [1] = { [0] = 53, [1] = 49, [2] = 53, [3] = 49, [4] = 52, [5] = 50, [6] = 47, [7] = 50 }, [2] = { [0] = 103, [1] = 99, [2] = 103, [3] = 99, [4] = 102, [5] = 100, [6] = 97, [7] = 97 }, [3] = { [0] = 94, [1] = 90, [2] = 94, [3] = 90, [4] = 93, [5] = 91, [6] = 88, [7] = 91 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    players[2]:center_view({ ({ [0] = { [0] = 57, [1] = 61, [2] = 61, [3] = 53, [4] = 57, [5] = 56, [6] = 53, [7] = 59 }, [1] = { [0] = 27, [1] = 31, [2] = 31, [3] = 23, [4] = 27, [5] = 26, [6] = 23, [7] = 29 }, [2] = { [0] = 165, [1] = 169, [2] = 169, [3] = 161, [4] = 165, [5] = 164, [6] = 161, [7] = 161 }, [3] = { [0] = 234, [1] = 238, [2] = 238, [3] = 230, [4] = 234, [5] = 233, [6] = 230, [7] = 236 } })[R[35]][R[26]], ({ [0] = { [0] = 29, [1] = 25, [2] = 29, [3] = 25, [4] = 28, [5] = 26, [6] = 23, [7] = 26 }, [1] = { [0] = 53, [1] = 49, [2] = 53, [3] = 49, [4] = 52, [5] = 50, [6] = 47, [7] = 50 }, [2] = { [0] = 103, [1] = 99, [2] = 103, [3] = 99, [4] = 102, [5] = 100, [6] = 97, [7] = 97 }, [3] = { [0] = 94, [1] = 90, [2] = 94, [3] = 90, [4] = 93, [5] = 91, [6] = 88, [7] = 91 } })[R[35]][R[26]] })
    if R[26] == 5 or R[26] == 6 or R[26] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [5] = 53, [6] = 62, [7] = 53 }, [1] = { [5] = 23, [6] = 32, [7] = 23 }, [2] = { [5] = 161, [6] = 170, [7] = 170 }, [3] = { [5] = 230, [6] = 239, [7] = 230 } })[R[35]][R[26]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [5] = 61, [6] = 53, [7] = 61 }, [1] = { [5] = 31, [6] = 23, [7] = 31 }, [2] = { [5] = 169, [6] = 161, [7] = 161 }, [3] = { [5] = 238, [6] = 230, [7] = 238 } })[R[35]][R[26]], ({ [0] = { [5] = 27, [6] = 32, [7] = 32 }, [1] = { [5] = 51, [6] = 56, [7] = 56 }, [2] = { [5] = 101, [6] = 106, [7] = 106 }, [3] = { [5] = 92, [6] = 97, [7] = 97 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 7 then
        if R[35] == 0 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 1 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 2 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[35]", R[35])
        end
      else
        unseen("R[26]", R[26])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [5] = 63, [6] = 60, [7] = 56 }, [1] = { [5] = 33, [6] = 30, [7] = 26 }, [2] = { [5] = 171, [6] = 168, [7] = 168 }, [3] = { [5] = 240, [6] = 237, [7] = 233 } })[R[35]][R[26]], ({ [0] = { [5] = 25, [6] = 26, [7] = 24 }, [1] = { [5] = 49, [6] = 50, [7] = 48 }, [2] = { [5] = 99, [6] = 100, [7] = 100 }, [3] = { [5] = 90, [6] = 91, [7] = 89 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 5 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 6 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[26] == 7 then
        if R[35] == 0 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 1 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 2 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        elseif R[35] == 3 then
          if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[2].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
          end
        else
          unseen("R[35]", R[35])
        end
      else
        unseen("R[26]", R[26])
      end
    elseif R[26] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 1 or R[26] == 2 or R[26] == 3 or R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[2], at = { ({ [0] = { [1] = 61, [2] = 54, [3] = 58, [4] = 54 }, [1] = { [1] = 31, [2] = 24, [3] = 28, [4] = 24 }, [2] = { [1] = 169, [2] = 162, [3] = 166, [4] = 162 }, [3] = { [1] = 238, [2] = 231, [3] = 235, [4] = 231 } })[R[35]][R[26]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[35]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 22, [1] = 46, [2] = 96, [3] = 87 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 1 or R[26] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = { [1] = 52, [2] = 53 }, [1] = { [1] = 22, [2] = 23 }, [2] = { [1] = 160, [2] = 161 }, [3] = { [1] = 229, [2] = 230 } })[R[35]][R[26]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[35]], ({ [0] = { [1] = 28, [2] = 32 }, [1] = { [1] = 52, [2] = 56 }, [2] = { [1] = 102, [2] = 106 }, [3] = { [1] = 93, [2] = 97 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = { [1] = 56, [2] = 57 }, [1] = { [1] = 26, [2] = 27 }, [2] = { [1] = 164, [2] = 165 }, [3] = { [1] = 233, [2] = 234 } })[R[35]][R[26]], ({ [0] = { [1] = 33, [2] = 29 }, [1] = { [1] = 57, [2] = 53 }, [2] = { [1] = 107, [2] = 103 }, [3] = { [1] = 98, [2] = 94 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = { [1] = 56, [2] = 61 }, [1] = { [1] = 26, [2] = 31 }, [2] = { [1] = 164, [2] = 169 }, [3] = { [1] = 233, [2] = 238 } })[R[35]][R[26]], ({ [0] = { [1] = 29, [2] = 26 }, [1] = { [1] = 53, [2] = 50 }, [2] = { [1] = 103, [2] = 100 }, [3] = { [1] = 94, [2] = 91 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [1] = 62, [2] = 60 }, [1] = { [1] = 32, [2] = 30 }, [2] = { [1] = 170, [2] = 168 }, [3] = { [1] = 239, [2] = 237 } })[R[35]][R[26]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[2], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[2], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[35]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[26]", R[26])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "RoboMiner" })[R[26]], player = players[2], at = { ({ [0] = { [1] = 63, [2] = 62, [3] = 60, [4] = 57 }, [1] = { [1] = 33, [2] = 32, [3] = 30, [4] = 27 }, [2] = { [1] = 171, [2] = 170, [3] = 168, [4] = 165 }, [3] = { [1] = 240, [2] = 239, [3] = 237, [4] = 234 } })[R[35]][R[26]], ({ [0] = { [1] = 33, [2] = 34, [3] = 33, [4] = 23 }, [1] = { [1] = 57, [2] = 58, [3] = 57, [4] = 47 }, [2] = { [1] = 107, [2] = 108, [3] = 107, [4] = 97 }, [3] = { [1] = 98, [2] = 99, [3] = 98, [4] = 88 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = ({ [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck", [4] = "Earthworker" })[R[26]], player = players[2], at = { ({ [0] = { [1] = 60, [2] = 58, [3] = 61, [4] = 51 }, [1] = { [1] = 30, [2] = 28, [3] = 31, [4] = 21 }, [2] = { [1] = 168, [2] = 166, [3] = 169, [4] = 159 }, [3] = { [1] = 237, [2] = 235, [3] = 238, [4] = 228 } })[R[35]][R[26]], ({ [0] = { [1] = 34, [2] = 33, [3] = 34, [4] = 30 }, [1] = { [1] = 58, [2] = 57, [3] = 58, [4] = 54 }, [2] = { [1] = 108, [2] = 107, [3] = 108, [4] = 104 }, [3] = { [1] = 99, [2] = 98, [3] = 99, [4] = 95 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [1] = 63, [2] = 55, [3] = 55, [4] = 55 }, [1] = { [1] = 33, [2] = 25, [3] = 25, [4] = 25 }, [2] = { [1] = 171, [2] = 163, [3] = 163, [4] = 163 }, [3] = { [1] = 240, [2] = 232, [3] = 232, [4] = 232 } })[R[35]][R[26]], ({ [0] = { [1] = 30, [2] = 34, [3] = 30, [4] = 26 }, [1] = { [1] = 54, [2] = 58, [3] = 54, [4] = 50 }, [2] = { [1] = 104, [2] = 108, [3] = 104, [4] = 100 }, [3] = { [1] = 95, [2] = 99, [3] = 95, [4] = 91 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
      if R[26] == 1 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 2 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 3 then
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[26] == 4 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      else
        unseen("R[26]", R[26])
      end
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 1 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 2 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 3 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[26] == 6 then
      if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[2].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[35]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif R[26] == 7 then
      if R[35] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 63, 31 }, direction = "East", lights = false, exact = true }[1]
      elseif R[35] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 33, 55 }, direction = "East", lights = false, exact = true }[1]
      elseif R[35] == 2 then
        if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[2].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
        end
      elseif R[35] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { 240, 96 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[35]", R[35])
      end
    else
      unseen("R[26]", R[26])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "RoboMiner", [7] = "CargoTruck" } })[R[35]][R[26]], player = players[2], at = { ({ [0] = { [0] = 53, [1] = 52, [2] = 58, [3] = 57, [4] = 55, [5] = 62, [6] = 57, [7] = 62 }, [1] = { [0] = 23, [1] = 22, [2] = 28, [3] = 27, [4] = 25, [5] = 32, [6] = 27, [7] = 32 }, [2] = { [0] = 161, [1] = 160, [2] = 166, [3] = 165, [4] = 163, [5] = 170, [6] = 165, [7] = 165 }, [3] = { [0] = 230, [1] = 229, [2] = 235, [3] = 234, [4] = 232, [5] = 239, [6] = 234, [7] = 239 } })[R[35]][R[26]], ({ [0] = { [0] = 26, [1] = 28, [2] = 24, [3] = 25, [4] = 34, [5] = 29, [6] = 28, [7] = 34 }, [1] = { [0] = 50, [1] = 52, [2] = 48, [3] = 49, [4] = 58, [5] = 53, [6] = 52, [7] = 58 }, [2] = { [0] = 100, [1] = 102, [2] = 98, [3] = 99, [4] = 108, [5] = 103, [6] = 102, [7] = 102 }, [3] = { [0] = 91, [1] = 93, [2] = 89, [3] = 90, [4] = 99, [5] = 94, [6] = 93, [7] = 99 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" }, [1] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" }, [2] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "Earthworker" }, [3] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker", [4] = "CargoTruck", [5] = "CargoTruck", [6] = "Earthworker", [7] = "CargoTruck" } })[R[35]][R[26]], player = players[2], at = { ({ [0] = { [0] = 54, [1] = 54, [2] = 57, [3] = 56, [4] = 56, [5] = 63, [6] = 58, [7] = 63 }, [1] = { [0] = 24, [1] = 24, [2] = 27, [3] = 26, [4] = 26, [5] = 33, [6] = 28, [7] = 33 }, [2] = { [0] = 162, [1] = 162, [2] = 165, [3] = 164, [4] = 164, [5] = 171, [6] = 166, [7] = 166 }, [3] = { [0] = 231, [1] = 231, [2] = 234, [3] = 233, [4] = 233, [5] = 240, [6] = 235, [7] = 240 } })[R[35]][R[26]], ({ [0] = { [0] = 26, [1] = 27, [2] = 23, [3] = 24, [4] = 33, [5] = 28, [6] = 27, [7] = 34 }, [1] = { [0] = 50, [1] = 51, [2] = 47, [3] = 48, [4] = 57, [5] = 52, [6] = 51, [7] = 58 }, [2] = { [0] = 100, [1] = 101, [2] = 97, [3] = 98, [4] = 107, [5] = 102, [6] = 101, [7] = 101 }, [3] = { [0] = 91, [1] = 92, [2] = 88, [3] = 89, [4] = 98, [5] = 93, [6] = 92, [7] = 99 } })[R[35]][R[26]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[26] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[71] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[71]][R[35]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 31, [1] = 55, [2] = 105, [3] = 96 } })[R[71]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        for i = 1, game.initial_units() do
          R[72] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 59, [1] = 29, [2] = 167, [3] = 236 } })[R[72]][R[35]], ({ [0] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [1] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[72]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
        for i = 1, game.initial_units() do
          R[73] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[73]][R[35]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[73]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[35]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[35]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[35]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[35]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[35]] })
        for i = 1, game.initial_units() do
          R[74] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[74]][R[35]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[74]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[35]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[35]] })
        for i = 1, game.initial_units() do
          R[75] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[75]][R[35]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[75]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[76] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 } })[R[76]][R[35]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 } })[R[76]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[77] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[77]][R[35]], ({ [0] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 } })[R[77]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[26] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[78] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { ({ [0] = { [0] = 56, [1] = 26, [2] = 170, [3] = 233 }, [1] = { [0] = 52, [1] = 22, [2] = 169, [3] = 229 }, [2] = { [0] = 62, [1] = 32, [2] = 166, [3] = 239 } })[R[78]][R[35]], ({ [0] = { [0] = 32, [1] = 56, [2] = 97, [3] = 97 }, [1] = { [0] = 28, [1] = 52, [2] = 103, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 104, [3] = 88 } })[R[78]][R[35]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[2].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[26]", R[26])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[3], at = { ({ [0] = 64, [1] = 23, [2] = 163, [3] = 237 })[R[36]], ({ [0] = 16, [1] = 71, [2] = 115, [3] = 79 })[R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[53] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[53]][R[36]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    players[3]:center_view({ ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[53]][R[36]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[53]][R[36]] })
    if R[53] == 5 or R[53] == 6 or R[53] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [5] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [6] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [7] = { [0] = 53, [1] = 23, [2] = 170, [3] = 230 } })[R[53]][R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [5] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 61, [1] = 31, [2] = 161, [3] = 238 } })[R[53]][R[36]], ({ [5] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [6] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [7] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 7 then
        if R[36] == 0 then
          if LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 1 then
          if LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 2 then
          if LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 3 then
          if LEVEL_OF[players[3].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[3].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[36]", R[36])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 }, [7] = { [0] = 56, [1] = 26, [2] = 168, [3] = 233 } })[R[53]][R[36]], ({ [5] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [6] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [7] = { [0] = 24, [1] = 48, [2] = 100, [3] = 89 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 5 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 6 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[53] == 7 then
        if R[36] == 0 then
          if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 1 then
          if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 2 then
          if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        elseif R[36] == 3 then
          if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[3].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
          end
        else
          unseen("R[36]", R[36])
        end
      else
        unseen("R[53]", R[53])
      end
    elseif R[53] == 1 or R[53] == 2 or R[53] == 3 or R[53] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [4] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[53]][R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      if R[53] == 1 or R[53] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 } })[R[53]][R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[53]][R[36]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 } })[R[53]][R[36]], ({ [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 } })[R[53]][R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[53]][R[36]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[36]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 22, [1] = 46, [2] = 96, [3] = 87 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[3].difficulty] == 2 then
        elseif LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U]:set_lights(true)
      if R[53] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        if LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U]:set_lights(true)
      if R[53] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[53] == 4 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      else
        unseen("R[53]", R[53])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [3] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 } })[R[53]][R[36]], ({ [1] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [3] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [4] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[3], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[3], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[3], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[36]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[53]", R[53])
    end
    U[#U]:set_lights(true)
    if R[53] == 0 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 1 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 2 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 3 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[53] == 6 then
      if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[3].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[36]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif R[53] == 7 then
      if R[36] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 63, 31 }, direction = "East", lights = false, exact = true }[1]
      elseif R[36] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 33, 55 }, direction = "East", lights = false, exact = true }[1]
      elseif R[36] == 2 then
        if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[3].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
        end
      elseif R[36] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { 240, 96 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[36]", R[36])
      end
    else
      unseen("R[53]", R[53])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboMiner", [3] = "CargoTruck" } })[R[53]][R[36]], player = players[3], at = { ({ [0] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [3] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [5] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [6] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [7] = { [0] = 62, [1] = 32, [2] = 165, [3] = 239 } })[R[53]][R[36]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [5] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [6] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [7] = { [0] = 34, [1] = 58, [2] = 102, [3] = 99 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [1] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [2] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [3] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "Earthworker", [3] = "CargoTruck" } })[R[53]][R[36]], player = players[3], at = { ({ [0] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [1] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [3] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [4] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [7] = { [0] = 63, [1] = 33, [2] = 166, [3] = 240 } })[R[53]][R[36]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [3] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [4] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [5] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [6] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [7] = { [0] = 34, [1] = 58, [2] = 101, [3] = 99 } })[R[53]][R[36]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[53] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[79] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[79]][R[36]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 31, [1] = 55, [2] = 105, [3] = 96 } })[R[79]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        for i = 1, game.initial_units() do
          R[80] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 59, [1] = 29, [2] = 167, [3] = 236 } })[R[80]][R[36]], ({ [0] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [1] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[80]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
        for i = 1, game.initial_units() do
          R[81] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[81]][R[36]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[81]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[36]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[36]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[36]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[36]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[36]] })
        for i = 1, game.initial_units() do
          R[82] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[82]][R[36]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[82]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[36]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[36]] })
        for i = 1, game.initial_units() do
          R[83] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[83]][R[36]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[83]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[84] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 } })[R[84]][R[36]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 } })[R[84]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[85] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[85]][R[36]], ({ [0] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 } })[R[85]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[53] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[86] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { ({ [0] = { [0] = 56, [1] = 26, [2] = 170, [3] = 233 }, [1] = { [0] = 52, [1] = 22, [2] = 169, [3] = 229 }, [2] = { [0] = 62, [1] = 32, [2] = 166, [3] = 239 } })[R[86]][R[36]], ({ [0] = { [0] = 32, [1] = 56, [2] = 97, [3] = 97 }, [1] = { [0] = 28, [1] = 52, [2] = 103, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 104, [3] = 88 } })[R[86]][R[36]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[3].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[53]", R[53])
    end
    U[#U + 1] = game.create_unit{ type = "GuardPost", player = players[4], at = { ({ [0] = 64, [1] = 23, [2] = 163, [3] = 237 })[R[62]], ({ [0] = 16, [1] = 71, [2] = 115, [3] = 79 })[R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
    R[87] = game.rand(8)
    U[#U + 1] = game.create_unit{ type = "CommandCenter", player = players[4], at = { ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[87]][R[62]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    players[4]:center_view({ ({ [0] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [3] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [4] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [5] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 59, [1] = 29, [2] = 161, [3] = 236 } })[R[87]][R[62]], ({ [0] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [5] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [6] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [7] = { [0] = 26, [1] = 50, [2] = 97, [3] = 91 } })[R[87]][R[62]] })
    if R[87] == 5 or R[87] == 6 or R[87] == 7 then
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [5] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [6] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [7] = { [0] = 53, [1] = 23, [2] = 170, [3] = 230 } })[R[87]][R[62]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [5] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [6] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [7] = { [0] = 61, [1] = 31, [2] = 161, [3] = 238 } })[R[87]][R[62]], ({ [5] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [6] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [7] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      if R[87] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[62]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[62]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[62]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[87] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[62]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
          U[#U]:set_factory_cargo(4, "VehicleFactory")
          U[#U]:set_factory_cargo(5, "RobotCommand")
          U[#U]:set_factory_cargo(6, "Residence")
        elseif LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[62]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_factory_cargo(1, "Tokamak")
          U[#U]:set_factory_cargo(2, "Nursery")
          U[#U]:set_factory_cargo(3, "University")
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[62]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[87] == 7 then
        if R[62] == 0 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 54, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 58, 23 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 59, 29 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 56, 26 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 57, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 62, 27 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[62] == 1 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 24, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 28, 47 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 29, 53 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 26, 50 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 27, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 32, 51 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[62] == 2 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 161, 103 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 161, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 166, 98 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[62] == 3 then
          if LEVEL_OF[players[4].difficulty] == 0 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U]:set_factory_cargo(4, "VehicleFactory")
            U[#U]:set_factory_cargo(5, "RobotCommand")
            U[#U]:set_factory_cargo(6, "Residence")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[4].difficulty] == 1 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_factory_cargo(1, "Tokamak")
            U[#U]:set_factory_cargo(2, "Nursery")
            U[#U]:set_factory_cargo(3, "University")
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { 231, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { 235, 88 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { 236, 94 }, direction = "East", lights = false, exact = true }[1]
            U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 233, 91 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { 234, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { 239, 92 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        else
          unseen("R[62]", R[62])
        end
      else
        unseen("R[87]", R[87])
      end
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 }, [7] = { [0] = 56, [1] = 26, [2] = 168, [3] = 233 } })[R[87]][R[62]], ({ [5] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [6] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [7] = { [0] = 24, [1] = 48, [2] = 100, [3] = 89 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      if R[87] == 5 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[62]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[87] == 6 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[87] == 7 then
        if R[62] == 0 then
          if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[62] == 1 then
          if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[62] == 2 then
          if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        elseif R[62] == 3 then
          if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
            U[#U]:set_lights(true)
            U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
          elseif LEVEL_OF[players[4].difficulty] == 2 then
          else
            unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
          end
        else
          unseen("R[62]", R[62])
        end
      else
        unseen("R[87]", R[87])
      end
    elseif R[87] == 1 or R[87] == 2 or R[87] == 3 or R[87] == 4 then
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [3] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [4] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[87]][R[62]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      if R[87] == 1 or R[87] == 2 then
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 } })[R[87]][R[62]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[62]], ({ [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[87]][R[62]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 } })[R[87]][R[62]], ({ [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 60, [1] = 30, [2] = 168, [3] = 237 } })[R[87]][R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[87]][R[62]], ({ [1] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 3 then
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[62]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[62]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 4 then
        U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[62]], ({ [0] = 24, [1] = 48, [2] = 98, [3] = 89 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
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
        U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[62]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[62]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 22, [1] = 46, [2] = 96, [3] = 87 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[87]", R[87])
      end
      U[#U]:set_lights(true)
      if R[87] == 1 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[62]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 3 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[62]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[87]", R[87])
      end
      U[#U]:set_lights(true)
      if R[87] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[62]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 2 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[62]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif R[87] == 4 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[62]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = 51, [1] = 21, [2] = 159, [3] = 228 })[R[62]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      else
        unseen("R[87]", R[87])
      end
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [1] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [2] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [3] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 } })[R[87]][R[62]], ({ [1] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [2] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [3] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 }, [4] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[87] == 0 then
      U[#U + 1] = game.create_unit{ type = "StructureFactory", player = players[4], at = { ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[62]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
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
      U[#U + 1] = game.create_unit{ type = "CommonOreSmelter", player = players[4], at = { ({ [0] = 59, [1] = 29, [2] = 167, [3] = 236 })[R[62]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Agridome", player = players[4], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "StandardLab", player = players[4], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[62]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "Tokamak", player = players[4], at = { ({ [0] = 62, [1] = 32, [2] = 170, [3] = 239 })[R[62]], ({ [0] = 23, [1] = 47, [2] = 97, [3] = 88 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 61, [1] = 31, [2] = 169, [3] = 238 })[R[62]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[62]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
    else
      unseen("R[87]", R[87])
    end
    U[#U]:set_lights(true)
    if R[87] == 0 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[62]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[62]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[87] == 1 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[62]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 29, [1] = 53, [2] = 103, [3] = 94 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[87] == 2 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[87] == 3 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[62]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[87] == 4 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[62]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 52, [1] = 22, [2] = 160, [3] = 229 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[87] == 5 then
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[62]], ({ [0] = 25, [1] = 49, [2] = 99, [3] = 90 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 63, [1] = 33, [2] = 171, [3] = 240 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
    elseif R[87] == 6 then
      if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 26, [1] = 50, [2] = 100, [3] = 91 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 55, [1] = 25, [2] = 163, [3] = 232 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 33, [1] = 57, [2] = 107, [3] = 98 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      elseif LEVEL_OF[players[4].difficulty] == 2 then
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[62]], ({ [0] = 34, [1] = 58, [2] = 108, [3] = 99 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 27, [1] = 51, [2] = 101, [3] = 92 })[R[62]] }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif R[87] == 7 then
      if R[62] == 0 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 56, 24 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 63, 31 }, direction = "East", lights = false, exact = true }[1]
      elseif R[62] == 1 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 26, 48 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 33, 55 }, direction = "East", lights = false, exact = true }[1]
      elseif R[62] == 2 then
        if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
          U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 168, 100 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 163, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 164, 107 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        elseif LEVEL_OF[players[4].difficulty] == 2 then
          U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 166, 108 }, direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
          U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { 164, 101 }, direction = "East", lights = false, exact = true }[1]
        else
          unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
        end
      elseif R[62] == 3 then
        U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { 233, 89 }, direction = "East", lights = false, exact = true }[1]
        U[#U]:set_lights(true)
        U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { 240, 96 }, direction = "East", lights = false, exact = true }[1]
      else
        unseen("R[62]", R[62])
      end
    else
      unseen("R[87]", R[87])
    end
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [1] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [2] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [3] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "RoboMiner", [1] = "RoboMiner", [2] = "RoboMiner", [3] = "RoboMiner" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "RoboMiner", [3] = "CargoTruck" } })[R[87]][R[62]], player = players[4], at = { ({ [0] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [3] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [4] = { [0] = 55, [1] = 25, [2] = 163, [3] = 232 }, [5] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [6] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [7] = { [0] = 62, [1] = 32, [2] = 165, [3] = 239 } })[R[87]][R[62]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [3] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [4] = { [0] = 34, [1] = 58, [2] = 108, [3] = 99 }, [5] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [6] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [7] = { [0] = 34, [1] = 58, [2] = 102, [3] = 99 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = ({ [0] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [1] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [2] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [3] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [4] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [5] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "CargoTruck", [3] = "CargoTruck" }, [6] = { [0] = "Earthworker", [1] = "Earthworker", [2] = "Earthworker", [3] = "Earthworker" }, [7] = { [0] = "CargoTruck", [1] = "CargoTruck", [2] = "Earthworker", [3] = "CargoTruck" } })[R[87]][R[62]], player = players[4], at = { ({ [0] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [1] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [3] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [4] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [5] = { [0] = 63, [1] = 33, [2] = 171, [3] = 240 }, [6] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [7] = { [0] = 63, [1] = 33, [2] = 166, [3] = 240 } })[R[87]][R[62]], ({ [0] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [3] = { [0] = 24, [1] = 48, [2] = 98, [3] = 89 }, [4] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [5] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [6] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [7] = { [0] = 34, [1] = 58, [2] = 101, [3] = 99 } })[R[87]][R[62]] }, direction = "East", lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if R[87] == 0 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[88] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 }, [2] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 } })[R[88]][R[62]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 25, [1] = 49, [2] = 99, [3] = 90 }, [2] = { [0] = 31, [1] = 55, [2] = 105, [3] = 96 } })[R[88]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 1 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 56, [1] = 26, [2] = 164, [3] = 233 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] })
        for i = 1, game.initial_units() do
          R[89] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [1] = { [0] = 56, [1] = 26, [2] = 164, [3] = 233 }, [2] = { [0] = 59, [1] = 29, [2] = 167, [3] = 236 } })[R[89]][R[62]], ({ [0] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 }, [1] = { [0] = 26, [1] = 50, [2] = 100, [3] = 91 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[89]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 2 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[62]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[62]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[62]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[62]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[62]] })
        for i = 1, game.initial_units() do
          R[90] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 53, [1] = 23, [2] = 161, [3] = 230 }, [2] = { [0] = 57, [1] = 27, [2] = 165, [3] = 234 } })[R[90]][R[62]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[90]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 3 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[62]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[62]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[62]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 54, [1] = 24, [2] = 162, [3] = 231 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] })
        game.create_tube({ ({ [0] = 57, [1] = 27, [2] = 165, [3] = 234 })[R[62]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[62]] })
        game.create_tube({ ({ [0] = 58, [1] = 28, [2] = 166, [3] = 235 })[R[62]], ({ [0] = 28, [1] = 52, [2] = 102, [3] = 93 })[R[62]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 31, [1] = 55, [2] = 105, [3] = 96 })[R[62]] })
        game.create_tube({ ({ [0] = 60, [1] = 30, [2] = 168, [3] = 237 })[R[62]], ({ [0] = 32, [1] = 56, [2] = 106, [3] = 97 })[R[62]] })
        for i = 1, game.initial_units() do
          R[91] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [2] = { [0] = 54, [1] = 24, [2] = 162, [3] = 231 } })[R[91]][R[62]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 27, [1] = 51, [2] = 101, [3] = 92 }, [2] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 } })[R[91]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 4 then
      if game.initial_units() == 0 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[62]] })
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        game.create_tube({ ({ [0] = 53, [1] = 23, [2] = 161, [3] = 230 })[R[62]], ({ [0] = 30, [1] = 54, [2] = 104, [3] = 95 })[R[62]] })
        for i = 1, game.initial_units() do
          R[92] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [1] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[92]][R[62]], ({ [0] = { [0] = 22, [1] = 46, [2] = 96, [3] = 87 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 32, [1] = 56, [2] = 106, [3] = 97 } })[R[92]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 5 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[93] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 }, [1] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 }, [2] = { [0] = 52, [1] = 22, [2] = 160, [3] = 229 } })[R[93]][R[62]], ({ [0] = { [0] = 33, [1] = 57, [2] = 107, [3] = 98 }, [1] = { [0] = 28, [1] = 52, [2] = 102, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 } })[R[93]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 6 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[94] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 62, [1] = 32, [2] = 170, [3] = 239 }, [1] = { [0] = 61, [1] = 31, [2] = 169, [3] = 238 }, [2] = { [0] = 58, [1] = 28, [2] = 166, [3] = 235 } })[R[94]][R[62]], ({ [0] = { [0] = 23, [1] = 47, [2] = 97, [3] = 88 }, [1] = { [0] = 29, [1] = 53, [2] = 103, [3] = 94 }, [2] = { [0] = 30, [1] = 54, [2] = 104, [3] = 95 } })[R[94]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    elseif R[87] == 7 then
      if game.initial_units() == 0 then
      elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
        for i = 1, game.initial_units() do
          R[95] = game.rand(3)
          U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { ({ [0] = { [0] = 56, [1] = 26, [2] = 170, [3] = 233 }, [1] = { [0] = 52, [1] = 22, [2] = 169, [3] = 229 }, [2] = { [0] = 62, [1] = 32, [2] = 166, [3] = 239 } })[R[95]][R[62]], ({ [0] = { [0] = 32, [1] = 56, [2] = 97, [3] = 97 }, [1] = { [0] = 28, [1] = 52, [2] = 103, [3] = 93 }, [2] = { [0] = 23, [1] = 47, [2] = 104, [3] = 88 } })[R[95]][R[62]] }, weapon = ({ [0] = "Microwave", [1] = "Laser" })[(players[4].is_eden and 1 or 0)], direction = "East", lights = false, exact = true }[1]
          U[#U]:set_lights(true)
        end
      else
        unseen("game.initial_units()", game.initial_units())
      end
    else
      unseen("R[87]", R[87])
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
    trigger.time{min = 18000, max = 22000, one_shot = false, on = Meteor}  -- after 180 to 220 marks
    trigger.time{min = 12000, max = 18000, one_shot = false, on = Vortex}  -- after 120 to 180 marks
  end
  return true
end
